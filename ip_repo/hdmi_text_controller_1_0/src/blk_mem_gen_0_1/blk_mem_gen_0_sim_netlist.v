// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Thu Nov  5 17:22:05 2026
// Host        : amogks-laptop running 64-bit Fedora Linux 42 (Workstation Edition)
// Command     : write_verilog -force -mode funcsim
//               /home/amogk/Vivado/ECE-385-LABS/ip_repo/hdmi_text_controller_1_0/src/blk_mem_gen_0_1/blk_mem_gen_0_sim_netlist.v
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
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [1:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [10:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [15:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [15:0]douta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB WE" *) input [1:0]web;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [10:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DIN" *) input [15:0]dinb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [15:0]doutb;

  wire [10:0]addra;
  wire [10:0]addrb;
  wire clka;
  wire clkb;
  wire [15:0]dina;
  wire [15:0]dinb;
  wire [15:0]douta;
  wire [15:0]doutb;
  wire ena;
  wire enb;
  wire [1:0]wea;
  wire [1:0]web;
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
  wire [15:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "11" *) 
  (* C_ADDRB_WIDTH = "11" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "8" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "1" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     5.3746 mW" *) 
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
  (* C_READ_WIDTH_A = "16" *) 
  (* C_READ_WIDTH_B = "16" *) 
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
  (* C_WEA_WIDTH = "2" *) 
  (* C_WEB_WIDTH = "2" *) 
  (* C_WRITE_DEPTH_A = "2048" *) 
  (* C_WRITE_DEPTH_B = "2048" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "16" *) 
  (* C_WRITE_WIDTH_B = "16" *) 
  (* C_XDEVICEFAMILY = "spartan7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  blk_mem_gen_0_blk_mem_gen_v8_4_5 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
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
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[15:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb({1'b0,1'b0}),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 28864)
`pragma protect data_block
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
F2rxOisZ1ZKg/o3X7JiFeh2MJ5EAYA==
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
