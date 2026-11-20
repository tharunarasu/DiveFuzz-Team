.globl _start
.section .text
_start:
trap_vec_init:
  la x13, other_exp
  csrw 0x305, x13 # MTVEC - M-mode trap handler
  la x13, other_exp_s
  csrw 0x105, x13 # STVEC - S-mode trap handler
mepc_setup:
  la x13, init
  csrw 0x341, x13
init_env:
  li x26, 0x0000000a001039a2
  csrw 0x300, x26 # MSTATUS (MPP=3)
  li x16, -0x1
  csrw 0x3b0, x16 # pmpaddr0 = all 1s (NAPOT full coverage)
  li x16, 0x1f
  csrw 0x3a0, x16 # pmpcfg0: entry 0 = NAPOT+RWX
  li x16, 0x0
  csrw 0x3a2, x16 # pmpcfg2 = 0 (disable remaining entries)
  li x26, 0x0
  csrw 0x302, x26 # MEDELEG - no delegation to S-mode
  csrw 0x303, x26 # MIDELEG - no delegation to S-mode
  csrw 0x304, x26 # MIE - disable all interrupts
  csrw 0x340, x26 # MSCRATCH - init to 0 for cosim sync
  csrw 0x343, x26 # MTVAL - init to 0 for cosim sync
  csrw 0x342, x26 # MCAUSE - init to 0 for cosim sync
  csrw 0x140, x26 # SSCRATCH - init to 0 for cosim sync
  csrw 0x143, x26 # STVAL - init to 0 for cosim sync
  csrw 0x142, x26 # SCAUSE - init to 0 for cosim sync
  csrw 0x141, x26 # SEPC - init to 0 for cosim sync
  mret
init:
  li x1, 0x124ad325756c3553
  li x2, 0xaa1eeb1cd8dddaf0
  li x3, 0xa7c04869520ac0a4
  li x4, 0x5f267ddf080bf32b
  li x5, 0x56a0d17c5f99dde7
  li x6, 0xdb84c6654554e4e8
  li x7, 0xb1b00103341234da
  li x8, 0x9010001f7bec052c
  li x9, 0x1bd8556f1b3b0f0d
  li x10, 0x28274feb8f8ea04e
  li x11, 0x711a58184a6467f1
  li x12, 0x0d63142368252201
  li x13, 0x2fa38cabf3756685
  li x14, 0x1e20a2fcf74a5579
  li x15, 0xd390a6320b267796
  li x16, 0x0cbc16b6a97acdd6
  li x17, 0xea043cc91008d6ea
  li x18, 0x52d6238364d676cf
  li x19, 0xa8f06c27a508c6ea
  li x20, 0x9b930dcf776de2f5
  li x21, 0x4b712c476fe13dc1
  li x22, 0x6685d4db9cda90db
  li x23, 0xd1829d252efc2117
  li x24, 0x48d513b89a1ed788
  li x25, 0xc2c30c7db44d6c06
  li x26, 0xbe570dd3367006c6
  li x27, 0xc481b41f48aeee1f
  li x28, 0x1a7fd3f4ac35d3c0
  li x29, 0x4e1a5e6a9405dc71
  li x30, 0x305540a7800da1d5
  li x31, 0x05a90a1156cfde02
  la t6, mem_region
  li t5, 4096
  add t6, t6, t5
  j main
.align 12
other_exp:
.option norvc
  csrr x13, 0x341
  addi x13, x13, 4
  csrw 0x341, x13
  mret
.option rvc
other_exp_s:
.option norvc
  csrr x13, 0x141
  addi x13, x13, 4
  csrw 0x141, x13
  sret
.option rvc
.align 2
.option norvc
main:
  srliw s2, a1, 27
  remuw gp, s4, s2
  remw t1, s2, gp
  srai a1, s2, 1
  divw sp, s3, gp
  subw s6, gp, t1
  div s1, sp, gp
  xor a5, s1, a1
  add s8, a1, a6
  lh a7, 382(t6)
  fence.i
  div a6, sp, s8
  sb a4, -841(t6)
  div a1, a7, a5
  divuw s11, a1, a5
  srli zero, s8, 0
  fence.i
  srl a0, a3, a1
  fence.i
  remu s7, a6, s7
  rem s10, zero, a1
  remw s8, s10, s7
  subw t0, s8, a6
  addiw ra, s8, -2048
  li s5, -380399921510
  divuw tp, s5, s10
  addiw t3, tp, -1
  sub a7, s1, t3
  divuw a5, tp, tp
  slti zero, s5, 1
  mulw gp, zero, a5
  lui s0, 0
  sraiw s8, a5, 14
  lwu t2, 1792(t6)
  sllw a3, s0, zero
  sllw s10, s0, s0
  fence.i
  divuw a6, a6, s8
  srliw gp, s10, 9
  mulhsu t1, a6, s3
  sra t4, gp, gp
  slli sp, sp, 10
  div s9, t4, sp
  sd gp, 744(t6)
  andi s8, t1, -2048
  slti a0, t4, 2047
  add zero, s8, t4
  sltu tp, t2, zero
  divu s10, t3, zero
  mulw s6, tp, zero
  divw a3, a3, a2
  nop
  sllw gp, s1, s8
  addiw a1, gp, 0
  srlw t2, s10, gp
  fence.i
  remu s3, s4, s6
  srli s8, a4, 51
  addw s9, s9, s3
  fence.i
  fence.i
  remuw s4, s8, s9
  sllw a0, s8, s8
  ori zero, s3, 0
  fence
  fence.i
  srai a4, ra, 0
  fence.i
  fence.i
  fence.i
  lwu a5, 996(t6)
  mul s6, s6, a4
  srli a6, s6, 50
  sh s1, -1380(t6)
  mulhu t1, t1, s10
  sh a5, -576(t6)
  fence.i
  mulw s0, t1, s10
  fence
  fence.i
  divu s3, s0, s6
  fence.i
  fence.i
  remw t3, t3, a6
  sh a4, 662(t6)
  sraiw ra, a7, 1
  mulhu s4, tp, t3
  mulw a6, ra, s3
  fence.i
  mulhu a0, a0, t3
  div s2, a6, t1
  srlw t0, a3, a0
  fence.i
  li t4, -1
  and s11, s11, t0
  mulhsu a5, s11, s2
  divw a1, t4, t0
  divuw a2, zero, a2
  srl s7, a1, s7
  fence.i
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
.4byte 0x0000006b
.option rvc
write_tohost:
  la t1, tohost
  li t2, 0x1
  sw t2, 0(t1)
_exit:
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  j _exit
debug_rom:
  dret
debug_exception:
  dret
instr_end:
  nop
.section .data
.align 6
.global tohost
tohost:
.dword 0x0
.align 6
.global fromhost
fromhost:
.dword 0x0
.section .region_0, "aw", @progbits
region_0:
.word 0x3e2e3bdc, 0x4bf6ad28, 0x356bd671, 0xbff88fc3, 0x94cbe66c, 0xf44f3c37, 0x5680c59c, 0x00b4be58
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x2af47f18, 0xd490defb, 0x5029c760, 0x12b55fdb, 0x230668d7, 0xae8b7e89, 0xe3ce39b6, 0x15fba6bf
.word 0xf6782bf7, 0xb10bfb3b, 0x819a7702, 0xeae5d047, 0x6ee42db2, 0x643f878a, 0xc19d26c7, 0xa0478987
.word 0x2ce18e78, 0xb6ceebb0, 0xd23f58e9, 0xb2ef8600, 0x761f9230, 0x5cea61fd, 0xbd5b66dd, 0xf94a48ba
.word 0x2e48d1f8, 0x6121536c, 0x80b4686a, 0xb9804355, 0x3da4764c, 0x8653154c, 0xaf803e89, 0x6dc18582
.word 0x50e628c4, 0x4e36031a, 0x75268ba0, 0x7025c697, 0x410e8732, 0x41a9e147, 0x7ddc4465, 0x48a3da32
.word 0xd7850f0d, 0x4bf10aa5, 0x097cb036, 0x6980515f, 0x5ceec5f6, 0x5b9d2365, 0xcb05734e, 0x3a329fc2
.word 0xbc3d79bd, 0x2f91cde8, 0x20518d14, 0x6f152928, 0x814a7877, 0x5d432996, 0x3d46746b, 0xdca3434d
.word 0x4b4f5105, 0xe9453d38, 0x89232c3c, 0x8021a432, 0x51a5d4b9, 0xbcb35a83, 0xa3128dac, 0xe09a5a98
.word 0x4be8ceaf, 0x4de18567, 0x0bdb5537, 0x0dd2c284, 0x6db75bd8, 0xcb382d76, 0xb5a31967, 0x8f2d8c82
.word 0xea5ef3bc, 0xa69e546d, 0xfc8eee94, 0xb4ca6a91, 0xfc7ea978, 0x12078a64, 0x573a14ba, 0x87676002
.word 0x211f8f85, 0x34cdfbd9, 0x3f2542fc, 0x84d665ad, 0xa336bb74, 0x5879d079, 0x5ebb9e5f, 0x3b86be92
.word 0x13cf6ae6, 0x26872af7, 0xb36f528f, 0x1f02a8d7, 0x8d293b83, 0x666c6887, 0x71b1c2a8, 0x2fc74a7f
.word 0xff7e1d33, 0x15c2cf78, 0xac8f9378, 0xee109575, 0xba18f534, 0xcb69b9c7, 0xbcc86548, 0x41b8a6a6
.word 0xcfec36ed, 0x6e4b5106, 0xfbbc0d69, 0xfc699bc2, 0x70ec3237, 0xa1f5cad3, 0x09df747a, 0x1a6eaeb7
.word 0x42a8ccf4, 0xe7f35904, 0xb9062180, 0x9fb173f0, 0x4c1e3aa4, 0x7688dbbf, 0x145c03e0, 0x45f3b8a5
.word 0x940bc18c, 0x784d9604, 0x0efff498, 0x5a3b6574, 0xe167152f, 0xdcf05777, 0x55722134, 0x3a093bc0
.word 0x54c99bdd, 0xe436150c, 0xacb4383c, 0x342b8a50, 0x31484b46, 0xb3f5f780, 0x31ad12da, 0x7b711f86
.word 0xdfac40e1, 0x15eb952f, 0xb8c04149, 0xe50c42eb, 0xd22461ae, 0x6d8c6383, 0x03f55e77, 0x2c0f24d8
.word 0x10de9665, 0x1fd7d1be, 0x98e58306, 0x54646df6, 0x61c5e171, 0x41cef3c6, 0xa3f59e1d, 0xfaa2408c
.word 0xdf767bb4, 0x1556720d, 0x16f0173b, 0xd16ed539, 0x8b983771, 0x3c743805, 0xc58f9f75, 0x80a09172
.word 0xdeebf199, 0x4ec1c935, 0x3d802585, 0xda672a0f, 0x8c943558, 0x9c0268c5, 0xf9fbbb66, 0x5cb79137
.word 0x6c4f554b, 0x3b5bca1f, 0xc52c394d, 0x028a0466, 0x99409950, 0xf26aa6bf, 0x40c089ed, 0xa7e03b4c
.word 0xa690f658, 0x11f95862, 0x3861f300, 0x89cd725f, 0x9b6374f4, 0xdb857143, 0x73f02d80, 0xa213c667
.word 0x8dac04c7, 0x3dbf0f8d, 0x55b2c789, 0x404b5fbb, 0x35500108, 0x0237f977, 0xc0048b19, 0x92f2282d
.word 0xcf992e22, 0xd3cff4b5, 0x0e2698e0, 0xa2dd6290, 0x835ee824, 0xa1c38eeb, 0xe82b3955, 0x3599c375
.word 0x71cca864, 0xc1ee9abb, 0x19a410e1, 0x69a286f8, 0xba120264, 0x52083d99, 0xcd461701, 0xeaa9141e
.word 0x6b17d8f4, 0x3c03a45b, 0x99cb3eb4, 0xbf430156, 0xd9ee6e21, 0x4be2bb56, 0x4a4711d5, 0x72656275
.word 0x1ec627c8, 0x5c27cc3b, 0xdba30529, 0xd1e0e6b4, 0x106ef537, 0x06e85fd7, 0xf80f5f92, 0x4979d98a
.word 0x1921bd98, 0x2d8ee1b8, 0xdfea3166, 0x10e4c3c3, 0x2298a092, 0xe4e2fc44, 0xedb4dca3, 0x9b118796
.word 0xac44edee, 0xc2b5634f, 0xadfe9e01, 0xbb9ccd1f, 0x0b021d91, 0x6e9f925f, 0xe90bf19c, 0x1a03c8f1
.word 0xa996dd76, 0x7aa6afdd, 0xde1c1e03, 0x7c2b38ec, 0xde98ee6c, 0xa9978901, 0x6bfd89a4, 0x882c3631
.word 0x94b3fbd2, 0x4879de78, 0x8b3369e3, 0x0977455b, 0xf501a407, 0x9c45cbc8, 0xfeb18321, 0x953f2c45
.zero 7168
mem_region_end:
