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
  li x26, 0x0000000a00643882
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
  li x1, 0x89f3f81fc6c4c6af
  li x2, 0x2d3f5254ac08cabf
  li x3, 0x95d7a0012500876b
  li x4, 0x0d4357d562a018b9
  li x5, 0xe5b0cce295251788
  li x6, 0x6dd62953e62999fb
  li x7, 0x27c1bb81f67fbabf
  li x8, 0x98601530981b997f
  li x9, 0x5d314df16337361a
  li x10, 0xef7c3707fb74f3d9
  li x11, 0x336cfcbb1b7b8078
  li x12, 0x5171acff0d59d949
  li x13, 0xf1b59bbd9f03d7d3
  li x14, 0x7c2bbb9e538c11ef
  li x15, 0x41d9d5977ceb5395
  li x16, 0xe8bf91fb03d58395
  li x17, 0xd6eb92bf5c8243d4
  li x18, 0x26367366ea8fdbda
  li x19, 0x0a12e35be5a407b0
  li x20, 0x5762bd7de922dae4
  li x21, 0x2653708a1f4f6a5f
  li x22, 0x2e774d03c5989f6d
  li x23, 0x6dac37da9583304e
  li x24, 0x307f978dac3f53da
  li x25, 0x11442aab018a9ba9
  li x26, 0x850f26b3e37c625b
  li x27, 0x2a3a1b1634fe5755
  li x28, 0x2964928466d49b70
  li x29, 0x2114169006c7a002
  li x30, 0xb1ca38c84cc1340c
  li x31, 0x2ad753193dcc045f
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
  sw t2, 568(t6)
  div a3, a3, a5
  srai gp, a3, 0
  mul s8, a3, s8
  or a5, s3, a5
  remuw t1, a3, t1
  mul ra, a3, s8
  rem a7, zero, ra
  srlw a5, s8, t1
  srai s10, t1, 0
  rem a6, t1, a5
  lwu s2, 1224(t6)
  srai s1, a6, 63
  lhu ra, -624(t6)
  srli t3, a7, 0
  srai t1, t3, 33
  mul s7, s2, t1
  mul s9, t3, s4
  srai a1, a1, 0
  divw s0, s9, t3
  fence.i
  fence.i
  fence.i
  fence.i
  mul s10, t3, s9
  fence.i
  fence.i
  rem a5, s7, a5
  divuw s4, a5, s0
  mulw zero, a5, s0
  ld sp, 1824(t6)
  lb s9, 1997(t6)
  lbu s4, 1178(t6)
  srl s5, zero, s6
  lui s11, 0
  rem a4, s5, sp
  lw s3, 1436(t6)
  sllw a7, s11, a4
  xor a5, a4, s3
  remu zero, a5, a5
  nop
  remw a3, a5, a5
  mul s9, a3, tp
  mulw a3, zero, s9
  mulhu sp, a7, zero
  fence.i
  auipc t2, 257089
  remuw a6, t2, s4
  fence.i
  div a6, a6, zero
  srlw s2, a3, a3
  fence.i
  slli t1, a3, 0
  auipc s11, 1048575
  fence.i
  remuw t0, t1, t0
  fence.i
  srlw t4, s2, a6
  lui zero, 203025
  andi a2, t4, 763
  fence.i
  sraw sp, zero, a2
  xori s4, a2, 0
  rem s10, s11, a2
  fence.i
  div t1, s4, a2
  lhu a6, -1156(t6)
  div a3, a1, t1
  lh t4, -788(t6)
  sltiu s11, t4, -1797
  sh t4, -114(t6)
  sll s1, t1, gp
  divuw t3, a3, s1
  mulhsu gp, s1, a3
  mulhsu s8, s1, s11
  remw s0, s11, t3
  sraw a7, t3, a7
  mulw s4, a7, t4
  auipc gp, 391101
  mulw t2, t2, s11
  fence.i
  fence.i
  sd s4, 880(t6)
  slliw t0, a7, 19
  fence.i
  remu s7, s0, s4
  fence.i
  div s2, t2, t0
  divuw a0, s2, t0
  addw a7, s1, s7
  fence.i
  mulw a5, a7, a5
  slli s0, a5, 63
  fence.i
  divw a6, a0, a6
  add zero, zero, s11
  divw s6, a6, a7
  divw a6, s0, a5
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
.word 0x7cc0816e, 0x33ee1355, 0x093eeb8d, 0x90abf6d8, 0x35f6c474, 0xd166e686, 0xa0923e1b, 0x7b4387e3
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x4a03a7d5, 0x7abbfc2d, 0xe6b3880b, 0x23c1babb, 0x04a6e416, 0xa2a767b5, 0xeeb62872, 0xaf149e9a
.word 0xbce571c6, 0xb904a3f5, 0x7374b151, 0x1d4fe39f, 0xaf8c51b7, 0x0ec8a5ca, 0xf52030fd, 0xbbeb1400
.word 0xcfe48c52, 0xf81b6f7e, 0x94cd0718, 0xd4a5ff71, 0x7c6ee6c3, 0x3678d244, 0x132ce868, 0xe474301f
.word 0xbb66d1be, 0xe383c879, 0x8cf68aae, 0x533f12e7, 0x47e3f473, 0x6988cd21, 0x5d03b57d, 0x3b0b67ae
.word 0xf7220630, 0xc47e029b, 0x8414deba, 0x32aa8b2a, 0x58ad47d4, 0x1926fd51, 0x20a63052, 0x11597ec1
.word 0xbf74d1c8, 0x409ef9dd, 0x3cfb152c, 0x4a6986e1, 0xa9608332, 0xe18aa00a, 0xeffa2f44, 0xe7287da5
.word 0x7e5359db, 0xc1d7baa1, 0xb7d9cb37, 0xe2846938, 0xa7bc1f37, 0x11ab0822, 0x18998316, 0x135b8cfa
.word 0x49bcfeb5, 0x011752dc, 0xca614180, 0x869fe41b, 0x61081ae7, 0x41c81da5, 0x80ba677d, 0xe41ccf79
.word 0x081dad1b, 0x71a17662, 0x985da794, 0xdc0d75d5, 0x466c56b2, 0x370099eb, 0xdacd6b4c, 0xa6f2d07b
.word 0x3ea9d00e, 0x4031d227, 0xf5422d38, 0xb97c6964, 0x6e59c87f, 0x61379cf3, 0x9d0cec76, 0x434b24a9
.word 0xddc535ce, 0xc8a22f48, 0xbfde30e1, 0xac99d369, 0x1e4729aa, 0x4270ca3b, 0x358a3eb9, 0xed0c3b4d
.word 0x78e47968, 0x5f201554, 0xb816e862, 0x6eb4804c, 0xb3f1ba93, 0xb78ecc22, 0xc16f1934, 0x689ea9d2
.word 0x15a4ffa0, 0xda1ed1b0, 0x8cb602c3, 0xac658860, 0x070dbc1c, 0x876f231b, 0xa8027fc9, 0x79d81cad
.word 0x06412bc0, 0x2686508e, 0x8b079e89, 0xd1a0f25f, 0x739a488c, 0xfd086b99, 0x174bc640, 0xe659c750
.word 0xad393071, 0x3e76f90f, 0xbf1aa505, 0x010f1bba, 0xd1d0ac00, 0xa62a325c, 0xf31cce65, 0x6104415d
.word 0xdabc200a, 0x18b7582d, 0xd684f0db, 0x58c51545, 0x00333a59, 0xe9dbde2d, 0x20176d13, 0xcf0aaf79
.word 0x48397304, 0xfdf6d6f0, 0xaac0d8d9, 0xfaf553c4, 0x2e1e9b95, 0xadad57b7, 0x9f46e4be, 0x37ac0ece
.word 0x2a42e29f, 0x84e82c48, 0xc7f0462d, 0x260a907d, 0x43561f7a, 0x1d8f356f, 0xc7bfd9fd, 0x6788e802
.word 0xae94ca67, 0x5908c25a, 0xdfbf0f92, 0x369826ac, 0x42916360, 0x5b05af52, 0x9ca3f431, 0x911e1f70
.word 0xf86b3580, 0xbcc3ce64, 0x8af96518, 0x772b54a7, 0x5a05c22d, 0x1ee65648, 0x16816242, 0x3e8a1341
.word 0x2106dcd4, 0xd1e6cb45, 0xa7112a1a, 0x34ff9bbb, 0x92e9a230, 0x595ea13c, 0x1073d7ab, 0x23573b54
.word 0x81df7470, 0x6eb8ac99, 0x60ed6371, 0x044d1858, 0x789b0be8, 0x6a16b587, 0x714d288d, 0x96837a29
.word 0xfb33539a, 0x1980e88a, 0xc3d7577f, 0xde16e948, 0x664f0621, 0x179771a1, 0x0c0936d2, 0xeab5b701
.word 0xf6717c8d, 0xedc40ab9, 0x25fbfa40, 0x11a7f35a, 0xde7975d5, 0x363f6de9, 0x7edf9dba, 0x4239840b
.word 0x0f3d4008, 0xa7e7b0af, 0x8b7a711a, 0xe375a226, 0xd679e23f, 0x96efcef0, 0x0ca1c7a8, 0xfd754cbd
.word 0x7b35b1f0, 0x54224e30, 0x6ef404f8, 0x2bf01e99, 0x441e44d5, 0xa1fed62b, 0x436b2fbf, 0x526e40d7
.word 0xe2469bf5, 0xf50345c6, 0x20ee188d, 0xc693d287, 0xcbe4d7e1, 0x25687518, 0xc50be444, 0x7fb0e850
.word 0xb7e89e9b, 0xde4c5ee3, 0x90635745, 0xac17e233, 0x56be501b, 0x0f446c20, 0x0ef45faf, 0xf3ca56fe
.word 0x7acc9f7d, 0xbaeb4920, 0x4a1a9b9d, 0x3222372b, 0x20c6945d, 0xc21d4ad3, 0xca2bddda, 0xdb6792f6
.word 0x0f7f45e7, 0x109c9e3d, 0x901819fa, 0x34444ca8, 0xaae55e67, 0x767aa2dd, 0x89d3f74e, 0xdb095913
.word 0x389cefd6, 0x4568914d, 0xc4869a66, 0x8c72cbc8, 0xc4ce440b, 0x8cead6df, 0x8030a8ad, 0xd0f8ccd6
.word 0xccf6ba10, 0x2ba38e9b, 0x9d6e41d8, 0x22356583, 0x04cb42bc, 0x1dd6305d, 0xc3f42df9, 0x5449ef6a
.zero 7168
mem_region_end:
