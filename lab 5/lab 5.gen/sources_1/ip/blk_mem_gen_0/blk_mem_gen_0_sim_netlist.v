// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Thu Oct  1 17:54:12 2026
// Host        : a770b275e0ee running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode funcsim {/home/user/ECE-385-LABS/lab 5/lab
//               5.gen/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0_sim_netlist.v}
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
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [9:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [15:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [15:0]douta;

  wire [9:0]addra;
  wire clka;
  wire [15:0]dina;
  wire [15:0]douta;
  wire ena;
  wire [0:0]wea;
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
  wire [15:0]NLW_U0_doutb_UNCONNECTED;
  wire [9:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [9:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [15:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "10" *) 
  (* C_ADDRB_WIDTH = "10" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "0" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     1.51805 mW" *) 
  (* C_FAMILY = "spartan7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
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
  (* C_MEM_TYPE = "0" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "1024" *) 
  (* C_READ_DEPTH_B = "1024" *) 
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
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "1024" *) 
  (* C_WRITE_DEPTH_B = "1024" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "16" *) 
  (* C_WRITE_WIDTH_B = "16" *) 
  (* C_XDEVICEFAMILY = "spartan7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  blk_mem_gen_0_blk_mem_gen_v8_4_5 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[15:0]),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[9:0]),
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
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[9:0]),
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
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(1'b0));
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 18928)
`pragma protect data_block
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
KqUiZA==
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
