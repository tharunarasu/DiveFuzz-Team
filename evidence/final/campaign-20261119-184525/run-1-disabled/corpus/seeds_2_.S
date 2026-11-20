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
  li x26, 0x0000000a006c688a
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
  li x1, 0x167ff12e80a94841
  li x2, 0x4b8b7548e586f6e1
  li x3, 0x56b09beadf8edab1
  li x4, 0xe6efc1c794d4553f
  li x5, 0xb7a413d48183cf4e
  li x6, 0xe60bb145ab9da908
  li x7, 0x0872808db18a381e
  li x8, 0x3a7ce484a4ba427b
  li x9, 0x89c40189aec7d882
  li x10, 0x0fafb9ae8bee3b27
  li x11, 0x3ab70d7151d4fc15
  li x12, 0x8f501dc9af4282a6
  li x13, 0x003785478d706735
  li x14, 0x645c6c8b23dd741a
  li x15, 0x0805960457c2f186
  li x16, 0x3d95e90a8a6e9b9d
  li x17, 0xe5378b4ab2fbb4a0
  li x18, 0x62fbfdc8c535c306
  li x19, 0x44923d700f89d00c
  li x20, 0xe94f5dbf678391db
  li x21, 0xdb2de32621ac0e9a
  li x22, 0x413ebb04f56229ad
  li x23, 0x6d5b92cb60a4cfbf
  li x24, 0x327b5bd4eb42f48a
  li x25, 0xc3b5129732d8f1bf
  li x26, 0x7447247341a2ac43
  li x27, 0xc5282c62d3721710
  li x28, 0xc126a12732d1a9cf
  li x29, 0x22082932ad5a688e
  li x30, 0x22d668b4db353526
  li x31, 0xbe00c61795151d39
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
  divuw a7, a7, a7
  divu a2, a0, s11
  fence.i
  divuw a0, a2, a2
  rem s9, a7, s9
  fence.i
  divu tp, s9, a0
  addw a0, a2, a7
  srliw s0, tp, 6
  mul s2, a0, s0
  and a3, tp, a5
  nop
  sraiw a6, a0, 13
  mulhu a2, a3, a3
  slli s4, a3, 32
  srai t3, a2, 0
  rem t0, a2, s8
  remu s11, a6, a6
  sra s10, a2, s11
  remw s3, s3, s11
  sltu a6, a5, a6
  lhu a3, -1202(t6)
  ld s8, 80(t6)
  divw s6, ra, s6
  divu s11, s3, s6
  mulhu zero, s6, s8
  sraiw s5, zero, 22
  addw s2, s2, s11
  nop
  mulhsu a2, s5, s2
  fence.i
  remw a6, a2, zero
  srli tp, a2, 0
  fence.i
  srai s5, s2, 21
  fence.i
  divuw t2, s2, a2
  remw a1, t0, a6
  sraiw t4, t4, 0
  fence.i
  mul a4, s5, tp
  sllw s6, t2, a1
  remu t3, a4, t2
  div t0, t4, a4
  slti t0, t4, -1
  lwu a4, 896(t6)
  mulw a0, t3, a4
  divu s4, a0, s6
  fence.i
  remu sp, a4, a0
  fence.i
  fence.i
  fence.i
  fence.i
  sllw s11, a0, a0
  fence.i
  fence.i
  fence.i
  lwu a5, 660(t6)
  fence.i
  ld s8, 1336(t6)
  sltiu a2, s7, -2048
  fence.i
  fence.i
  rem s1, s1, s1
  fence.i
  divw s5, a2, s11
  sllw s0, s1, s5
  fence.i
  addw a1, a1, a4
  mul tp, a2, tp
  mul gp, t0, gp
  fence.i
  fence.i
  remu t4, s10, tp
  rem a3, gp, s0
  mulhu a0, t3, a3
  divw s9, sp, a3
  sd t4, 96(t6)
  mulhu s6, gp, t4
  sw t4, -1216(t6)
  mul s2, s9, s2
  rem t2, a3, t2
  rem s11, t2, s11
  mulhsu zero, a6, s9
  subw s8, s2, s2
  fence.i
  fence.i
  remw s9, t2, s8
  mulhsu t4, s9, zero
  srai s2, zero, 63
  fence.i
  fence.i
  divw a3, s9, s8
  fence.i
  add s7, sp, s7
  mulhsu t3, t3, t4
  fence.i
  fence.i
  lb t0, -951(t6)
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
.word 0x9efff64f, 0xdefc0db5, 0x402b9d70, 0x2e61e90f, 0x06783220, 0xdbb021ff, 0x617d1469, 0x33e7178e
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0xba0e61d4, 0x574dae7f, 0x7271bc86, 0xa32171d9, 0x5d627e94, 0x2628524e, 0x8cae3ae4, 0x82caff4f
.word 0xd8eb025f, 0x6f6f5f56, 0x630bf1b0, 0x18fccb25, 0x32fa6fa3, 0x0f361a6a, 0xb0364e4e, 0x6e359adc
.word 0x2e139e39, 0x80a3793e, 0x45197edd, 0x820a88a2, 0x3d565ede, 0x1066dcde, 0x739078e6, 0x6e838966
.word 0x6ce2a5e0, 0xfa3720ea, 0xa1195227, 0xb55804b0, 0xfb299a3d, 0x52db49ef, 0xbf871026, 0xb1e0a683
.word 0xe3ea0e9a, 0x655e9a3c, 0x9b04ad30, 0x91f8c22e, 0xe53db9b3, 0x209c2cd8, 0x8d280e76, 0x0090f931
.word 0xb94d4f93, 0xb54f1c7b, 0x831d3cfa, 0x760767af, 0x0328bf40, 0x0c7932d1, 0x577d3a40, 0xffe6b666
.word 0xec0c0724, 0xa09c1dc5, 0x282e093e, 0x3c1ff1c9, 0x6250769c, 0x810dac49, 0x6723d710, 0xcdcf1336
.word 0xb5222588, 0x7ab4c579, 0x8935b1cb, 0xb53cb0bc, 0x98cc3209, 0x01ef1fca, 0x350eefa1, 0xccfbb78b
.word 0x72166863, 0x924b8055, 0xa0158b80, 0x5af85423, 0xaf602451, 0x6934064d, 0x6f94d1aa, 0xdfc684f8
.word 0x6aa7c6a7, 0xf1284a9c, 0x2fe27892, 0x4d849ed0, 0x11bdbb04, 0xd412e360, 0x94575079, 0x54994ffc
.word 0xe9278ca6, 0x88d83564, 0x50f20b7b, 0x0ef76740, 0x084dee12, 0x5d3317d1, 0x01b0c4b1, 0x7decbf66
.word 0xe0442f5a, 0x0d803090, 0x1b4640fa, 0xe8802085, 0xd8d2ad4a, 0xc24e718c, 0xc384759d, 0xe7809432
.word 0xe6d8b5df, 0x817f1eae, 0xcafbf72d, 0x2fde24e0, 0x2af4d8eb, 0x60de35aa, 0x9520f05f, 0x11cd9d94
.word 0x4cc99d50, 0x81b6d771, 0x19898e3d, 0x78d5ce18, 0x548b807f, 0x446fffb1, 0x4d0360b7, 0xc746b442
.word 0x09d874f2, 0xadef0b4e, 0x17d0cc60, 0xfb3f5b0d, 0xfb6e6f6b, 0x67ca6290, 0x487e49b5, 0x9be785f5
.word 0x54bea124, 0x25efed33, 0xc9e5a0bf, 0x63a53f39, 0x3601c20e, 0xb69ed7fc, 0x644bf815, 0x4f94b676
.word 0x15f5cf3f, 0xc9898fa1, 0xf85d1a42, 0x8452e37a, 0xf18924a2, 0x2c7ebe71, 0x79ae6c9d, 0x19ba1ac7
.word 0x62780012, 0x0ffef263, 0xf95d4383, 0x9be7358d, 0x53310f24, 0x412e806c, 0x3af1ecd5, 0x545a1fd7
.word 0x0ff4fbf0, 0xe3410675, 0xd1436f64, 0x09182655, 0x3edd8bfe, 0x795f65e5, 0xe9a219c4, 0xad07b82d
.word 0x56c3bf5b, 0x3964e384, 0xb2f9f225, 0xf739c5be, 0xe128b66e, 0xe348805f, 0x28d3879e, 0xa3e0e7cc
.word 0xbb900607, 0x2f14114b, 0xd3f276d5, 0x4cbb55cb, 0x1681d434, 0x3fb0ab89, 0xc8d4131f, 0x3d76014c
.word 0x3cff3200, 0x135f2ba0, 0x5dff351e, 0xdb28be5f, 0x8d6207a6, 0xc237d37a, 0x7a2f4c28, 0x07d09fb4
.word 0x35173196, 0xf3485cf2, 0x075d1e52, 0x8753d2ed, 0x12c76884, 0xe33ef0db, 0x6c25cb01, 0x50f0c82c
.word 0x0f47f7cc, 0xcf0d8577, 0x13c4b8ab, 0x224e3bdf, 0x632b2d2f, 0x2af90cc5, 0x3aeffefa, 0x88afa7c3
.word 0x31252439, 0xb34d432f, 0x542f0529, 0x6578e312, 0x6867c26b, 0xd26e8040, 0xa446bcb5, 0x529c4ae6
.word 0x2e6f825e, 0xf059d89c, 0x211cbf10, 0x6fd48c6a, 0x9f00a66f, 0xd8517fcc, 0x8c015328, 0xb87b2422
.word 0x0a4b1230, 0x2e8aa6d8, 0xdd6507c6, 0x0b436769, 0xa15f835c, 0x671547a3, 0x9deebc24, 0xca006c38
.word 0xb3063eec, 0x74763692, 0xfdd1f74f, 0xaffd7e55, 0x04d1e3f8, 0x3e188d0f, 0x4fd156cd, 0xe99a1b6f
.word 0xa9afa129, 0x5aed4051, 0xe9f1183b, 0x34a485d3, 0x5c3e2f63, 0x12586f1b, 0xaf650801, 0x35cba488
.word 0xce73d1a1, 0x22415a43, 0x1e9db182, 0x2aac2559, 0x264e10a8, 0x005ae6a5, 0xd50354cf, 0x95b95924
.word 0xe7916103, 0xd9a827a1, 0x6206e852, 0x58555db3, 0x6b5f8589, 0xff08f127, 0x73226124, 0xf00af0fe
.word 0x2f8bfe7d, 0xa638847d, 0x86934f61, 0x52ada972, 0x99f1d65c, 0xf2c45d76, 0xfcf45b75, 0x417fc687
.zero 7168
mem_region_end:
