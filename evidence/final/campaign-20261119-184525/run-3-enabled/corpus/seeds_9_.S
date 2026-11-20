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
  li x26, 0x0000000a00646980
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
  li x1, 0x7be271171355a2ae
  li x2, 0x40784a926588eb1f
  li x3, 0x9b99ce1a7c54b92b
  li x4, 0xd81892ab8c5ae250
  li x5, 0x245b9879284338cf
  li x6, 0xc90154506df0a478
  li x7, 0x0796c711f4621b27
  li x8, 0x9c504ef20b689277
  li x9, 0xc1f76b45a6d179c9
  li x10, 0x39616aa603df9f2e
  li x11, 0xb319f268ab6dd756
  li x12, 0x95eef5e5229ef1b2
  li x13, 0x2ba01e8d6361e66d
  li x14, 0x8257fea2a9897f8f
  li x15, 0x97945bf46f85e1b8
  li x16, 0xec49bd79b8ca47b3
  li x17, 0x4f8d83f71d93f6dd
  li x18, 0x3376446954c47b76
  li x19, 0xaf5962a71e0760d8
  li x20, 0x557e328674a4e83d
  li x21, 0xfec966ed46e86d2b
  li x22, 0x1212985fb9e62e69
  li x23, 0x9f52bbbec4e4d08b
  li x24, 0xf72cd33a68a18f2d
  li x25, 0x78875e317030b50e
  li x26, 0xcbb1362791114a85
  li x27, 0x941161faff6a4571
  li x28, 0xf3ca1654736e7cef
  li x29, 0x3ccebe188d349d4d
  li x30, 0x83488b8b3b1fe66b
  li x31, 0x85e6a7982c784d3e
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
  subw s1, s1, s1
  srlw s6, s6, s1
  remw a4, a4, a1
  mulhu gp, gp, s6
  sltu t1, a4, gp
  divuw zero, zero, tp
  xor t2, tp, t1
  divuw a3, a7, gp
  sra a1, zero, tp
  sll s9, tp, s4
  mulhsu s0, s9, s0
  sra gp, s5, a3
  addi s1, s4, 1
  slli t3, s10, 1
  remuw s11, s10, s11
  sraiw s6, s11, 29
  mulw s7, a5, s10
  sb s6, 1409(t6)
  mulhu s4, t0, s10
  srai tp, s10, 0
  divuw s10, s7, s11
  divuw s3, t3, s0
  addw s4, t0, s9
  rem ra, s7, ra
  rem s10, s10, s10
  add s3, s8, s8
  mulhsu s2, s2, s8
  sllw a4, s2, a4
  srlw s1, s8, a4
  sw s8, 484(t6)
  remw s4, t3, s4
  srai t2, a3, 28
  remw s1, s8, t1
  slt s7, s4, s8
  sd s4, -416(t6)
  mul a6, a6, s1
  mul t4, s5, s5
  div s11, a0, s5
  addi s9, a0, 250
  slli a0, a6, 1
  srai t2, a6, 3
  mulhu s10, t4, s11
  mulhu a3, s11, a3
  div s4, s10, s11
  andi t4, t4, -1836
  slti s0, t4, 2047
  srliw s2, t4, 25
  mulhsu a6, a6, a3
  divu s5, s2, a6
  divu a5, t0, a5
  slti a1, s11, -2048
  addw s0, a1, tp
  add s7, sp, s11
  auipc s1, 0
  mul a3, a2, s11
  div s8, s8, s10
  addi a0, s8, -1
  slli s10, a0, 43
  rem s2, s2, t2
  remw t3, tp, s7
  mulhu a6, t3, t3
  li s11, 72632944279
  remuw s9, s11, s2
  divuw gp, s0, s2
  rem s7, gp, s7
  sllw a1, a6, s4
  rem a0, t3, t2
  mulhsu gp, s7, a1
  mulw s4, s7, a1
  rem s11, s7, a0
  andi t4, s4, 1
  mul s2, a0, gp
  remuw ra, s2, s6
  srli a1, a1, 45
  ori a4, a1, -406
  xor a3, s1, t2
  srai ra, a3, 63
  mulw s1, s3, a3
  divuw t4, a5, s3
  addw t1, a3, t4
  srai s4, s1, 48
  mulw a1, s4, t3
  sll s8, a1, s8
  remuw a3, a3, t1
  mulhsu s8, a1, t1
  addw a0, tp, a4
  div s0, s5, a0
  remw t0, s0, a0
  sllw t1, t1, t3
  xori tp, t1, -2048
  remw a1, a1, s7
  remuw t3, t0, tp
  divw gp, tp, tp
  slliw t4, a2, 9
  remuw tp, t3, s3
  mul t0, zero, t4
  remu s11, s11, s1
  remu a0, s2, tp
  divw a6, s11, a4
  mulw s10, s1, a0
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
.word 0xae677f35, 0x7b443554, 0x9ffed67a, 0xa0a2c7d5, 0xf8ebad80, 0x3c80cf4b, 0xb5d13e2b, 0x423f75b9
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x49684470, 0x1787824c, 0x4e90bbe9, 0xe047fbab, 0x74e41f07, 0x0b67bdff, 0x457be682, 0x77c0a4e6
.word 0x91ea7a91, 0x118aeedc, 0x3cea432b, 0x4ab06a10, 0xdf5bb8c9, 0xa8b62c73, 0xe2eee0f0, 0xc5acd425
.word 0x0add459f, 0x47a130ba, 0x88615078, 0x8a8159b9, 0x4368fb99, 0x6acf0fe5, 0xb8ccfe47, 0x8417cdb4
.word 0x1b754dd4, 0x6d33e103, 0xd0452d75, 0x5d8a3bf4, 0xa2ed6c67, 0x7c6c7102, 0xc897af4d, 0x2b08cda4
.word 0x410e3ec2, 0xebfe941f, 0xb9a3a2ef, 0x5c56ea6a, 0x44221eda, 0x2b07b8e1, 0xeaf7e970, 0x3d522678
.word 0x813a4f01, 0xedad556f, 0x7db54ed8, 0xd136c855, 0x937d744e, 0xd7ea710c, 0xe208c885, 0x0db31865
.word 0xd29f6d0b, 0xfa96c761, 0x76b294ae, 0x45694c5e, 0x4ef66da0, 0x91a716ef, 0xe8e390da, 0xdff9c595
.word 0xee4fdf50, 0x514a0b2a, 0x3a4d8b6d, 0x43b80022, 0x6b8996a3, 0x01ee40ee, 0xbc3c3fc0, 0x50a8a8d9
.word 0x568b985a, 0xecee527c, 0x45b030f7, 0xbe84e42a, 0x07015396, 0x4a57500c, 0x0baac90f, 0x59f1eaff
.word 0xeb8bc5a2, 0xcc2af180, 0xf9ab2085, 0x25418d02, 0x4151ba35, 0xdb828fc7, 0x6511f310, 0x18da9c28
.word 0xc9390019, 0x75f9d637, 0x310eeccb, 0x08f4add6, 0x3738eef1, 0x0be11a4e, 0x8b76b65e, 0xdaef5c4b
.word 0x05a641bd, 0xd92d2206, 0x299c5b7a, 0x03dbeb64, 0xe2dfc643, 0xe3b9d911, 0x28cf4a01, 0x556d99c0
.word 0x48200fac, 0xa6bd9d6a, 0xca66fff6, 0x828a7ee2, 0x2da33293, 0x9371a0c8, 0xe18b5197, 0x0f062c1e
.word 0x6b333c97, 0x0f0def98, 0x31284e77, 0xd7420114, 0x932606fb, 0xb39fda18, 0x0c46d13a, 0x612c0181
.word 0x2134e3a4, 0x60c8786c, 0xb1d1c230, 0xb0f3397e, 0x86a80269, 0x150176a0, 0xce50c4de, 0xd15002aa
.word 0x907c869e, 0x3a785eff, 0x2cdbbe3d, 0x446081f5, 0x11cef8c1, 0x6707573a, 0xd8b095cf, 0x19efc84f
.word 0xf7b68dae, 0xcbf018d5, 0x4edd5381, 0x0cb62848, 0xde1cc722, 0xbc259681, 0x67d076ae, 0x42fbc246
.word 0x7ae78129, 0x2dc0670c, 0x10251ffd, 0x99926fe3, 0x7c21264d, 0xac7abb24, 0x05d5dc29, 0x94410290
.word 0x015b8111, 0x9355472b, 0xd319f7d0, 0xdcb6e76f, 0x50c8bd69, 0x93f74287, 0xc5dad7ff, 0xa587e8d8
.word 0xa9e7cf4f, 0x4ddfa5f6, 0x0ca6ee22, 0x45829396, 0x959a1232, 0x802322be, 0xe707797a, 0x595dae6e
.word 0xff739057, 0x8ee48d0d, 0x6abbf1ac, 0x74b1dd60, 0x72866582, 0xb73aa845, 0xcaa0d5d1, 0xc9732cd2
.word 0xe01e645f, 0x7fc74bc3, 0xaaa08084, 0x6115d111, 0x8e9bd9e8, 0x4e84d3ab, 0xd9c13c4c, 0x05e0af06
.word 0x008eeac9, 0xe932624d, 0x37f0d08e, 0x10530dd0, 0xb7e104b6, 0xc641bc52, 0x1de9f753, 0x5fd13f4f
.word 0xe6a0475b, 0x38650b7c, 0x255a6a04, 0x73573598, 0xcebb4942, 0x774f814e, 0x5b9d4048, 0xc6cbf37f
.word 0x9b609189, 0x8c7185f7, 0x2c29a8db, 0x6cb4e414, 0x5e22ba3f, 0xa1f0f746, 0x394b6aa5, 0xdc81e416
.word 0xf127628f, 0x2ff8c604, 0x761160bd, 0xc3ed2f00, 0xc557e864, 0xdf6b276b, 0xe292bf58, 0x0d573dbf
.word 0x1ef028f4, 0xf0b93074, 0xb5ec3eac, 0xcbe8f8fb, 0x5f784e6b, 0x20e65b80, 0x2696b5d4, 0xb5bc6b5d
.word 0x4457aa5a, 0x3957df5b, 0x0afc3e14, 0x5521ae5a, 0xade3c594, 0xaabedc82, 0x42a73689, 0xa48c45f0
.word 0x8aa81fe0, 0x38c08550, 0x52873201, 0x44e5b2d1, 0x35e496d7, 0xfc8ad1f3, 0xa298a9a5, 0x63d792f9
.word 0xc9c7a153, 0x99ee0eab, 0x778d530d, 0x48a8ccc7, 0x07d32fe0, 0x5c2394df, 0x6758c295, 0x39f23362
.word 0x0ca6b2cd, 0xfc88995a, 0x81757507, 0x695e79da, 0xfadfa01a, 0x059ed22c, 0x5e1fc05e, 0xefb1df4d
.word 0xd17084d2, 0xda1d99ee, 0xfa925427, 0xfdc7f27b, 0x7ddd0d62, 0x148bef51, 0x46aa50ab, 0xe535b4d9
.zero 7168
mem_region_end:
