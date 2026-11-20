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
  li x26, 0x0000000a00686928
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
  li x1, 0xad6f0b6eda72c7c5
  li x2, 0xf93754e3a61189ff
  li x3, 0x71d63fb796a95c3c
  li x4, 0x78bb5db92d2a7470
  li x5, 0x4215fe5234a413c8
  li x6, 0x17ac83ca072966a1
  li x7, 0x3e44495523f94e57
  li x8, 0x3a1d4701a0024f92
  li x9, 0x429ef9d8a1369234
  li x10, 0x6b949d94a1fc6190
  li x11, 0xc4e4fa776893dd26
  li x12, 0xae348552663ac6e1
  li x13, 0x147a2c905bbd5957
  li x14, 0xc0eeac4f2cbde16f
  li x15, 0xa501c257c4a36ec2
  li x16, 0xb05601d24a2ba282
  li x17, 0x7ace32a70b39d850
  li x18, 0x6233eff2b2be3d33
  li x19, 0x46a609a28b839aab
  li x20, 0xd662fa26984d767e
  li x21, 0xa350e111084a282b
  li x22, 0xf229d6a21a5dfeca
  li x23, 0x830a1ebcfa4de5d7
  li x24, 0x32abd8fe04c724a4
  li x25, 0x1be61f65350d963f
  li x26, 0x8c27bb45d42a19f2
  li x27, 0x3ec7af8da3eaee74
  li x28, 0xa16fc8e7c63a4364
  li x29, 0x562972fa4f1ce845
  li x30, 0x26152aa989cef029
  li x31, 0x2861a887942966d0
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
  srlw s7, s7, s9
  sllw s11, a1, s11
  lwu s4, 24(t6)
  remw a6, a6, a6
  remw a4, s4, s7
  lb a2, -251(t6)
  sraw a5, s1, t2
  sra s3, a5, s4
  mulhsu a0, s2, a6
  fence.i
  remu s11, s11, a5
  remu t4, s11, s3
  sraw s8, a5, a5
  fence.i
  subw s2, s3, a1
  mulhu s7, s7, t4
  lh s9, 682(t6)
  addiw t3, t3, 0
  or a6, s9, s2
  mulhsu tp, s9, tp
  fence.i
  divuw sp, t3, s7
  divu a4, sp, a4
  mulhu s2, a4, a4
  ld t1, 1616(t6)
  fence.i
  remw a7, ra, sp
  xori s11, sp, 1447
  fence.i
  divu s1, a4, s2
  divuw gp, a7, s2
  mulhsu s3, s1, s1
  fence.i
  mulw t2, s11, t4
  fence.i
  rem t3, gp, s11
  mulhu a7, a7, a7
  sw gp, -720(t6)
  fence.i
  rem s4, tp, t3
  srl s10, a7, s3
  ld s11, -840(t6)
  sllw a6, s2, t3
  fence.i
  slt t3, s10, a6
  fence.i
  sraw s11, s2, a6
  lui t4, 916641
  srlw s2, s11, a6
  fence.i
  xori t2, t0, 98
  divuw s4, t3, s11
  remuw a1, t4, s4
  divuw t0, s2, s4
  mulw s11, t2, t2
  mulhsu s7, a1, s4
  sub zero, t0, t0
  ld t1, 1072(t6)
  fence.i
  fence.i
  subw a7, t1, s7
  lbu t3, -43(t6)
  divuw s3, s3, s9
  fence.i
  sraw t2, t2, t4
  srlw a2, t1, a2
  fence.i
  mulhu s11, s11, s11
  mul sp, sp, s3
  fence.i
  addi t4, a2, 435
  mulw a5, t4, a2
  divw a7, s11, a3
  sd t4, -1736(t6)
  mulhsu s4, sp, s4
  rem a4, s4, a4
  mul s8, a7, t4
  divu t2, zero, a7
  fence.i
  divu gp, s8, gp
  remu t0, s9, s4
  mul a3, gp, t2
  slli t3, t2, 57
  mulw s2, gp, t2
  fence.i
  sraiw t3, gp, 16
  fence.i
  remuw s9, s2, s2
  div s7, a3, s2
  lw s5, -428(t6)
  addi a2, t3, -1998
  lwu a1, 1440(t6)
  remw t4, s2, s9
  addw t0, t4, s5
  fence.i
  lw a7, -696(t6)
  remw s9, a1, a1
  rem s11, t0, a7
  remuw s4, s11, s11
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
.word 0x1bd026f7, 0x3532abae, 0x39ad4f60, 0x5b39269f, 0x32c41b77, 0x111bde11, 0x047246f0, 0xd130108e
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x3f877f43, 0xae472905, 0x1ae1ded4, 0xb3df290c, 0x8ead619c, 0xe0eff30c, 0xf0a70099, 0x13a54d44
.word 0x09598f28, 0xcb34349d, 0x5a86b428, 0x31c0ade5, 0x8861f2b7, 0x2aacf417, 0x6993698d, 0xdee732eb
.word 0xe4da49ac, 0xd5409492, 0x19c6b60c, 0xd3e9d7fc, 0xa88aad4d, 0xfc46cd11, 0xffc8b0e6, 0x64d0ccd5
.word 0xb67fd065, 0x0a9a499e, 0xadaf96d4, 0xeb167b3b, 0x6eef61e0, 0x3ad3aa6f, 0x6489ebfa, 0x8e5169ce
.word 0x6771557b, 0x79467bea, 0x23ea05b1, 0x63063283, 0x409f45f1, 0xcee46c06, 0x7721ce8b, 0xfa41f101
.word 0x5adfa2e8, 0x1cc98b88, 0xf6c185f2, 0x5d459a90, 0x5943c34c, 0x093d9176, 0xe664f71c, 0xaeb2e3cf
.word 0xf715dc48, 0x2775c5ac, 0x463423a8, 0x5b8a7ae0, 0x41ea240d, 0x77748e83, 0xc479c91d, 0xe7b80a74
.word 0xeaa28635, 0xf941262f, 0x77fea1d2, 0xe11118bc, 0x751eab53, 0xa359582a, 0x59f8fa42, 0x04aac702
.word 0x784e1627, 0x4e0ba8f0, 0x8f76aed6, 0xb4098614, 0xd420cba9, 0xf772f5b7, 0x9f6a0a76, 0xc59ca38d
.word 0x63b53aa0, 0x16265edf, 0x2bbf0f48, 0x0d4657b6, 0x6a0f45f5, 0x5eefb630, 0x061e59e4, 0xc3456387
.word 0xf1781915, 0xd6049fd7, 0xbc9fe80a, 0x6e6c310b, 0x44366f70, 0x24e14976, 0x855ab1cf, 0x1c257c68
.word 0x2cc9ff7b, 0x5fdf6a7b, 0x26a93708, 0x11b14aa9, 0x707749bd, 0xa8efcdc2, 0x41eff4ad, 0xb971eb09
.word 0x2351b225, 0xe9858f34, 0x35f46681, 0x116ec2ea, 0x49a1b020, 0x4929c23c, 0x54df1fed, 0x377396b0
.word 0x02e31979, 0xe546e0cf, 0x1c342657, 0x8199de2a, 0x509a579b, 0x8f8e9620, 0xbc31ed08, 0x21a9990f
.word 0x4cfb228f, 0x40641336, 0x1aae05fc, 0xad6554b4, 0xb2bf1486, 0x2e5e5123, 0xfb8acce2, 0x09ca8c91
.word 0x3f88c16a, 0x476afd17, 0x5619f0d7, 0x45f64083, 0x45fa10e3, 0x2448ccc1, 0x2df907be, 0xe081e33f
.word 0xb3578a32, 0xa3f5d13c, 0xc773ef3d, 0xebe5dbc0, 0xeefc4553, 0x3d46a2df, 0x732aa733, 0x4ec7cfdd
.word 0x4f0dd50f, 0x1e63a4ab, 0xfde89080, 0x66a32c0c, 0x77856d61, 0x57498ba8, 0xc3f4fb06, 0x0208de21
.word 0xb19d0b05, 0xad08187b, 0x4e6eacf8, 0x586473df, 0xc816b133, 0xf944c5e8, 0xc587b703, 0xc20a3fbc
.word 0x91e4c4eb, 0xfe11d16d, 0x780488bf, 0xb40a06c4, 0x7908fa43, 0x25f2733d, 0xa4e27208, 0x04655dc9
.word 0xf71e3cb1, 0xddb375ee, 0x8c5a0a3e, 0xcc1a735d, 0x1954c633, 0x6f9e1a80, 0x2604c241, 0xde298fbc
.word 0xce163999, 0xd2ab2ba4, 0x88919783, 0x449307af, 0x58b5cd50, 0xf8afca6d, 0x4f6c7ca5, 0xd40d4f48
.word 0x0fbc0d14, 0x508aa343, 0x8e31b644, 0x18401e10, 0xab230964, 0x9980960d, 0x51eb33af, 0x747d86a9
.word 0xeb7114be, 0xba45e8a5, 0x1eb752e9, 0x4d63d496, 0x6a2ca73a, 0x5ebd9b9b, 0x49894045, 0xc3183c31
.word 0x2b621f10, 0x35952822, 0x682fa6c8, 0x7c1dcb17, 0x101617b6, 0x23ceed54, 0xd3a3fc03, 0x868ba10d
.word 0x9ce12dab, 0xb16a5977, 0xfa1faf24, 0xc7985514, 0x5626f45a, 0x87b5f080, 0x122038b1, 0x94402840
.word 0x8bfb353e, 0xf5a39255, 0x68e0bd04, 0x35f3048a, 0xa20fa1a4, 0xdcc73770, 0x6fb0bb24, 0x35bf9c49
.word 0xf2ccccc6, 0x39e9da63, 0x0c0d6ed8, 0xedb1a429, 0x58944bd8, 0x4d700dfd, 0xf0b67aa8, 0x0b6200c6
.word 0xba0e9b3e, 0x64326eff, 0x3672d7cb, 0x472de706, 0x5b95964a, 0xdd488858, 0x0193f86b, 0xbe294438
.word 0x39bfba0e, 0xe6d92cea, 0x86d233ee, 0x7063ad34, 0xbbb0a40e, 0x8dfa3040, 0x51ebb890, 0x92e12210
.word 0xe6f3c143, 0xe38a6044, 0xb2a32e9d, 0x0047e61f, 0x6e4326e4, 0x1de88bbf, 0x442bd3ac, 0x5f4dbdda
.word 0xe0d33f6d, 0xebf9d7bc, 0x346386a1, 0x8d0bd80b, 0x5d43ecdf, 0xf62b7d36, 0x785e5c28, 0x0b7b74ab
.zero 7168
mem_region_end:
