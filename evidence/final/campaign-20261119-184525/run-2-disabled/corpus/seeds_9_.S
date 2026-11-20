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
  li x26, 0x0000000a0034680a
  csrw 0x300, x26 # MSTATUS (MPP=1)
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
  li x1, 0x7f03bc6bf0f59275
  li x2, 0x9ed422d720584216
  li x3, 0x7ef944e5a86b986b
  li x4, 0xc8aa609345fd4a5a
  li x5, 0x391f40393e39c607
  li x6, 0x082701039264cc15
  li x7, 0xa62162114cfd4c6c
  li x8, 0x3344c45f68ade2ef
  li x9, 0xa7ec283ac3ce94b2
  li x10, 0xeb13b713cbd24faf
  li x11, 0x3c678d2789daa41e
  li x12, 0x2ead4b9dfacd2308
  li x13, 0x5f15d93a9748c5c8
  li x14, 0xce865c1a6103c8e3
  li x15, 0xf7944ab64995dd4b
  li x16, 0x23c82f98148193b3
  li x17, 0x1b2074fd19c48b00
  li x18, 0x043c2deb77882608
  li x19, 0xfc55066a141e1af9
  li x20, 0x236ebe499414d1f6
  li x21, 0xd1c7d31984617758
  li x22, 0x20f555205816012d
  li x23, 0x505c80e2fa4e5dc0
  li x24, 0xf41a91e85dadec8a
  li x25, 0x94a8e6aaeff39715
  li x26, 0x5d61d4f95f1d892b
  li x27, 0x9d36018182e99256
  li x28, 0xd6b7472d8115c265
  li x29, 0x040998bf4e029989
  li x30, 0x07b9ee6e8b2748fd
  li x31, 0x16e69c86cf410b30
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
  fence.i
  slli a4, a4, 55
  mul sp, a4, s10
  mulhsu sp, a4, a4
  lwu a5, -1108(t6)
  fence.i
  subw zero, a4, a4
  lwu s4, 848(t6)
  slli t2, a4, 0
  mul s6, zero, s4
  divw s9, a5, s6
  divw a7, s4, s9
  remw s1, a7, s1
  or a4, t2, s3
  lb t4, 212(t6)
  fence.i
  remw s10, s10, t4
  rem s9, s10, a4
  sub a2, s1, s10
  divuw s0, s0, s9
  mulw s2, t0, s10
  lb ra, 583(t6)
  divu gp, s9, s2
  srli t3, ra, 60
  srliw t0, gp, 1
  fence.i
  srlw sp, s2, t2
  fence.i
  divuw s4, t3, t3
  slli s11, s4, 51
  fence.i
  rem a5, t3, t0
  div gp, s11, t0
  fence.i
  rem tp, s11, tp
  sraiw a3, a5, 0
  srli a0, gp, 3
  divw s1, s1, a0
  srliw a1, gp, 1
  divw ra, ra, s1
  mulw gp, s1, a0
  lui s5, 0
  mulw tp, a1, a1
  fence.i
  fence.i
  srai s2, s3, 1
  remw a6, s5, ra
  fence.i
  divuw s1, s2, gp
  remw sp, s1, s1
  fence.i
  srliw s7, tp, 6
  fence.i
  sraw a1, a1, s7
  divu t4, a6, a1
  sra sp, s1, a6
  sw a6, -228(t6)
  divw s2, sp, s7
  fence.i
  divu s10, s10, a1
  sw s2, -320(t6)
  srl a0, s4, zero
  mulw s6, t4, s2
  div s1, s10, t0
  divu zero, a0, s10
  sltu a2, s6, sp
  sb s6, -788(t6)
  fence.i
  sraiw s3, a4, 18
  ori s9, s6, -209
  fence.i
  divw a0, sp, s9
  remw a6, a2, a0
  fence.i
  fence.i
  sraw a1, a1, s9
  divu a3, a1, s9
  ld s6, 1152(t6)
  div t4, a3, t4
  remw a3, t4, a0
  mul gp, a0, a1
  fence.i
  lbu a0, -11(t6)
  srai s11, t0, 1
  remu t3, a0, a0
  srlw s7, gp, s11
  mulhu s5, s11, s5
  fence.i
  rem t0, t0, t3
  slliw t1, t3, 0
  fence.i
  sll s3, s5, s7
  add a3, t1, t1
  remuw t4, t0, t4
  div a4, s7, t1
  remu a0, s3, a4
  srlw s7, a4, a3
  divw a6, t4, s7
  addiw s9, a4, 2032
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
.word 0x9707f3b6, 0x16a060fb, 0xf69c0fa2, 0xfc363fea, 0x1a429e98, 0x3dea601a, 0x8c6c939f, 0x945ccb8d
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0xecfc8068, 0xf35ab646, 0x0a166705, 0xc9288e0d, 0x4a0150ea, 0x66f5d048, 0x53ea02ef, 0xe66992c8
.word 0x06d85191, 0x5143b07c, 0xc7caa6bb, 0xf72ea06f, 0x8565e425, 0x2c1c7ad1, 0x2e933655, 0x361fa948
.word 0xc854a929, 0x9ff34e89, 0x56efcabd, 0x573236e4, 0xd76cb149, 0xf49a2a93, 0x2bfe65e0, 0xf1627ddc
.word 0x0f9a534d, 0x35191b24, 0xae6c8237, 0x6b4efc31, 0x17b418c7, 0xd77d9ac1, 0x75bb5707, 0x4f51e91f
.word 0xdebd24ae, 0x0358e294, 0x4b6e992d, 0x50941186, 0x26f1e219, 0xee56350b, 0x193525a7, 0x079f1a5a
.word 0x50d7b312, 0x6f87f84f, 0xaf214d45, 0xd2f1453c, 0x18994680, 0xfb926737, 0xbef1731f, 0x48efc36c
.word 0xf93497a7, 0x3d10948b, 0xf9d93dcb, 0x8d7dc8f3, 0x3e63818f, 0x20acb701, 0x1425627a, 0x8c0a28b2
.word 0x2e7f0f56, 0xf6101525, 0x95aa36d8, 0xac1cad80, 0x3c37a068, 0x128d891d, 0x83b76768, 0x33e80a25
.word 0x5c996842, 0x45095059, 0x6fa54dd6, 0xddb9fd2d, 0x3bea22b4, 0xf287269b, 0xac9fd415, 0x4cfd07a9
.word 0x89fa6d21, 0xd4c6ad23, 0x4c84ae35, 0x046ccdcd, 0xfbc8a334, 0xd5d4d61b, 0xd07e5001, 0x7e5aafea
.word 0xec280ab4, 0xb9ec1b5d, 0xc4a60440, 0xbe0fb7d1, 0xe13fbc76, 0xd8ec1cd4, 0x75a9c527, 0x6f19281d
.word 0x3f100b9e, 0x01069a32, 0xc1fcffba, 0x10ffb83a, 0xe57fc992, 0x6e51b41f, 0x8cf8d2da, 0x374197e5
.word 0x0df3d301, 0x052726fe, 0x49261a5f, 0x748795af, 0x944d9e6d, 0x709d5df1, 0xc7168c83, 0x888c5ef7
.word 0x763cc7de, 0x87f82ab0, 0x5afa117d, 0x9afa1293, 0xb67e01f4, 0x1ddc48f2, 0x7845a1e7, 0x06557793
.word 0x120d0e6d, 0x3bdd5068, 0x262c1ad1, 0x829c6d1f, 0x163eacfd, 0xa9cbfb1c, 0x8e7c7a0f, 0x33c5f3c1
.word 0xe042cd97, 0x1a5aef8f, 0x179e64c6, 0xb778f772, 0x42c279e0, 0x1e6b90dc, 0xa541631e, 0x6cdc27d2
.word 0x3fe0a563, 0x45e8ef2b, 0x994259bb, 0x7aef3487, 0xfae90348, 0xe961c5d9, 0x575a764b, 0x8a78004a
.word 0x1a51b2c7, 0x8d9f491c, 0xc05706db, 0x8f19f0f1, 0xa340e29f, 0x16b528b8, 0xc3559347, 0x16982639
.word 0x89b1c40c, 0xf7780328, 0x370727ec, 0xaab79261, 0xef21eddb, 0x2df5e9dc, 0x44af9a24, 0x16cc077f
.word 0x9a86e504, 0xef03511d, 0xdf6300ef, 0x3341004e, 0x4394b0e3, 0x5c8dccf6, 0x2915f860, 0x39dca6c5
.word 0xb4adf415, 0x69b30db6, 0xc7fc2f31, 0x8119e60c, 0x64761593, 0x1b2df62e, 0x246e40c3, 0x2b7b2899
.word 0xe36dc2e4, 0x8ad5d1f5, 0x19b7deff, 0xa8c02650, 0x1be86d4c, 0x7bbcfa07, 0xdd9aeb53, 0xc979cc29
.word 0x1be2fb38, 0xfdae492b, 0xb5bc39ce, 0x4254c227, 0x1f29cdd3, 0x4ec1257b, 0x5f0eea38, 0x8c0da1eb
.word 0x850b2d66, 0x12e5add6, 0x639b69bc, 0x19c74938, 0x02b3a12f, 0xc88f3cb1, 0x1e5e583c, 0xb75d1bfa
.word 0x71512a17, 0x585805fa, 0xdd8972ac, 0xcc9067e2, 0xf0e02ac3, 0x4cbd9ebc, 0xecea195c, 0x65c5cb8c
.word 0x1764cfe6, 0x8b2e2708, 0x2f1d11d6, 0xd593491d, 0x10cb0a65, 0x24b9bcb4, 0x9b4267c7, 0x767fc3ed
.word 0x450f64b5, 0x90d2a7c0, 0x4337748d, 0x301d8e93, 0x9421e811, 0xbc422ea8, 0x2b8672ba, 0x30b4aeee
.word 0x8437b79d, 0xb78f1ff7, 0x20fe2596, 0x3a5557e4, 0x803423d1, 0x894ace9e, 0x1d506219, 0xc8169fca
.word 0x5ab45454, 0x33d17a09, 0xc08b4263, 0x49913e7e, 0x13867397, 0x234fbf54, 0x4198c489, 0x5a344160
.word 0x96eb8a01, 0x919ac6c1, 0x718881cc, 0x6d61b343, 0x141f6f41, 0x21cc585b, 0x5949bb0d, 0xff027e98
.word 0xa50f4731, 0x9c2ed039, 0xf9a75d71, 0xa4ca263f, 0x2f8c210b, 0x00a9f349, 0xbe77da44, 0x87e40cf9
.word 0xf148a231, 0x2d14829d, 0xfedd12ee, 0xc490355f, 0x21ae0f29, 0xdd0bc38c, 0x77db76dd, 0x25258977
.zero 7168
mem_region_end:
