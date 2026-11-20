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
  li x26, 0x0000000a007048a8
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
  li x1, 0x7fd174cb93801745
  li x2, 0x1a609df92e29017c
  li x3, 0x448bce8f963095fd
  li x4, 0x56d01ad0533e0395
  li x5, 0x5ddf205d5c8eb1c2
  li x6, 0xd896febde135c547
  li x7, 0x59b39884551322a2
  li x8, 0x3dc4f8714ad7d0a4
  li x9, 0x582a7a809d736c93
  li x10, 0x478f66bdd008ceb8
  li x11, 0x07c897a2be22c030
  li x12, 0x74941859a5065835
  li x13, 0x340d9c892ef78b0f
  li x14, 0x42e7a5333bf25ba3
  li x15, 0x57a9a51694bd6cec
  li x16, 0x5f3843a25876a0fa
  li x17, 0x835dfa91c3c6b49a
  li x18, 0x4ebe64b4231bb874
  li x19, 0x5a263d2f55ff2118
  li x20, 0xaf6708b9cfc5572b
  li x21, 0x17090a48605f8566
  li x22, 0x30fc493bdd28b86d
  li x23, 0xc03f12188a737004
  li x24, 0x7013362bd81a365c
  li x25, 0x3e19de459583ae45
  li x26, 0x2eff9459c2fab067
  li x27, 0x4f5ae3b532c44292
  li x28, 0x4c163cec93d7858f
  li x29, 0xe2b2194c17739547
  li x30, 0x4c6269f512e4864e
  li x31, 0xcac7fe56f2f2c1ad
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
  remw a7, a7, s10
  sraw s4, s4, a7
  sd a7, -216(t6)
  divw a6, a6, a6
  sltiu gp, s4, -2047
  mulw s3, a6, s3
  addw t0, s4, a6
  sraw s7, t0, s7
  fence.i
  xori t2, s3, -2048
  remuw s8, a1, t2
  lwu a1, -1528(t6)
  remu a0, a0, s7
  srlw s2, t2, t4
  srlw t1, a1, t2
  remw s3, sp, t1
  remw s6, t1, s6
  fence.i
  remw t4, t1, t4
  divuw sp, s0, s6
  div s8, s6, sp
  sltu a1, t4, t4
  lwu a6, -1468(t6)
  rem s3, s3, sp
  sraiw t2, a2, 1
  fence.i
  addw t4, a7, t4
  fence.i
  ld zero, 448(t6)
  lwu s8, -1708(t6)
  fence.i
  sra s5, s1, a2
  divw gp, gp, t2
  mulhu s3, s8, s3
  addiw a0, t3, 1563
  remw s4, s3, a0
  rem s0, t1, a0
  divuw s6, s3, gp
  div a7, s3, s6
  fence.i
  nop
  mulhsu t4, a7, a7
  remw tp, s4, s4
  sd s4, -1384(t6)
  fence.i
  xori t0, sp, 1824
  lbu s2, -1042(t6)
  srli sp, sp, 0
  and t4, a7, a7
  slti s0, s0, 1680
  remu s3, s5, t4
  remu a2, t4, s3
  sd s0, 16(t6)
  xori s1, s1, 0
  remuw t0, s3, t0
  fence.i
  subw tp, tp, s2
  ori s6, s1, -1
  fence.i
  srlw ra, s6, s6
  addi t4, t4, -715
  remw a2, tp, ra
  fence.i
  auipc a3, 3766
  or a7, a7, ra
  div s9, a3, s4
  divw zero, s6, a2
  rem s2, s2, s9
  mulhu a6, s2, s2
  remu t1, s9, a7
  mulhsu a3, s9, zero
  fence.i
  subw s11, s11, s2
  fence.i
  slliw a0, t1, 31
  srai t0, t1, 63
  srli t3, s1, 0
  rem a7, a7, a0
  divu a2, t0, t3
  auipc s2, 624167
  rem s3, t0, a2
  fence.i
  fence.i
  slli s0, s0, 46
  remu a1, a2, s0
  divw a4, a4, s0
  fence.i
  divw s8, s3, s2
  fence.i
  fence.i
  mulw a5, a1, s8
  fence.i
  divw s5, s8, t4
  fence.i
  fence.i
  fence.i
  ld s9, 1936(t6)
  fence.i
  fence.i
  srai s0, s9, 0
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
.word 0x63e47370, 0x5d1c0ec3, 0x8480e0b6, 0x7105735d, 0x6f968aa8, 0x38c543f1, 0x29a9b19b, 0xdebd0e4f
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x2be545e3, 0x780f1802, 0x2b06319f, 0xa8ad8d5e, 0xbf3a4dd4, 0x65145c8a, 0x0732e3dd, 0xa550fbc5
.word 0xe6b06acc, 0xb3963c2a, 0x658c2cca, 0x386e482b, 0xfc25c17a, 0x387d236b, 0x7a8777b7, 0xa0b443dd
.word 0xce973337, 0x03379ca6, 0x15e8ce7a, 0xe6d98bb3, 0x77f37cd3, 0x95da998d, 0xcbeadc92, 0xfcbf1077
.word 0xed59d8a9, 0x658ac8b0, 0x7974f999, 0x55424e3c, 0xf1a1edbb, 0xa8a9af45, 0x0bf4b386, 0xc6827cfb
.word 0x6aec5143, 0xdc3ae2cd, 0x4d9faf9d, 0x7ddb2cb2, 0x6ff195d8, 0xf0ef0b86, 0xb4fc6c94, 0xdf6ee911
.word 0x2d5d8acf, 0xb93ede5c, 0x0a031e1b, 0xc05d69fa, 0xd8405a7a, 0x3f1ba415, 0x79af8294, 0xdcfaaf03
.word 0x8181a57f, 0xcdd79ef3, 0x365f19ed, 0xb7117883, 0x50ff86fa, 0x3af5652a, 0x45c2d19f, 0x0bfe79b7
.word 0xfbe1d56b, 0xb0242708, 0x7d7dc921, 0xf212749c, 0xc07ca5ee, 0x9fe12b18, 0x774d3948, 0x2d02dcd3
.word 0x224dbe20, 0x84a03e3b, 0x8317b46b, 0xeea5c903, 0x99d9706d, 0x94d7018c, 0xa77eddca, 0x7e048340
.word 0xd09aa1a3, 0x3d4ddb1f, 0xa49c35e7, 0x8f38a9aa, 0x0e3bf1f2, 0x14a11a58, 0x19b22a41, 0x6ce3aec2
.word 0xac722462, 0xd92f01e4, 0x6fa49fe8, 0xd3397aad, 0xadead9f4, 0x847bedd8, 0xa7c17cb0, 0x2f82c9fa
.word 0xa4a4f9f9, 0x0ff8757e, 0x330cfe73, 0x7bf46359, 0xc86e69c6, 0x5b4527c8, 0xa3e8e300, 0x4a588d8e
.word 0xe0d18299, 0x7fde5231, 0x20e53676, 0x4e9d21aa, 0xcec30333, 0xe3b2e552, 0xa78df87c, 0x750b4cd2
.word 0x4622c77f, 0xcb139312, 0xe08170dc, 0xea4f17b3, 0x52e67c44, 0xe60e76da, 0x8a89929d, 0x83f59c30
.word 0xed06fd11, 0xf0e6e71f, 0x58ae57b2, 0xc297dc2f, 0x32acd4af, 0x9c576b3a, 0x286ea539, 0xbe40c23e
.word 0x9fb4c708, 0xc5c78790, 0x16f9501d, 0x3e293776, 0x0e1ebe30, 0xf540f60c, 0x675a8aa1, 0x186af6c0
.word 0x61df9032, 0x65c723b3, 0xca701c65, 0xc852b6db, 0xa25a2f9e, 0x35314182, 0x84deffd6, 0xefa005a5
.word 0x8801795f, 0x1c5c95d8, 0x56b1c9c9, 0x13d7d909, 0x9ac6769c, 0x229c6d36, 0x11808136, 0xc8bb850d
.word 0xe36f7103, 0x58962a7c, 0x791c462a, 0x29317a25, 0xd4c7692a, 0x72e9851b, 0x00687722, 0x3a6cfdc3
.word 0xbde66aec, 0x0d8fba77, 0x12aecab7, 0x5cc5f5be, 0xca2d71d4, 0xa97b2062, 0x0b858481, 0xbf1318ff
.word 0x7dd27c88, 0x5cb54bdc, 0x70bf7750, 0xc8a61822, 0xb3acbe05, 0x6552984b, 0x584264e7, 0x3d67d15b
.word 0x03645004, 0xfc6fca59, 0x0048def9, 0xa2f943ea, 0xf3b246ba, 0x0220bba5, 0x45b144b4, 0x80d07814
.word 0x27bc70ce, 0x04731c4b, 0x8dd010e5, 0x92bd174e, 0x61b88c30, 0x9d01de76, 0xd2216a08, 0x92055cb7
.word 0x9c00a302, 0x36ab61ed, 0x0c6fe85c, 0x306a9d47, 0x3a561ecf, 0xe08e3237, 0xc5cd3773, 0x0493c5b3
.word 0x73a085cf, 0x70ca21b0, 0x47faaa5e, 0x0c1710c6, 0xc90c6680, 0x98d6af79, 0xa14c25f9, 0x19427c4b
.word 0x08050b0c, 0xa8646a17, 0x4ae7509c, 0xfa16bf01, 0x7a6bce9c, 0x7dd5ead6, 0x63c2b472, 0x8b50fed1
.word 0x82efccbc, 0x671876fe, 0x8c768765, 0x038bd60e, 0xc3c5c30e, 0x124e989f, 0x7ab48b0e, 0xbff0193c
.word 0x08e7fa02, 0xc1b202e2, 0xc4a4db05, 0xef581277, 0x942691b4, 0x190c9c1f, 0xd3d9530b, 0x9e39ecd6
.word 0x5dfc3052, 0x7af86d70, 0x314ecac5, 0xaf902988, 0x93a38413, 0x797b0015, 0x11021557, 0x33e3687d
.word 0x05cdd8c5, 0xa33456b3, 0x9233501b, 0xc231de66, 0xa8c5ce8f, 0xdc471f7d, 0x86c83a0d, 0x4e453a66
.word 0xac7dda04, 0x274f8bfa, 0x8dfed094, 0xd3c98732, 0x06fb9a6c, 0x71ebb50b, 0xfcd868e9, 0x746c3b6b
.word 0x32e353cc, 0x265f826e, 0x4b0559b2, 0x633caba0, 0x3b475e99, 0x192aa6e9, 0x2f82cda4, 0xbfb8cf8e
.zero 7168
mem_region_end:
