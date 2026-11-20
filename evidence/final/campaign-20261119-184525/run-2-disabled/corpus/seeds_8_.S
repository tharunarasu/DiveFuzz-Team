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
  li x26, 0x0000000a00542800
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
  li x1, 0xaede780ce811330c
  li x2, 0x0f1bff9894f00023
  li x3, 0x871bbc4ee063a819
  li x4, 0xd6a82989e2b6a674
  li x5, 0x7e2198f30191c69d
  li x6, 0xf0a673cc82a0cc24
  li x7, 0xfdbf06be9a5fed9b
  li x8, 0x7e4b9d31fccd241f
  li x9, 0xec431fdea011f8e5
  li x10, 0x1202306df8e30c99
  li x11, 0x80ce26ef9ef40435
  li x12, 0xeebcb8293b39cc3b
  li x13, 0x6cea7c02b45c69e3
  li x14, 0x1b3d12eebd2d647a
  li x15, 0xecb1b50a52549bed
  li x16, 0x29a2d527d05228d7
  li x17, 0x8ec879b1727801f0
  li x18, 0xc4f09b9990f7b553
  li x19, 0x10335f5d39e0535b
  li x20, 0x0a729359a39ad283
  li x21, 0xae53c851015071e9
  li x22, 0xf672e2073a2de5a1
  li x23, 0x6cc63a118f229250
  li x24, 0x857d36973ba7bad0
  li x25, 0x50039a2767f0ee4d
  li x26, 0xa21a91e9aa858bc2
  li x27, 0xd1d3bcad1d21354d
  li x28, 0xe18856cefbd82c32
  li x29, 0xbcf8f37e66a0f0fa
  li x30, 0x990240db5610653e
  li x31, 0x4e1fd24297c30ef5
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
  add a3, a3, s11
  remw a0, a0, a0
  fence.i
  sll s1, a0, s7
  fence.i
  div gp, s1, s1
  fence.i
  div a1, t0, a1
  fence.i
  divw s5, a1, s5
  srli s4, a0, 46
  addw zero, s4, s4
  srli s3, t2, 0
  fence.i
  fence.i
  sd a1, -1304(t6)
  fence.i
  divuw s7, s0, s5
  auipc s1, 415292
  sllw t3, s1, s1
  sltu sp, zero, t0
  remu gp, sp, s3
  lui s11, 1
  srliw s10, sp, 30
  srai s9, s11, 1
  fence.i
  mulw a1, a1, sp
  srli s8, s8, 0
  divw s5, s11, s3
  divu a3, s9, a4
  div a4, a4, s5
  divw s0, s8, s5
  fence.i
  fence.i
  fence.i
  div t0, a4, s5
  fence.i
  divuw s11, a6, s11
  rem s3, s3, t0
  xor a2, t4, a4
  sll gp, t0, s4
  sraw zero, s11, t0
  sd s3, -1264(t6)
  divw s1, s1, s0
  srai a0, a2, 24
  mulhsu a5, s1, a0
  mulw t2, a5, gp
  remu a6, zero, t2
  fence.i
  remu t2, t2, a0
  mulhsu s3, s3, a6
  sb a6, 1943(t6)
  srliw a7, a0, 7
  lw a1, -1148(t6)
  fence.i
  divu sp, a1, t2
  divu a1, a1, sp
  srli t4, a1, 1
  or a7, s3, t2
  subw s6, s3, tp
  sllw tp, tp, a7
  fence.i
  remw s11, t4, t2
  mulw s1, s11, a7
  divw s2, s1, s11
  remw s10, tp, s6
  divuw a4, s11, s2
  divw s6, a4, a7
  remuw a3, s2, s2
  slli a2, a4, 56
  remw s7, a3, a4
  fence.i
  fence.i
  mulhsu s4, a4, a4
  fence.i
  fence.i
  fence.i
  lui t0, 0
  fence.i
  remu a1, a3, t0
  sraiw tp, s4, 6
  remw a0, a4, a0
  mulw s8, a0, s8
  lhu s3, -1508(t6)
  rem sp, s3, s9
  srli a2, s3, 50
  fence.i
  div a6, a6, a0
  slti s7, s8, 0
  div a5, s3, s3
  rem a4, a2, a4
  srai a6, s6, 0
  or s10, s7, s10
  subw a1, t3, tp
  mulhu zero, a1, s0
  sd zero, 1104(t6)
  slli t2, a4, 0
  divw ra, zero, s10
  lwu sp, -1840(t6)
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
.word 0x4bb762a9, 0x36ace5ad, 0x52b81e71, 0xc6725641, 0xdc26d5fd, 0xba2ebf32, 0xed69b5b8, 0xe037e2b1
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0xc54c01cc, 0x0452072b, 0xb23e0ad3, 0x4af01dde, 0x2dd03b5e, 0x844fb834, 0x503fa5c3, 0x7d5fd646
.word 0xa3affebf, 0x104ec8e9, 0x6a75e8bb, 0x0092e12e, 0xa999b939, 0x83be9096, 0x70f8b892, 0xb6a8cbab
.word 0x4a5855a3, 0x89cfa07d, 0x67bbccf8, 0x593714f1, 0x4bb9a65c, 0xb932af5d, 0xeee24947, 0xec2c02ea
.word 0xd5cba847, 0x67242ca5, 0xae537e0d, 0x70ba8713, 0xb643ae33, 0xe657c6a2, 0xc79ff172, 0x934c6f0a
.word 0x6292fac7, 0x788a2754, 0x06c2ef09, 0xb1574090, 0x3c9ac4c6, 0x8d3cdd51, 0xbe61dcd5, 0xb4757be2
.word 0x166d22ef, 0xdcc5f105, 0x2bc83e0c, 0x11e18360, 0x5f85dd67, 0x89f82b79, 0x6d3a3e16, 0x34f8a92d
.word 0x26133389, 0xfdbe17c9, 0x81ad8a70, 0x9c136368, 0x464ef7ad, 0x9854375f, 0x5c4609ff, 0xa3971533
.word 0x1d80f854, 0x90058608, 0x95edc8bb, 0x3f4875e8, 0x498db2a9, 0x445d9359, 0xb00db883, 0x890ee096
.word 0xef9277a9, 0x354559b3, 0xdce3553e, 0xae6d01fd, 0xd6b1f51e, 0x913530c7, 0x18be98ec, 0x45896166
.word 0x1af87957, 0xa578cfba, 0x0cf25fff, 0x8d9cc067, 0xc1580844, 0xff87d12a, 0xf8a0d3be, 0x86b0a7d8
.word 0xbba3211e, 0xdbaf7a99, 0x8bacafe1, 0x8dfcbc41, 0xa4669735, 0x49c57e7e, 0xdb80d9aa, 0x0c7d3d48
.word 0x90f5bb65, 0xc45bf6e7, 0x2d63423a, 0x559556e6, 0x250c0aca, 0x1337406c, 0xab47f810, 0x86847c24
.word 0x5c492dff, 0x97fb52c2, 0x95e4ce9b, 0x6f9c00e8, 0x04760823, 0xfa120941, 0x5d71d825, 0xdeb9e666
.word 0xf207738e, 0xff4892ac, 0x0560018d, 0x3c06ce79, 0x017dfa13, 0x8aec8fc5, 0x2a753688, 0x447b741c
.word 0x9e842b1e, 0x2420915d, 0xd2a3cfc4, 0x7c8d5e12, 0x030c60d4, 0xb9be4af7, 0x0174a318, 0xc143e926
.word 0xe69a1034, 0xe3604fb4, 0xc9b22ebc, 0x7a70de7c, 0x4d6941ff, 0x7a26dbde, 0x53478182, 0x0c092a3e
.word 0x102548c3, 0x0ed9a8ac, 0x8212382e, 0x4fb034cc, 0x592bbc7d, 0x2c167d14, 0xecbd7f02, 0xddc7ee9f
.word 0x634f69c0, 0x6b0bb85a, 0xb97bb7f2, 0xb83f54c5, 0xfbab5921, 0x5b9ba687, 0x1a0799db, 0xe3386206
.word 0xacefb970, 0x8995e6c7, 0x2afbb75a, 0x7c79fa2e, 0x79c06100, 0x3f146d02, 0x3ffb5d88, 0x03f63a3a
.word 0xeb2d4391, 0xad654dbd, 0x7e8c137e, 0x83cdfcc6, 0x2f69cf50, 0x45532a10, 0x8242d5b2, 0x0451d678
.word 0x4d50ac0a, 0x8424a234, 0xf570824a, 0xaa3b24c6, 0x261e9a3c, 0xb949acd0, 0xcb6d27a4, 0x510c8f9f
.word 0x74e2ec7d, 0x5f1b27b0, 0x75e8a0ad, 0x66f45d80, 0x6b05a27c, 0xae254dac, 0x71e010aa, 0x4ca2b820
.word 0xf0addcec, 0x1f502709, 0xa49ce589, 0x84a1a67c, 0xe642e267, 0x019b7cc4, 0x2ccbd2bb, 0x58758640
.word 0x6d153351, 0x77017172, 0xedc0ce30, 0x20d70ae7, 0x76b1d4f3, 0x57fcaf90, 0xc4c934d5, 0xe798c250
.word 0x2f39675e, 0x53a9b3c1, 0xe3d4e4e8, 0x11a4462e, 0x204e6a30, 0x263584ba, 0x4fe7531b, 0x83eb8790
.word 0x6e11a778, 0x7aa21d8a, 0x9f45062a, 0xfd5dd345, 0xfe0be296, 0x7621335b, 0xb9940eab, 0x9f6f0ab6
.word 0xbf8b4c13, 0x9e9c914d, 0xc8d7fa28, 0x77361573, 0x6fe54545, 0x3d2ea666, 0x8d7930e5, 0x287a68d5
.word 0x6cdc7646, 0x3796ea55, 0xbdf77de1, 0x2d4f90cc, 0x4cb3ee5f, 0x3b3afd27, 0x5bae2988, 0x69c594c3
.word 0x45958877, 0xe2827d3f, 0x579d9d6c, 0x9e990598, 0x2f5d23dc, 0x8ed4ffea, 0xd06f3540, 0x8d981096
.word 0x9f19daf5, 0x8370db73, 0xd42e82b5, 0x1744f6b7, 0x61b9dbca, 0xbd79df18, 0x64fdfe11, 0x4801dd5d
.word 0xedf8c806, 0x4cc7788f, 0x5f998bbc, 0xdb56fb77, 0x9f8aa9c4, 0x20a8955d, 0xd219ca30, 0xcca74a09
.word 0x4dd0ec40, 0x3cc7b361, 0xc6c44f2e, 0x978cac04, 0xe5d74934, 0xdea205fb, 0x16ab714a, 0x1144f2f5
.zero 7168
mem_region_end:
