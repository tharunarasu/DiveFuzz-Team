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
  li x26, 0x0000000a0010602a
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
  li x1, 0x9d8e4aa92b25628d
  li x2, 0x0f065bbd5177fd23
  li x3, 0xa0934eec4c42ccf3
  li x4, 0x92eb9bce7408b6cc
  li x5, 0x588c11141a096baf
  li x6, 0xdb3180386042055a
  li x7, 0x1cfe0c7cdf46be12
  li x8, 0x13ee78a5df61f396
  li x9, 0x1fe6b0be360b7d21
  li x10, 0xe360bbec983b0e61
  li x11, 0x8070d9352b251669
  li x12, 0x468ec4580f7ee4dc
  li x13, 0x9c253828d39ef65a
  li x14, 0x57828d2fbababf64
  li x15, 0x8ebbf4419e58f597
  li x16, 0xbff0c7560f93f88f
  li x17, 0x4c46e9099bd0f29c
  li x18, 0x88108dc1b6343ad2
  li x19, 0x6d240ab5d7df6214
  li x20, 0x57e3a258116f73ce
  li x21, 0x968b526c3317b902
  li x22, 0x987134574fe346a9
  li x23, 0x896de0491ec71ed9
  li x24, 0x7f34318e4e8c8787
  li x25, 0xf35c16cb17ca9048
  li x26, 0x8293b9fb5e1d87b3
  li x27, 0x75b4f89a0dbb7b7d
  li x28, 0xc96d46ae1288f7c4
  li x29, 0x8e1e1b2941cf93e8
  li x30, 0xeeba074ac11179c8
  li x31, 0xd21ced8e762e567d
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
  divw a4, s8, a4
  divu s2, a4, s2
  remuw s4, s2, s2
  rem s10, s2, s2
  fence.i
  addiw a5, t2, 190
  mul a6, s10, a5
  remu s5, a6, s10
  lb a3, -198(t6)
  lh s11, -1264(t6)
  divw s7, s7, s7
  fence.i
  fence.i
  subw s9, s0, s11
  rem gp, a3, t3
  div a5, s8, gp
  remuw s6, s9, gp
  sltu ra, s9, s7
  sd a4, 1720(t6)
  srliw t3, a5, 4
  mulw t2, s6, t3
  fence.i
  fence.i
  divw s9, t3, s6
  remw gp, a2, gp
  add t4, s9, t3
  subw s0, s2, s6
  slli s5, s7, 1
  mulw a0, s0, a1
  fence.i
  mulw s8, a0, s5
  addw a2, a0, s8
  div t3, a2, s5
  fence.i
  mulhu a3, zero, s8
  fence.i
  slliw ra, t3, 11
  fence.i
  divw s3, a2, t3
  fence.i
  lw a4, -968(t6)
  remw t4, t4, a3
  ld s8, -1232(t6)
  divw t2, a5, s3
  rem s1, a4, t2
  remuw a5, a5, s7
  sll s9, t2, s8
  divuw s3, s8, t2
  mulw a1, zero, a1
  mul t4, a5, t4
  nop
  remu s0, s9, a5
  mul gp, s3, s9
  fence.i
  mulw tp, gp, s3
  mulw t2, t4, tp
  slliw a3, a6, 13
  sltu s2, t2, s1
  fence.i
  fence.i
  addi a2, gp, -1
  mulhu t0, tp, tp
  slliw s11, s11, 0
  fence.i
  divu a5, t0, s11
  remw t2, s11, a5
  div t3, t2, t3
  fence.i
  remw t0, t2, a0
  srliw s2, s2, 31
  fence.i
  ld a6, 1576(t6)
  divuw s5, s2, s11
  divuw s9, a6, a6
  remw s4, s2, t0
  sb s10, -814(t6)
  fence.i
  divu s6, s10, s4
  remu t2, s4, s4
  divu s1, zero, s2
  remw a3, s1, s4
  sd s9, 1160(t6)
  fence.i
  ori a7, a7, 2047
  fence.i
  lhu a0, -644(t6)
  rem tp, a3, tp
  slliw a6, a3, 0
  mulw s4, a6, a7
  slliw gp, a7, 0
  divuw a5, t2, tp
  lbu t3, -1104(t6)
  srlw s0, a6, t3
  lhu s1, -1626(t6)
  srli zero, s1, 6
  lui ra, 0
  remuw s9, a4, s1
  divuw zero, ra, s9
  srli a4, ra, 59
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
.word 0x9c346b4d, 0x865d389c, 0x314d7548, 0xdedb5981, 0x7d678aee, 0xa376fae3, 0xaef3bc12, 0xcd01e4dc
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x77256d71, 0x494d4ebb, 0x77e23f32, 0x56ff6a72, 0x1ae158a3, 0x7a6c08c0, 0x4665d309, 0xf22216ba
.word 0x665f34bf, 0x91f0d1dd, 0x339cb663, 0xc3ca5f61, 0xaae43d9f, 0x628fb113, 0x9369c7e1, 0x86585775
.word 0x6818bb88, 0x9e559881, 0xb345a3f7, 0x76d46a05, 0x9a53ccbe, 0x6e3ca3d7, 0x69052628, 0xa7c00418
.word 0x032b7875, 0x33b85f33, 0x53dc0e5d, 0xcec04f0b, 0xa5483dca, 0x5ee5f0d7, 0xc9e863f3, 0x13d72b73
.word 0x2f96ad27, 0x6d3416af, 0x11f72b8f, 0xc702d5af, 0x13c27849, 0x203e1bcd, 0xe5c3c52c, 0xdddce782
.word 0x20d82ee6, 0xe0891e16, 0xc5b9bee3, 0x643433af, 0x3ff639b5, 0xe6b2f18a, 0x1fb769cd, 0xc2458e7d
.word 0xc4755675, 0x3d27c41e, 0x364669dd, 0x867a7d33, 0x8d72d618, 0x1b5f1c5f, 0x7ff40d28, 0x38d04802
.word 0xfb9f5eb3, 0xe1e2edd2, 0x1c9b27f0, 0x4f00f478, 0x74b67ec8, 0x717e3a9b, 0x4e301494, 0xd1140f15
.word 0x70e00b33, 0x65471fb3, 0xb373d728, 0x65b71233, 0x87325762, 0xc79cbafe, 0x2ff0518f, 0x4c1a3aed
.word 0x14e46c3d, 0xa9eed9c3, 0xc8a805cc, 0x025426dd, 0xcd60df14, 0x2b5ad4ba, 0x8563053f, 0x3824d127
.word 0xea007709, 0x93e8c59d, 0xa201b094, 0x130746c3, 0xbe846f0f, 0xd8be716d, 0xd1b21970, 0xe7fae061
.word 0xcd01aa90, 0x1ba80f27, 0x452638ce, 0x311fb813, 0x961f212a, 0xe132b056, 0x32284c23, 0x6b5c8f8f
.word 0x39518f67, 0x56c86005, 0xe8b96f3d, 0x7de2bfc7, 0x608229a0, 0x91b1275b, 0xe87ca4be, 0x63b975d1
.word 0xbc6fa1eb, 0xb1fda524, 0x55c0ec9b, 0x7bf8dff5, 0x2ed2bdfc, 0xd457a34b, 0xaf2e9a22, 0xaef92221
.word 0x47d614a3, 0x0a465d26, 0x1eb72632, 0xff4f5e03, 0x1a09c6b1, 0x026b2a86, 0x53489b24, 0x526235a2
.word 0xfbe7eeb8, 0x77b59024, 0xea1658de, 0x31425dba, 0x0784377c, 0xd9a7f019, 0x73788091, 0x2cda45c5
.word 0x2b0bd43f, 0x346f99c9, 0x3264ab60, 0x05bc5934, 0x9cfdbf3f, 0x7ed708ad, 0xf4018b2d, 0xf4cde442
.word 0x26b5dc9f, 0xb7baccc7, 0x7d180d91, 0x6f101bf7, 0xb6af61a3, 0xc36a3df7, 0x43a0a870, 0x5d1bdb10
.word 0xb5bab4d5, 0xb5b4cac3, 0x2cc2409d, 0xae3be4f5, 0xd571bce8, 0x54743829, 0x686fe06b, 0x392c54b7
.word 0x8b98f641, 0x2df3e090, 0x98ed780f, 0x2f0c0b1e, 0x2a5fed82, 0x0747826b, 0x9d0753ff, 0x4b1d664d
.word 0x1897f671, 0xe963b436, 0x46832df3, 0xbb92bf06, 0x24f2bd6e, 0xb4b55c0f, 0x57e709ca, 0x0e9d9d40
.word 0xd7f52b7f, 0x6ea3e056, 0xc1ea01d4, 0xefdc7e55, 0x98533a71, 0xb88b6223, 0x6c5bb2a2, 0x75ae4031
.word 0xf0a546bc, 0x980d6d2a, 0xe61055c9, 0x0e9d58a5, 0xbd396eef, 0x5e6abdff, 0x62a8b0ad, 0x754bcf8e
.word 0x3edcef27, 0xcc6086a0, 0x97a703fa, 0x9bb155fe, 0x3c91aebe, 0x0426b7c5, 0xa0c5265c, 0x5735c200
.word 0x09cdf562, 0x67681063, 0x69181769, 0xee7da565, 0xae5890d8, 0xfbe293c0, 0xab1112a8, 0xad6744e2
.word 0xb6c1ff99, 0xf170a0a5, 0xf24549d0, 0xd1fa831d, 0x89ca9be9, 0x733d62c2, 0xf38b2c11, 0xa3b83830
.word 0x626063fc, 0xa205172c, 0x422cc833, 0x8e1916c7, 0x6f17c6c0, 0x5a67cb58, 0x455c3f3f, 0xa89f014c
.word 0x06225d50, 0xcb6689ec, 0x1f4c3a59, 0x72ebefe7, 0x66229be8, 0xe6a9e71b, 0xe2f84033, 0x64642534
.word 0x682a1a9c, 0xf83fa488, 0x85d66e69, 0x3975d0a1, 0x17d92e9f, 0x536c2842, 0xe4734807, 0xd79b894d
.word 0xc8165002, 0xfd5c3b9a, 0x84518bcf, 0x972106a4, 0xccd3998f, 0xbd57fb00, 0x6436c9c7, 0x3cc92127
.word 0xe33d5c7e, 0x61fbce15, 0xf0646404, 0x10b692fc, 0x8fa24a53, 0xa494b1e1, 0xa603f35a, 0xe8547e1b
.word 0x1703f13b, 0xdf70d240, 0xa97cfb4c, 0x9a650bf0, 0x910a8092, 0x059507d3, 0x5f37f738, 0xd7e1b299
.zero 7168
mem_region_end:
