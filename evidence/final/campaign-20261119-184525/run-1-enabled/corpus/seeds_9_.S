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
  li x26, 0x0000000a001c210a
  csrw 0x300, x26 # MSTATUS (MPP=0)
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
  li x1, 0xb1c595c4935751a5
  li x2, 0x64568e24256988da
  li x3, 0x9a06439d7a41298a
  li x4, 0xba5f33e2c5426ef8
  li x5, 0x84c3651b5e4c1de7
  li x6, 0x03adeee9138e1849
  li x7, 0x84b49162870cf5c9
  li x8, 0xbe5f646d8d569a83
  li x9, 0xbf1e80774913351b
  li x10, 0xfe38643eb4fb5931
  li x11, 0x24d868bf25f4ba50
  li x12, 0xfebbe2d9815dd82b
  li x13, 0x2c432ac4e8dc5fc6
  li x14, 0xfbd11934ff9fbe40
  li x15, 0xd59b3a6ec98b8b59
  li x16, 0xe4076c57ffbae66f
  li x17, 0x06830ad2bbf10bb2
  li x18, 0xfc78866030d79e9a
  li x19, 0x1b6b91b26eefe8ac
  li x20, 0xc3d7368eb342e9e9
  li x21, 0xf53ffa67044bf4f6
  li x22, 0xa142c10edba69d0f
  li x23, 0xb3a52ce1ed1f3299
  li x24, 0x10286e23072fe5fe
  li x25, 0x0d23910f8a942573
  li x26, 0xc2ce5ce79ab42edd
  li x27, 0x94de504791a24b74
  li x28, 0x4821834d0d7b7a64
  li x29, 0x3217af15de748862
  li x30, 0xe20b1f043a77dea9
  li x31, 0x3a626774101cb7ee
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
  slli a3, a3, 26
  sra t1, a3, a3
  slli s3, s3, 61
  srai s9, a3, 12
  remu gp, s11, s9
  and a6, s9, s9
  div t1, sp, gp
  mul sp, t1, t1
  mulw s11, sp, s11
  mulw a6, a6, t3
  sd t0, -528(t6)
  divw s1, tp, t1
  srli tp, s5, 54
  div s3, a1, a1
  srlw s2, tp, t1
  sraw s6, s3, tp
  sraiw a0, s10, 26
  sub a1, zero, zero
  sraiw a2, a1, 12
  divu t0, t0, zero
  add t2, t0, s8
  srliw a7, a1, 27
  mul a1, a4, zero
  xori s7, t0, -803
  remw s11, s1, a7
  div a6, a1, s8
  srliw s5, s7, 0
  mul a2, a6, s7
  divuw s4, a2, s4
  remu s7, a6, sp
  sraiw s1, s9, 8
  and s7, a2, s1
  slt a5, t4, a2
  remuw s11, sp, s1
  mulhsu a1, s10, a2
  divu tp, s11, s1
  div gp, s11, a1
  srai zero, t4, 6
  divu a0, s10, a0
  sltu a0, t4, s10
  mulw s9, s9, t4
  mulw t1, a0, s5
  sb a0, 140(t6)
  xor tp, t1, zero
  sraw a5, a0, a0
  auipc t0, 461322
  srli tp, sp, 19
  remw s7, tp, sp
  mulhsu a0, s7, t0
  mulw a7, sp, a2
  subw s2, s8, s2
  mulhsu a4, s9, tp
  remw s9, s7, a4
  rem a3, t2, a3
  addw s5, a3, s8
  xor a6, a3, t2
  divu t4, a3, a2
  mulhu t1, tp, s5
  sllw a0, ra, ra
  auipc a4, 13724
  div sp, a0, s6
  srlw s3, s8, s3
  sh s3, 372(t6)
  sd sp, 1528(t6)
  remw s7, s8, a4
  remuw a6, s1, s4
  remuw t0, a6, t0
  remw s9, s3, s4
  rem a5, a6, t0
  rem t2, tp, t0
  remu s11, s5, s9
  slli ra, ra, 0
  srai t3, sp, 10
  sd ra, -1160(t6)
  divw s1, ra, s5
  remuw t2, a4, s5
  remw s6, s5, s5
  div s0, ra, t2
  divw t4, a4, ra
  lui t1, 1048575
  div sp, s0, tp
  rem s8, t1, tp
  divw zero, t4, t1
  srlw s3, s9, zero
  mulhsu a0, zero, a0
  sub t4, a3, s8
  mulhsu s5, s3, a0
  subw a4, s3, s5
  remuw a1, a1, a6
  auipc s9, 521513
  sltiu s0, t4, 1793
  mulhu s11, s11, s9
  sllw t0, s2, s0
  mulhu t1, t0, s11
  sltiu s4, a0, -1
  divw t4, s2, t0
  rem a4, t0, s2
  sllw a1, a3, a4
  divu sp, a2, a1
  mulw t2, a1, t4
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
.word 0xae1a1c2e, 0x4968cd8e, 0x91a6b372, 0x4c05db99, 0x3cf4c7cf, 0xd496cb86, 0x8774e676, 0xc4b44744
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x343df42d, 0x570e51aa, 0x23de30b6, 0x522d1255, 0xf41034bc, 0xa73a42fd, 0x16c9e362, 0xadf365fe
.word 0x7b08a3fc, 0x79e208f0, 0xf74580e5, 0x61750c3f, 0x0a331f89, 0x5f773656, 0x2df127e9, 0x134376c6
.word 0x9feb4719, 0x382535b4, 0xbaf152e9, 0xa8b4c658, 0xd9bda284, 0x71075341, 0xdf5ba9a9, 0x46ea426f
.word 0x06662a6b, 0x1bd5c2d6, 0x0bd4f750, 0x623adf72, 0x9f23ebab, 0x85786630, 0x1d1b1b92, 0xf967c92c
.word 0xddc50282, 0x5591c12b, 0xf9c8e07f, 0xce927243, 0xd4c3cf6f, 0x35205f5d, 0xe55b55f4, 0x3ff2dfd4
.word 0x0cda9804, 0x198f5c78, 0xf0d4c843, 0xe99961b1, 0x7c41dc42, 0xddce2cf1, 0x7116e609, 0xe2a1d62a
.word 0xe9251f09, 0x5a029893, 0x0937827e, 0x4dc0c8c1, 0xbab8a69b, 0xfe222425, 0x1b6eb838, 0x80b05765
.word 0x00007ac0, 0x2f036bc7, 0xac69ad87, 0xc1773061, 0x1666857e, 0x9e8c1a2d, 0xf5ce6b7b, 0x8676de52
.word 0x8ab0f941, 0x90790e4b, 0xa2eeddec, 0xc704aa12, 0x04ccfe9b, 0xb4f59861, 0x736f25f8, 0x3ca3d74c
.word 0x05c1c3b4, 0x08ef6f3f, 0x3da4fa5b, 0xcef0642b, 0x36802b2f, 0x41b040a5, 0xa21a9fb2, 0x6682b448
.word 0xcafaa44f, 0xcdfac79f, 0xefa19e91, 0xda03acdd, 0x51550a79, 0x9f2aad57, 0x8a46744f, 0x36eb661e
.word 0x443ed6f5, 0x43df570a, 0x7e03ab16, 0x36e2c53a, 0x03a0bb4e, 0x20c100c9, 0x7205e195, 0x0d0f00c7
.word 0xa14418e2, 0x7cb399a9, 0xa116fbb7, 0x3079c9c3, 0x6ee4ef72, 0xbe0aeb9a, 0x2b7cee0a, 0x04e560b2
.word 0x3d32726c, 0xa20f5bec, 0x7a7e5d12, 0x9111d496, 0xe65ba863, 0xcffa6193, 0x22a58fd2, 0xd42bb6df
.word 0x98b65eda, 0x2442aaac, 0x3ed3965d, 0x96525cf2, 0xd1419634, 0x8dc12aef, 0x390e0b9e, 0x17be9e8c
.word 0xf384e2e7, 0xf7e26992, 0x3c784707, 0xe793c317, 0xb3f99093, 0xb2015ac0, 0x84790ab7, 0xb3685d8c
.word 0x6ac32956, 0x5217a21f, 0xe4889d30, 0xe8197f36, 0x95b9f2fe, 0x4e08f529, 0x8e83468a, 0xaccf1db4
.word 0xa42058df, 0x71563483, 0x61b6ea70, 0xc6941eb6, 0x22396ddd, 0x8b9177e2, 0xe39956de, 0x666c7e09
.word 0xba3477a2, 0xbaa43ba5, 0x7d4823a0, 0x783ad987, 0x0351959c, 0x5728db1d, 0xdb205608, 0xae553e38
.word 0x622d9dd7, 0x99154a48, 0xb7d930d0, 0x7afc6505, 0x11d55739, 0xadb74685, 0x8bab00c9, 0xda9a0ac7
.word 0xd3a55758, 0x4425f7b2, 0x1a85f441, 0x52f3689c, 0x0b7a825c, 0xfd62e31c, 0xe40aeea7, 0x5cc820d4
.word 0xcac82f3a, 0xaa45d2ea, 0x60b47c4e, 0x14a5721b, 0x15f9bc38, 0xf0d3cfa7, 0x762587e4, 0xbdc68288
.word 0x68290ded, 0x5a05611a, 0x196b7405, 0x2611afb0, 0x4d77eb13, 0x75bbb7bf, 0x83192ad9, 0xa77bfedf
.word 0x497624ae, 0x74c74a4b, 0xe799abbd, 0x7b951e1b, 0x669ca6d0, 0xa9668e8a, 0xaf187b21, 0xbd325340
.word 0x2d05960e, 0xfa3eaa3d, 0x8484c396, 0xe75db132, 0x4424970a, 0xf6c7e0b6, 0x159b4cc5, 0x7d33b4e2
.word 0x3a156973, 0xa880aae1, 0x2048779d, 0x73076550, 0xc0cf392a, 0x8f222cce, 0x17cfeb2c, 0xce160554
.word 0x71652fcb, 0xb74cc61e, 0x957e6be6, 0xf5d5e45b, 0x7f60a367, 0x5fdc090c, 0x6cad70f6, 0x66f92e4e
.word 0xaf1d9c24, 0xf6b7f0b9, 0x9ab45962, 0x18959313, 0x2927839e, 0x865c652a, 0xdf8ee838, 0xdf0a89c8
.word 0x12f71079, 0x5444f5eb, 0xbf1930b8, 0xbe625002, 0x88471e7b, 0xaf3f8068, 0xed72b88a, 0x13f47a53
.word 0x7e9c851d, 0xeeec3b49, 0x503ac3b7, 0x6a6c10ce, 0x34098e4f, 0xd6cd81bb, 0xc66fad7a, 0xda4fbce7
.word 0x8be83e1e, 0xc6b1fb7e, 0x3f3a7c21, 0xef060de3, 0xfeb11191, 0xa2a6ab54, 0x4e2ba8da, 0xc1c50036
.word 0x9cbf0461, 0x7447cfad, 0x4d0791b8, 0x3050f1f9, 0xac64965a, 0xc5a2ac6a, 0x7faf1515, 0x222d3b38
.zero 7168
mem_region_end:
