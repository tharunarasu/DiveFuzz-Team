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
  li x26, 0x0000000a00502008
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
  li x1, 0x506f83ba634c8390
  li x2, 0xae6c87b8fddfeb71
  li x3, 0xb8c2860c1279b8cb
  li x4, 0x969c2dccaa538899
  li x5, 0x2054d2ff1d8efc62
  li x6, 0x1ce225c5a6e52ff1
  li x7, 0xabbc7bd45d8d3b54
  li x8, 0x77120741ea33fb19
  li x9, 0xeb7ad6a206ffc67f
  li x10, 0xc8360bdc67e2b41d
  li x11, 0x5a4c810f3b6185d8
  li x12, 0xfb1bf67d384daf2e
  li x13, 0x4bb21b7cc4cc39c3
  li x14, 0x46d7c4b0f4f3fb3c
  li x15, 0x83957bc5c5f19476
  li x16, 0x4c7ccd78df98696a
  li x17, 0x93f4060b96b7cbeb
  li x18, 0xd9034f2ae88c1ca9
  li x19, 0x880d2c69dfb180f2
  li x20, 0x4cd35cc71ffc65e8
  li x21, 0x365caf4c5f488317
  li x22, 0xd26ad7a3fc3f8bd4
  li x23, 0x13ec82466e7644fc
  li x24, 0x016818c4ac0c7ecf
  li x25, 0xb3ce54b3230b5bf8
  li x26, 0x4ae27cf19b5d930f
  li x27, 0xd541084683d0c25f
  li x28, 0x6cf8e1ad197a8ed7
  li x29, 0xc2b0c4438adcb14d
  li x30, 0xa90f41deca3663aa
  li x31, 0x59d82e26b1ad1230
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
  sub sp, s4, s5
  rem s7, sp, ra
  subw a5, a5, a5
  div a4, s9, a0
  divuw s1, a0, s0
  subw s6, s3, s8
  subw s9, s3, s3
  or s0, t0, t0
  sraw a0, a3, s6
  srlw t0, s9, s0
  mulw tp, a0, a0
  subw t4, tp, t2
  rem ra, tp, zero
  mul s2, a5, ra
  mulw a2, a2, s11
  mulhu s8, s8, s1
  divw s5, a2, a4
  divw a5, s11, a5
  div a1, t1, s8
  divw s1, t4, a5
  mulw t2, a1, s5
  srai tp, t2, 17
  remu s7, s1, s1
  remu ra, ra, t2
  remu s6, tp, s7
  divuw s0, s6, s6
  remw s4, tp, s0
  sraw t3, ra, ra
  remw sp, s6, t3
  addi a1, s4, 326
  divw t2, s10, sp
  divu tp, a3, sp
  div t0, t0, tp
  mul s10, s10, t0
  divuw s7, t3, s10
  sraiw s0, s7, 11
  divuw a6, s5, t0
  slti s11, a6, 1
  srliw ra, a3, 21
  mulw t2, t4, s10
  sltiu s5, t2, -1
  remuw s2, s2, s3
  addw t4, t2, t4
  sltu s0, s5, zero
  remw s8, gp, s2
  divuw gp, a3, t4
  srl s5, s0, s5
  srlw t4, s3, t4
  mulw t3, a7, t4
  mulhu a0, t4, s6
  remuw s3, s5, t3
  or s8, t3, s3
  srliw s7, s8, 0
  subw s11, s9, a7
  remu a5, s5, s11
  mul t1, t1, t1
  lui s7, 484167
  andi t4, s9, -1082
  remuw t1, a2, sp
  remw a0, s8, s7
  remuw s7, a0, s8
  div sp, a0, sp
  li t3, -477198184148
  divw t2, s10, a1
  mulw zero, a1, a1
  addw a6, zero, s11
  mulhu a5, a6, zero
  sll a3, zero, a3
  remu a1, t2, s8
  srli s10, t2, 51
  remuw gp, s2, t1
  remuw a6, a6, gp
  slliw t0, sp, 30
  remuw s3, tp, s3
  div sp, sp, s3
  mulhu s4, s3, t4
  ori a2, s3, -1640
  remuw s10, a2, t4
  remuw ra, t4, ra
  sltu a6, a2, ra
  mul s2, s10, a4
  sd s10, 1408(t6)
  remu zero, s0, tp
  rem s3, a4, s6
  divuw s1, tp, zero
  remuw s6, s1, tp
  lui s5, 92920
  lui s4, 1028942
  divuw s11, s4, t1
  sltiu s7, s5, -853
  divuw a0, s2, gp
  mulhu a7, gp, a7
  mulhu a1, a0, s7
  mulw a6, t0, a0
  srlw a2, a2, tp
  sltiu s2, a7, 1
  mulw s5, a2, a1
  sraw ra, s2, tp
  rem s11, tp, tp
  sraiw a2, sp, 23
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
.word 0x099f554a, 0xb68a5b9b, 0x578e9ba3, 0x7d072b7f, 0xe9cff835, 0xce528901, 0x11a35bc7, 0x078d843b
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0xdf45b4c1, 0x5d1cb417, 0x368865d3, 0x34926d5f, 0x5d992360, 0x3b906437, 0xf6095b5c, 0x712802e1
.word 0xb0e577c9, 0xc519f687, 0x39e9bdaa, 0xfeaa4c18, 0xee3451a0, 0xb24fe072, 0x65477076, 0x195a96b8
.word 0x5594f61d, 0x038f68b6, 0x27ec556a, 0x20788af0, 0x879bcd14, 0x7a3b34d2, 0x5ab95b88, 0x6ad258c6
.word 0xbffb725a, 0x9b7c58c2, 0x8dcb8baa, 0xf008de2e, 0xd4b7a0d5, 0xa670fbbe, 0xa764ec8c, 0xa1414ae2
.word 0x50fc6fa2, 0x24248888, 0xc208ea65, 0x1358539f, 0x7b9b96d2, 0x2b0598a5, 0x670b987a, 0x068ed450
.word 0x9690b865, 0x62c79643, 0xc894e0c5, 0x9eab28d7, 0x5a5f001c, 0x19c833a3, 0xd0b1d37f, 0x370eeb19
.word 0xc2b5deb3, 0x4f911bf1, 0xe82c7262, 0xa733e395, 0xfd5b5dee, 0x9eaf99f0, 0xa32dd911, 0x1cfaa93f
.word 0x0c08e271, 0x0ee29dd3, 0x208e83a6, 0x29229e60, 0x5bb9fa73, 0x2787e517, 0x86232e9a, 0x8eabca28
.word 0x020b682d, 0xd5b096dc, 0x317e4bb0, 0x1d58224f, 0xcfbd6ba5, 0xe1520ef8, 0xc97c8280, 0x8afbbe80
.word 0x96561fdf, 0x6e93dd17, 0x3477255b, 0xa23f3023, 0x17218049, 0x83479187, 0xb40a704d, 0x77a14346
.word 0x1b0a7f0d, 0x185880dc, 0x0405e4ea, 0xa2ce53fa, 0x2d6d77ef, 0x78a17b80, 0x104b58e9, 0x3dfe56c3
.word 0xfdac921d, 0x1d181238, 0x9203261e, 0x5bf794b6, 0xb9a6e825, 0xb1f41ebd, 0x86a34c50, 0xf0fcd978
.word 0x035c8890, 0xd5110002, 0xea273660, 0x4b409f7c, 0xe2c0b485, 0xde005c88, 0x3b53259e, 0xbe0531d0
.word 0x14322b19, 0xbfba69a6, 0x65b7619b, 0xdf967cb2, 0x6ab18fc1, 0x0208d72e, 0x9ccf5e99, 0xa7b3855e
.word 0xd625ece8, 0x8522c6e5, 0x45c40406, 0x3fb4371f, 0xcfe24a04, 0x77c1e765, 0x2fd53d99, 0x6b2140f8
.word 0xf76f8284, 0x22de7ead, 0xe7b6e3da, 0x98bf6297, 0x6eb53854, 0x9f86b7fd, 0xb4e46741, 0x9e97bb42
.word 0x082304e8, 0x8826bb57, 0xa81e5744, 0x3168c221, 0x84f24eea, 0x798e2ee5, 0x33ae68be, 0xb24ee1e8
.word 0xc09f43cc, 0xc3c21e18, 0x5f626c1d, 0x1e787015, 0x6bd6d313, 0xafd96f87, 0xb46e9ea9, 0x1aec3634
.word 0xb6f332e2, 0x5e415516, 0x3ac43d26, 0x78a93161, 0x96f7b472, 0x22a94beb, 0xa21ac23e, 0x82cb9d29
.word 0xc4d76aef, 0x4dd37c08, 0x988a7301, 0x103fe152, 0x3ceb20d3, 0xea477d2e, 0x943fdbdc, 0xaab72759
.word 0x3b5eb1f7, 0xe1601867, 0x1232d2d3, 0x06e4b926, 0xa1df0712, 0x848ed288, 0x3e209bbe, 0x861e619a
.word 0x536f84cd, 0x07b44f58, 0x6eccc0f5, 0x3c06e514, 0xc84f78dc, 0x2820b9f4, 0x6832c073, 0x272abeeb
.word 0xa59a365c, 0x2b38aed9, 0x936f1bd8, 0xe53cfab9, 0x79b1da6c, 0x2901b855, 0x5d1698c2, 0xd77a369b
.word 0x5c2a031a, 0x92956217, 0xd24acf72, 0x6c955f2c, 0xab6c418a, 0x5216ce94, 0x66a8e921, 0xb138e942
.word 0xd5a1421c, 0x95b6b079, 0x4ee0364b, 0x39355f28, 0xd94b98e9, 0x7eb27d7c, 0x31999928, 0x1f725366
.word 0xd964e1b7, 0x7073ee50, 0x024855a8, 0x22b068de, 0xa12b9cfe, 0x44fa1d49, 0x0655e7be, 0x6dcedec7
.word 0x055d9b6a, 0xe863242a, 0xbd3d2d63, 0x66773be1, 0x409ef35c, 0xd85b33f8, 0xf1c1112c, 0x753cad9b
.word 0xb498f258, 0xed7f131b, 0x3181e82f, 0x26a24129, 0xc4361365, 0xe0eaac92, 0x48bffedf, 0x24e5f91e
.word 0x81c071b9, 0x223a9d67, 0x802983ab, 0x13a30574, 0x197dc2d0, 0x3a0cb8e6, 0x7c95ddb0, 0x168f3a80
.word 0x84c02fb3, 0x469ac710, 0xfcf06881, 0x657a4bbc, 0x3c1e0a3f, 0x118de7d1, 0x14c7dece, 0xe6a1a506
.word 0xa72051d9, 0x0e29ed94, 0x5d10bacd, 0x8e08bf77, 0xd2ad1c01, 0xd7777383, 0xa7bcdeda, 0x82ad15ae
.word 0xd3cc5bf8, 0x1b0f3ee4, 0x9704f690, 0x3c8ce78d, 0xf717527c, 0x0cb2f337, 0x26dea730, 0x9c975b59
.zero 7168
mem_region_end:
