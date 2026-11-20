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
  li x26, 0x0000000a00480982
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
  li x1, 0x01b5bca76a5b23a3
  li x2, 0x74105f946644dc1c
  li x3, 0x1adb88b3eb8d2653
  li x4, 0x9c5bc4ac7a21b60a
  li x5, 0x394a8108e4328461
  li x6, 0x63ce12b6f4f5b47c
  li x7, 0xb87a3dce7be8ff22
  li x8, 0xd2f4c3415c4eb1fd
  li x9, 0x355550742a8c785e
  li x10, 0x63a41b199cfcd902
  li x11, 0xd0d62394e25a3db6
  li x12, 0xe8d9f6458f6b402b
  li x13, 0x7b54dc20204a3579
  li x14, 0xd323d86ba34ba2d3
  li x15, 0x4933c5b18af68e6a
  li x16, 0x1ba66ddf39be83fb
  li x17, 0x2d413811ba869e9c
  li x18, 0x007dbdd8ff7cd0ff
  li x19, 0xe2aed827d845afab
  li x20, 0x45477c33f40a422d
  li x21, 0xb78ac01de6acf79b
  li x22, 0x12f9b1cce8ebcbad
  li x23, 0x0cf2519d82d40b48
  li x24, 0xcd5448a039b9d24e
  li x25, 0x2c9e49de80d92215
  li x26, 0xc6ceee235d92fa42
  li x27, 0x380c0723331c562b
  li x28, 0xc1d4bd6aee629158
  li x29, 0x0fcdf761e662f9de
  li x30, 0x2fb0c58cc3e0faf5
  li x31, 0xa6acea72c91455b9
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
  div a2, a2, t2
  divuw s3, a2, s3
  rem ra, ra, a2
  slli s4, s7, 51
  remu s0, s4, s8
  remw s5, t3, s6
  remu a4, a4, a2
  srli s11, s10, 0
  divw a7, a7, a7
  remu t3, s9, t3
  div s8, s10, s11
  rem s9, s10, s1
  srlw a7, s1, s9
  sw s1, -1944(t6)
  sll t2, s8, s6
  mulhu a6, s11, s9
  div t3, a7, a7
  sltu s2, t4, a4
  mulhu a3, s2, a3
  divuw a2, s2, gp
  andi t1, a3, 1116
  srlw s3, s11, s3
  mul a1, zero, s3
  div a5, t4, s5
  remw t0, t4, a1
  mulw a7, a5, t4
  divu a3, gp, t4
  addw s6, a4, a7
  divw a5, a5, a3
  sw s2, 1176(t6)
  remw t1, s6, a7
  ori s0, s0, -641
  subw zero, a2, s6
  remuw s10, a5, a6
  rem s9, t1, s10
  or s3, zero, s3
  and a3, s9, a6
  divw a7, s9, a1
  or gp, a1, s4
  srliw s11, a3, 0
  mulw s9, a5, a3
  srli tp, s11, 0
  subw s2, tp, gp
  addi s7, gp, -22
  srlw t1, s7, s7
  sub s4, s9, s2
  divw tp, t1, s9
  srl s2, s2, s6
  slliw t2, s7, 28
  mulhu a3, t2, t2
  mulhsu a2, a3, a2
  or gp, s4, a2
  srlw zero, a2, gp
  mulhsu t4, gp, a2
  mulw s2, gp, gp
  divu a3, a0, t0
  remw ra, ra, t4
  mulhu s9, s2, a3
  srlw t1, a2, t1
  sraw t0, t0, s9
  remu s7, t4, ra
  srlw s4, t0, s5
  rem zero, t1, a6
  divuw zero, s6, s7
  addi s3, s10, -1226
  sraw a5, s10, a5
  slti a3, a3, -1
  addw t2, t1, t2
  remuw s2, t2, s5
  or a4, a2, a5
  sd a4, -1480(t6)
  slliw a2, a5, 1
  remw s4, s4, s4
  sllw s0, s7, a4
  sd a2, 1720(t6)
  divuw zero, a2, s7
  sd sp, 1240(t6)
  srli s10, a5, 0
  remu a0, zero, a0
  div s5, sp, zero
  divu s6, a1, s1
  sh a4, 1890(t6)
  div t1, t1, s2
  remu s1, s1, s5
  divuw gp, s2, s11
  srlw t2, t2, zero
  srlw tp, a4, gp
  remw s8, t1, t2
  auipc a1, 317128
  mulhsu s11, s11, s11
  div t0, zero, a1
  and s9, s9, t2
  auipc t4, 1048575
  rem t3, t3, a5
  rem a4, t0, a4
  mulhu s4, s9, t4
  mulhu tp, sp, t3
  auipc s11, 1
  li gp, -76085211684
  remuw t4, t4, t0
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
.word 0x80d97bf8, 0xeb16c369, 0xde8d1157, 0xd84b3fbe, 0x9b8fe720, 0x3c89349d, 0x860fa22e, 0x82e2f66d
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0xe0fd6fd7, 0xda29f184, 0x8bb40a06, 0xfb120006, 0xabf45d8d, 0xd7f8a07d, 0x55d81bde, 0x8ad65844
.word 0x83dad666, 0x89f514cb, 0x67bd9598, 0xa426ae14, 0x183eff89, 0x5b33dd0e, 0xca4911d7, 0xa845e491
.word 0x9f5b5c9c, 0x87c11450, 0x2711f45f, 0x5cc60bc1, 0xcb6e26e5, 0x0d46b1f1, 0xb40eb034, 0x2ed19728
.word 0x0732a88e, 0x31990ea5, 0xb6b61025, 0x3fa3d829, 0xe8c59ab6, 0x2536a957, 0x3a76fdd2, 0x0c40fa04
.word 0xb2f5ccac, 0x1ed70b6b, 0xd7c21189, 0xc44c1fa7, 0x08badc03, 0x429d0aab, 0xe75e33e8, 0x44dc6298
.word 0x8b271a91, 0x84e5cba3, 0xc3cfe8a3, 0x568aa99f, 0x9ebf4eb2, 0xd7420725, 0xba9f65df, 0xc3ac806e
.word 0xb557eceb, 0x0245de90, 0xf6479a9b, 0xa8e79508, 0x8332f3da, 0x668a4f21, 0x12e15c17, 0x19c74773
.word 0x941f24e1, 0x62d224d5, 0xa43331fd, 0x49980956, 0xa84dbe7b, 0x508d584b, 0x64bf2702, 0x56fec91d
.word 0x20337921, 0xbffd5cea, 0x4865a100, 0x7d810ddc, 0x28dfa6c7, 0xd27bf2e7, 0x4d114084, 0x3052e7a1
.word 0x97e9557b, 0x2c5b2b3e, 0xbd88959c, 0x80c1bdd9, 0xf994c3f2, 0x4a168e22, 0xb2ed9129, 0x715cf001
.word 0xf9ee5e69, 0xa6b79435, 0x39263a4e, 0xe352b32b, 0xe862e7f2, 0xa32280c3, 0x67f1999e, 0x0ddb1b94
.word 0x73255975, 0x28e38eb7, 0x2b519021, 0xfec31476, 0x5ab26e5a, 0x5cedeb62, 0xfe4bf9ef, 0x225ef93e
.word 0xe1c9e29a, 0x54205cf5, 0x26d4e88f, 0xa1ad3177, 0x7912d09b, 0x2f9125a0, 0xfed49797, 0xb0460aec
.word 0xb476e0e1, 0x2b404bc1, 0x93f8f276, 0xb638c2d8, 0x6e43ca25, 0xb7252ad6, 0x7a90176c, 0xf504e03e
.word 0x7252d5d0, 0x4e529784, 0x53e17dd0, 0xf79920df, 0x5b0e99bf, 0xb7554f6d, 0xac4b2a4e, 0xfb1b71bd
.word 0x6acba14a, 0x928e90c3, 0xd338940e, 0x34a6f013, 0xa7df7f6e, 0x5386dab7, 0x02af3a7f, 0x03851736
.word 0xbbe0416a, 0x2fe4a25a, 0x19c1bc7f, 0x1a99f9ab, 0xd95b75b4, 0xad94ed8c, 0xda25baa4, 0xf795d936
.word 0x8f12bd57, 0xe96ec6c8, 0x4ddc2007, 0xb99a5f25, 0x550ce967, 0xc32a1bf6, 0xae620cc4, 0x15aa5832
.word 0xcbe20082, 0x153a6b8a, 0xe13c6845, 0xfa79d46b, 0xb1f27b6e, 0x83f52973, 0xeffa3b11, 0xd2cd2d4f
.word 0xbf1aa4fb, 0x256a6e4f, 0x950cdc57, 0x40a39c0c, 0xf919d0f0, 0x4436c342, 0x6dc4775f, 0x7e05fe30
.word 0xbe35a724, 0x3fe48270, 0x8725501a, 0x8e58d37e, 0x4e3e3aac, 0x5d991e42, 0xf560a91b, 0xd7503824
.word 0x42d07778, 0x7faf31be, 0x2e75c018, 0xa3c012e2, 0x0dc7ad0e, 0x8763e691, 0x422508c2, 0x0308fcc3
.word 0xe23425e3, 0xae502c6c, 0x40df5643, 0xf0df6b5c, 0xea7c672f, 0x21038ab8, 0x7f44d43e, 0x0d960e2d
.word 0xca261de7, 0x08f9970a, 0xf6e574ea, 0x26252c4d, 0x28c7d363, 0x333e1978, 0x09c6a744, 0x42aff632
.word 0x70d91821, 0xdacc54d7, 0x17fa71d6, 0xad0cba59, 0x8df19755, 0xe8497bfa, 0xa1082cd6, 0x8c917c38
.word 0x4126f996, 0x006694cc, 0x063b82ee, 0x031c669e, 0xc1b5557e, 0xca1c6c9a, 0x7f7b0edf, 0x37def3b9
.word 0x6bcc54fc, 0xcab0b546, 0xaa108c0d, 0x51f72692, 0x2b39256f, 0xc099eaf5, 0x0563cc50, 0x60cb4988
.word 0x1be78c86, 0x966719a7, 0x2eeccd1f, 0x037f93f4, 0x8eff70f3, 0xcf359325, 0x5f5cdb7e, 0x614e2e30
.word 0x9702c72f, 0x5b7a5e7a, 0x80883588, 0xea2e01c0, 0xf19902c3, 0x34bc304d, 0x0df242fc, 0x4de67ce0
.word 0x39020380, 0xbea0f829, 0x89105829, 0x94783db1, 0x8a32faf7, 0xbcc9ed6a, 0x7bbf637e, 0x9ea91b00
.word 0xb4ecfa38, 0x3e5a3855, 0x43f979a0, 0x3e7d89e2, 0x6d0b4571, 0x62251a50, 0xff3b9b87, 0x0df6abc8
.word 0x71e24671, 0x2f786c03, 0xc7c35cad, 0xe599eed8, 0xff876140, 0x8b8912db, 0xc2ef378e, 0x403f858a
.zero 7168
mem_region_end:
