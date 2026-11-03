// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Tue Nov  3 18:10:07 2026
// Host        : 249c9f910381 running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/user/ECE-385-LABS/ip_repo/hdmi_text_controller_1_0/src/blk_mem_gen_0/blk_mem_gen_0_sim_netlist.v
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
  wire clkb;
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
  (* C_COMMON_CLK = "0" *) 
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
  (* C_READ_DEPTH_A = "1200" *) 
  (* C_READ_DEPTH_B = "1200" *) 
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
  (* C_WRITE_DEPTH_A = "1200" *) 
  (* C_WRITE_DEPTH_B = "1200" *) 
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 48192)
`pragma protect data_block
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
Ljj16t2g2MDy3kz+yN/jSVw8qVgP2S4SMxA5
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
