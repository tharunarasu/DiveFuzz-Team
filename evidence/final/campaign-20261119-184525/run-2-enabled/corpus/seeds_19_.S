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
  li x26, 0x0000000a003c7820
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
  li x1, 0xab9460d968e43b9a
  li x2, 0x9ac21292348e8d2f
  li x3, 0x78b38662261e62d3
  li x4, 0x1ae0206a73cd3146
  li x5, 0xab8bcf18b4a67a9d
  li x6, 0x7dbb279f2965998c
  li x7, 0xdf7eedd4ef009da9
  li x8, 0x89966c2c9f21d8b6
  li x9, 0x79bc8ba3bf473686
  li x10, 0x0a755cd0cd16c4d4
  li x11, 0x0ca1ad0971591188
  li x12, 0xe912182cd063746c
  li x13, 0xecb193eb584e3238
  li x14, 0x378e34bbdafaf3b5
  li x15, 0xd7b6d7491f212eee
  li x16, 0xb14ae9f38829abee
  li x17, 0x17f2a634e31d1f27
  li x18, 0xfa54e376ff344ac7
  li x19, 0x43525d929ced53d9
  li x20, 0xf52c4154c06538fc
  li x21, 0x06b937b427cafd6b
  li x22, 0x8a003124a4c9564b
  li x23, 0x76c284bc4ce57f99
  li x24, 0x4ea1da383cc630e5
  li x25, 0xa4280712805e13fe
  li x26, 0x75b61ac0a0362f23
  li x27, 0x83f119a63ea4dfc5
  li x28, 0x9dcb8b020a7a0657
  li x29, 0x85bc1130d832fefd
  li x30, 0xad2e01829f92fdec
  li x31, 0xbbdf48d83d95d45d
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
  div a6, a6, a6
  slt tp, a6, a6
  sll s3, s8, t0
  sltu s5, s7, s8
  addw a5, tp, s3
  srai a1, s1, 0
  srliw s7, a1, 21
  divw a1, s8, a2
  mulhsu s5, t0, s5
  addw a4, s11, a1
  mul gp, s11, a4
  divu sp, a0, a4
  remw s7, gp, a7
  mul t3, sp, gp
  slt a3, s5, t3
  div zero, s7, tp
  andi ra, zero, 0
  srli ra, a6, 36
  remuw a3, a1, a7
  divuw s10, s10, s7
  remw gp, s8, gp
  sra s5, s3, a3
  auipc s6, 221247
  remuw ra, s6, gp
  divu t1, ra, gp
  sra s4, t1, s9
  srli a2, a2, 63
  mul a5, t0, a5
  remw s5, a5, a5
  sraiw a6, s5, 15
  mulhu s4, a5, s4
  rem s0, a5, s4
  divuw sp, a6, s2
  rem s2, s2, a6
  slti gp, s2, 60
  divuw s7, gp, s7
  slliw a1, s0, 31
  divuw s4, s3, a2
  mulw t0, s4, s5
  slti t3, s6, -423
  mul a6, s6, a4
  remw t1, t3, a6
  sd a6, 1264(t6)
  remu s6, t0, a6
  li s11, -243513741335
  div s9, t2, s10
  andi t0, a0, 2047
  sh a4, -1966(t6)
  remw a3, a3, gp
  divw a5, a7, a7
  mulhsu t2, zero, s11
  divuw t4, t2, t4
  remu a7, a1, s0
  srli a0, s6, 50
  remw a5, a0, t0
  remu s7, t0, t0
  addw s11, a6, t2
  mulw s1, a3, s1
  andi t4, tp, -403
  addw t2, s3, a6
  mulw s0, tp, t2
  mul t3, t2, s0
  sraiw ra, t2, 1
  remu tp, t0, s9
  sll t0, ra, t0
  mulw t2, sp, s4
  remw gp, t0, gp
  srai ra, t2, 15
  rem t3, s0, s2
  divuw a1, a1, tp
  mul s10, a5, tp
  mulhsu a4, s3, t4
  div a5, t4, s3
  remw s2, a4, s2
  subw s7, t0, s6
  divuw s11, a5, s7
  mulhsu s7, a1, a6
  auipc s7, 794185
  slliw s10, s7, 31
  srai a7, s8, 63
  rem a6, s3, t0
  add s7, s7, s11
  sraiw a4, a4, 10
  divuw sp, t0, a4
  or s1, a4, t0
  divw s6, s1, s6
  mulw s10, a4, s1
  remu s1, s4, ra
  mulw s10, s1, s9
  mulhu s7, s7, a3
  divw s5, s4, s9
  mul a7, s5, a7
  div ra, s5, t1
  slli s4, a6, 10
  sw s3, -1228(t6)
  div s8, s8, ra
  remu t2, t2, s10
  divw t3, s4, s8
  rem t0, t0, s0
  sraw s5, s5, a6
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
.word 0x3edcce52, 0x91b26164, 0xd3c6840b, 0xe0864b01, 0x4b56e0fa, 0xe93d3fbc, 0x4bd647cb, 0xd7be8977
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x20cc34c1, 0xb9b6d543, 0xfd46fef2, 0x6c47578d, 0x62eeec70, 0x9ef3d723, 0xc50ed972, 0xd0cce26c
.word 0xd34dc4ee, 0x4a49549e, 0x2978d016, 0xb6376ae1, 0x73075136, 0xd850c8e3, 0x59694fa4, 0xa0cb187e
.word 0x1971c304, 0x16c27cf2, 0xe99cff13, 0x3c202cd4, 0x91b16ed4, 0x3d5cd277, 0x8ddf1d68, 0xf8bc06b2
.word 0x8ab18024, 0xcce53920, 0x80347685, 0xe691350e, 0xa2d15359, 0x0b8802d4, 0x80385729, 0x190b4d6e
.word 0x239936e4, 0x0ed166b8, 0xf71fc3df, 0x5a5c0422, 0x3e489804, 0xe1581787, 0x8f53b3ed, 0xfaf85308
.word 0x750c3b94, 0xda01d513, 0xb48196b6, 0x1a8bfec4, 0x6cb66f0b, 0xa04d6cf7, 0xcab62e2e, 0xded51b72
.word 0x3a5ea463, 0x7db29be1, 0xdd23dcad, 0xcf5fe55d, 0xcd977bea, 0x56ee1641, 0xacf94a4b, 0x710aeee6
.word 0x14919914, 0x33c994ce, 0x50548506, 0x59101dcd, 0x0760d47a, 0x850dd658, 0x7a243166, 0x99a7fbc2
.word 0xdc410db6, 0xd3f29cd2, 0xa118d995, 0xcd06e656, 0xf25604a3, 0x9d7dbe20, 0xc06fa902, 0x982280ca
.word 0xd54cbfbe, 0xa561e851, 0x8806fa55, 0xc1a7affc, 0x66c768ec, 0xf402d3a5, 0x646aa022, 0xa891cfa3
.word 0xf3ed81ee, 0x40d05b0a, 0xaa443472, 0xb70bed8a, 0xa36b0bfb, 0x11261728, 0x50c5428f, 0x1c653fae
.word 0xd6aae41c, 0xe9bc977f, 0x7a944928, 0xe4434767, 0x99c85e76, 0xeb7eb585, 0x6519ccb1, 0x8924cc09
.word 0x5d99ecec, 0x3a0d8c19, 0x998cb87e, 0xbe58d1ca, 0x06e6755f, 0x66e82d9d, 0xcbd4a2c2, 0xaa0d158e
.word 0x1fc1848b, 0x470d4a6c, 0x832715f6, 0x54a9f0f7, 0x9cfed8ec, 0x72290b35, 0x59c1be0a, 0x170c2ae3
.word 0xe1b3b54c, 0x87cbd119, 0x20c88c6c, 0xdb00c4b4, 0xb8e9d13e, 0x696d4627, 0x075a13b3, 0x03685c6b
.word 0x7fd15aa1, 0x24038ee2, 0xf3998b06, 0x88fdb943, 0x63d225b7, 0x05ff08bf, 0xf1bf0528, 0xe6027c12
.word 0x114b3f7a, 0x331f0a69, 0x19b1ecdd, 0x47addb37, 0x804d857e, 0x8336a7e7, 0x74238c1d, 0x40f2175e
.word 0xd5d5f4b2, 0x2a7ad9d7, 0xda9bd5b1, 0xc601d2e3, 0x6ca4ce6b, 0x3da9441d, 0xfabecbdd, 0xf813a79e
.word 0x00f54eab, 0x736f47c3, 0xb2638bba, 0x5946ab85, 0x16097ca3, 0x9fee7c3d, 0x96566104, 0xbc117f2e
.word 0x3e5cc1c0, 0xb340a3e0, 0xabe7f4d7, 0x70481010, 0xc26145f3, 0xa49d9ea8, 0x895adcd9, 0x997794ba
.word 0x4884eefa, 0x62090e45, 0x3194dc18, 0x6632187c, 0x8f27de23, 0x964a24ba, 0x609bd02e, 0x7b86f38b
.word 0xcb97a040, 0xe1f6bc30, 0xbdc997a3, 0x39a8c12c, 0xab022f19, 0x23b4767f, 0x5a1eecc3, 0x10488424
.word 0x966b71e3, 0xb52463d7, 0x702e82f6, 0x64e89560, 0x7e46c32f, 0x8b20bb90, 0xd4ee15c8, 0xdd6e3c4b
.word 0xf0e093ae, 0x66c4b484, 0x4d50ada9, 0xb987d984, 0x122bbb0e, 0xba02f196, 0xebc61343, 0xf61f598b
.word 0x8cbf4978, 0xf6cdfeca, 0xda646595, 0xce78081f, 0x6f51e967, 0x87118490, 0x71bb8abf, 0x5223f6a7
.word 0xf76f8d4d, 0xcdb5642e, 0x9c4b051e, 0x5f71824a, 0x379ee4b7, 0x26139a2e, 0xde7c7ac1, 0x703465f3
.word 0x71f8d498, 0x455de4f4, 0xe03575dd, 0x686cea78, 0x517a48af, 0x5f6eb1ca, 0xc6136189, 0x795c1b13
.word 0x49cb5756, 0x74ce2d29, 0xcb5dc007, 0x5da968a8, 0x8db5eefd, 0x36b8c8bd, 0xb806dd25, 0xd15144ce
.word 0x5279cf01, 0xa717b4fc, 0xd9d62ccf, 0x8230facf, 0x8d272b75, 0x8f2caa30, 0x7980303b, 0x608aa6f4
.word 0x160379fc, 0x3f0f388c, 0x97a0164c, 0x53cea0ce, 0xee2276a1, 0x60e51d96, 0x69d9306c, 0xb27933ce
.word 0xc88c64f1, 0x5c897841, 0x9b6234a9, 0xd7579ff1, 0x4421ec05, 0x732abc64, 0xf6cec0d7, 0x54fb1791
.word 0xe93abc6d, 0x0765c137, 0x237871eb, 0x85268a6e, 0xb13733e3, 0x9deba106, 0x0e15b4f7, 0xe2533968
.zero 7168
mem_region_end:
