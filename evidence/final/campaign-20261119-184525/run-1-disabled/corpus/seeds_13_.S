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
  li x26, 0x0000000a001478aa
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
  li x1, 0x7835f76a965666a6
  li x2, 0x016164341a45527e
  li x3, 0x371d0adfdc64a5d0
  li x4, 0x904e832ec08bb012
  li x5, 0x25e5bf65b96f18de
  li x6, 0x84c1a4383f8f4239
  li x7, 0x24722eabe2e03095
  li x8, 0x8f1020705e8c913f
  li x9, 0x868aac5454c3cd50
  li x10, 0x8bcf3da7c6c71077
  li x11, 0x2f9e118a3edb74c3
  li x12, 0x3eba740deba22ee4
  li x13, 0xc2257f5d0e04ac3a
  li x14, 0x7653d66247156859
  li x15, 0x7d33d906a2e62e09
  li x16, 0x825b03415b266e32
  li x17, 0x16614beb6c2abfb9
  li x18, 0x555130ee08b57950
  li x19, 0xe0515bb7f96d43a3
  li x20, 0x8b85fd6ccd1e4c74
  li x21, 0x9744896fde3b2729
  li x22, 0xefc55e012d17b905
  li x23, 0x3a3ab81495df9f94
  li x24, 0xba81b89d75267659
  li x25, 0xc43800cf1c50cb0e
  li x26, 0x88ccfaf93482feb6
  li x27, 0x387b201a85189ead
  li x28, 0xdfe1280f105c0bf3
  li x29, 0xb8d53fa311c22f44
  li x30, 0xfd05bd8cb93954c1
  li x31, 0x7a0a90d3bf473856
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
  divw s8, s8, s8
  lwu gp, -612(t6)
  fence.i
  fence.i
  addw t0, t0, gp
  srlw s7, s11, s8
  fence.i
  remuw t3, gp, s7
  sd t0, -752(t6)
  divw s7, s7, t3
  fence.i
  srai tp, a7, 0
  remuw gp, tp, t3
  mul a0, s2, tp
  subw s1, zero, gp
  remuw a6, s10, s6
  addiw t0, a6, -715
  lbu t2, -859(t6)
  fence.i
  rem s7, s1, s1
  ld t4, 1856(t6)
  lwu s11, 544(t6)
  mulw s3, t4, s3
  add s5, s11, t2
  slliw s1, t4, 1
  srli a7, a7, 63
  remw sp, s1, a7
  slti a3, s10, -1989
  fence.i
  sraw a0, a3, a3
  mulw t2, s1, sp
  srlw a4, a7, a0
  slliw s10, s2, 1
  addi a6, a6, 645
  div s5, a0, a0
  slli s1, s5, 1
  srai ra, s10, 0
  addiw tp, tp, 1040
  fence.i
  remu s9, s6, a5
  fence.i
  sd tp, -1632(t6)
  sra s8, s1, t3
  slli a0, s9, 0
  remw s4, s9, a6
  mulw a0, a5, s8
  sw ra, 552(t6)
  srliw gp, a1, 31
  lhu a7, -1756(t6)
  remuw sp, sp, s4
  sra s2, t0, a7
  div ra, gp, a7
  remu s1, a5, s2
  fence.i
  divu s9, ra, a7
  add s11, ra, s9
  sraw a5, t3, s1
  sllw t1, s9, ra
  remu a6, a6, s1
  divw s2, a7, s2
  mulhsu a4, a4, a4
  fence.i
  divu s5, s5, s2
  and a7, a4, a6
  mulw sp, a4, a6
  remw s10, sp, a7
  remw t3, s10, s10
  lwu t4, 844(t6)
  ld t1, -1288(t6)
  div a3, t1, t1
  fence.i
  lui s4, 0
  remw s7, t1, s7
  fence.i
  srai a7, s4, 55
  remuw s3, a7, s3
  sb s4, 1406(t6)
  sh a7, 74(t6)
  andi a4, a7, -722
  remuw a0, s7, a5
  srai s6, s4, 29
  sd a4, -872(t6)
  add a3, t3, a7
  subw s9, s9, a4
  fence.i
  sraw t2, a3, a4
  fence.i
  sub a1, a3, s6
  mulhsu a2, a1, a2
  ld s11, -136(t6)
  fence.i
  fence.i
  nop
  remu a3, a3, s9
  fence.i
  fence.i
  lb a6, -382(t6)
  sw t2, -948(t6)
  sraw a7, a6, a7
  divuw s4, a6, a3
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
.word 0xdd8a6757, 0xd6b68407, 0xe20c5efe, 0x646d9613, 0x1f6ab12d, 0x7d025d51, 0x36cf08dd, 0xd170fd40
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0xee0059ee, 0x0cd45cba, 0x97e66331, 0xc69f086f, 0x71a805a5, 0xcc0f8581, 0xad78955e, 0xeaec9a39
.word 0xd1ad83cb, 0xc2756815, 0xfd1ff692, 0x3704a5c5, 0xa0d68f64, 0x9cc086e4, 0xaa7b9e27, 0xe2a882f1
.word 0x05951a48, 0xe97ae577, 0xb9dfea01, 0xfec40522, 0x49e15c9d, 0xf91f875e, 0x12db1f5c, 0x65632633
.word 0x97705134, 0x2613ea27, 0x5bcda7bf, 0x0f2fba23, 0xa57de59f, 0x2187f4cf, 0x180d5f04, 0xc4de7385
.word 0x71275862, 0x08407f63, 0x8bf4308c, 0x4460b2fd, 0x02418826, 0xbf132dbe, 0x5770a7dd, 0xd7a059ff
.word 0x8e439c85, 0x041ffed9, 0x2c702c81, 0xbfffd95d, 0x86eaf76c, 0x5ad6081d, 0xa6ce76de, 0xe0f39fd6
.word 0x0fcc5622, 0xbf96a98e, 0x2af6ba70, 0xc73f1569, 0x9003297a, 0xe54cecfc, 0x6b7c5f5c, 0x3404c689
.word 0xba993408, 0x58e192ee, 0x3d16380e, 0x1f8c4931, 0x040f6dfc, 0xa61830ae, 0x9559c693, 0x1f208f59
.word 0x0a893e3e, 0x4b2e78be, 0xc4f61079, 0xc4b825b9, 0x1fbd2942, 0xb2d43de2, 0x7be5bf38, 0xfb15b300
.word 0x6b854d1e, 0x7beaefd2, 0x22ae4fb0, 0x0f61a0f5, 0x216c60b4, 0x69ffcc2e, 0x2052c26e, 0x4a6e88a0
.word 0x3e6e4d91, 0x6c8bb9ef, 0x60ba6ed3, 0x18ec30dd, 0x308d2ce5, 0x7af1e654, 0x31c92cdd, 0x9538231d
.word 0xb7b280de, 0xfc38f090, 0xa4713e35, 0x3d81700e, 0x62f3cd49, 0x8e23e68b, 0xb4880ecc, 0xe3dd72b8
.word 0x33c4731e, 0x6e7f1742, 0x3e0c0388, 0x4ac91c4e, 0x2d7815f0, 0xf02b96a9, 0xc5340372, 0x53b565c0
.word 0xb2063e71, 0x3699b679, 0x43e57979, 0x045cf872, 0xb3fee5bd, 0xeb11a204, 0x61736e32, 0x66028c1b
.word 0xf4231c5a, 0x0d1290ce, 0x7a985710, 0xe20ed12d, 0x98879568, 0xfa9b25ed, 0x1fbe72bc, 0xe312e932
.word 0x8c36e79a, 0x7dc5dca8, 0x3af84c91, 0x4d8dbdec, 0xf79c93b3, 0x8918ec9e, 0xf899c44f, 0x9976eb2f
.word 0xef3de664, 0x7f64a5b1, 0x26eea27b, 0x03ac369c, 0x270e3fc5, 0x53b85b74, 0xa7d471aa, 0x3e5c9bc0
.word 0x01462cbf, 0xffe343ed, 0xcd1f4ca9, 0x63e453fe, 0x66ee928e, 0x03540719, 0xddee7da8, 0x13950f82
.word 0xdfbe1d17, 0xcb93bd7f, 0xb8528193, 0xc075bd01, 0xd7477ed2, 0x7ccde878, 0xe97a9c78, 0xb1823897
.word 0xb015bdeb, 0xf1927771, 0xcacb4062, 0x06a69bc3, 0x8e8aa2ac, 0x4214a3b7, 0x5001860e, 0x9bcfed8f
.word 0xd73af243, 0x9c2df112, 0xf68aea1e, 0xc3be99b7, 0xa375f455, 0x2c5bbc02, 0xc05f44e7, 0xd8b601b1
.word 0x27666f96, 0x1036ad9a, 0x69c4a645, 0x33e0ccc8, 0x6db46383, 0x2f12e80e, 0xad60d65e, 0x2dbe898f
.word 0x497b3dee, 0x438e4ea2, 0x0a1ed007, 0xeb3dc672, 0x4a2eeb4c, 0x81aa4233, 0x1c132a5f, 0xf92fec12
.word 0x87687b0c, 0xd579dc24, 0x92492578, 0xc9b8a1bd, 0xfe9a8873, 0x359da818, 0xd37951de, 0x64e2b5e9
.word 0x26cd0061, 0xf295614c, 0xa83dbbd7, 0x1c19aeb2, 0xe9b4ed6d, 0x561dc569, 0x3c1c0e74, 0x09e71890
.word 0xfdb25719, 0xb518da7f, 0x519bd755, 0x6a5ece16, 0xec218b66, 0x7d0f7327, 0xe28cb3c1, 0xdf1f8c06
.word 0xd4d99fcb, 0x3a5789c6, 0x2933eb6f, 0x46e51e45, 0x889ca354, 0x5e73cdbc, 0x6ee232a6, 0x4660fe7c
.word 0x5c760e62, 0xbb642d99, 0x0b7b1f17, 0x6ec51e2d, 0x7c2f06e7, 0x809b7f0b, 0xf730fdb4, 0x6ed39e1e
.word 0x0c5b92b6, 0x9cb5d8a9, 0xec25b9b5, 0x3c06c9ad, 0xa3b3166b, 0x1989154e, 0x6bfbf2e6, 0x5b33ed8c
.word 0x4c56d6e4, 0x12d3797d, 0x72857df4, 0x60e74272, 0xa3e5b959, 0xe24e60e8, 0x1b7c4c70, 0x9c9ce4de
.word 0x69dedb6c, 0xb00c118b, 0xa2b12e49, 0xd54791ec, 0x7126e039, 0x60d1da89, 0x90ce5b2a, 0x8fc7e3cc
.word 0xcb79356d, 0x9daee3da, 0xeadbcff6, 0x89416da3, 0x385c3e5f, 0xfe9e67f7, 0x76519a49, 0x12581a66
.zero 7168
mem_region_end:
