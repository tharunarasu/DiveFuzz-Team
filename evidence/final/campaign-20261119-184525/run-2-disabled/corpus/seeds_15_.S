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
  li x26, 0x0000000a00680920
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
  li x1, 0x35fb09c15261f798
  li x2, 0x35533f5359d3bbc6
  li x3, 0x2b24ab903d30cfba
  li x4, 0x73f433947efc1dcd
  li x5, 0xb5f90c31ecadf3ee
  li x6, 0x14fbdaf55095aada
  li x7, 0xa0f9a1c0baf692a0
  li x8, 0x3e3084678fd2f856
  li x9, 0x9bbde910446f1ad3
  li x10, 0xdc514557f9f09259
  li x11, 0xc5e86924d39b3e7f
  li x12, 0x08a80726a8e0ef2e
  li x13, 0x9170cb1a4c6d6aa9
  li x14, 0x329331dfe15cddbf
  li x15, 0x5147e0546d156733
  li x16, 0xa02be60004218bf6
  li x17, 0x129cf724606129b2
  li x18, 0xc3ac417e4d253a32
  li x19, 0x18cea33673110f9f
  li x20, 0x87a90eee2c23f1fe
  li x21, 0x081070bd95752a29
  li x22, 0x954cca37610ab2e4
  li x23, 0xdd02a91433561bc8
  li x24, 0x59e6b869f24541f8
  li x25, 0xabc3fb9bca0e5392
  li x26, 0x5b6dc8353b4c5e60
  li x27, 0x63fafabb0f2e40bf
  li x28, 0x86ef5caef686c9ea
  li x29, 0x411bcf5f0fce4ff3
  li x30, 0xb5fea9657cffabd2
  li x31, 0x5cdd9b5bb55e81f3
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
  mulw sp, sp, a2
  add s7, s7, s7
  remuw zero, s7, sp
  remw s6, s6, sp
  and t1, s6, s6
  fence.i
  remuw t2, sp, s7
  mulw s1, zero, t1
  fence.i
  lwu s0, -1364(t6)
  rem t0, a5, s1
  div a4, t2, t0
  fence.i
  lb ra, -516(t6)
  srl t1, t0, s1
  addiw s2, a4, 1081
  lwu sp, -648(t6)
  sraiw a2, sp, 7
  slli t2, s8, 31
  mulw s4, s4, s2
  mul s10, s10, s4
  fence.i
  remuw t2, sp, t2
  slliw zero, s4, 16
  and a0, s10, a0
  remw a4, a4, s10
  sra a2, zero, a0
  addw s11, a2, a2
  subw sp, s11, t2
  srliw s3, a2, 31
  divuw t4, sp, s3
  slti a3, t4, 1821
  fence.i
  lh t2, -1634(t6)
  fence.i
  sraiw s0, t4, 31
  fence.i
  mul a2, s3, t4
  fence.i
  divuw a6, a3, t2
  remw ra, s0, ra
  mulhsu s5, ra, a6
  lui gp, 569708
  slli s9, gp, 53
  mulw a1, a1, s9
  lhu a5, -1142(t6)
  sltu t4, gp, a2
  mulhsu s5, t4, t4
  fence.i
  remw zero, gp, a1
  lhu a2, -620(t6)
  fence.i
  divu s8, t2, s5
  lhu s4, 1008(t6)
  nop
  mulw a4, s4, a4
  mulhu a3, s4, a3
  add gp, a4, s6
  nop
  fence.i
  lhu s6, 318(t6)
  and a6, s11, s6
  ori t4, t4, 1675
  fence.i
  fence.i
  mul t1, a7, a3
  rem s10, t1, s2
  srliw s4, t4, 1
  fence.i
  srlw zero, s4, a6
  fence.i
  subw s9, a2, s10
  mulhsu gp, s10, s10
  fence.i
  slli s1, s10, 0
  srlw a7, zero, s7
  srlw a4, a4, zero
  remuw t0, s1, t1
  fence.i
  srai a6, gp, 1
  mulhu a6, s8, a4
  sb s1, -2037(t6)
  mul s9, a4, a6
  add a5, a6, s9
  remuw t2, t0, s9
  fence.i
  lui t1, 1048575
  rem gp, gp, t1
  ori s10, t2, 1
  addiw s2, s2, -1501
  divuw s2, t1, s10
  fence.i
  mulhsu s7, gp, a4
  sraw t0, s2, a4
  mulw s11, s7, s10
  auipc s4, 1048575
  divu a4, s4, s4
  divw s9, s11, s7
  sllw a6, s11, s4
  divw s1, a4, a6
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
.word 0xaeb88e76, 0xc570bda3, 0x5fd59a92, 0x2eeacc03, 0xa18a674b, 0x4ce14a41, 0xb315a41d, 0x0fd71521
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x9e880f4c, 0xbabb7115, 0xfbae5066, 0x9105e4b6, 0x0a3aefe6, 0x962cb467, 0xebddd6ef, 0xbd25b452
.word 0xdc628848, 0xd267fcaa, 0xb04be744, 0xaface6ad, 0x7c3ad9c9, 0x8bfbd5d3, 0x25ca76b7, 0x426130da
.word 0x38886e29, 0x8e6805bf, 0x7e654ab5, 0x852245e8, 0x9857bc73, 0x0f3d4da3, 0xe794bd24, 0x11bbf8de
.word 0x013e182c, 0x9603b276, 0x320e32fe, 0x4845cb0f, 0x7ff586ed, 0x92ffd449, 0x89956c2b, 0xf28af8ed
.word 0x32e115d2, 0xe4dbe662, 0x083cd07f, 0x5ad38e0b, 0x80517264, 0x9f9dd542, 0xaebb77d1, 0x5ffad8c8
.word 0x57ff3bf9, 0xd5d685d9, 0x19b413ce, 0xa0b3f2cf, 0x01c7543f, 0xd31d14d7, 0xf1bdcfd7, 0xfac21311
.word 0x5b007ed0, 0x6203f616, 0xd1cedda3, 0x1e4acbb5, 0x20d8d1a1, 0xa2c492df, 0x4714e31e, 0x25a8de96
.word 0x242dedf2, 0x9e031449, 0x9d839557, 0xf7d7b13e, 0xfa53df5b, 0xf475155c, 0x6772e303, 0x1a7c06b0
.word 0x365c29a5, 0x1879dfb8, 0xa960e305, 0xa0d409cd, 0xfc3df4ff, 0x82d4fb25, 0x05fb3ba4, 0x5a6b1aae
.word 0xa34a2bbf, 0x49023234, 0xfa901aef, 0x76995fc1, 0xc6f08db0, 0xf22a0267, 0xc35d2fc5, 0x278c4c57
.word 0xc31d5783, 0xf54bdfdb, 0x29391775, 0xd7596821, 0x01499452, 0xb1bca8e6, 0x798180d0, 0xc2eececd
.word 0xab611383, 0x2bc60b13, 0x252eb5b7, 0x8e9c0b02, 0x2c000c35, 0xc6cd22c0, 0x6f39bcb8, 0x351ab9f6
.word 0x9dec67e1, 0x912fc6a8, 0x408eab65, 0x0245ec00, 0x534edaca, 0x6a8e3ed7, 0xdcb7cb30, 0x29a3ba5a
.word 0xf8c6d78f, 0x703757db, 0xbcc0cf4d, 0xbbfe5f27, 0xc2db82dc, 0x79e275dc, 0x51257ce3, 0xa8a8729f
.word 0xf185fe11, 0xdec7526a, 0x2295752d, 0xc8cdceb0, 0xdc0d8ed6, 0x2b83c215, 0x7d18e14a, 0xbf49a13a
.word 0xfdb07b26, 0xb8e1c887, 0xdf18f3dc, 0x6970db99, 0x97bc1fbc, 0x3da56dac, 0x40a95aec, 0x079b64ec
.word 0x2978bc2c, 0x58a52bfa, 0x9668d96f, 0xef0cfd64, 0x78db0565, 0x7662c27e, 0xe83fa1d3, 0x1c8ab226
.word 0x1b98d98c, 0x85ae3c7e, 0x7d84bc05, 0xc3c778bd, 0x76636590, 0xe0b1615f, 0x4f7b8726, 0xbc60586a
.word 0x7990d51a, 0x030e43a1, 0x406bf5e5, 0xa667efc0, 0x5bc7fd77, 0x17c79dfd, 0x9fbcc1ce, 0x95459c67
.word 0x38787f48, 0x87a720e4, 0xc7aca58a, 0x4f5792de, 0x3e6791ca, 0x5fdf7b46, 0x617c665c, 0xae6d9f3d
.word 0xf85c66af, 0xc9736730, 0x10f3b8a2, 0x042b5728, 0x3a35cb94, 0xa1ca8bb0, 0x6033b2d8, 0xa059a6ad
.word 0x298409df, 0xe6a8e8e7, 0x680ba6fb, 0xdfd1a5ac, 0xb8bf4d17, 0xaa93abeb, 0x8477d519, 0xff1c84ee
.word 0x7bc55f1e, 0x5bf19414, 0x17016221, 0x852d0b84, 0x12740dd6, 0xde0086b3, 0xe87216a9, 0xa1636e68
.word 0x7044afbc, 0x66574803, 0x10cf3894, 0x60797e24, 0xf8d7c6f6, 0x3e3f2916, 0x90cfbc7d, 0x3aae476a
.word 0x3f97a391, 0xc1eeff7f, 0xde159a05, 0xee594805, 0x591b77d1, 0xa793afb6, 0x2a291fd5, 0x4fa02728
.word 0x978b545b, 0x764ad404, 0xfcb2055e, 0x081f549f, 0x634be920, 0x31a4456a, 0xa081beed, 0x627b013f
.word 0xe6b80e7f, 0x32c916d9, 0x4846fbfa, 0x3f6cfc0f, 0x454353c9, 0x00a1e0e3, 0xe4616cb0, 0x7a44f9f4
.word 0x8c6ce121, 0xa6e22913, 0x08b9b2db, 0x73d9eb7d, 0x0279e008, 0x8d062d43, 0x5012deb3, 0x94cf736c
.word 0x9e97cd78, 0xe18a5c47, 0xaba52ad4, 0xe2643771, 0x6c5b9b23, 0x7fb47db9, 0x97e1ab95, 0xa322758e
.word 0x24c8d17a, 0xaec059f7, 0x0acd63d2, 0x6dd93348, 0x3402d0fd, 0x652dde63, 0x627b23f8, 0x2430cf76
.word 0x20d0d2ea, 0x724ca035, 0x0ac60ebd, 0x7842b259, 0x692c75dd, 0x32a70b76, 0x8c305b8e, 0x6e32dd2a
.word 0x3d837b93, 0x4f1660e2, 0xd1ec7c78, 0xe94ae639, 0xa2e5a601, 0x75b8aaae, 0x8cccfef8, 0x996ff9b5
.zero 7168
mem_region_end:
