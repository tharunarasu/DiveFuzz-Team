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
  li x26, 0x0000000a0060388a
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
  li x1, 0x7c349d8838e3ee61
  li x2, 0x8956140e25927068
  li x3, 0x37bfbe440a67f5e5
  li x4, 0xbc08990924ae05b8
  li x5, 0xfd0bdd721a7e73c8
  li x6, 0x601618e03ae241c1
  li x7, 0x1b824530598fd79f
  li x8, 0x188d89c0dde36194
  li x9, 0xc8a0cc5625c8585d
  li x10, 0x5f50ce9939527456
  li x11, 0xe253ea7d3fa7e1e6
  li x12, 0xede7a3573ae22351
  li x13, 0x1a7f2c5bd44d67bb
  li x14, 0xb8e3de2a705f5f61
  li x15, 0x4cc53886731f2346
  li x16, 0xc610bdec57590ad1
  li x17, 0x209042fee6851111
  li x18, 0x5c5d32e1708b8575
  li x19, 0xc519224d751f7754
  li x20, 0x52b8cff4905d12ed
  li x21, 0x692f31fdac35fa7f
  li x22, 0xdb487c6fa8e2221e
  li x23, 0x5d81124de90417ce
  li x24, 0x5853c5a693a1ee03
  li x25, 0xc22845946a606ba3
  li x26, 0x0c3ca1105b8a2673
  li x27, 0x802ad12f8aa6a522
  li x28, 0x7fd5b1ab3dcd4b67
  li x29, 0x4c93252e24cbbcae
  li x30, 0x380cfca00f3a03d4
  li x31, 0x470738497feff323
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
  remuw a0, a0, a0
  sll s8, t2, a0
  mulw ra, a0, s8
  srli a6, ra, 0
  fence.i
  mulhsu t3, a0, a0
  div t0, t0, t3
  div s3, t3, a6
  rem a5, a5, t1
  fence.i
  sll a1, s9, t3
  fence.i
  sllw a0, a0, a5
  slti s1, t0, 1769
  srli s10, s3, 42
  fence.i
  fence.i
  fence.i
  div a2, a2, a0
  andi t3, s10, 753
  remuw t4, a2, t3
  div s4, s4, s1
  divw a6, t4, t4
  divw t2, t3, t4
  divw s5, t4, a6
  rem sp, s4, t2
  mulhsu a7, t4, a3
  sraiw s10, s10, 0
  fence.i
  subw a1, s10, s10
  remuw t1, a1, a1
  fence.i
  mulhsu t3, a1, t3
  mulw a7, tp, a1
  fence.i
  fence.i
  mulhu a2, t1, a7
  sraiw t2, t1, 1
  srai s2, a2, 49
  xor zero, a7, a2
  mul ra, t2, zero
  srli t3, t3, 63
  div a7, s5, ra
  li a4, -549755813888
  ori s1, s4, 2047
  addiw a0, s1, -973
  fence.i
  slli t4, t4, 4
  slti s7, t4, -2048
  remu a1, s7, a3
  div s4, a0, a0
  fence.i
  divw s8, a6, s4
  sd s4, -752(t6)
  fence.i
  sllw sp, s4, t4
  lhu s2, -1422(t6)
  lw t4, -184(t6)
  subw ra, sp, s11
  srai t3, s10, 1
  sraiw t1, t1, 6
  remw s5, ra, s4
  mul gp, sp, s6
  fence.i
  srliw a3, t1, 0
  remu s11, gp, s11
  xori s9, s5, -1
  remu a6, a0, gp
  fence.i
  xor a4, a6, a4
  fence.i
  divu t2, gp, a3
  fence.i
  mulhsu s10, a4, t2
  mul a1, a4, t2
  div s7, t2, s7
  fence.i
  slt s8, s10, s7
  fence.i
  ld a7, 80(t6)
  remw s8, a1, s7
  mulhsu zero, s10, s0
  mulhu sp, s7, sp
  srli t0, a7, 63
  mulw a5, s8, t0
  divw s5, t3, t0
  sll t4, a5, a5
  fence.i
  lhu a4, 1334(t6)
  remuw a5, t0, a5
  sub gp, t3, t0
  remuw s11, a5, gp
  srl s7, gp, gp
  divuw tp, s7, s7
  mul sp, t1, a5
  fence.i
  ld a2, 1672(t6)
  mulw a3, tp, a4
  lw t2, 1464(t6)
  remuw a0, a3, t4
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
.word 0x51909eab, 0x73924b0d, 0xc51fdbf8, 0xabb02bd6, 0x7c42b597, 0x7d93db2b, 0x7678748e, 0x38b9187d
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x89a23a3e, 0xa60e3413, 0xe8948cd7, 0x0acbc2ec, 0xe3b3e7de, 0xb0ab8d7c, 0xbac52a02, 0x1cf333f2
.word 0x1a00275b, 0x8c3f7f78, 0xc6942fa7, 0x7af6c413, 0x43c1a382, 0x0a7e4d00, 0x15d1385c, 0x24f56c81
.word 0x0d90b7aa, 0x8371ea7a, 0x284adbcf, 0x7ea4ca2c, 0x6e9041ff, 0xf1b1a38f, 0xa2171f1d, 0x58d5caed
.word 0x3e90870c, 0xba27a436, 0xe62277b3, 0xcd8df21b, 0x84e60304, 0x4a3df300, 0xae588b57, 0x19ef5d97
.word 0x2a5c7985, 0x2ae23900, 0xc34a751e, 0xd303db61, 0x506e7510, 0x3705756b, 0x6973b9f3, 0x14197bea
.word 0x05bc6d72, 0x5825e844, 0xa0585303, 0xaa7c3221, 0xb1d3f028, 0xd80afcaa, 0x8dc50088, 0xdda505d6
.word 0x24becc39, 0x03e1177a, 0x61ffc335, 0xb985f9f7, 0x349c3174, 0x2416ce31, 0xd7a89345, 0xe98773c6
.word 0x549fe149, 0xf5263c3f, 0xf349e443, 0x6f5828fc, 0xbbd109f7, 0x89bf00fc, 0xbb97b710, 0x8f9d0bf5
.word 0x95542cb8, 0xda91dcd7, 0x438000a5, 0x0cfb4949, 0xb42fa02c, 0xa87c7ffb, 0xfc6a791b, 0xabe0ae4d
.word 0x57bf3ef5, 0x4004a233, 0xbb2ca452, 0xd79f0451, 0x3de71579, 0x7e8c9930, 0xce44f991, 0xf3269d92
.word 0x3f6b75a6, 0x81437ef2, 0xb6e2272a, 0x25ca7e58, 0xd07b63f0, 0xf8f35a22, 0x6656f5d6, 0x64f19138
.word 0x0343c757, 0x72510df0, 0x9e7d60b2, 0x76fdbe92, 0x2acf05c6, 0x82f8800a, 0x6d927960, 0x18dc7d10
.word 0x337f05d7, 0x47f10a5c, 0x3c69a9e9, 0xb726e7ff, 0xb1c36ec0, 0x40cf67b6, 0x7a3438f1, 0xdecd9ba8
.word 0x28082f5e, 0x3636d78a, 0x0b0c5331, 0x5c38f524, 0xea3b8d85, 0x01688967, 0x858011f2, 0x55a845f5
.word 0xb0d81991, 0x025728e2, 0xcb33a7c5, 0x8252bd72, 0xf56120ad, 0xecaf45db, 0x25a20412, 0xb90ac743
.word 0x17952be6, 0x988b1ade, 0xb878640c, 0xd6a9990c, 0xcee72210, 0x01ca359c, 0xf0724b1a, 0x1a9f4c62
.word 0xce98d6ae, 0x6f6fb71f, 0xc87cbba0, 0xd7d5c1aa, 0x998cabec, 0xc15d4a4b, 0x59101477, 0x0d9e9173
.word 0xe5dd0b0e, 0x736e6601, 0xad8cc5f2, 0x6c6a3d56, 0x4980ee27, 0x71c42400, 0x1d6e1cfc, 0xbdc92df4
.word 0xeff85d85, 0x16932350, 0x2e4f82c6, 0x2c8d7e2e, 0x46478b5c, 0x57904629, 0xf9b00029, 0x45e7af7e
.word 0x9ba95a7b, 0x61f54481, 0x98582104, 0xf6953ddb, 0x72366f34, 0x3f387228, 0x52c23cb1, 0xc95c3abf
.word 0xc738a9a6, 0x0699fe8a, 0x0ba8e330, 0x54d6008b, 0x68e1bb78, 0x8e3038a2, 0xfc85d5a6, 0xd6bf04f3
.word 0x1b740cbc, 0x9dd14f1d, 0x678de004, 0xd650b5db, 0x827eab2b, 0x1a85f336, 0x4ce912e8, 0x2482e478
.word 0x08dd2c2d, 0x8fd20928, 0x26f297c1, 0xcb98cda5, 0x0c5c3c63, 0x836b7d60, 0xe2cf8d68, 0x603a26d1
.word 0x4d2be1da, 0x0ba0f6a2, 0x805ef843, 0x4e1d56e1, 0xc59c81a2, 0xb9c7d5c1, 0x2f3ca983, 0xb69ef78c
.word 0x4431d916, 0x47e8129e, 0x48f1ea89, 0x419957bf, 0x20b47d88, 0x0b68f8d1, 0xd9a2f9e0, 0x0fa414df
.word 0x2341f06c, 0x830a5f48, 0xd0556006, 0xc112c4db, 0x2f0d9c49, 0x9869dca7, 0x5cd74b5e, 0xed40f139
.word 0xf90ff71a, 0x7c010d62, 0x934abf9e, 0x108d9c8c, 0xf8ebced1, 0x309ad143, 0x0cdf1969, 0x7e907570
.word 0xb6c51d95, 0xd1420cf0, 0xabb74d3c, 0x02b08af8, 0x3f190666, 0x80a5e99c, 0x8567fedb, 0x4c7288fc
.word 0xa9ee70cb, 0x9402da38, 0x3fe27848, 0x002801cb, 0xe5f80f26, 0x18964bb0, 0x04928f02, 0x0f883f67
.word 0x35d8e1e8, 0x0b25fff0, 0x443d6f42, 0x03f8b443, 0x4f703124, 0xf72dc413, 0x65eee408, 0x52ff49ed
.word 0x7e2d698e, 0x17a88e79, 0x2b251952, 0x6dfc590f, 0x21ba5d0c, 0x74fe2573, 0x348abb3f, 0x95a39188
.word 0x0dbf2521, 0x1af6a79f, 0x7ba39d1c, 0xe6dda3fa, 0xae3e7f27, 0x3d303563, 0x74039b28, 0xbac87505
.zero 7168
mem_region_end:
