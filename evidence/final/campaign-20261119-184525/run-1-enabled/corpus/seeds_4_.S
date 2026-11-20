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
  li x26, 0x0000000a007c28a0
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
  li x1, 0xabc0ff65a92da05d
  li x2, 0xcb5607b7948bc532
  li x3, 0x4c075f1f0b493f1a
  li x4, 0x0e2bd802c5c6ba65
  li x5, 0x7d9cf46457162242
  li x6, 0x43d7157c1855de48
  li x7, 0x163ed0e03b6e07f7
  li x8, 0xa61c3a164b8aa9b0
  li x9, 0xe10090fd1f6ddae6
  li x10, 0x345cdc6a79359390
  li x11, 0xc0777ccadfba4925
  li x12, 0xe44cef099823f8d8
  li x13, 0xfa31d8c364aced97
  li x14, 0xf250361f5b33fcf9
  li x15, 0xe5cddd3bd8261736
  li x16, 0xe4af4ea6b6ba13ac
  li x17, 0x0c1263b78aa99278
  li x18, 0xcab0ec714409d3a1
  li x19, 0xad240fffee2ca3d4
  li x20, 0x4e3c7f06aa2a0462
  li x21, 0xefc8aebed91ecc31
  li x22, 0x6b4f92514638ad08
  li x23, 0x79372d61994a039e
  li x24, 0x71c1bcd274fa2d4e
  li x25, 0x8216f8935506de55
  li x26, 0x4877c9b5d008d4d9
  li x27, 0x1858fcb998b3d74c
  li x28, 0xdd4e3000feaa7c5a
  li x29, 0xf2e0a82cd42626ee
  li x30, 0x5f3a70f604b4a67c
  li x31, 0x65f2976b9c2d23fc
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
  divw a3, a3, a7
  mulhsu t2, t2, a3
  sub a0, t2, a0
  sllw t0, t2, a7
  mulw s4, s6, t0
  mulhsu s6, a0, s4
  srliw s10, gp, 31
  remuw a6, a6, a3
  addw a5, a5, a6
  divuw s8, a5, s10
  remuw s0, s6, s8
  subw s7, s10, s8
  sllw s3, a0, a5
  addi gp, s3, -1409
  divw t1, t1, s3
  div t2, s4, a0
  mul s5, s5, t4
  mulw a2, s5, a3
  mulw s9, a2, s9
  div a5, sp, s10
  ld zero, -456(t6)
  sh s5, 818(t6)
  and s4, s11, gp
  divu s7, gp, s4
  divu s5, s5, a5
  sraiw ra, gp, 0
  sltu t2, s4, s7
  srliw a2, s5, 31
  xori a1, s5, 1058
  sllw a4, ra, s1
  srli a3, a5, 0
  mul s3, a4, a3
  subw a5, a3, a4
  mulw s11, a1, a2
  remuw a0, a3, a0
  mulw a6, a6, s3
  mulw zero, a0, s11
  slliw t3, a0, 8
  subw a4, t4, t3
  remu t2, t2, s1
  ori t4, t3, -2048
  srai s7, s1, 0
  mul s4, s9, s1
  and tp, s7, s4
  sb s9, -285(t6)
  sraw s5, s4, t4
  mul a2, t4, s7
  div s1, s1, s5
  divw s11, t1, a2
  addw a6, a6, s11
  sra a4, s11, t3
  mul s2, s2, s0
  srai gp, a2, 0
  sraiw t2, a0, 0
  subw a5, a4, gp
  sb a6, 1081(t6)
  srlw sp, s2, a5
  sw zero, 472(t6)
  sb a1, -733(t6)
  divuw gp, a0, a1
  srli a7, a0, 54
  mul t3, gp, a7
  andi t1, s2, 2047
  srlw tp, a6, a6
  divuw s10, s6, t4
  mul s2, sp, gp
  mul a6, s10, a6
  remuw gp, s3, s1
  remuw t4, a6, t4
  mulw t3, s0, gp
  subw zero, gp, t4
  divw s1, s7, s1
  div s8, ra, s7
  remu a1, s1, zero
  divu s4, s7, s4
  mulw s1, s5, ra
  divuw s9, s7, s8
  divu s0, a0, s4
  mul ra, s9, s1
  srli t4, s9, 20
  mulhu s2, s9, s2
  slli a6, t4, 43
  sw a5, -144(t6)
  mulhsu t0, a1, s11
  divuw t4, t0, a2
  lui s0, 889368
  mulw a1, s0, a3
  divw s1, a3, a3
  rem a5, s4, s7
  mulw t0, s1, a2
  mulw s9, a3, t0
  mulhu t2, s4, t0
  srai s5, a5, 63
  mulhsu s11, t0, s5
  srlw a2, a2, a3
  lhu s7, -1672(t6)
  rem a7, s11, s11
  divu a3, a7, s11
  slli s8, s11, 1
  slliw t3, a1, 0
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
.word 0x499c60cd, 0x8d50cbd1, 0xcc75da36, 0x5c34333f, 0xd1446ece, 0x910db0fc, 0x307d1180, 0x9d9e9aa9
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0xecd30931, 0x77049fd3, 0x898d9183, 0xafe97ada, 0xd626af57, 0xb3253de7, 0xa1b68761, 0xdcebba53
.word 0x26df024a, 0x08c8ffcc, 0x8735e7fd, 0x0231d04d, 0x75561b4d, 0x07182699, 0x0ad49631, 0x3633efb3
.word 0x20350fc9, 0x704360e4, 0x10d99a09, 0x3d31a8df, 0xe5bd4a86, 0x76f02f3b, 0x79043e03, 0xd5c827b0
.word 0x30a628bf, 0xf6ae0a8a, 0x57ae69e5, 0x29504e1f, 0x399788cc, 0x2a6aa93a, 0x4b1c0ed2, 0xa4ad6b35
.word 0x6018884c, 0xa24f8e48, 0x75c0d49a, 0x59c1d8ee, 0x7abfbb44, 0xb76fa1f7, 0xf5650bc0, 0x88156585
.word 0x08547a92, 0x6c6ec930, 0x6f4f1622, 0x88fddeaa, 0x3fb17aed, 0x128a1f21, 0xef20839d, 0x76093cb6
.word 0x5b929823, 0x54883e04, 0x39539e2e, 0xf24c29cd, 0xddfff8aa, 0x84a14025, 0x3482ae6d, 0x6527efd0
.word 0x9969997b, 0x3a076be2, 0xadbdea1f, 0x942e0bff, 0xf0042e12, 0x931c2e52, 0x639b7b3d, 0x328faf33
.word 0xa0fe11c1, 0xeeeade13, 0x5df35d8e, 0xa8bb7a56, 0x0c01a6d3, 0x9fdd3ab3, 0xd95dacd5, 0x94bb30d0
.word 0xe3e2024c, 0x6f0ba471, 0xea8ab026, 0x40ff912d, 0x1cf468f2, 0x96123321, 0xc70734cd, 0x50e1c5e8
.word 0x07ecf8d4, 0xdcaf8ece, 0x0a2a693d, 0x187c2d99, 0xbaa818ba, 0xaadff4b8, 0xa772a25a, 0xaccb9368
.word 0x995c9105, 0x21af50a4, 0xfae5875e, 0x721b69b7, 0x60794cf2, 0x0fa9a021, 0xa088b3b4, 0xf1d3819e
.word 0xd2ff20dd, 0x378b298c, 0x78bd2dd7, 0x5b896a17, 0x6e53108e, 0x92c1699f, 0xdec1bf81, 0xc4399c13
.word 0x53f3d2a0, 0xf24e9222, 0xafde2a97, 0x7299d034, 0x2d550885, 0xe70ab48a, 0xb70fffb1, 0xc487cba0
.word 0xd2071bd7, 0xee72b12b, 0x4f8667e3, 0xfce2ec96, 0xb91daf67, 0x83fede7c, 0xfce171a0, 0xcd94f385
.word 0x8d21417b, 0x2d0f5fa3, 0x1354cd84, 0xc40c9c46, 0x859745c4, 0xba9ca15d, 0xe3669a1d, 0xd0e1b2e0
.word 0x995df415, 0xc78a4129, 0x27c944cb, 0x2fda14c2, 0xa45a379a, 0x141816ce, 0x52a488c3, 0x448d2056
.word 0xedcdd2e3, 0xefbfac78, 0x1cac45a1, 0x0a6dc4f4, 0xcea02d15, 0xf836f9cd, 0x440d2fbf, 0x74cb662e
.word 0xa545484f, 0xb040bafe, 0xad5e6069, 0x3bd2391f, 0x158224a4, 0x27e293c4, 0x42eb5303, 0x76e514e1
.word 0xb1703d47, 0x65e08832, 0x9ed1f77b, 0x54b09523, 0x6db5d16a, 0x3928e431, 0x65f04814, 0x68560e4c
.word 0x882f44b0, 0x85665c1b, 0xd7489fac, 0x53850a37, 0x113fd4fd, 0x37ad0b48, 0xa5a77674, 0x33610fa6
.word 0x61d7c705, 0xd2419408, 0xa57107c3, 0x48043029, 0x00a07836, 0xc2935390, 0x8b002b54, 0x01b707d4
.word 0x63dc0084, 0xadd1ab7c, 0x14cbab44, 0x6186875a, 0x0b389119, 0xcf4c33f7, 0x55be2220, 0xbe3ba32f
.word 0x7bea29ea, 0x5b45a976, 0x7412150b, 0xc4504ec9, 0xa3265664, 0xa98d5ffd, 0x9f4e0795, 0x50a0f12e
.word 0xad75b730, 0x80d520e5, 0xe3a43e8d, 0xa4abcfaf, 0xe1191c40, 0x4c7b3b96, 0x1af5232d, 0x4e004a28
.word 0xb07af1f0, 0xadfa5117, 0x1ea78615, 0x16f75639, 0xd51ec1ab, 0x7efc80ce, 0xfed7413a, 0x11c12622
.word 0x94b2ae07, 0x6b9e1f67, 0x5329252f, 0xebfc7bf9, 0x978675c6, 0xe19e3dd6, 0x9143a9c7, 0xee484437
.word 0xd3ff0e2c, 0xf19727c6, 0x27896758, 0x5f421a5e, 0x93b62325, 0x4716b2f4, 0x6f36f2a7, 0x8172f46e
.word 0x31ef2103, 0x2c526529, 0x64717125, 0x2cdd322b, 0x890814b4, 0xe6cebf39, 0x54c20388, 0x76efa087
.word 0xd84e97c5, 0x75e3f49c, 0xb10d7589, 0x517b717d, 0xffeaff3b, 0x3b4598cf, 0xed44bc96, 0x06099076
.word 0x6b6f6cff, 0xa93082ea, 0xe372145c, 0xbd488bb1, 0x65bab221, 0xd3dc7b4a, 0x57dfbc9a, 0xe3a3f8be
.word 0xaa00a49c, 0xc5a8d4d9, 0x236cb767, 0xbe3a3a17, 0x130a69b7, 0xb5346083, 0xf2244770, 0x7199f667
.zero 7168
mem_region_end:
