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
  li x26, 0x0000000a005c690a
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
  li x1, 0xc4e9e6ee14be21c3
  li x2, 0x3e586e13d334eeb4
  li x3, 0x774cd14ab36afa87
  li x4, 0x238577b18ec195ba
  li x5, 0xe307ed1ff1d1dd43
  li x6, 0x4efa2e43b278343b
  li x7, 0x70b3fb5abf28d856
  li x8, 0x4ea998117fbe9487
  li x9, 0xb1b5523746cd419a
  li x10, 0x12a76e202ead3c6b
  li x11, 0xcf918b6fd5ea7b39
  li x12, 0x4b117ff0958f1b19
  li x13, 0x971753ecba306f56
  li x14, 0x1eb9de3237ab1b13
  li x15, 0x97c47bbc20904a7b
  li x16, 0x8f34f54054d05551
  li x17, 0x77c2599763d11b77
  li x18, 0x56a9b162cc85b34a
  li x19, 0xa0d9a057a003c936
  li x20, 0x5b2d9d14a4604be3
  li x21, 0x6263cc8bc439d198
  li x22, 0xb954d09a3e265851
  li x23, 0xb0dd996cec36b3e7
  li x24, 0xee15bd7de0253f49
  li x25, 0x924457b7038729df
  li x26, 0x82ff19d23f92bc83
  li x27, 0x2edee588852b171b
  li x28, 0xd2477d9f2a2f9b7c
  li x29, 0xa944833ca0574352
  li x30, 0x14a01628dea04f75
  li x31, 0xe19c217726112826
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
  remuw sp, sp, sp
  srl t4, t4, t4
  divuw a4, a4, a4
  divuw t2, sp, sp
  sltiu s8, t4, -1
  divuw s7, s1, t4
  divuw s3, a4, a0
  remw t3, a4, s8
  fence.i
  sllw a3, s3, a3
  fence.i
  addi a7, a3, 1471
  divw s0, t3, s0
  subw t2, s3, s3
  remu t0, a7, s0
  mulhu a1, a3, s2
  srliw s5, t2, 12
  srai s11, s5, 0
  rem t3, t2, a1
  fence.i
  li a2, -321907884930
  fence
  sltiu a7, t3, -2048
  mulw s1, a2, a7
  mul t4, s1, t1
  divuw s11, t1, t4
  remuw t3, s1, t3
  remu s0, s11, s7
  remu sp, s0, sp
  rem a7, a7, t3
  sd a7, 1984(t6)
  slliw s6, s11, 21
  srlw a4, s0, zero
  fence.i
  fence.i
  subw ra, ra, s11
  fence.i
  remuw s7, a6, a4
  fence.i
  srli a7, a7, 49
  lw t2, 128(t6)
  subw s5, s9, a4
  sllw gp, t2, a7
  divw s1, gp, a7
  fence.i
  addw a5, a2, a5
  rem t3, s5, a6
  mulw tp, a1, s3
  slliw t4, a2, 1
  fence.i
  mulhu a3, t3, t4
  divw t1, t3, t3
  mulw a4, a0, a3
  remw a3, t3, a3
  fence.i
  lui t2, 1
  remu s7, a3, t2
  remw a2, a3, t2
  div s2, a2, s6
  fence.i
  fence.i
  slti s5, a6, 1
  mulw ra, t2, ra
  divw tp, a2, s2
  sw s5, -1984(t6)
  fence.i
  mulw t0, s8, t0
  divuw gp, ra, gp
  mulw s1, tp, tp
  fence.i
  lhu t1, 1690(t6)
  lw s4, -476(t6)
  mulw s9, gp, s4
  fence.i
  fence.i
  divu a4, t1, s4
  addw tp, s1, sp
  lwu s2, -520(t6)
  remuw s10, a4, s10
  sraw s8, s9, s8
  fence.i
  slti a2, tp, 1050
  slli s11, s10, 0
  fence.i
  fence.i
  srlw s9, a2, s1
  srli gp, s10, 36
  rem a7, sp, s9
  rem ra, s4, ra
  divuw s10, a7, s10
  sd s10, 1208(t6)
  and a0, ra, a0
  mulhsu a2, s0, ra
  addi s4, a7, 949
  sllw s3, s3, a2
  sllw tp, tp, s6
  slli t0, s4, 0
  divuw a1, a1, s3
  subw s4, t2, s1
  ld t0, 1992(t6)
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
.word 0x349907c0, 0x316d2924, 0x167f25d5, 0xe9c6def9, 0x08f8fe7f, 0xed4c7502, 0xad30d4f2, 0x6b0837d6
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x818d7e0b, 0x836a3a79, 0xef085b11, 0xea27b001, 0xf5d6ebd4, 0xf108f38e, 0xc87018f0, 0x4bc56bad
.word 0x209b2e8d, 0x0b53aed0, 0xb0828dde, 0x084cc985, 0x92ed7fef, 0x9d0bd526, 0xc195dff9, 0x67324fb5
.word 0xe5f64a0d, 0x2b2b0c16, 0xd0d5a4c0, 0x67871776, 0xb0675e5e, 0x19f033cb, 0x448c53cf, 0x618c4431
.word 0x4c4da7ae, 0xf4643464, 0x47868208, 0x461b46c7, 0x29a3bef0, 0x498ddc8e, 0xd78a9919, 0x999f2011
.word 0x201707ef, 0x97c03200, 0xb427ba26, 0x838e1e5f, 0x83f56add, 0x37d67070, 0x0ba77bb5, 0x31f339aa
.word 0xe5f2d23d, 0x33876f18, 0x231a3a07, 0x0149c09a, 0x2986c517, 0x95cec05c, 0x836187b7, 0xe7a3cc81
.word 0x86658200, 0xcd21ff84, 0xfcd4be90, 0xd8cd92fe, 0x7582c93a, 0xc40ffca2, 0xf2cbfccd, 0x03620a6b
.word 0xb1dc227b, 0x342fa069, 0x66e2bfe0, 0xc6ebcbb1, 0xcc11c73c, 0x2f425d51, 0x0dde5f28, 0xb78010f3
.word 0x51417bf5, 0xb3c4777c, 0x94135dc0, 0xf326abe2, 0xe6ecfc60, 0xb1857ce8, 0x9fd422c7, 0x7680ef3c
.word 0xe4dbc354, 0x97578c59, 0x5efeff69, 0xb0724aba, 0x7e5a922c, 0xe5b9f13b, 0xd97bda1b, 0xb18466e5
.word 0x3dfc97c3, 0x0211db74, 0x5f30f5dc, 0x1ad6b4c9, 0xfcf4d7fb, 0x4bd6dacd, 0x8dd987ef, 0x73257951
.word 0xfa75476e, 0x22232c0c, 0x65107803, 0x7afd6092, 0x201f363f, 0x1979d24b, 0xc3bac6c1, 0xc27f0ce9
.word 0x86cce3b8, 0x88feeee8, 0xe3cc8acd, 0x5a9e6852, 0x50bbc34e, 0x77ad77d6, 0xd3fdb1b8, 0xa4d1d044
.word 0xd6793fc9, 0x1b85d467, 0xa44cfd66, 0x8a334cf9, 0xdb99660a, 0x03b12a98, 0x813e8131, 0xa35f1eb0
.word 0x762c4e24, 0xeb62f248, 0xab8c3b65, 0x05c09c59, 0xe6a2d7f3, 0xdd4a804d, 0x2079ff8a, 0x4f144635
.word 0xa7ae4922, 0x8f5e7b0d, 0x1cfa61eb, 0x4f80cc72, 0xc97d3dd6, 0x9fb74909, 0xc6b42299, 0x454ebc35
.word 0xedd3cae2, 0x91bc64ea, 0x208b04d7, 0x5a235143, 0x4714fe10, 0x556775e7, 0x1b477d58, 0x86535d50
.word 0xe54e4e17, 0x21edce8c, 0xc8a4c796, 0x62a47ad6, 0x65f4d67a, 0x9287f589, 0x2cbdd711, 0xb530f2af
.word 0xb9fe9e47, 0x6856297c, 0xb8ec6e33, 0x76fba509, 0x9f477e2d, 0x67256597, 0xf8464ebf, 0x76430e54
.word 0x00f83964, 0xa47ca1a7, 0x375fe698, 0xbc11ddff, 0x99131ed4, 0x33d340ad, 0x9123e2bb, 0x7a9fac74
.word 0xd6393865, 0x2dc3aae2, 0xcef211a4, 0x388c42a2, 0x75b76fe5, 0x37547f6b, 0x0f9fceef, 0x70a18fa2
.word 0x9afb4bee, 0xc1430776, 0x4319d57f, 0x49afd1ad, 0x6a65e147, 0x79fc7eb6, 0x9099d3f5, 0x62793396
.word 0x2787aea2, 0x20d7577e, 0xcd5ce755, 0x9c4f4baf, 0x8a5a4a29, 0x3c4b6980, 0xe7ee5117, 0x246350a2
.word 0xc66b0408, 0x4248dfda, 0x921fa375, 0xe8c2adb2, 0x89d91359, 0xc605a431, 0xf82c881b, 0xe8a67233
.word 0xe38b0f17, 0xeffc7277, 0x34e164fe, 0x4060ae69, 0x0c7ac142, 0xae9cb4a3, 0x2cb7a2a2, 0x597e3b5d
.word 0x097bb8e5, 0x0fc38c0b, 0x3146039a, 0xa324842e, 0xd7226b9e, 0x5aed8237, 0xc22a7068, 0x1f156649
.word 0xb25a0f9a, 0x8ad99e62, 0x72fdadac, 0x275ca684, 0xdf1169f8, 0xa1a91662, 0xf4dc4433, 0x653e344c
.word 0x3edc1190, 0x1bad64ff, 0xb95769ec, 0xa149755a, 0xa5722ecf, 0xe69a0bb6, 0x2e14d803, 0xbc21cd05
.word 0x01b69f4b, 0x748503e4, 0xdab9e8c9, 0xdd937168, 0x37c95982, 0xd4c5f03d, 0x43f86c73, 0xce8f88a5
.word 0x20fe71a8, 0xccb7561d, 0xff6a55e8, 0x295d3f45, 0xf9872a99, 0xaad7ed0f, 0x8a94fd35, 0xc8f05556
.word 0xd5da8dfc, 0xdc302e1b, 0xccf168db, 0x43ef03af, 0x87c15e3a, 0xbaa2c294, 0x00cfb462, 0xcd593451
.word 0xc3bf3649, 0xd2cb2570, 0x4181b0b7, 0x04d065d0, 0x4c3444c8, 0x78590d45, 0xeb516688, 0x8633bddf
.zero 7168
mem_region_end:
