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
  li x26, 0x0000000a006c7888
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
  li x1, 0xdb808555aee7dbe8
  li x2, 0x7d39ddfa0205b8b4
  li x3, 0x384083d5a436f05a
  li x4, 0x68e96f7a370b1730
  li x5, 0x025879b3a0fd540d
  li x6, 0x353c2960edf61422
  li x7, 0xa73470abb713c8a2
  li x8, 0x7cbf8f479ef677d5
  li x9, 0x699d3a8b27b39f09
  li x10, 0xc1db38540c1db72b
  li x11, 0x67cc0b40ba4b799b
  li x12, 0x8a81e4b45d8f834e
  li x13, 0x019127cb67d27ae0
  li x14, 0x32d0f644ccc6b5a0
  li x15, 0x9b80b169315040d9
  li x16, 0xc2d01a9b50028144
  li x17, 0x6e583c1378f6c5f9
  li x18, 0x148cbac4abe77949
  li x19, 0x4d51bc92e7bcf450
  li x20, 0x5fb8a90f03d35e7b
  li x21, 0x7c299f43b708038f
  li x22, 0x70c293d7001ce910
  li x23, 0xfb9515c3b98e9849
  li x24, 0x554d9f2493f36da9
  li x25, 0x5c84da41086dcc55
  li x26, 0x839736dbe7adb468
  li x27, 0xe3457ae44edf4397
  li x28, 0x18bfa4a0abc6ca5b
  li x29, 0x98cb70568073ae6d
  li x30, 0x6e45c3ec00620101
  li x31, 0xba18fad8dfb648ee
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
  remw t2, t2, t2
  lwu sp, 1096(t6)
  rem t0, sp, t3
  mul a1, a1, s6
  remw s10, a1, s3
  mulhsu s11, sp, a7
  remu s3, s10, s6
  rem tp, s6, s10
  subw s1, a2, s2
  mul gp, s8, s1
  rem a3, s1, a3
  divu s2, s2, s5
  add a2, a4, a2
  sw s5, -720(t6)
  rem a2, ra, ra
  divw t2, a2, a3
  remuw s10, t0, a3
  srai a7, a7, 3
  mul s8, s8, s10
  xori t2, s4, 2030
  srlw s8, s0, s0
  mulw t3, s9, tp
  divu s5, a5, a2
  mulhu gp, gp, a5
  remuw s4, a0, a0
  mulw ra, s5, gp
  mul t1, a2, a0
  mulhu a4, a2, gp
  slli s9, a4, 29
  remw a6, s0, a2
  divw s1, a0, s8
  sraw s11, s1, s11
  mulw ra, s1, a6
  mul a2, s7, a2
  mulw s4, s4, ra
  remw t2, t2, s1
  lui a6, 793117
  subw s5, t2, s4
  remw t1, t2, a3
  mulw s8, t2, s4
  auipc zero, 168371
  div s0, s5, zero
  or a7, a0, s11
  mulhu s6, s3, a7
  divuw a5, a7, s6
  subw s1, s1, t3
  sd t2, -1360(t6)
  divu s11, a7, s7
  srlw s9, t3, s6
  remu sp, s1, s1
  slli ra, ra, 54
  sd s9, 1848(t6)
  div s11, a0, s4
  slliw a5, a0, 1
  remw s2, s11, s5
  subw t0, s5, s2
  div s1, t0, t0
  remu gp, s7, gp
  divu t1, gp, a5
  srliw s0, ra, 28
  sraw s9, s8, s9
  div a6, tp, a0
  divw t0, s10, t0
  and sp, a1, t0
  and s7, t2, a1
  sraw t3, s10, t3
  sh s2, -1788(t6)
  mulhsu sp, a5, a2
  srai s10, t3, 25
  slli s6, a2, 52
  sraw ra, sp, t1
  divw gp, t1, a3
  srli a7, a7, 1
  sw a7, -844(t6)
  remuw a3, a7, a5
  div s1, a7, s6
  div s4, s6, a3
  xor a4, a3, s1
  auipc t0, 527599
  lh s10, -1526(t6)
  remuw a3, s9, t0
  mulw s6, a0, t2
  sraiw s0, a1, 0
  mulhsu sp, sp, s0
  div a7, a6, s0
  and a1, s10, s5
  sllw s3, gp, s5
  mul a4, a0, gp
  remu t2, a4, t2
  sltu s9, s6, zero
  mul tp, t2, t0
  remw s1, s6, a6
  divw s2, a2, s1
  remu sp, s6, tp
  divw t1, t1, a0
  divw s8, s6, a3
  srliw s10, a6, 25
  ori a0, a0, -1991
  slli s7, t1, 0
  sllw a1, a6, s8
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
.word 0x97f3ff22, 0x1250a14f, 0x69e1250b, 0xf55c9095, 0xb2f1ef81, 0xd36a42e7, 0x9e292043, 0x8bc99c62
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x99de3e94, 0xd08681c5, 0x2fc549a3, 0x370c909b, 0xb14c0838, 0xa9a73eae, 0xdb52c230, 0x099f8afe
.word 0x5514fce4, 0x6fc55ecf, 0x4ec7efe7, 0xc8301c1a, 0xcc995f93, 0xa428c3c0, 0x8ae27045, 0x3eecef69
.word 0xda9cdc7e, 0x3ec4efc8, 0xbfbdbe14, 0x56ac6e89, 0xf2cfcbc8, 0x696b53d6, 0x8233aa71, 0xf0b388cb
.word 0x01519974, 0x8bfe41bc, 0x22245862, 0x12f3289b, 0xda0e9c71, 0x4993cff2, 0xf85fb427, 0xbecd72c8
.word 0x2a4ac617, 0x6bbc5db2, 0x4ecc76f7, 0xb4a4adc0, 0x86af29e2, 0x9b6cc5ff, 0xc4409998, 0x3510ece8
.word 0xb5940f37, 0xa8250fc1, 0xeef257db, 0x617bc44f, 0x92025598, 0xe724a367, 0x46783f95, 0x7529c957
.word 0x007cbe5d, 0x18bf9dc8, 0xc4152e6a, 0x12f40053, 0xd185732e, 0x7df6541a, 0x080b6a9a, 0x7bb01c23
.word 0x44600b35, 0xa3bf38e2, 0x683f961c, 0xb41825e5, 0x6a24ce33, 0xd038677e, 0x021d4739, 0x3600a171
.word 0x2ff37360, 0x51acf570, 0xb50c3ffc, 0xeffe1740, 0xdf46e258, 0x7e342f2b, 0x16628c52, 0x64ee7821
.word 0xe0c16cb9, 0x06e37b69, 0xd8a06099, 0x15b6cd38, 0x903a0bfd, 0x223377a2, 0x5ac141eb, 0x7eeb8e96
.word 0x664d1159, 0x294b64bb, 0xca007724, 0x2e8da98a, 0x8daee7d5, 0x43a19e05, 0x2de6ec83, 0x180f28ad
.word 0x1bec0c48, 0x0465c651, 0xe7151403, 0xdd0a02c7, 0x5981ef49, 0xaff39689, 0x807c0dd9, 0xb5afcd3d
.word 0x36bc00ea, 0x54d81adc, 0x6160c358, 0xcdf095f3, 0xc7869911, 0xe990bb89, 0x628bfbe4, 0x3abb51b2
.word 0x320b3c41, 0x5458b225, 0x8622a34c, 0xf69c3657, 0xee5927d2, 0x0b0798e5, 0x0014af9e, 0x328d7726
.word 0xfc095224, 0xb4c83658, 0xffc01513, 0x65c3ba5a, 0x107b4a79, 0x6e8c465b, 0x533ef9e1, 0xf4a4f15e
.word 0xdc5b8021, 0x441b4e58, 0x6aebf7c7, 0xb2e509c9, 0xdf5a863d, 0x42ca50ea, 0x18b732db, 0xa138937f
.word 0x19da4e1d, 0xe5f3b120, 0x3eab7475, 0x23b25af4, 0xdfc43782, 0xdfa27f4f, 0x05f97435, 0xc39f0739
.word 0x63f8a371, 0xf45901cc, 0x5aa12313, 0x6b0d899f, 0x4ec310c6, 0x4947b9cf, 0x85d89985, 0xe434e6ba
.word 0xc52e87ed, 0x632e90f5, 0xe5420df0, 0x668d3aa2, 0x0a44596f, 0x6d888172, 0x6c8eb663, 0xaabdda0c
.word 0x7bbeabbc, 0x47eeac34, 0x6b19ea37, 0xf5f31a06, 0x12ff4f39, 0x26929921, 0x455d6dc2, 0x663504ad
.word 0x8655d8b2, 0xa2b86cba, 0xca724993, 0x6937e424, 0xf272782d, 0x4ea4b068, 0x8da540a6, 0x74208945
.word 0x014989a2, 0x67ca3148, 0x027282d0, 0x602d3006, 0x72cbb001, 0x4cc56089, 0x26237972, 0x67a6c0f5
.word 0xce9a8063, 0x65f060fa, 0xda87540f, 0xd58d7aec, 0x06da27b1, 0xd7456ad0, 0x4d546bc3, 0x75b790ee
.word 0x9196e555, 0x7fa51d84, 0x73ee0565, 0xe8cf64cc, 0xf6a65278, 0x57270b72, 0x99bb3792, 0x4e94be5e
.word 0x2168233a, 0xdacb8aab, 0xf6e77c1b, 0x5a2fc99e, 0x11a63892, 0x7251dfcc, 0x6f2d7773, 0x89063771
.word 0xa80baba5, 0xb072417a, 0x7ab2fc17, 0x1a923377, 0x08055411, 0x8b68aac8, 0x8d75e455, 0x7c80dd11
.word 0x9507fcf6, 0xabcc87ac, 0xf19cbff1, 0xd05c22fd, 0xeaa0c577, 0x3251966d, 0xf7d63837, 0x346a1148
.word 0xe2f66302, 0x36eae162, 0x3066a286, 0x62cac082, 0x15072a86, 0x85cad8d0, 0xdb09fecd, 0x592da2e8
.word 0x67669a06, 0x7f564451, 0x8739573f, 0x2316d0ba, 0xf6298965, 0xa1438756, 0xd9c68c37, 0xfd02cb08
.word 0x0a21e1c4, 0x31e3eeb5, 0x6f654303, 0xf02994d2, 0xcba0d022, 0xb01e3ee1, 0x2487a812, 0x08cf9d88
.word 0x8ca00e24, 0x6fa3c726, 0xdea65c3f, 0xd47b2286, 0x7a5d5536, 0x996feb84, 0x113d15ea, 0xaa3a7bf0
.word 0xde781a99, 0x02fe269f, 0x803a8ced, 0xfb13dda2, 0x1f2e861a, 0x250a5f30, 0x8c6294e8, 0xbd6024a6
.zero 7168
mem_region_end:
