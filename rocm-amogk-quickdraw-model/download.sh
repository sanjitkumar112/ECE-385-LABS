#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"
mkdir -p data
base="https://storage.googleapis.com/quickdraw_dataset/full/numpy_bitmap"

for name in airplane apple bicycle car fish house star sun tree umbrella; do
    file="data/$name.npy"

    if [[ -s "$file" ]]; then
        echo "Already downloaded: $name"
        continue
    fi

    echo "Downloading $name"
    curl --fail --location --retry 3 "$base/$name.npy" --output "$file.part"
    mv "$file.part" "$file"
done