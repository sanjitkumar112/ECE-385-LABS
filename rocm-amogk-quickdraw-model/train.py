import argparse
from pathlib import Path
from time import perf_counter

import numpy as np
import torch
from torch import nn


ROOT = Path(__file__).resolve().parent
DATA = ROOT / "data"

# The FPGA firmware must use this same class order.
CLASSES = [
    "airplane", "apple", "bicycle", "car", "fish",
    "house", "star", "sun", "tree", "umbrella",
]


def load_data(device, quick):
    """Return (pixels, labels) for the training, validation and test sets."""
    rng = np.random.default_rng(385)
    split_sizes = (500, 100, 100) if quick else (5000, 500, 500)
    splits = [[], [], []]

    for label, name in enumerate(CLASSES):
        path = DATA / f"{name}.npy"
        if not path.is_file():
            raise SystemExit(f"Missing {path}. Run bash download.sh first.")

        # Each row is a flattened 28 x 28 image. Only read the rows we select.
        images = np.load(path, mmap_mode="r")
        indices = rng.permutation(len(images))

        # Reserve the full split ranges even in quick mode. This keeps a
        # quick-run training image out of the full run's validation/test sets.
        starts = (0, 5000, 5500)
        for split, start, count in zip(splits, starts, split_sizes):
            selected = indices[start:start + count]
            pixels = images[selected].reshape(count, 1, 28, 28)
            labels = np.full(count, label, dtype=np.int64)
            split.append((pixels, labels))

    datasets = []
    for split in splits:
        pixels, labels = zip(*split)
        x = torch.from_numpy(np.concatenate(pixels))
        y = torch.from_numpy(np.concatenate(labels))

        # Google's bitmap files use 0 for background and 255 for full ink.
        x = x.to(device=device, dtype=torch.float32).div_(255.0)
        datasets.append((x, y.to(device)))

    return datasets


class SketchCNN(nn.Module):
    def __init__(self):
        super().__init__()
        self.features = nn.Sequential(
            nn.Conv2d(1, 8, kernel_size=3, padding=1),
            nn.ReLU(),
            nn.MaxPool2d(2),
            nn.Conv2d(8, 16, kernel_size=3, padding=1),
            nn.ReLU(),
            nn.MaxPool2d(2),
        )
        self.classifier = nn.Linear(7 * 7 * 16, len(CLASSES))

    def forward(self, x):
        x = self.features(x)

        # PyTorch convolution output is [batch, channel, row, column].
        # The FPGA design stores channels together at each pixel.
        x = x.permute(0, 2, 3, 1).reshape(x.size(0), -1)
        return self.classifier(x)


@torch.inference_mode()
def accuracy(model, dataset):
    model.eval()
    images, labels = dataset
    correct = torch.zeros((), dtype=torch.long, device=images.device)

    for x, y in zip(images.split(512), labels.split(512)):
        predictions = model(x).argmax(dim=1)
        correct += (predictions == y).sum()

    return correct.item() / len(labels)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--quick", action="store_true")
    parser.add_argument("--epochs", type=int, default=15)
    parser.add_argument("--batch-size", type=int, default=256)
    args = parser.parse_args()

    if args.epochs < 1 or args.batch_size < 1:
        parser.error("--epochs and --batch-size must be positive")

    gpu_names = [
        torch.cuda.get_device_name(i) for i in range(torch.cuda.device_count())
    ]
    gpu_index = next(
        (i for i, name in enumerate(gpu_names) if "6700S" in name), None
    )
    if gpu_index is None:
        raise SystemExit(f"RX 6700S unavailable. Visible GPUs: {gpu_names}")

    device = torch.device(f"cuda:{gpu_index}")
    torch.cuda.set_device(device)
    torch.manual_seed(385)
    print(f"GPU: {gpu_names[gpu_index]}", flush=True)

    train, val, test = load_data(device, args.quick)
    train_x, train_y = train
    print(f"Drawings: {len(train_y)} train, {len(val[1])} validation, "
          f"{len(test[1])} test", flush=True)

    model = SketchCNN().to(device)
    optimizer = torch.optim.Adam(model.parameters(), lr=0.001)
    loss_fn = nn.CrossEntropyLoss()
    checkpoint = ROOT / ("quick.pt" if args.quick else "best.pt")
    best_val = -1.0

    for epoch in range(1, args.epochs + 1):
        model.train()
        torch.cuda.synchronize()
        start = perf_counter()

        order = torch.randperm(len(train_y), device=device)
        for batch in order.split(args.batch_size):
            optimizer.zero_grad(set_to_none=True)
            scores = model(train_x[batch])
            loss = loss_fn(scores, train_y[batch])
            loss.backward()
            optimizer.step()

        torch.cuda.synchronize()
        seconds = perf_counter() - start
        val_acc = accuracy(model, val)
        print(f"Epoch {epoch:2d} | {seconds:6.2f} s | "
              f"{len(train_y) / seconds:7.0f} images/s | "
              f"validation {val_acc:.1%}", flush=True)

        if val_acc > best_val:
            best_val = val_acc
            torch.save({
                "weights": model.state_dict(),
                "classes": CLASSES,
                "epoch": epoch,
                "validation_accuracy": val_acc,
                "input_format": "Google bitmap, uint8 divided by 255",
                "flatten_order": "row, column, channel",
            }, checkpoint)

    saved = torch.load(checkpoint, map_location=device, weights_only=True)
    model.load_state_dict(saved["weights"])
    print(f"Best epoch: {saved['epoch']}")
    print(f"Held-out test accuracy: {accuracy(model, test):.1%}")
    print(f"Saved: {checkpoint}")


if __name__ == "__main__":
    main()