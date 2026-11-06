// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Thu Nov  5 17:46:44 2026
// Host        : amogks-laptop running 64-bit Fedora Linux 42 (Workstation Edition)
// Command     : write_verilog -force -mode funcsim
//               /home/amogk/Vivado/ECE-385-LABS/ip_repo/hdmi_text_controller_1_0/src/blk_mem_gen_0_2/blk_mem_gen_0_sim_netlist.v
// Design      : blk_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7s50csga324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_0,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module blk_mem_gen_0
   (clka,
    ena,
    wea,
    addra,
    dina,
    douta,
    clkb,
    enb,
    web,
    addrb,
    dinb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [3:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [10:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB WE" *) input [3:0]web;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [10:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DIN" *) input [31:0]dinb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [31:0]doutb;

  wire [10:0]addra;
  wire [10:0]addrb;
  wire clka;
  wire [31:0]dina;
  wire [31:0]dinb;
  wire [31:0]douta;
  wire [31:0]doutb;
  wire ena;
  wire enb;
  wire [3:0]wea;
  wire [3:0]web;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [10:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [10:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "11" *) 
  (* C_ADDRB_WIDTH = "11" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "8" *) 
  (* C_COMMON_CLK = "1" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "2" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     10.7492 mW" *) 
  (* C_FAMILY = "spartan7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "1" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "blk_mem_gen_0.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "2" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "2048" *) 
  (* C_READ_DEPTH_B = "2048" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "32" *) 
  (* C_READ_WIDTH_B = "32" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "1" *) 
  (* C_USE_BYTE_WEB = "1" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "4" *) 
  (* C_WEB_WIDTH = "4" *) 
  (* C_WRITE_DEPTH_A = "2048" *) 
  (* C_WRITE_DEPTH_B = "2048" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "spartan7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  blk_mem_gen_0_blk_mem_gen_v8_4_5 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb(dinb),
        .douta(douta),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(enb),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[10:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[10:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[31:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(web));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2022.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
VHPlDkoDlWlBfBMvPBmGYmaek3s9hXXhjF28kllYPnaNm3TSnzzpXHWHc8Ye9/2L2yiQfJ1hTWou
Ia/zeQ8h9/dtr6QB5YkyW4wlb/LbMgXb+DGIXPSllNl0IMsRQIcQDbcQm1bO/nlhb+2pjxiuaQrl
DbvxoDwPs7z3LunRxsg=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
lmIhoX8hXuc7tNV1sXY1K2/gXL7Y7Hq73qQF7+x03UWWTRd3uhGmVQtOMVbhIW+66UkWUHiD26zL
fzqGor8bgSNGpSFyS11k4TwLQT4OfAMGO8C9Qmmh4+VENBnpS9TW+wHzCv8oUwht7xYtYRZvOvYK
F3fMppz2sBkUd1lciw98ZE/UmNkhqBuMfIYF43j45DEJ55PBhOZNg91Ls4v3qBHyBAaYPFFoMry3
d5Fw1PZyFQSEOSSpwgyds2aN0g6oIwl7zm0LJrM9VDAOxBUE50hk+oHr4jj8J8UhHQJnlEHm1Idm
rvxKygNKRvfSpa90NYxZJFYgqnrMYg+19+9aZA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
VkyCjO2onoeZWEoYQ/4ue7X5mkHyTYVW9xjdoTsGS4GdP/Q64VaCZL/jr6R8DVDXPMnH7tRMrDpo
jpYBnyzSgOkfgqM+96ioC2fDyAaG4gYgGLmrBR6qK3/mxXwAZZX+GJ9R/eWXkc9h8xN+gsSSX6/M
jIQCgeT6q7PB4dWT6KY=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Iub91V+TnhVlZCSLu6iKmFjix71y6/l83OPTs8uewWvkE7WcqYxEKi9fonXEkzAtWzuKwEUqnOlN
VBsNJqPUdKcd22q523mrdt89mpdosWD+hvZdO7ELhJniY5u9h49FFkubpN2JiUTcIcKEYxVNlds4
wyvaYUqbPVH5v2ooJwDdimS4GVn9HerCOgPwfshvQDNlMTxLcYju4v8BHMc5Rub9Q/ihvpQU74v2
ouZ9XIwA+C6pBLwvaqS8jE7HXOokgqJilaX/W/t+KEgiFry/txRTMU9WMD7tCN7lcfjCydmS3Lq+
3u6Hsr0S8BwNjcaDpZDnBTygUJd4JSqREnk33w==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
U46EWFmKmpZGaWfyL+dokyQtJtaOYsa7HCW/+fdtw9/yHKTWFpmqKBZngBj5rPkNhtTDDCJkqsYj
tUXg1j4tgIBaCQn9B0q/aG+B3gPLrudp9hLL25mVbsfiTzdekiV2hJMmhuMoavKKPJHC6zyW7kZi
80er82OQy8h+Df/fe6TRjH9xEt3/b80tRKUMbxkLfnnkAyyf1KfOhB6/uyI4mwXuQR+DsAbzybKR
YtXpOiW72tGrXTFlzcwbHamWZefqsilVpBw6V5dh33vYKGx50xwWpj76maAkpQrOpB7zufeldJe4
W1UOEN84AZdRTLkVSxamWo/wp8nP9fiGS/ItRw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_07", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
qczgIJYpE/SzErzK7eWJBGcDFEzDLm8cKbwJbPXuM6YnJxx44W+E60R3war7K2QGFAkOoCDUtDC7
SghJGF32btaDLzeKm0tQ669sBtQmMIaBrlt7I9QBkNM8zN9GL92qxNC9o3UVWMOYy5BmH8nUPgcE
O6lRubeltlrTuDe7UJQ2nEPHcXjpUJJ8dxktyW+LovBy1OxW8g4GRAsmEJsoOEg0HuDdWcc4IshJ
PvwPJ7LblELAKsdkSt65y9VaklaEm7MlH4ImlgIa74TgRmutLUbWxM1QYhGE5rAzFhGU5i3RJOdx
L3N7GGGvLMW2z9NSHbIFX+/eNII9fNJ9nZbgLA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Ti1NUgDv8YPk90APMwfu/mRr38QYwAxZfv0T6zQ89YS55t2EquEGVqrEafYX6rTydLOw8le1Oucv
f2oERpSSSTih/ScZneSZmuPE/Zh2BU1Ajv0j+/+0uEWXU+5lLPbDJjnapTmJXih1MYPf0SHpZZmE
BKj2IEBI9MPZlh6bxpa5BWJnyPdAvHf+UNaMXU9+pmbtrzUVebql4mFJu45Z3+ehmFY4FBW3zXMF
44C4TlHACLwL3vHVMCVfeKhgdVDbpE+/IFhTStz7mZ9h9RKGanQcs6YDVM1R+2RKA1QT1fX4FiQc
1V+FGmrm1ujxmFGXwpfNKByVlfCY0oWhRJCYYQ==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
HuEXFK0NXt09xU2yxxjng1OLsT+ZEM4EhqBgpr9D2ljw2vDaMBrqEsRQTc2B9soDq3ewDduHJXBd
OGYxkPnoN6LhjULtB2nTgjcH6NxA4puZ1ZNcndDndVBo8rTW5W1OqHq6InAG0CqPpTIkuqz3ECPl
EysI++MCDfH6tIzlekxJFIJ1McJsTq5rFuLzMMcrmkBxgcayDpOcCFuzZzCczxmt/cCCIKmDybwT
OQXmOcLJoYLP4sFu6R9c6xO8i6p++crv2N3eIxZHKbek9xBBZqQM9EYuEtsbkqAs9XZpa16i5njR
BDFxTKcP6r7JgFALJE89AZhBbate5JXWp0v4ECZD18aEL17CipwcWPutNMdG1apzSPP5y59n7rMG
yxBPz1gKHc3Emkl4WcO0hjICxqmO6dMXoY8JvBSf6ry2l0sH9Ihr3Bq5WWmlhPHnoaNr5jl//vNe
KfToWtn97eoVSt1LnmXXnSpdigbHr0UIg8AdkpdkuNRaWdVicDdgSo49

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
mokwst2bn6UxD6V9UdIgCIG1QQ/d0FiJqYGOTI2eHPV6YElaLjnJ8DnQmZnGS95o3x93FDOoa58C
RwYsX1fVoVtXkj1LuZq0k7q9vEe4T8xMjpkeYtIHY9k0Xhy1Lq/xRlfzGAf9fvf9e+f4r7aR/Sb/
uCZxxugG5niTwLENY1n3NthYL0jvo8Fmdw4Qg0nTCGWlVCws+09K0g9/lx6I9EcuHHemcHO3fOZG
lMc4NaPNozKwnyDMoWUkwiVxyFEPFaQLNYqzjvR+CqrWfhFLo96JWhL+eaDoNuZoBVYQtNH5ZwBL
BoO27Pw10lgcReGlZBz3BLO7T4ddynCx0+eSnw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
PiP7AjOQqqouyQMoBQqgWIDhUSViq94rIvGiIJ/UKMDspM/yXw1caE8AhWHTjYckC4yLpPAz5P6s
1Z6flzDPrzVwg4e59X2cc4IMCHhedna0rDO804njcc6amRDTeLsMLTkWfvomB4xwszm2AgT+PRnB
WHd09ZUDVFjiBXT+Oa9AicgGJHrX3w823yBPuAa704kje/SzgtiDpcTU1eLmLhLW7LpEd9KIHd9s
ER7Uk9Orws0Kq9PMTqMX4hMn5K5mFakOeOURiEbUjdv5RiIJ2g/PlQXSItM8fHsBTQa6fOaJwQTI
vHwK3a8ZBHpfT1YH+n7wNiNUZwD4SFXm1QVx4g==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Ul5ZfTHJwMctaNhYRortUZizYMPYRef7uYqPSuMkxsArnxI/cjGh+KRMwzV86hyp/6TXSJIjm5ec
2wX2UONdPN+DOJ84jYC4JbgJQrPnTj7ioD8uLX/WlyPcQzyF5keqFgj5eR5s13FskVWCuAWf5m9w
mhFEKFjVXDAr7gVgAJh/hL8P6Psrnf+LGfiM8JhnDepsHEYykGlpD3fzru2BGgqHWqPqFMcnyVGl
vysaIXiJz/eYKvO8RGcgd3DJAM/wPm9A0m/DWcmSnczOgTjoqkHcBg2H5uJMLvufzmjImi6LYEqq
v04ESDEN31cSUzqUYcayvMFOnI/WNsWbFIa5+Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 47760)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
