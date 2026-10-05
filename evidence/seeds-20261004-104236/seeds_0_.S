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
  li x26, 0x0000000a0066e980
  csrw 0x300, x26 # MSTATUS (MPP=1)
  li x16, -0x1
  csrw 0x3b0, x16 # pmpaddr0 = all 1s (NAPOT full coverage)
  li x16, 0x1f
  csrw 0x3a0, x16 # pmpcfg0: entry 0 = NAPOT+RWX
  li x16, 0x0
  csrw 0x3a2, x16 # pmpcfg2 = 0 (disable entries 8-15)
  sfence.vma x0, x0
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
  fsrmi 0
  csrwi fflags, 0
  li x1, 0xe9add81ab5219bf9
  li x2, 0x6613048b1a0740b9
  li x3, 0x64b202f0492f4052
  li x4, 0x5fd7f7b20b0ad5b5
  li x5, 0x962ba9dcbe7cfd89
  li x6, 0x394e7b47795267c7
  li x7, 0x23874cac4e41b153
  li x8, 0xc0efa5a06349f2f4
  li x9, 0x3c96d70ae904eebf
  li x10, 0x8faf4929faf05552
  li x11, 0xdf5ad79a24e204b8
  li x12, 0xca3941a3391c1607
  li x13, 0x0b46cc8004f19fc6
  li x14, 0xae25c38f78c0df7a
  li x15, 0x8cdc31a9ea247fde
  li x16, 0x17831a5066c3e61c
  li x17, 0xbac732fed0f8912a
  li x18, 0x5353850fddc6c88d
  li x19, 0x74eaeb13e8b6a784
  li x20, 0x3c44c1df29a74d33
  li x21, 0xc4d54ee77dc3d0db
  li x22, 0xf6553e2073c8d23f
  li x23, 0x24dc4727d31fdd62
  li x24, 0xaffa2bd0d65c4b72
  li x25, 0xaacdec7db2e5c3a6
  li x26, 0x8bd1094133d2cb53
  li x27, 0xb206188520551549
  li x28, 0xd426c4b45d0d3cb5
  li x29, 0x219e7b48cc003df5
  li x30, 0xb3720d3a7c7cd017
  li x31, 0x6a90cd5c26200ade
  li x5, 0xa4d0c5aab69e7dbc
  fmv.w.x f0, x5
  li x5, 0xa3aeec90217bc3a8
  fmv.w.x f1, x5
  li x5, 0x05c4eb07afc1187b
  fmv.d.x f2, x5
  li x5, 0xad243a1337ebe8f0
  fmv.d.x f3, x5
  li x5, 0xe3ca68148580d69c
  fmv.d.x f4, x5
  li x5, 0x1d61be5b667652d2
  fmv.w.x f5, x5
  li x5, 0x67ec21121f32ad01
  fmv.d.x f6, x5
  li x5, 0xbababa273a56c635
  fmv.d.x f7, x5
  li x5, 0x4e634a657d020771
  fmv.w.x f8, x5
  li x5, 0x2329459a51d91814
  fmv.d.x f9, x5
  li x5, 0x93301c23e5aa813d
  fmv.w.x f10, x5
  li x5, 0xaa0f9746aec53fcd
  fmv.w.x f11, x5
  li x5, 0x463f3cb7c425089f
  fmv.w.x f12, x5
  li x5, 0xcac58420f5380272
  fmv.d.x f13, x5
  li x5, 0x5b66d4e44f6ee96a
  fmv.d.x f14, x5
  li x5, 0xc854f1192487efb5
  fmv.d.x f15, x5
  li x5, 0x99f5e421947923a0
  fmv.d.x f16, x5
  li x5, 0x90cc1866fd94a824
  fmv.d.x f17, x5
  li x5, 0x453bed800a8ed031
  fmv.w.x f18, x5
  li x5, 0xf486062efeb03645
  fmv.w.x f19, x5
  li x5, 0xb98714cec4174fbe
  fmv.w.x f20, x5
  li x5, 0xb30dea20d34cafb6
  fmv.d.x f21, x5
  li x5, 0x69a4459abb3e1b3e
  fmv.w.x f22, x5
  li x5, 0xb4de1d1515b94b47
  fmv.d.x f23, x5
  li x5, 0xff5736e3c1ba85bc
  fmv.w.x f24, x5
  li x5, 0x3465a1587983fdae
  fmv.w.x f25, x5
  li x5, 0xa8ce0d38a5962dd5
  fmv.w.x f26, x5
  li x5, 0x862ef15b98aa2cc0
  fmv.w.x f27, x5
  li x5, 0xfa2484c3f7b756c8
  fmv.d.x f28, x5
  li x5, 0xfcf507f1eeb19dd7
  fmv.w.x f29, x5
  li x5, 0xd3e7594839cfda6d
  fmv.w.x f30, x5
  li x5, 0xb55c0aa0090c27c0
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
  amoor.d.rl tp, s4, (t6)
  remu a4, tp, a4
  xperm8 s8, tp, s11
  csrrsi a2, sideleg, 5
  fdiv.d fa3, fa4, fa6, dyn
  fcvt.d.lu fa5, tp, dyn
  sd a4, -1264(t6)
  slli s10, a4, 0
  rori a6, a4, 0
  rem t3, a2, a2
  sc.d.aq t1, a2, (t6)
  fmadd.d fs3, fs3, fs3, fa3, dyn
  ror tp, s11, t3
  srai a3, t3, 11
  amomax.w.rl s11, a3, (t6)
  xor a4, t3, t3
  xperm8 sp, sp, s11
  rori a6, s11, 63
  rolw zero, s11, a3
  rol s4, s11, sp
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
.word 0x2cb49173, 0xe4132214, 0xc5703b2c, 0x4d820480, 0x238e3615, 0xc98187ed, 0xdf60b56e, 0xcaafbaa1
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0xc5cb06d6, 0xe62f9f45, 0xf3cf3750, 0x0ba26367, 0xe055b0ee, 0xbc937556, 0xa8d0f042, 0x66d5d65a
.word 0x1f160cbd, 0xf48e7fa7, 0x7bd3a546, 0xef4e2d63, 0xb57dacf9, 0x4b5c7356, 0x4b7e399e, 0x0ceb3198
.word 0xdb10d73a, 0xb7d4d3b9, 0x0645ddda, 0xc10a1b32, 0x041b4956, 0x3e0164bf, 0x08f119fb, 0xbaa3b509
.word 0x905722e0, 0x81b74e5b, 0x8390f90b, 0x8dd1715a, 0xeb04f052, 0xf54d20a6, 0xf5dcdf44, 0xa854028f
.word 0xd99fe3ae, 0xb53080f4, 0x013452c1, 0xf32a1f8a, 0xa50e4f69, 0xe2bcc00b, 0xb10f1c8a, 0x07f4eb2f
.word 0xed714758, 0x5d3258fc, 0x6873baca, 0xc35aa50e, 0x7b971986, 0x20c3b4b4, 0xeef9da2f, 0x1809ecaf
.word 0x135e7983, 0x5bb5e6f2, 0xa7db0e4d, 0x36ea01a1, 0x001c6a45, 0x2f66518f, 0xe794383b, 0x4280ea8c
.word 0xe071ff36, 0xd6d2e4a0, 0xd3bea3b4, 0x2e3bacd5, 0x1e9cb976, 0xf922126c, 0x647fa2fe, 0x7dbb26ce
.word 0xdb752201, 0x590c301e, 0x305b7ae6, 0x1d3d87a2, 0x01ba6068, 0xf4e02f72, 0x5b0e1e7f, 0x605e376b
.word 0xb0867ab5, 0xef4b21e8, 0xd8fc410f, 0x9f720ac8, 0x7733eb56, 0x0a0679d0, 0xdb9640fe, 0x6bcf8ac3
.word 0x34fd74b0, 0xf1b3637b, 0x5053563a, 0x1aad18d3, 0x90c2c141, 0x6c0c5b30, 0x12b45a0e, 0xc81984c0
.word 0x4ab6bd93, 0x3ba89d41, 0x63b6fe57, 0xd7be5720, 0xb5211fd1, 0xc8bb34be, 0xb468328d, 0x1fff6a6b
.word 0x9a73fb81, 0xa875851d, 0xaccc9085, 0x7c09cfdd, 0x9d087eb3, 0xd77f0b19, 0x104a3ebf, 0x2add1cbf
.word 0x0b9c84e9, 0xa3f91a00, 0xd9e6e338, 0xfbed529c, 0xa088d649, 0xb628bce0, 0xba69ba3d, 0xd6201f6d
.word 0xd4c2fc53, 0x278c69a9, 0xb07c6dc6, 0x3e1312ba, 0xe541fe12, 0x8691a5b4, 0xa80b9960, 0x0b77f874
.word 0x468527db, 0xa0bc87ff, 0x43b39bd4, 0x8dab9467, 0x8fc7d9e2, 0xe79de559, 0x3820a1fa, 0xd5ae381e
.word 0xdb524f47, 0x03e3d4a3, 0x6eeb8ec0, 0xc0657a81, 0x8a666daf, 0x10176525, 0xf7abfd4f, 0x7bc478db
.word 0x8f3d1742, 0xcde39e63, 0xfe473c51, 0x73b77f93, 0x0d78550e, 0x747c8b51, 0x716fcc6c, 0xfb196995
.word 0x689690b6, 0x9c7ff8a6, 0xd37cc1b1, 0x5d454689, 0x6b81555a, 0x79261788, 0x5af09d18, 0x2353242f
.word 0x35bc2ab9, 0x35e8d02b, 0xb44f14c3, 0xcc58ee9c, 0x502389db, 0xd26c0a91, 0x71050100, 0xd0217ee0
.word 0xf5da7ee5, 0x63fca17e, 0x7207a047, 0x6d7c220a, 0xf6cafe29, 0x5d7516c3, 0xf49ec736, 0x5ba7c946
.word 0x92ebc661, 0x28a4a583, 0x3caa700c, 0x39f2a7ea, 0xb60a49a5, 0x35f4669d, 0xc107c4f8, 0xfcd09155
.word 0x69ee9ba6, 0xf27725fb, 0xed9f7afd, 0xb72590d6, 0x8d8b6dd9, 0x390e9311, 0xc5c3d9e1, 0x5671e034
.word 0x182abf38, 0x396793e7, 0x16bc200d, 0x04d1ddf6, 0xa2d789ea, 0x8046cf8a, 0x5b3dd308, 0x4f9c99c2
.word 0xd985feee, 0x48d0d604, 0xc9acb3db, 0xdbec2d43, 0x1ec9a5d0, 0x27c2efe8, 0xc4dc5b84, 0x07c51555
.word 0x7ca7c91b, 0x07afc0ba, 0x8a32904d, 0x361a15f3, 0xb178cb57, 0x9e58d557, 0xbf8c1a02, 0x7ac9a7f9
.word 0x5b825d23, 0xdb3ed3ad, 0x9a900b86, 0x13190004, 0x3bf46531, 0xfbce0202, 0x7a114d61, 0x2d4f6d35
.word 0x09f599fa, 0x28dd5cf3, 0x902ef8c6, 0x779e7a3b, 0x45c5a7ab, 0x99613df1, 0x64eff880, 0xb94fea8f
.word 0x1b797cea, 0x875f1389, 0xdb66f151, 0x37afb661, 0xe7205c8b, 0x30b2ec39, 0xe0c25ccd, 0xe0110162
.word 0x829f423d, 0x053f3087, 0x99d327ff, 0xb6413f40, 0x5095534c, 0xacaa9fdc, 0xb90c7b03, 0xa723847f
.word 0xdc11e244, 0x3b10c69b, 0xd2493cb4, 0x663bb835, 0xfa553a56, 0xd164cca2, 0x53ce305f, 0xcb72ff7b
.word 0x56ae8227, 0xc215b4b6, 0x9d6c1c52, 0x5d2e2ad1, 0x7e26238f, 0x90fb7b6b, 0x66520f8e, 0x517c84b3
.zero 7168
mem_region_end:
