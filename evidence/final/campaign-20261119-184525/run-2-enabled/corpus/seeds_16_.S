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
  li x26, 0x0000000a00381908
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
  li x1, 0xc57cf4bf01a65c08
  li x2, 0xdace324514a1ce14
  li x3, 0x3e970db0447c4aa0
  li x4, 0xc2ff2ea3cb854d0c
  li x5, 0xdbf04877247260d0
  li x6, 0x230d40ec311fd092
  li x7, 0xfc8e2179469cfe35
  li x8, 0xb4bec89b3be6a77f
  li x9, 0xd0258b59856db0ad
  li x10, 0xeda258dffc4a04fc
  li x11, 0x806d68dfa73084c8
  li x12, 0x8d02c38d63efe95e
  li x13, 0xd7a1cf78db76065c
  li x14, 0x1bb65caf9700aa22
  li x15, 0xcd9f066cd753bd04
  li x16, 0xf7e7a4814d87f7dd
  li x17, 0x3826657cc070d69d
  li x18, 0xaebc3eeec971e472
  li x19, 0xc714da57e27fa50f
  li x20, 0x7d861f83b5266aa6
  li x21, 0xcd51573281b7890b
  li x22, 0x865c4b04fc6dd7d4
  li x23, 0xb3ca3bda5a2dddca
  li x24, 0x103823494aca8000
  li x25, 0x2375fe34a68772a3
  li x26, 0x9ed4f3b81d9da96d
  li x27, 0x0d1f630926cf4aec
  li x28, 0x9cff6f41be8c3546
  li x29, 0xbdb96c413d442f99
  li x30, 0xf7a76c4f72b7f57d
  li x31, 0x8c157b01bbaacbe8
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
  remuw s1, s1, s1
  ori a5, gp, -1
  addi t2, s5, 0
  remw tp, s4, t1
  addw a5, t2, s2
  sd a5, 1344(t6)
  remuw s0, a5, s0
  srliw tp, s2, 18
  slti a7, a5, 1
  divuw t0, t0, tp
  slliw sp, s10, 23
  sraw a2, t0, sp
  sd sp, -1152(t6)
  remu s6, s6, a7
  remuw a1, t0, t0
  mulw t1, s7, s6
  remw a0, a1, sp
  remu tp, s6, gp
  divuw s9, a0, s6
  slli s3, a0, 45
  mulw s1, tp, s1
  sllw s8, s1, s8
  mulhsu zero, s4, a1
  divw s10, s4, s10
  div t3, s8, t3
  remu ra, s5, sp
  sb s0, -1550(t6)
  sw s10, -2028(t6)
  rem s4, tp, t3
  sraw s6, s6, ra
  sd ra, 1480(t6)
  divw ra, s2, s5
  mulhu t0, s6, t0
  divuw gp, a6, s4
  srli a5, s6, 0
  slt gp, gp, sp
  slliw s10, s10, 0
  xor s7, gp, t2
  sw s0, 1916(t6)
  auipc t1, 368695
  divw a0, t1, s6
  sra t3, a2, s4
  divw a5, s1, a0
  divu t4, a5, t4
  divw s11, t3, s11
  divw a2, a5, a2
  srlw a3, s11, s10
  sw a0, -1088(t6)
  slliw s6, a0, 1
  sltu s0, tp, a0
  sllw s10, a4, tp
  sllw s3, s10, s7
  rem ra, s4, a4
  remw s7, a5, a0
  divuw t1, tp, t1
  remuw zero, ra, s10
  remw s7, tp, s4
  remu s2, s2, a2
  sraiw t4, s2, 0
  mulhsu zero, s7, ra
  rem a5, t4, zero
  mulhsu t0, t0, zero
  mulhsu s7, s8, s6
  sllw t3, s8, a0
  auipc tp, 540057
  remw s7, s7, tp
  sb tp, -1589(t6)
  divuw ra, a0, t0
  xor s8, a0, a0
  mulw s0, a0, s8
  xori s9, a5, 1867
  srlw s11, s1, a5
  srliw a4, a4, 0
  mul a2, t3, a4
  remw a3, s9, a2
  remuw t4, t4, t4
  mulw ra, s3, a4
  add s0, a0, s3
  srai a0, s1, 59
  sh s4, -180(t6)
  xor s3, ra, s0
  lui s4, 1048575
  divu s9, a5, ra
  divu a0, s2, s9
  add tp, a5, ra
  remuw s5, a0, tp
  slli t4, s9, 29
  divw a7, tp, t4
  sltu a4, s10, s6
  sb s2, -418(t6)
  srliw s11, s7, 21
  remuw s8, s2, s11
  div a3, a7, a3
  mulhsu gp, s5, tp
  sra s10, s10, s5
  sll tp, tp, s5
  auipc a7, 1005605
  divuw s6, a7, a7
  srl s5, s9, s10
  mulw s0, s11, s0
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
.word 0xbafe7770, 0x1d0c6f3e, 0xde56dece, 0x7de01290, 0x11f256f0, 0x6a20269e, 0x34251c48, 0x8be49b92
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x313b5d88, 0x5ce24631, 0x6ba0728e, 0xc9f1dffc, 0xbeca0920, 0x5a9db68a, 0xcd3e8e12, 0xd2e0e09c
.word 0x46ae2ea4, 0x11e342e7, 0x7aabe593, 0xd394e18a, 0xae6e82fd, 0xf4a77745, 0x13a7d227, 0x9f2269bf
.word 0xaca9162f, 0x87592559, 0x4fe5cb73, 0xe6789b79, 0xcfbfda2a, 0x39b68d7b, 0x53b6bcfd, 0x270e1492
.word 0x1f924b10, 0x40a5135e, 0x61b30ff6, 0x8269845d, 0x933118f3, 0x9546bd83, 0xbff1e156, 0xfd39ea9e
.word 0xb1674ef7, 0x2cc70a1c, 0xd48e5c37, 0x092b916c, 0x9b2eb790, 0xa4efcd8d, 0x69d29648, 0x8d314e4c
.word 0xb0596604, 0x25a9e9ce, 0x5bbea9d9, 0x53c2e043, 0x2bd427ca, 0xf0a1bcf7, 0x10f57f20, 0x72f1ab9a
.word 0xecda343e, 0xba2a0456, 0x5ea3312b, 0x3936e560, 0x2c0b52f9, 0x14294ce1, 0xbc00731f, 0xaf6b428d
.word 0xc48946aa, 0xadbe94dc, 0x8ff989f3, 0x27da65a4, 0x7bb339df, 0x7705a4c8, 0xf056fdc4, 0x88e9f0f0
.word 0x606fe028, 0x60887bc2, 0x7c930901, 0xafbf550b, 0x261cf17d, 0x144b4ae1, 0xeff2ef68, 0xdd6efdb0
.word 0x410830c2, 0x6480a220, 0x0d8479e6, 0xc8e4f33a, 0x30d8f732, 0x4edef511, 0xf21e08fd, 0x83ace5d0
.word 0xbf1842d6, 0x7b2fa337, 0xc5e95403, 0x610eae6d, 0xad6802e1, 0x73d016bf, 0xe9679efb, 0x8ccc77d5
.word 0x48bde147, 0xedd5e06f, 0x1ba1e747, 0x1449658c, 0xf7dd1000, 0x1c014dfb, 0x1f5225a7, 0x51224caf
.word 0x0a293712, 0xdefc7ea3, 0xbd457e57, 0xfa975858, 0x421767c7, 0xbefcfc3a, 0xbbf12312, 0xf70c3ad4
.word 0xc0cf267c, 0x432d5401, 0x45b2c7aa, 0x3f9b110e, 0x235ab1a4, 0xa29ed766, 0xacb24fb2, 0xfbd0b624
.word 0x9aaddf43, 0x2ab410a8, 0x77a7b090, 0x284fdc31, 0x8dcaab42, 0xf5b30b43, 0xbd4521ba, 0xb7bf3a8b
.word 0x5fbdafdd, 0x214e7f3b, 0xfd8feb09, 0x6c5ddca2, 0x9c0fddcf, 0x58ff3ffd, 0x19c2a5b0, 0x97d44f56
.word 0xf7f0cefb, 0x72a522b5, 0x2b11a873, 0x5bd0cf72, 0x9a52a3d2, 0xae89650a, 0xb851dc90, 0x18453474
.word 0x02d6462a, 0x8ba26a1b, 0x330e5ace, 0x618d6d21, 0xaa416469, 0xd3a2756a, 0xaa4f54fe, 0xd5feb1ec
.word 0x2b5083df, 0xdc992e4e, 0xc6e52079, 0x38cffcca, 0x2f090f42, 0x8196e0a2, 0xd4653df3, 0x8c3313ed
.word 0xb41cec47, 0x3619d979, 0x9c4d0bc4, 0x44666310, 0xa4f2fd2c, 0xf5a27454, 0x6f4ff0b3, 0xa275b14d
.word 0x327a3049, 0xd133b368, 0xaae650cd, 0x41a2361a, 0xf7646f74, 0x688c393e, 0x6a8551ad, 0xceeafe25
.word 0x0bfa127a, 0x7e7f6677, 0xead5f8fb, 0xa3b86982, 0xd34b35d0, 0xcc68ee2d, 0x7f48c67e, 0xa9a1078e
.word 0x52f1d073, 0xcdd603de, 0x1704673f, 0xf2668c31, 0x16f16d3f, 0xbab6f434, 0x4476bead, 0x46ab0cb1
.word 0x6e3e7289, 0xc77c22e3, 0xe7c625ba, 0x51811602, 0xa1042420, 0x36389685, 0x7b5e75f0, 0x0d8186b7
.word 0x09814d47, 0x8407698f, 0x0e76101c, 0x5eae9e33, 0x12c32047, 0x4848fa0a, 0x7b700860, 0xc743ca5e
.word 0x10bec8c7, 0x1e360c0e, 0xec0cd2ea, 0x278f3f85, 0x097078e2, 0x9ad214c6, 0xea26f2b0, 0x17059399
.word 0xb76e9122, 0x7e8a1115, 0x7e779f6e, 0xd319d15a, 0x058167fc, 0x308d546a, 0xc4ac2102, 0x47790f0f
.word 0x7367f274, 0x9103fa15, 0x9582a743, 0x82dda411, 0x8608f57d, 0x856c65b3, 0xc89f463f, 0x583ad513
.word 0xbb973263, 0x33dc2d80, 0x58a119c6, 0xf58dbcc0, 0x4e3da364, 0x6acff286, 0x4ae86d1c, 0xf3bbf07c
.word 0x5ef3d345, 0xbba05f15, 0x332931a4, 0x053cb6c8, 0x03b5c65e, 0x9d7bf5d5, 0x13237904, 0xb9b46a37
.word 0x748405f6, 0xbdc2ada4, 0xec787e12, 0x9708e68d, 0x01674c30, 0x18fe7c7d, 0x3887e9ca, 0x4f08e2d9
.word 0x022425c7, 0x6073656f, 0x2a63f84d, 0xa80fc084, 0x30affe64, 0xc0339995, 0x0e63e254, 0x7882ad9c
.zero 7168
mem_region_end:
