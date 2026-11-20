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
  li x26, 0x0000000a002038a0
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
  li x1, 0x6ebd0bb7a4494c6d
  li x2, 0x5a97ea1315dea97e
  li x3, 0x2be166d6edc80f2e
  li x4, 0x7b3e1e5a6f8cec55
  li x5, 0xd901b7bda9347392
  li x6, 0x4d0d9e015a7abdb9
  li x7, 0x6ab084536032ba3a
  li x8, 0x297c6914eca8141c
  li x9, 0x616a96ed78b91f8a
  li x10, 0xa80e080341144a7b
  li x11, 0x0a233e6eb5770516
  li x12, 0x713fcfde7627f731
  li x13, 0xabbb63b13fc7c796
  li x14, 0x798a60729f1ca4d2
  li x15, 0xe323d03c22cbd02a
  li x16, 0x3f31b0c6cb1ea24a
  li x17, 0x856404dcd595515e
  li x18, 0x6854316d29d55003
  li x19, 0x230fe9a937cb75ba
  li x20, 0x8482efb8f05e8e45
  li x21, 0x8bd9324a49633643
  li x22, 0x73460d0dcd16bc1e
  li x23, 0xea5a7697a8885ff4
  li x24, 0xc6b978cc50777ea1
  li x25, 0x008f35f2b04cf2fd
  li x26, 0x6afcae60062cbb17
  li x27, 0x2a05cabd54a53796
  li x28, 0xdc8435b2d29be464
  li x29, 0xaee2cdaafbe30a9a
  li x30, 0xa02e6cf5ba114f29
  li x31, 0x9b5f13ff5bc9f7e8
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
  addi s8, s8, -1
  fence.i
  remuw s7, s7, s8
  ld s2, -1528(t6)
  divuw s5, s5, a2
  sb s8, 132(t6)
  addiw s11, s7, 885
  fence.i
  sub a2, a2, s5
  mulw s9, s10, s5
  ori sp, s5, -1354
  mul t0, t0, t3
  divw t1, s11, a4
  divu zero, s9, t0
  divw ra, s7, sp
  sraiw s5, t4, 8
  divw s1, ra, t1
  divw tp, ra, t1
  mul t3, ra, a7
  mulhu t2, tp, t0
  sra a7, t3, a7
  sraw a6, s1, t3
  fence.i
  remuw s5, t3, a6
  remw a1, t2, t2
  fence.i
  remuw t0, s5, s5
  fence.i
  rem s11, a7, a1
  addw s9, s11, a1
  fence.i
  fence.i
  sllw s9, t0, a1
  remu s8, s9, s5
  fence.i
  fence.i
  mul t1, t0, t0
  divuw t3, s9, t3
  fence.i
  lb a6, 824(t6)
  divuw a3, a3, a3
  fence.i
  ld s1, 200(t6)
  div s4, a6, a3
  fence.i
  divu t4, a3, gp
  rem t1, a6, s1
  fence.i
  mulhu s8, a2, sp
  srai s11, t4, 54
  remw s7, t4, s7
  sraw a6, a6, a1
  fence.i
  remw a4, s11, t1
  fence.i
  divw s10, a6, a4
  fence.i
  xori a7, a0, -2026
  fence.i
  remuw zero, zero, zero
  divuw s5, a4, a7
  xor tp, a7, zero
  div s10, sp, a7
  sllw a4, a7, a7
  mulhsu s9, zero, tp
  divu s4, s10, sp
  or a0, a4, s4
  mul s6, a2, a0
  mul a7, t4, a4
  sraiw t0, a0, 0
  subw ra, ra, t0
  fence.i
  sd s4, 1952(t6)
  sllw s10, a6, ra
  rem s0, t0, ra
  mulhsu s11, ra, a7
  mulw gp, t0, s10
  sub zero, s0, a6
  sllw t3, s11, zero
  divw s5, a2, t2
  sllw s3, s5, zero
  srli ra, ra, 0
  remw t4, t3, t3
  lui s0, 0
  sllw t1, sp, s0
  addiw s7, s3, -674
  rem a7, s7, a7
  sraw s5, zero, s6
  fence.i
  mulhu ra, s0, t4
  slliw s10, s7, 7
  slli a7, a7, 10
  srli a5, s7, 1
  rem a0, a5, a0
  fence.i
  divuw a7, a7, a5
  sra a6, ra, zero
  remu gp, a1, a5
  addw s11, gp, a7
  divuw t4, t4, t4
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
.word 0xf0783e82, 0x600fa676, 0x9ed63462, 0xe349eb5a, 0xea64e65e, 0xf44a537e, 0xcf416564, 0xfdcd7ece
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x88df3880, 0x54d15fa5, 0x5a69bec9, 0x18a6a087, 0x7ec9a455, 0x0ae845b7, 0xc1a011b8, 0x0b7cd0ab
.word 0x457764d9, 0x47c5ece5, 0xbc8f42e8, 0x88fb6958, 0xcc97e591, 0x73fab501, 0x5c6d5e46, 0x2c56def9
.word 0xc371b3fc, 0xce24dc93, 0x14ed7255, 0xedb9713c, 0xe33ec8ea, 0x8fee8a30, 0xefa2d56d, 0xb82d8077
.word 0x729142e7, 0x15b39e68, 0x5f04a431, 0xabbe8905, 0xd34bf958, 0x33094794, 0x52e2c254, 0x39865a98
.word 0x6137f647, 0x3325e7fc, 0x2993ca5d, 0xba653cab, 0x2fed9f53, 0xdb0f94a7, 0x187cc0df, 0x3325bd28
.word 0x325dd512, 0x925890d1, 0xad09a44d, 0x84dc6a5b, 0x108a7a80, 0xc1d770b7, 0xf37b4d2e, 0xd1288535
.word 0x32d18fb0, 0x81ae33fc, 0x3a700340, 0xf8e039ff, 0x0b7e313f, 0xc8d3e639, 0xce0c2203, 0xe76d0b47
.word 0xe453c9ca, 0x950e771c, 0x55362a77, 0x954b57a9, 0x141d50f2, 0x722478a8, 0x152c24f4, 0x89c9d052
.word 0xbd2401a6, 0x5f748037, 0x598b8f1e, 0x7068385f, 0x97972b53, 0xd71f4169, 0x03f7bc4f, 0x365644fb
.word 0xde960b01, 0x5404088a, 0xae69bc40, 0xdc201712, 0x0378d44a, 0x93f9e22d, 0xce177dcf, 0x5e970a0e
.word 0x6b2f4028, 0xe431a2d4, 0x30ca5563, 0x7bd9419e, 0xd9f80e70, 0xf98569c0, 0xc1b8bfab, 0x90c99e4c
.word 0xa35df3c1, 0x8e27b448, 0x21c875f6, 0xcc7f8e85, 0x212709dd, 0xe4a2fc6f, 0x3fb56673, 0xaac78054
.word 0xe9a14e32, 0xe6eb8a8c, 0x104254b4, 0x8798fea1, 0x13879c22, 0x378923ba, 0x3d9eab81, 0xc2bab1df
.word 0xe22fe2fc, 0x354dbb26, 0x79218434, 0x3b347fdf, 0x6d7b8d75, 0x38fe0b9f, 0x75714266, 0x6c599675
.word 0x23d7cc54, 0x3a49a974, 0x15d120dd, 0xcaa735c3, 0x8e9f7d8a, 0xf0ecd0e2, 0x06f65c8a, 0xcfaf6fb4
.word 0xd7136eaf, 0x6a9ca7ea, 0x54c0487a, 0xff410f48, 0xe4741cf3, 0x437f6665, 0xe13a9b82, 0x0e8a9205
.word 0x5c22df39, 0xee6df019, 0x9f29abdb, 0x2bcf05d7, 0xf3375adf, 0x63092f1b, 0x752e2861, 0x12134b0c
.word 0xbdba45f6, 0x1b7b739a, 0x1beefa0e, 0x776f5045, 0xbb0d58f2, 0xd83f34af, 0x1266544d, 0x67aaf48d
.word 0x88033bb1, 0xad30dcc6, 0x0727ef14, 0xfd8f4054, 0x9b48bad1, 0xf77c079b, 0x145e9566, 0x58163614
.word 0xdd87da05, 0x20ed6c57, 0xc0543f0c, 0x92ff8395, 0x50407a8a, 0x91f08f36, 0xe16be883, 0x763dacbb
.word 0xdd194ba6, 0xda368343, 0xf1d45d20, 0xd489ee98, 0x1a7162f7, 0xcd2d9805, 0x5a25c28c, 0xb5ef9f31
.word 0x6677c2f7, 0xc9f63c00, 0x1cbe858e, 0x6b7f9432, 0x1c33acd0, 0xf288428c, 0x70a88941, 0xbb716dc2
.word 0x8d8e61fe, 0x4f496fba, 0x2ef8ebef, 0xdd2ae74b, 0x824233ed, 0xea367c4d, 0x43de82c5, 0x35d8bbae
.word 0x4e85e9e1, 0x39534ce8, 0x8511c476, 0x4a483069, 0xbfd24a3a, 0x5364450a, 0x0fc1be56, 0x5f53e76c
.word 0xc23503e8, 0x8cd75e99, 0x9c6e4745, 0x77f99135, 0x0598b16f, 0xc1a5aec6, 0x198cf883, 0xd486e316
.word 0x5a023c15, 0xe2b27f48, 0xb03d4c78, 0xb641fab7, 0x4026963b, 0x957248ee, 0x8d8f0776, 0xa9c8e4ba
.word 0xe6e25306, 0xbe606710, 0x9e58db98, 0xd954dff2, 0xbb94cab9, 0x923bf469, 0x27785d1a, 0x48ed19cb
.word 0x3e1d0738, 0x2eb3b1f7, 0x0a6bdb87, 0x6c8cd57b, 0x2ed188e1, 0xf6281647, 0x71a70a9c, 0x8875fee6
.word 0xa99cf73d, 0xd2251793, 0x5fac1176, 0x2d6b731b, 0x457efc5f, 0x94d16186, 0xe1052a9b, 0x736a1010
.word 0x4ac4bbc4, 0x8225a241, 0x06134dea, 0x53740423, 0x98d20c19, 0xd490e239, 0x12ceff7f, 0xbd1c4651
.word 0x7b923e3b, 0x642c361b, 0x4b413064, 0x80934100, 0x9140b724, 0x2f88321e, 0x91fb088c, 0xf7b262b4
.word 0xc56f06c7, 0x12113a9e, 0x46534b29, 0xd052b300, 0x9146a3db, 0x70beadff, 0xf1d20af9, 0x20fba3dd
.zero 7168
mem_region_end:
