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
  li x26, 0x0000000a00482182
  csrw 0x300, x26 # MSTATUS (MPP=0)
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
  sfence.vma x0, x0
  mret
init:
  li x1, 0xcf03abbc3356abdf
  li x2, 0x120b98f5aeb72bed
  li x3, 0x6335e1843618f507
  li x4, 0x88dba792514dfee1
  li x5, 0xf1d4f93c5d9a2e00
  li x6, 0x073b08e348d3de49
  li x7, 0x4d75493c76ce1c6c
  li x8, 0x21b24a2c673e812f
  li x9, 0xaf6af3f2cd45b71a
  li x10, 0x690e08ca2c604142
  li x11, 0xda62febfa78489b6
  li x12, 0x6f24d02dc170f112
  li x13, 0xd0528589abfd1369
  li x14, 0xa058a02898810699
  li x15, 0xe137fef7325721e1
  li x16, 0xa99123ac1a8068b6
  li x17, 0xf8283eeb1b3c5ea7
  li x18, 0x2fb0057579a2cd0a
  li x19, 0xccf15a8d8b54c183
  li x20, 0xa3d0c99d64db38dc
  li x21, 0xae19edab9b029ab2
  li x22, 0xe997402086dae7d0
  li x23, 0x0cf3d9ffe7d3e8a6
  li x24, 0x8a54a454acd6a68d
  li x25, 0xdb97170075037734
  li x26, 0x9d214b9a9ab591d8
  li x27, 0xfc22d5a19f3b829a
  li x28, 0xa37a9c907b168f1b
  li x29, 0x0dc01bc6ed0fee13
  li x30, 0x8778527633eaf352
  li x31, 0x13081a73fc556e6d
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
  and a7, s4, a7
  mulw sp, a7, t0
  sb sp, -161(t6)
  srai s5, a7, 38
  mulw s0, s5, sp
  divw s11, a6, s0
  srliw s11, t4, 28
  mul a3, s9, gp
  mulhu t2, t4, s11
  auipc ra, 321281
  mulw s3, gp, ra
  remw t3, t3, s11
  div s2, s2, t4
  xori s10, s10, -1
  sllw t1, s2, t1
  subw s3, s2, t1
  remu a2, t1, a2
  srlw s7, t1, a3
  mul s8, s10, s10
  divw s10, s5, s10
  remu a5, a5, s1
  sltu s9, sp, a5
  divw s5, s3, s5
  divw tp, s9, s3
  andi s0, tp, -469
  divu s11, s8, s11
  divw s3, s0, s9
  srai a5, s5, 1
  divuw s8, gp, s9
  divuw a5, s8, a6
  mul gp, s9, s9
  sw a5, 1576(t6)
  sd a2, 1120(t6)
  mulhu a4, s8, a5
  mulhsu a6, a6, a5
  sub a1, s4, t2
  sllw s9, a5, a1
  slli s1, s9, 21
  divw t1, a1, tp
  sraiw s11, t1, 31
  sraw t2, t2, s3
  divw a2, sp, t1
  sllw a7, sp, a6
  sllw s11, a2, sp
  divuw s10, s11, a2
  auipc t2, 1048575
  slt t0, t0, t0
  remuw gp, t2, t2
  rem s0, ra, s0
  mulhsu s4, ra, ra
  mulw t1, s4, s0
  subw zero, ra, t1
  li s8, -524022828481
  remw s9, s8, a4
  div s5, a2, s2
  slliw s7, s10, 12
  divu s9, a0, a0
  divw t4, s10, a3
  sltu zero, s10, ra
  rem s0, a2, zero
  srli a5, a3, 0
  sd s0, 1152(t6)
  lui s10, 982474
  div a6, s10, s10
  sraiw s6, s7, 0
  remu t1, s4, sp
  srai gp, gp, 40
  srai a2, s6, 17
  remuw t0, sp, a2
  srli a5, a2, 21
  divuw t4, tp, t0
  div t3, t4, t0
  divu s3, s10, sp
  divw t4, s11, s9
  divw a5, s5, s0
  sw s5, -700(t6)
  div a3, a3, s10
  divuw s6, t4, s6
  mulhsu s1, a5, s6
  slli t2, t0, 18
  remuw s8, s1, s8
  mulhu a6, t2, a1
  srliw gp, s1, 20
  mulw tp, tp, t2
  div a1, a1, s8
  mul a2, a1, sp
  mulhsu a7, tp, a1
  rem t0, a7, s2
  div s0, s2, ra
  remw a1, ra, t0
  mulhu s1, ra, s0
  remu t3, sp, s0
  sltiu a5, a1, 1641
  slliw a4, s7, 0
  remw t2, s1, t2
  remuw s3, a5, s6
  and a0, a5, s3
  or s2, t2, s3
  remuw s11, a0, t4
  div a3, s2, a3
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
.word 0x763d1103, 0x4fce32db, 0x6d31b48e, 0xd5a167c0, 0xf8792014, 0xb8809437, 0x023d024b, 0x74ff261f
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0xe7867536, 0x92afb168, 0xb569dbde, 0x83a95d1c, 0x2d481432, 0xd0db364e, 0x3eb0a6aa, 0xd4ca0767
.word 0xbe3939c2, 0x96f6e978, 0x315b9fab, 0xa970e265, 0x2559a4fa, 0x5e225930, 0x5601638e, 0xba953902
.word 0x8e9672a2, 0xdea5472f, 0x7478d5eb, 0xc8e6b9fd, 0x8ffc2c9a, 0x432c89aa, 0x834bb465, 0xe5f434da
.word 0x31e0abf6, 0xe5e5d1f3, 0xa4cc5e5b, 0xd4cc2db1, 0xdb1ca43a, 0xc80b6d4d, 0xfc8670fd, 0xd57eaf2b
.word 0x17e690cd, 0xb2c7d284, 0x214544b9, 0x0de7aa2c, 0xdaab45d4, 0x1f5ba0f9, 0x1aae9f32, 0x827c1be0
.word 0xf1578839, 0x9a0461c6, 0x9d025d43, 0x5b942dd1, 0x788d3734, 0xbe917955, 0x16928cad, 0x637ab1e6
.word 0x017bdaa6, 0xa04bc2a5, 0xb58e8e5c, 0x15e24f5d, 0x76b18e51, 0xbdfae11c, 0x8a7f6d0c, 0x65674e4e
.word 0x85f33c67, 0xb40b53b2, 0xcbfd337d, 0x98467176, 0xbc52359e, 0xda6cffa0, 0x9f07ca43, 0xf2a852b7
.word 0x5f7a68fd, 0xd872c18c, 0xad7af5e6, 0x5554389b, 0xaa8360ee, 0x4fb65ac0, 0x97f18a13, 0x400819d4
.word 0xce848e45, 0xaf1f4487, 0x8101a526, 0x46ab0774, 0x09a1a141, 0xab929e94, 0x8422cb94, 0x5fe9ce68
.word 0x1c8d6943, 0xa8c62efb, 0xf76e4f54, 0xda697f51, 0x2cb6295e, 0xa2ec4eec, 0x8abec8af, 0x54a46c87
.word 0xe5e3ca50, 0xba11a022, 0xbdf20d45, 0xa0b1f3a3, 0xee8d27bf, 0x0bb1d6b8, 0x4bfe08c9, 0x3f324952
.word 0x3acbaa48, 0x5661815d, 0xea810a84, 0xe5ff694a, 0xc4f9f2a0, 0x94e7db91, 0x64112415, 0x7c7eadfa
.word 0xaf11d383, 0x975059c1, 0xe3c0515b, 0x6b224e12, 0x2474afa2, 0xc07cb206, 0xc0ab682e, 0x31969253
.word 0x6e7936ff, 0x739274de, 0x9dc11dfc, 0x6285cc2f, 0x7aa7c827, 0xfa6858dc, 0xf91914f3, 0x63722603
.word 0xce1d0ec6, 0xdc8dc852, 0x870ee773, 0x28ba6900, 0x4363f610, 0x55074f48, 0x0dccd31f, 0x590513cf
.word 0x16d13bdc, 0x1d2bc136, 0x6a801bdd, 0x7c2450c3, 0xcb49e1ca, 0xb362ef05, 0xd04013b0, 0x0e6264e6
.word 0x2ded6a7c, 0x4cfa67f6, 0x375d2e42, 0xc4602cdd, 0xbbcc0fa3, 0x3f4de09e, 0x35074068, 0x1d486aec
.word 0x12d8f890, 0x12919577, 0xaf93e5e6, 0xc9169029, 0x42bf747c, 0xcd0a5cab, 0x2a307750, 0xf4be9af5
.word 0xd5d4b1dc, 0x11bac4f6, 0xe7a7c5ea, 0x3fa03a3c, 0x28ba46ae, 0x2d017f9d, 0xe3a53588, 0xc6464a46
.word 0x52febbe0, 0x9340bd75, 0x13b3c490, 0x6fa8f81b, 0x445c68c5, 0x056f81d3, 0xf8514fc9, 0x2633f1c8
.word 0xdcc34868, 0xbea1c8b0, 0xce307f97, 0x3d04f102, 0xce82126e, 0x9532c0ab, 0x48ed53e8, 0x070c917a
.word 0x7e4d8806, 0x8ced7362, 0x589830f4, 0xdf4d715b, 0xe5028429, 0x4a8a6ce3, 0xad1c9b81, 0x79cdd1dd
.word 0x76f2b5d4, 0xdb1e1991, 0xe87c3eec, 0x982318db, 0x10a025c3, 0xcafe3298, 0xd03a202f, 0x4cb71a82
.word 0x52a14ef5, 0x3b140388, 0xa3ad5acf, 0xee09ea6b, 0xb4ffb07d, 0xb7483231, 0x88673f37, 0x382ca4ac
.word 0xa78cbc90, 0xaab34947, 0xbc4dd2f5, 0x599f73e9, 0xa314a4ee, 0xd44e5a9c, 0x678ec279, 0xe339ee24
.word 0xff0256bc, 0xc574da21, 0xe4c9fb57, 0xc1d82a2f, 0x65eac60b, 0x17000158, 0x60b83ad4, 0x4f9c0f84
.word 0x1c816661, 0x6f7ca460, 0xd5713625, 0x226d98c3, 0xb34d3696, 0x0cb58ddd, 0x8ffb4159, 0x5947e91c
.word 0x63cac12c, 0xd0235eea, 0x9d5b4737, 0x2973ec4b, 0x3acd0af8, 0xe7f7b7dc, 0x0ac0f6ef, 0xc13d07d6
.word 0x62c1392d, 0x2a0b096b, 0xcd7ddafb, 0x43b2f298, 0x1f54e49d, 0x9738baff, 0xb99480f9, 0xb9d79453
.word 0xca9a0c42, 0xe6ccf5df, 0x80e5c773, 0xd73012d9, 0xd94a4731, 0x752c5124, 0x42db1a14, 0xf8253e5d
.word 0x190291db, 0xfad56da2, 0x2ee4f002, 0xb55f4fdf, 0x4f19c01e, 0xa31caeb5, 0x10440366, 0x8487fed3
.zero 7168
mem_region_end:
