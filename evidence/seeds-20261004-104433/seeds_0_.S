.globl _start
.section .text.init
_start:
trap_vec_init:
  la x13, other_exp
  csrw 0x305, x13 # MTVEC
  la x13, other_exp_s
  csrw 0x105, x13 # STVEC
mepc_setup:
  la x13, init
  csrw 0x341, x13
init_env:
  li x26, 0x0000000a0000f82a
  csrw 0x300, x26 # MSTATUS (MPP=3)
  li x16, -0x1
  csrw 0x3b0, x16 # pmpaddr0 = all 1s (NAPOT full coverage)
  li x16, 0x1f
  csrw 0x3a0, x16 # pmpcfg0: entry 0 = NAPOT+RWX
  li x16, 0x0
  csrw 0x3a2, x16 # pmpcfg2 = 0 (disable entries 8-15)
  li x26, 0x0
  csrw 0x302, x26 # MEDELEG - no delegation to S-mode
  csrw 0x303, x26 # MIDELEG - no delegation to S-mode
  csrw 0x304, x26 # MIE
  csrw 0x340, x26 # MSCRATCH - init to 0 for cosim sync
  csrw 0x343, x26 # MTVAL - init to 0 for cosim sync
  csrw 0x342, x26 # MCAUSE - init to 0 for cosim sync
  csrw 0x140, x26 # SSCRATCH - init to 0 for cosim sync
  csrw 0x143, x26 # STVAL - init to 0 for cosim sync
  csrw 0x142, x26 # SCAUSE - init to 0 for cosim sync
  csrw 0x141, x26 # SEPC - init to 0 for cosim sync
  mret
init:
  fsrmi 3
  csrwi fflags, 0
  li x1, 0x336448dc7454c6be
  li x2, 0xa478b6dab8b166f6
  li x3, 0x4c311644e504772d
  li x4, 0xeaf7815f114f9ae3
  li x5, 0xd96dc989377938c5
  li x6, 0xd66db6de663abfd7
  li x7, 0x2a0f90ba077f4690
  li x8, 0x25614deffd51ee28
  li x9, 0xf96fc3914b37b542
  li x10, 0x2dcb74cfb51ac0e0
  li x11, 0x866916c0d2252950
  li x12, 0x43d8dd0811dec884
  li x13, 0x3ee21a2ddf5497e7
  li x14, 0x556fe447ba505d3e
  li x15, 0x33edd82301ab328d
  li x16, 0x4dd6c31fe0295846
  li x17, 0x210b6b136ff124d3
  li x18, 0x7411eb51fa9cdc29
  li x19, 0x164b713ebdd5cd89
  li x20, 0x456ee100df2d2c46
  li x21, 0xd6da57f1ef5d88e0
  li x22, 0xe362231f1857f85d
  li x23, 0xc4599668911a7afc
  li x24, 0x92230f46937a88a1
  li x25, 0x9806d05c6a260d7d
  li x26, 0xe3a86e543a02b66f
  li x27, 0xc9c6062c5cdee872
  li x28, 0xb4eb0f1335fc0bd3
  li x29, 0xb1ccf8e002f76179
  li x30, 0xebd3e4cee4e1f449
  li x31, 0x07d1cb0018eddd57
  li x5, 0x35a77c29c214ce1d
  fmv.d.x f0, x5
  li x5, 0xf2fcb9bf8408e3af
  fmv.d.x f1, x5
  li x5, 0xe60271eb5be0c098
  fmv.w.x f2, x5
  li x5, 0xf57db34d7cf9e444
  fmv.w.x f3, x5
  li x5, 0xf0b112411539fbb2
  fmv.d.x f4, x5
  li x5, 0x43620dea98f4cb19
  fmv.d.x f5, x5
  li x5, 0x26716697faf3195e
  fmv.w.x f6, x5
  li x5, 0x5f6597ff7e2d2c86
  fmv.w.x f7, x5
  li x5, 0x22a03fcf4eee0585
  fmv.d.x f8, x5
  li x5, 0x8c43248c33390b83
  fmv.w.x f9, x5
  li x5, 0xc004b3224ac067ed
  fmv.d.x f10, x5
  li x5, 0xab29f593a5d16776
  fmv.d.x f11, x5
  li x5, 0x8f66b43dcc958e02
  fmv.w.x f12, x5
  li x5, 0xbb9c4f9aac72773d
  fmv.w.x f13, x5
  li x5, 0x1584b910dbeb77d7
  fmv.d.x f14, x5
  li x5, 0x0276ec551b4301d9
  fmv.w.x f15, x5
  li x5, 0xbf6477f67d34c1c4
  fmv.w.x f16, x5
  li x5, 0x3678f1f1058e15fc
  fmv.d.x f17, x5
  li x5, 0xb1f4b4b01e0bd328
  fmv.d.x f18, x5
  li x5, 0x746c31815313c79d
  fmv.d.x f19, x5
  li x5, 0x7593e84e93135253
  fmv.w.x f20, x5
  li x5, 0x5e9cb55eb8adf7b0
  fmv.d.x f21, x5
  li x5, 0x2c6ff21b061d3a96
  fmv.w.x f22, x5
  li x5, 0x0d520ede5d440c9e
  fmv.d.x f23, x5
  li x5, 0x43345ce1278db30d
  fmv.w.x f24, x5
  li x5, 0xb8e168fe850d2c77
  fmv.d.x f25, x5
  li x5, 0x8ddf3d280c6a7433
  fmv.d.x f26, x5
  li x5, 0x494ff929e5e20efa
  fmv.d.x f27, x5
  li x5, 0x4f6c6b07dfaee195
  fmv.w.x f28, x5
  li x5, 0x90af85faf32634f9
  fmv.w.x f29, x5
  li x5, 0xca8d089a71b51602
  fmv.d.x f30, x5
  li x5, 0xab4dea5e4e718c81
  fmv.d.x f31, x5
  la t6, mem_region
  li t5, 4096
  add t6, t6, t5
  j main
.align 12
other_exp:
.option norvc
  csrr x14, 0x342
  blt x14, x0, m_handle_interrupt
  csrr x13, 0x341
  addi x13, x13, 4
  csrw 0x341, x13
  mret
m_handle_interrupt:
  li x15, 0
  csrw 0x304, x15
  csrr x13, 0x300
  li x15, -9
  and x13, x13, x15
  csrw 0x300, x13
  mret
.option rvc
other_exp_s:
.option norvc
  csrr x14, 0x142
  blt x14, x0, s_handle_interrupt
  csrr x13, 0x141
  addi x13, x13, 4
  csrw 0x141, x13
  sret
s_handle_interrupt:
  li x15, 0
  csrw 0x104, x15
  csrr x13, 0x100
  li x15, -3
  and x13, x13, x15
  csrw 0x100, x13
  sret
.option rvc
.align 2
.option norvc
main:
  clmul s6, s6, s6
  divu a1, s6, a1
  sc.d.aqrl gp, a1, (t6)
  aes64ks2 a2, s8, a2
  roriw s10, a1, 28
  rem s5, a1, s10
  mulh zero, s5, zero
  or s9, s10, gp
  fcvt.s.l fs0, zero, dyn
  sd zero, -280(t6)
  lhu t4, 1460(t6)
  sraiw a6, a6, 0
  sha512sig0 s2, a6
  orn t2, t2, t4
  aes64es t3, t3, a6
  fcvt.lu.d a7, ft4, dyn
  fcvt.w.d s5, fs0, dyn
  nop
  divw gp, a5, a7
  mulhsu s4, gp, a7
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
.word 0xde71782c, 0xab88749e, 0x0be380c5, 0xa74511c7, 0xf20c6f30, 0xf5954ad9, 0x7bc95502, 0xc04a4639
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x4ba35dbd, 0x2175b0cc, 0x1c5cee0f, 0x27ec968a, 0xa9e63c32, 0x2f255e1b, 0x2f7595f3, 0x2eb912fb
.word 0x918e63cc, 0xfae1c033, 0x2033fe03, 0x722fa356, 0x735dcdf6, 0x324f6258, 0x870d2da6, 0xddf75eac
.word 0x516693ef, 0x4bc67182, 0x6c8c66ee, 0x548d9059, 0x7d8fce17, 0x359cfcda, 0x685da8a7, 0x2d0e912d
.word 0xe0d97f9c, 0x8cca498b, 0x92b0daf3, 0xe43f99fd, 0xf18c151a, 0xc0e24ef8, 0xaf337b9d, 0xc8a55d5d
.word 0xbc331a31, 0x25c42930, 0xd9c002f5, 0x7668047e, 0xc0ee902f, 0x9ea34ea5, 0xf023bfb6, 0x1fab32f2
.word 0xc14f5513, 0x76811045, 0x63d63cb2, 0x00d8fd56, 0x629f136a, 0xcf69ce33, 0x970a969f, 0xb096afc6
.word 0xec7d8959, 0x11ac5429, 0xde14b0bc, 0x8815f959, 0x36f49531, 0x2c9342aa, 0xa9fabbfc, 0x29f60885
.word 0x62d3ba33, 0x4bede18d, 0x31bca2d9, 0x640c4b8e, 0x8831db85, 0xe8732c46, 0x5a708483, 0xc1d3c6da
.word 0xc6339a7b, 0x2a5c3042, 0xf37a4e43, 0x968f740b, 0x098b59f8, 0x81df3083, 0xf321059a, 0x06e5d737
.word 0x7b4cf13a, 0x24ab92ff, 0x2f83b922, 0xed5eac56, 0xa114599e, 0xbd70c899, 0x4634a758, 0xa1da2962
.word 0xb23445db, 0x2bd3b390, 0xa58b2c3e, 0xee3354fa, 0x72da5ab3, 0x180ed275, 0x0707891e, 0x7e1ab4f9
.word 0xba8ae5f8, 0xff47c69b, 0x096fbd0c, 0x37fdb394, 0xea61eecd, 0xc3c70d16, 0x3698042f, 0x383b9c4a
.word 0x84e2112c, 0x530379fb, 0x51a26c83, 0xffbefa02, 0xaf523208, 0xb0aad071, 0x25545c8b, 0xfb14e3f2
.word 0xa2a76ce8, 0x17aea3d2, 0x55729251, 0xb43444f9, 0xc32495b2, 0x364dab65, 0xf1b6d0c0, 0x1af2a4d1
.word 0x05b347ed, 0xa1a66fc3, 0x9d022b01, 0x3294eba2, 0x1df54378, 0x369b21aa, 0x10f4fa8e, 0xa68f8d73
.word 0x31e39264, 0x23abd501, 0xb26f827f, 0x9611e6ef, 0x6e0899d3, 0x881e0bd1, 0xeb37dc5a, 0x3fa07d7a
.word 0xcca00745, 0xb99b0752, 0xcac25549, 0xb731e77b, 0x3d39ac0c, 0xa107cd07, 0x6b07f6d9, 0x0cf1a5c4
.word 0xd10a2d64, 0xa8d04488, 0xa0afbc89, 0x83942823, 0xd97187d7, 0x7ecfe8c6, 0x23f8bf20, 0x1a11f3ea
.word 0x798bdda5, 0xdc795b00, 0x9bbe8874, 0xd579061d, 0x3a447375, 0x081ba756, 0x440dc158, 0x7a1bb345
.word 0xafa64418, 0xc75b7dd7, 0xddfe1220, 0x2b0826cb, 0x0b2401c9, 0x327536a8, 0x979b10c9, 0xed0588a5
.word 0xb0b8c148, 0x4b170b67, 0xc0bbc3f8, 0xfadcd32b, 0x0f109712, 0x3aae546c, 0xc0cc1134, 0xe6f3126b
.word 0x862bd0ca, 0xd0c8b048, 0x95b74a08, 0x3827c6f1, 0xb4fa34f8, 0x17cdcd17, 0x07628949, 0x82510dac
.word 0x4d2622c9, 0x0a1326aa, 0x0c463964, 0x34a79dfe, 0xcc78af0e, 0x54c35e3f, 0xab7d18cc, 0x9d7afd94
.word 0x0247cd5e, 0x1c516640, 0x86fa0cb7, 0x6c640a94, 0xdae6a914, 0x50b8458e, 0x492b1e15, 0xbdb8acc2
.word 0x808a7329, 0x27b8733a, 0xf288b5bf, 0x55764a02, 0xfb889fa9, 0xea3c0366, 0x55f973a8, 0x15749a14
.word 0x929adb5f, 0x976947a7, 0xd5a94c59, 0x193c6080, 0x0d9a51f6, 0xfc902d5e, 0x1685c2c6, 0x9d2bbb66
.word 0x437d4d77, 0xf39b8cdd, 0x7a53cb6c, 0x6254e1d5, 0x52b62fb8, 0xf3139584, 0x1b924fec, 0x027b4e07
.word 0x39439ba5, 0xf641e223, 0x3f5b019e, 0x3e2ea27a, 0xbdb08290, 0x78baf21e, 0xf95a3e84, 0x87b9ec8a
.word 0x1276eb28, 0x084fbf86, 0x1d1bf06a, 0x80e23963, 0xa9327d23, 0x18fefdc1, 0xdf6594df, 0xb3be8fb5
.word 0xed237813, 0x31cf0500, 0x3c94f257, 0x901bddbc, 0x7d42cdf2, 0x8696265c, 0x0b4d583b, 0x220b40c5
.word 0x3601f1fe, 0x339e5758, 0xf842d1b7, 0x68970b37, 0x72abf34e, 0x49989b43, 0xb058f8c2, 0xd63c6bd8
.word 0x96e38f3f, 0x2af643ef, 0x5e2ab1f7, 0x584cddc7, 0x4c495007, 0x8436665f, 0xc2d7054c, 0x7579d09d
.zero 7168
mem_region_end:
