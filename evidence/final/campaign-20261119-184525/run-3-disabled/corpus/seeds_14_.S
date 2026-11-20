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
  li x26, 0x0000000a004c79aa
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
  li x1, 0xc8fef9b47c43ac47
  li x2, 0x0a6539226541fb60
  li x3, 0x91a98a766e1a856c
  li x4, 0x32397ce913763f66
  li x5, 0x7877545b24475050
  li x6, 0xdacd0e279c17da39
  li x7, 0x60050d7f00b54c87
  li x8, 0x303926c56fb63d64
  li x9, 0x602d5c13b7dabd8a
  li x10, 0x85abe4e42059b371
  li x11, 0x52c3c4d5f1eed810
  li x12, 0xebb14c4e7d6f7d0d
  li x13, 0x4fc5c37658a7611d
  li x14, 0xb0b06afc2ddb58f3
  li x15, 0x8eb697f937d2a04d
  li x16, 0x711e1c2fe8924762
  li x17, 0x4614fe095d55ca42
  li x18, 0x91742d37b5b4d8be
  li x19, 0x5d586afd7f37fab0
  li x20, 0x307d659f64e54ecd
  li x21, 0x3611a38520d381ba
  li x22, 0x1e56cfadec988758
  li x23, 0x7d0df8700444ace5
  li x24, 0x3a9fab971fe8052a
  li x25, 0x2bbb6b3b678263fc
  li x26, 0x86d808d67f5c8bf7
  li x27, 0x6650df4d34baf559
  li x28, 0xd276d5294800646c
  li x29, 0x36b0b53a43fd4b1e
  li x30, 0x26b2b97d25b0b7c7
  li x31, 0xf17d6f4727459e2e
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
  mulw a3, a3, a3
  xor zero, a3, s0
  sltu a7, a3, zero
  div s3, a4, zero
  sraiw t0, zero, 0
  divw t4, t4, gp
  subw s11, t0, zero
  and s10, s11, s11
  fence.i
  subw a2, s10, s10
  add s2, a7, t0
  fence.i
  fence.i
  subw s1, s1, s1
  divw s0, a4, s0
  slli a5, s10, 1
  mulhsu sp, a2, s7
  slliw a7, sp, 0
  mulw a2, a2, a2
  fence.i
  divuw zero, zero, s0
  divuw s1, s1, a7
  remuw t1, s1, s1
  divuw a5, zero, t1
  remw s8, s1, s1
  fence.i
  divuw t3, zero, s8
  divu s2, s1, s2
  fence.i
  rem s6, t1, a5
  divw sp, a5, t3
  addi zero, t3, -1023
  addw tp, s6, tp
  srli a1, tp, 49
  divw a5, t2, s2
  srai s4, s4, 1
  fence.i
  mul s8, t1, s8
  remuw s5, tp, a5
  remu t2, s5, s5
  lui a4, 0
  fence.i
  remu ra, s5, s4
  fence.i
  mulhu t4, s5, s8
  remw s1, a4, a4
  ld s1, -1112(t6)
  lw s0, 1108(t6)
  mulhsu a1, a4, ra
  slliw s7, a7, 17
  div t3, s0, s1
  divu a0, t3, s7
  remw s9, s7, a1
  mulhsu ra, s9, s2
  subw t0, ra, t3
  fence.i
  srlw t2, s10, t3
  fence.i
  mul t4, t4, ra
  sb ra, -1627(t6)
  remu s1, a0, t0
  slti s2, t0, 2047
  fence.i
  fence.i
  div s11, t0, t0
  fence.i
  mulw s5, s2, s5
  srlw ra, s2, t4
  sllw tp, s11, s5
  srlw a1, a1, ra
  nop
  mul s3, s11, ra
  lui t2, 619339
  lwu a3, -428(t6)
  divu a0, tp, a4
  mulw s6, s3, t2
  remw a5, a2, s6
  mul s2, s2, s6
  mulw s7, s2, a3
  fence.i
  fence.i
  mul s3, s7, s3
  fence.i
  srliw t4, tp, 31
  fence.i
  li a7, -289822471467
  or a1, s3, a1
  mul zero, a1, a1
  sb t4, -1951(t6)
  fence.i
  divu s0, t3, a7
  subw sp, sp, sp
  ld s5, 472(t6)
  remuw t2, sp, s2
  fence
  sd t2, 752(t6)
  divw s4, s7, sp
  div gp, tp, sp
  remu s0, s4, tp
  lwu a6, 980(t6)
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
.word 0x0ca92cc2, 0xa55c80a3, 0x903d8478, 0x5757ced7, 0xa86d7b1f, 0xe8e55ee4, 0x4e6c6554, 0xbad66e36
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x25e14b68, 0xe21bca15, 0x1c428f3f, 0xbd2dda3a, 0xfb036438, 0x2a31c5b4, 0x9fdc6a66, 0xc5e92e7d
.word 0xde0393d0, 0x7b921385, 0x61a50f3c, 0x7432d503, 0xe4db6ecf, 0xb13761b0, 0xc8dff69d, 0x62ed1b39
.word 0xce920de8, 0x94f9a845, 0x956017f0, 0x02186d17, 0x34ea2b26, 0x5301a60a, 0x458e11a1, 0x9cc1067b
.word 0x36d38613, 0x96f8e390, 0x18cfa958, 0xd142070f, 0xee959935, 0xb7478733, 0x9e69e951, 0x00157542
.word 0xdd8c54f0, 0x59f626a9, 0x43449287, 0x0793fed8, 0xacc8d2a8, 0x63a0f567, 0xc89964a6, 0x53fde0c6
.word 0x72e763f0, 0x20c2d87d, 0xc5b8cfbe, 0xeae6f5c8, 0xfdffde73, 0xeb3b8483, 0x52f57930, 0xa49b56ef
.word 0x4bcc9d8d, 0xbcf74430, 0x1f93710d, 0x538291de, 0x76eec900, 0x1dd419ad, 0xd7e7ff6a, 0xc30d5ffc
.word 0x310c14cb, 0x4b6941a8, 0x1e53e55b, 0xe6b170b6, 0xeb3716c4, 0x73195855, 0xeff2cb72, 0xb1b51307
.word 0x4b9e88e7, 0x3e252192, 0x31c1f3c6, 0x0abd268f, 0x6d900b1d, 0xaddac8b5, 0x190831b8, 0x1d5c958b
.word 0x9cacd292, 0xd6dabe6c, 0xc108e2e5, 0xaa6ae80b, 0xa55f0284, 0x1e5c9dd7, 0xb1722718, 0x33a05a76
.word 0xe3ffe915, 0x1e44eeac, 0x4874eb70, 0x217df22e, 0x785d9b9d, 0xce9040e4, 0x96bac4ad, 0xd94869cd
.word 0xa4f8d565, 0x716996f0, 0xe4d9a464, 0x8326e3a1, 0xc7711c68, 0x5cb03a6e, 0xc9de04d2, 0x5b663fb6
.word 0x4560246a, 0xc79600dc, 0xdf213ec7, 0x75dd8364, 0x870e2898, 0x37143092, 0x4a6f5ad9, 0xefa73b7b
.word 0xff75f5a6, 0x9fba74d2, 0x5e28a340, 0x42d956f9, 0x4c4f62b2, 0xa9b2ff12, 0xe2425bfa, 0x6df2d915
.word 0x013c6826, 0xd5cbf459, 0xb7b8874c, 0x79ce981e, 0x98384b74, 0xd6b6141f, 0x04307629, 0xbfe12551
.word 0xcf6ba675, 0x23dcb5fb, 0x67bb64aa, 0x21339285, 0x576e17ee, 0x1060548f, 0xda19e34f, 0xec652691
.word 0xa890e5e4, 0x6d576215, 0x86208c7f, 0x95dd5ae3, 0xd9ba18c8, 0x2aef3875, 0x75424c24, 0x1f662d20
.word 0xd2aa756a, 0x048e0090, 0xc692543d, 0x170ebdc5, 0x1eb6e379, 0x1f33683b, 0x2842594d, 0x2fc28021
.word 0x9f1b2877, 0x0509f732, 0x1d8d95dd, 0x737dfca2, 0xa754419d, 0x3e8f5ccf, 0x579acba7, 0xd3d7d397
.word 0x7d2922ec, 0x1d8a656e, 0xb9d21ae2, 0xe98e8702, 0xa61388aa, 0x7f1f6fce, 0x86c9efe7, 0xa97e934c
.word 0x12b442ce, 0xd31bdfaa, 0x5b9e1c9c, 0x14800c53, 0x159a09e1, 0xf85d5641, 0x2d4adf55, 0x966eba87
.word 0xde5c4b6f, 0xaf356b3d, 0xa0d77d70, 0x6aaf9a29, 0x348296da, 0x2868bf00, 0xf3222b2b, 0x981015df
.word 0xd35cdeba, 0xebc75da4, 0x4c210c27, 0x40cb9d75, 0x805de34e, 0x2c648601, 0xae5dd582, 0x2d191df3
.word 0xad04f343, 0x70c5af95, 0x33155e65, 0xfac327ef, 0x110ebca6, 0x28387f97, 0xabfdbe8d, 0x70937ed2
.word 0xc944d112, 0xedade182, 0x0cc8f2f0, 0xffd20142, 0x9e0dde13, 0xbf89888b, 0x008a7fcc, 0x8ecb08e4
.word 0x9fd310ae, 0xa291f3f6, 0x3a7bb69f, 0x7529a49c, 0x6887017b, 0x371ae396, 0x7cc2f44e, 0xed836d79
.word 0x0194a000, 0x0f2b3641, 0x5ae8e7b3, 0xcdfdee04, 0xcdaf7bf5, 0xd9683b90, 0x361dc964, 0x3f99e5d8
.word 0x3f1ee35d, 0xbfdc613e, 0xe8212730, 0xbf7db4ed, 0x68b44c5b, 0x2976fcbb, 0x9b57cff8, 0xb5dc715b
.word 0x3bee96cc, 0x38fd9b0c, 0x4f733356, 0xd6ce3eef, 0x60b7147b, 0x745cc65e, 0xf004938e, 0x915ff264
.word 0xbd15116f, 0x709e0a4b, 0x49378345, 0x8321b00c, 0x732b9c57, 0xd8d7d892, 0xaa9fe2c2, 0x43d867aa
.word 0xb269e2a5, 0x5d111e39, 0xcc3bb24c, 0x06811cd8, 0x02c4009e, 0xa102de1c, 0x78bf4359, 0x0eb010c7
.word 0x3c1f90a4, 0xb91f5cd9, 0xbdd3975c, 0xdfb05ccb, 0x383bea76, 0x348bfb2a, 0x5818f322, 0x23d5982c
.zero 7168
mem_region_end:
