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
  li x26, 0x0000000a00101828
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
  li x1, 0x6fb0360508bcb7f1
  li x2, 0x30428c31d4dc97ec
  li x3, 0xeccd642b3dc7152f
  li x4, 0xe6b755cfb513cd79
  li x5, 0x1eff774c12257820
  li x6, 0xeadad3e5ab300991
  li x7, 0xa233d9dade63b374
  li x8, 0xe4429ea70eda4894
  li x9, 0xf1584e7f46939815
  li x10, 0xa5bdc638b095aa73
  li x11, 0x4b5de9a86d0ce8e8
  li x12, 0x3a5449c04a31e161
  li x13, 0x06d79382a2436dd5
  li x14, 0x9224b1b4553359ec
  li x15, 0x1768376352d6ef83
  li x16, 0xf90eb7863e38b404
  li x17, 0x0c94586402e76938
  li x18, 0xd0f9656e97555d41
  li x19, 0x1f118b117188569f
  li x20, 0x64baf0af74d64e2f
  li x21, 0xc2e1b26148a5473f
  li x22, 0x445807ff6c4c61dc
  li x23, 0x0846b8fdda5e3f05
  li x24, 0x454a0126605a7be1
  li x25, 0xdedcf724f6c3d269
  li x26, 0xe188373dea0db4e5
  li x27, 0x2f20fe4e699f4abb
  li x28, 0x33999eaaf5a1ed04
  li x29, 0x8438ca6a04f4ea67
  li x30, 0x7edff46ee872b25c
  li x31, 0x9b942cae747ff897
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
  divu a3, a3, zero
  remw s9, a5, t0
  divu s10, a7, a5
  slli s4, s10, 56
  div a2, a5, a2
  divu s6, s9, s4
  sd s6, -1808(t6)
  sllw s7, s6, s10
  mulhu gp, gp, a1
  srlw a5, a5, a2
  add sp, sp, a5
  sll a7, t1, gp
  slliw t0, gp, 16
  remu s9, t1, a7
  mul a2, t0, sp
  sltu s4, a2, a2
  mul a7, s10, s5
  remw t0, a4, a4
  divw a5, s9, s6
  sllw s5, a0, a7
  remw a5, s8, s8
  mulhsu s6, t3, t3
  mul gp, a4, gp
  mul tp, t3, a1
  divu t4, s6, t0
  divu a7, s5, t4
  mulhu t2, tp, t2
  mulw sp, gp, gp
  andi t1, a7, 0
  divuw s3, s3, t2
  div gp, sp, t2
  remu a6, a0, a6
  divu s6, a5, a6
  divu s4, a3, a0
  mulw a5, a1, t1
  rem s6, t3, tp
  srli a3, s4, 38
  remw s10, s6, s6
  mulw sp, s6, s7
  sraw t3, sp, a1
  mulhsu t0, s10, t3
  sltiu s2, gp, 0
  remu a3, s1, t0
  sd t3, -952(t6)
  rem a6, a6, s2
  srlw s7, t3, a3
  add s10, s2, s7
  divu a7, a3, s10
  sraiw s6, a6, 26
  srai t0, a7, 12
  rem ra, ra, s10
  mulhu sp, ra, s6
  remuw tp, s3, s6
  divw a7, s4, a7
  sra t1, s11, s2
  remw a5, a0, a0
  mulhsu t3, t0, a5
  divu s8, s8, t0
  sllw s10, a5, s9
  remw s2, s8, s2
  mulhsu s4, a6, s4
  divuw sp, s5, a7
  remuw s9, s1, a7
  div s11, s9, a7
  mul a2, s9, zero
  divuw gp, a2, s9
  mulhsu t3, t0, s0
  remw a1, a1, s0
  sllw tp, t3, a2
  mul s7, gp, tp
  mul s6, t3, t3
  mulhu s3, s7, tp
  div a4, s0, s6
  remuw zero, tp, s3
  divu s4, s3, s9
  subw t4, s9, s9
  remu sp, s1, ra
  sb t4, -154(t6)
  mulw sp, t3, sp
  remuw s2, a4, s2
  remw t1, t1, a5
  srli t3, t3, 1
  rem tp, t1, s5
  mulhu s11, zero, t3
  srai t0, zero, 63
  divuw t2, t0, t2
  sraw a1, tp, t2
  slli s7, s3, 1
  srli s9, tp, 2
  lui zero, 151887
  or s4, a5, ra
  mulw sp, s9, t2
  sub t3, s7, s4
  li a4, 549755813887
  remw s1, t3, t3
  remw ra, a4, t3
  sra a0, a0, a0
  addw s8, a4, s8
  remuw s6, a0, zero
  remuw s1, a0, s6
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
.word 0xc8e30f48, 0xe66e2385, 0x2f64d390, 0xc8bb436e, 0xf23e92d4, 0x7b09d188, 0x325b5d4c, 0x1d61ff46
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x3cacf0c9, 0x11fb8cd6, 0x5d1b01c5, 0x51994791, 0x5ff8492c, 0x01ded335, 0x2c603499, 0x854265fb
.word 0x24e900ad, 0xa006584a, 0xfc706e56, 0x40246adc, 0xb47b6da4, 0x9dad17b3, 0xee59458c, 0x6318606b
.word 0xf70402c4, 0x37d88986, 0xe2c23d4e, 0xdf9d7484, 0x8fe40a90, 0x49874d71, 0xdde12a7d, 0x18ad4002
.word 0xd0fdac86, 0xc1403345, 0xcc92d0fa, 0xaf677b0d, 0x435a9c9c, 0x0d19be8a, 0x3930b030, 0x2dca6fa2
.word 0x51c2befe, 0x9bf7e8f8, 0xa47fb212, 0x3ff59d77, 0xf5ae39b4, 0x5e40b2a4, 0xcaa6ff14, 0x0f0b6214
.word 0x8940507f, 0x1f635712, 0x77719128, 0x758bae7f, 0xc90aa672, 0x66a329fb, 0x501f7cde, 0x770d64a4
.word 0xe369fc2f, 0x3694e655, 0x95872f3c, 0x9fee1f29, 0x12381163, 0x49064fc9, 0xf0ab3833, 0xa284eb6a
.word 0x971ea0e0, 0xd4fd2e6b, 0x31aaf795, 0xd6ec3bbc, 0xf5d03ace, 0x05057c13, 0xda473878, 0x8a99175b
.word 0x7e35cf16, 0x4599ea9e, 0xf9081cc4, 0x72bb61db, 0xdba11151, 0x4386566b, 0xf902d5b2, 0x55bf9777
.word 0xbfc9d3c4, 0x847bfdec, 0x78704498, 0xafc4e326, 0x2f1496bc, 0x201dbb1f, 0x48dadaa9, 0x05d16621
.word 0xc75da0fc, 0xbb1bb0be, 0xf4f3043e, 0x3b1c428d, 0xc7c4a83d, 0x4f5baf05, 0x18fd3a24, 0xb2d37ad6
.word 0xdc485337, 0xb83c16d0, 0xe6577030, 0x70dbaa33, 0x79a46c52, 0x7dbca713, 0x428a5707, 0x0dc2f02f
.word 0x667f23d1, 0x6476545e, 0x4a55d195, 0xacc6a88e, 0x6cd65b08, 0xbb537c84, 0x2391cacf, 0x2e059755
.word 0xc001556b, 0xb0e34b8f, 0x9a06ecf5, 0x2105f252, 0x68b2005e, 0x1580362b, 0xdb03d708, 0x7cb44346
.word 0x26c56cd0, 0xe44a46b2, 0x1ec5a6a4, 0x8de4eab8, 0x1adfaee6, 0x05169239, 0xa7743907, 0x9b990461
.word 0x959f06c1, 0x90e8dcc1, 0x88f55c1d, 0x8045b889, 0x7ba851a8, 0xde01547f, 0x83ee8ebe, 0x330caa24
.word 0x940d2474, 0x7fbcdcf1, 0x48ed1940, 0x619d694c, 0xb8953218, 0xeb0b0916, 0x7c0296f1, 0x2005baed
.word 0x4523a4e1, 0x3dce467a, 0xf3cb6f6e, 0x57565869, 0x0ddcbaa8, 0x2a4f456e, 0x11e7b5e8, 0xfc4f9f5a
.word 0x4115aec4, 0x86777bb9, 0xdfd07f01, 0x0392de9d, 0xf03cd126, 0x3df4619e, 0xbedc0bb0, 0x1db672e7
.word 0x91942087, 0x37140e2d, 0x553a7a9e, 0x30e83a8b, 0x4cfb436e, 0xb859d0f8, 0x754ddf2e, 0x0a581944
.word 0x02c60dd7, 0x34404aad, 0x911ecb3e, 0x0f21c774, 0xb5732a1f, 0xf0d95409, 0xf5bcec24, 0x5c7f94db
.word 0x9ccd56c5, 0x20d2d4df, 0x759b1558, 0x0e93f453, 0x4d490e27, 0xc9d4d8b6, 0x6ffeb542, 0xd4d5b7a2
.word 0x825904d4, 0xc471c31f, 0xbda39159, 0xe9b09570, 0xf11d15e8, 0x50b79895, 0x158f6d26, 0x332d078b
.word 0x1141ab8b, 0x4d5a7466, 0xf0acfcc9, 0x1dc2f60e, 0xc6e3139d, 0x2ea767a6, 0xc7fe1fb9, 0x705f7519
.word 0x56c4bf36, 0x0ada1dec, 0x4b2e52c7, 0x73d0c8c4, 0x2a777d4d, 0xf1c6272f, 0xedb9d292, 0x4d8c9338
.word 0xcc599a3a, 0x559063c6, 0x0f6e7ce8, 0x43d62568, 0x4147ace2, 0xe9a025fd, 0x67bbf3bc, 0x873940ea
.word 0x01c48c9f, 0xc7fb3402, 0xdc4b0b69, 0x2b8bbb99, 0x19f54d42, 0xf98f5fc9, 0xeb17e910, 0xd268b99d
.word 0x66f6fcc1, 0xbea5db59, 0xcc82f2c8, 0xa6a33c5d, 0x04753ff8, 0xec87ddde, 0x1137c441, 0x3243e6fd
.word 0x7b2b454a, 0xbd82787b, 0xfab23151, 0x835aa5fa, 0xd1aed99a, 0x1f62c8f9, 0x55661823, 0x06f6798c
.word 0xb4595564, 0x581ae260, 0xa624150a, 0xb2405744, 0x100440e2, 0x9c666ac0, 0x86ad55fc, 0x345fda28
.word 0x5ed336c4, 0x09e13e5c, 0x9598a121, 0xcc44d1fa, 0x7f322f2e, 0x64797f6c, 0x5a3ba7c8, 0xe4ad83de
.word 0x3b742439, 0x65ec4a07, 0x5792eb47, 0x9cbb4d25, 0xf726e4c8, 0xb2bce9d2, 0xeff1c3e0, 0x04c52b03
.zero 7168
mem_region_end:
