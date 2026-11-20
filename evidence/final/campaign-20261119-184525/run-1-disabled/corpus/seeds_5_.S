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
  li x26, 0x0000000a00483908
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
  li x1, 0x120984629605b44f
  li x2, 0xdf5c946567e4d652
  li x3, 0x4eb832d5079a2474
  li x4, 0x45da2336009bfc3b
  li x5, 0xfbdd5d0b0cabb195
  li x6, 0xbd0edb5a4c744670
  li x7, 0xc4e24fb0fd64b9e5
  li x8, 0xbc1a6364c2f86294
  li x9, 0x0a44a6b9025406c9
  li x10, 0xc884ca504301e34d
  li x11, 0xfd290bac49e39b97
  li x12, 0xfc9f1fb2ef9ace3e
  li x13, 0x1770aa4edd5b1c98
  li x14, 0x9df2695e17f0d4a8
  li x15, 0xe715f6fb62c16234
  li x16, 0xcc6d2ab9020b9c8b
  li x17, 0x60ac3dbd7338b17b
  li x18, 0x5ad658367d3a73af
  li x19, 0x67488f8753050dde
  li x20, 0x865feb121b41b952
  li x21, 0x6923afc9c6c07a70
  li x22, 0xa3c1d33ae1ea4da0
  li x23, 0xa515eb2990e15629
  li x24, 0xb7fd03cf2f748dca
  li x25, 0x75eefafeb12a1d57
  li x26, 0xf27e888ef7036ae1
  li x27, 0x8c5020f04167ae4c
  li x28, 0x85703afe98a0bd9e
  li x29, 0xff5aa8666d446284
  li x30, 0xd5b0730f1922b747
  li x31, 0x978f825530e73ec6
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
  divuw gp, gp, gp
  sllw t1, s5, t1
  remu a3, zero, gp
  lw s9, 1916(t6)
  and s7, s9, s5
  slti s2, a3, -1308
  divu t4, a3, t4
  lb sp, -1279(t6)
  sra a4, s7, s9
  divuw a6, s7, sp
  fence.i
  subw tp, a4, t4
  mulw s7, a4, tp
  mulhsu t3, a6, a6
  remu t0, s6, t0
  sllw s10, t0, a6
  sllw s2, t0, s2
  ld t1, 544(t6)
  remuw zero, s2, t0
  fence.i
  rem s7, t1, zero
  sltiu a6, s10, 2047
  slli s11, s11, 9
  divu a2, s7, t1
  xor a1, a6, s11
  lhu s5, 994(t6)
  div t0, s11, s11
  divw s7, a6, s5
  sll s3, sp, s7
  fence.i
  fence.i
  slli a5, s7, 1
  sraiw s10, a3, 29
  fence.i
  fence.i
  mulhsu zero, t0, a5
  fence.i
  divu a2, s7, s3
  remuw s4, s4, s5
  add s0, s4, a2
  fence.i
  divw s3, s4, a2
  remuw a0, a2, s4
  mulhu a5, s0, s0
  fence.i
  fence.i
  fence.i
  lhu s2, -1510(t6)
  srliw gp, s3, 18
  sllw tp, a5, a6
  mulw t3, a5, s2
  divuw sp, s2, zero
  ori a7, a7, -291
  nop
  remw s5, s3, gp
  fence.i
  lwu s6, 248(t6)
  remu s1, s5, s1
  fence.i
  remuw s3, s5, s6
  sltu a4, a4, s5
  sllw tp, s6, s6
  remw tp, a7, s1
  mulhsu a2, s3, a2
  sltu a1, a1, s1
  fence.i
  fence.i
  slti t2, tp, 2047
  sllw s9, a4, t1
  sraiw s5, a2, 21
  ori s3, tp, -80
  fence.i
  fence.i
  srl s1, t2, s3
  divuw s8, s5, s8
  div a1, a1, s1
  fence.i
  srlw a5, s1, a1
  fence.i
  sll a3, a5, s8
  mulw s4, a3, a1
  mulhsu s9, a5, a5
  remw sp, s4, s4
  addiw s1, s1, 1164
  fence.i
  sh s6, -1036(t6)
  sllw s3, a3, s1
  remuw s7, s4, ra
  rem a4, s1, s1
  mulhsu t4, s7, t4
  slliw tp, t4, 27
  sllw s9, s9, s7
  divu t2, a4, t2
  fence.i
  fence.i
  fence.i
  fence.i
  divu a1, t4, a4
  sw a4, 1624(t6)
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
.word 0x10a4528c, 0x8732e003, 0xe6eca7ae, 0xfea59cb1, 0xcf635e77, 0x61779952, 0x33f2d2dd, 0x2a4d8edb
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x211be5b8, 0x5c3aff27, 0xfda89085, 0x14b33852, 0xb26c4455, 0xd6ead107, 0xd5b5a94e, 0xf61ec4d5
.word 0x01d48c5f, 0x15f475bd, 0x80c3a8b1, 0x0ff306dc, 0x823f8acf, 0x7bac4fde, 0xedb8aa4a, 0xc0b10538
.word 0x55a27bbf, 0x90b94b0e, 0x5e04ea83, 0x24a11772, 0x3de9d688, 0xe71a3fe3, 0x08c4a0a8, 0x644a4d1a
.word 0x145f9a3e, 0x0b720af2, 0x7cb47b37, 0x7520e096, 0xe52ea210, 0x71b5daf6, 0xd06e3527, 0x1444dbb8
.word 0x50f8fa58, 0x60b144d0, 0x0cd59125, 0x3fac3680, 0xd7906e04, 0x506bc6d2, 0xfc5b7764, 0x6851f6cf
.word 0x77531887, 0x2c14e12f, 0x005aac40, 0x63618c60, 0x760485bf, 0xc25d53a1, 0x9b580561, 0x38ea6e8a
.word 0xeb2dc93b, 0x9037519f, 0x9f758964, 0x105904ba, 0x9f5d5c4f, 0x7dd56e1e, 0x1a1a3e47, 0xa63ace72
.word 0xd8a0c677, 0x5bf6ed0e, 0x7641e693, 0x02dc7ffa, 0x3644d223, 0x45fa0d16, 0xf6ac5a7c, 0x891a2158
.word 0x95c25513, 0xa1548de7, 0x7f2c44ab, 0x2155a517, 0x4da4c61d, 0x428d099a, 0x2a234f0f, 0x15c59068
.word 0x87861091, 0xbe48ee56, 0x1ed23d61, 0x2ea8bdea, 0x645acde8, 0xf2ef5280, 0xc38fb1ef, 0xde07e035
.word 0x10e4773c, 0x474395be, 0xf4e7ffcd, 0xc7901c4f, 0x01b41eda, 0x0d6c26c7, 0xfbbff9df, 0x8616758f
.word 0xef757dca, 0xc480c6cc, 0x61e20294, 0x88c56496, 0xa5ddea26, 0x24bebdf7, 0x2dd3e7ad, 0xb574c3dd
.word 0x8b14a1b4, 0xa2056cfa, 0x5a3d6e68, 0x4183542c, 0x148e5d7e, 0x246b6962, 0x7b5ea978, 0xd8a9e672
.word 0x5fb80b1f, 0x07a9b352, 0x88ff2546, 0xbec2bca8, 0x078a6957, 0x2ed5d4d6, 0x672baaeb, 0xcadde53a
.word 0x06cc8ef3, 0xc0ba7739, 0x504f6066, 0x40bd6482, 0x61684fb1, 0x5b374e91, 0x6b7a98c1, 0x310eb3e5
.word 0x3a3ab682, 0xa32fc02d, 0x01406912, 0xccb2aa6d, 0xf418935f, 0x76974eae, 0x03822080, 0xf51e5f73
.word 0xa59f1b3b, 0xd5431efb, 0xabd51fb1, 0xd698cf99, 0x499cbb52, 0x2c50385a, 0x0f104752, 0xee7acd99
.word 0x78ac4213, 0x701fdaf0, 0x6440baea, 0x22272fe9, 0x42579dbf, 0xc533c2fa, 0x3b22fa3f, 0x7a337349
.word 0x5238dfea, 0xbca7393c, 0x0d167de4, 0xe0786b7f, 0xb082ab75, 0x7f7bc93f, 0x16ee830b, 0x193eedf2
.word 0x30be9cf7, 0x49e1da38, 0xd62e1128, 0x314fa740, 0x2bc43fbd, 0xf0af8a56, 0x727d1685, 0x2b54c7b2
.word 0xf2631a48, 0xd1246f14, 0xdde248aa, 0xd281baf2, 0x0b5fb93f, 0xa00a7448, 0x92402957, 0x66a74ae9
.word 0x545e4c79, 0x09c89604, 0x40364f44, 0x5ddf5a0b, 0x4ee0f400, 0x34af3838, 0x8ff00fe4, 0x15487e7e
.word 0x37e39303, 0xa3098033, 0x532ab37a, 0x314ad374, 0x4ae5487c, 0x751f4e6b, 0x723cb117, 0x30eb1ea2
.word 0x62513f7c, 0x763e5ca7, 0x8be0b459, 0xed0ddaf4, 0xaef10078, 0x873ced70, 0x89d29084, 0x83a11fc0
.word 0xb82fdcf0, 0xde462e04, 0xdd64a26b, 0x16eba5a6, 0xa4a5e48e, 0x6e4ce0e5, 0x58752432, 0xab604734
.word 0x23773d94, 0x8bd52302, 0xf6e3dae3, 0x76ec93a0, 0xda53fb2a, 0x7e5adad1, 0x8d86886e, 0x0e45867c
.word 0x7c2f4c27, 0xb2530c39, 0x109ead87, 0xb79e4186, 0x638d6d5d, 0x090fde86, 0xa7d193ce, 0xcc2292b9
.word 0x713b1427, 0x6297e22a, 0xf51bf529, 0x858b3a85, 0xa30422ed, 0xb4854728, 0x4ea8325e, 0xe5508576
.word 0xfbbb0706, 0x24b08511, 0x448e0808, 0x6907a7d6, 0x8123f844, 0x83f20e39, 0x6865c871, 0x7680e9af
.word 0xb7ba1b4f, 0xdaf2bc74, 0x5cfd8f86, 0x6b82f13c, 0xc2e3341c, 0x2712eb26, 0x26998a35, 0x4c18d170
.word 0xc8f78560, 0x4d3540dd, 0xb663a0cb, 0x32b4af0d, 0x8211fc17, 0x106c4225, 0xe280cec4, 0x08db2f38
.word 0x7787ac0d, 0xd84d0446, 0xf7d4f6a1, 0xd63d7a9c, 0x94126ba6, 0x73907617, 0x2047057d, 0xf2cd3010
.zero 7168
mem_region_end:
