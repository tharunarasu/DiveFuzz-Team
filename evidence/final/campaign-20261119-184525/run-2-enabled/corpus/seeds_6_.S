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
  li x26, 0x0000000a0018382a
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
  li x1, 0x4d6054bd95115279
  li x2, 0xd8db4aef025b5b29
  li x3, 0xb886392d12fb0b2e
  li x4, 0xe06176accbfa62ce
  li x5, 0xaebfb708441f6747
  li x6, 0xb1c9b1fcfbf05835
  li x7, 0x8a0ce9fdabf826d9
  li x8, 0xe778e62daa08990b
  li x9, 0x5cb870c6541e1709
  li x10, 0xc6fdd32cdddc24c2
  li x11, 0x7991f1b2611e7afc
  li x12, 0x048042df362105f9
  li x13, 0x226cb58217458fad
  li x14, 0xc961b34be0a26011
  li x15, 0x7310da4ac2e6188e
  li x16, 0xf185b721324e38be
  li x17, 0x5a7141327e77386c
  li x18, 0x8e52907aee32746c
  li x19, 0x0e3875a8e9f11c38
  li x20, 0xca47727d3e7c9185
  li x21, 0xeef8558802c11c68
  li x22, 0x2f4c467e93825544
  li x23, 0x2352e5b4edb6d0b9
  li x24, 0x2a8955f3ce55bcf8
  li x25, 0x8b518e71cdf326c4
  li x26, 0xf60f7d146760d76c
  li x27, 0xf6cd4c04982449bc
  li x28, 0x9d5b889909980fcf
  li x29, 0xefc70cce3c114903
  li x30, 0x747f12321b5da67a
  li x31, 0xfc6b799c94424485
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
  remuw t2, s10, s9
  add s2, t2, t2
  remw a1, t2, a1
  mulhsu s4, s4, s2
  divuw s11, sp, s2
  and s9, a6, t1
  subw ra, s9, s4
  divuw gp, t1, t2
  slliw s7, t1, 2
  mulhsu a4, gp, s7
  sllw s0, a7, gp
  srai s5, a4, 45
  mulhsu s5, s5, a6
  divw s4, a3, a6
  sraw a7, s4, s9
  remu ra, a7, a3
  remu a2, s1, s5
  div s0, s0, s4
  rem t1, s8, ra
  remu gp, tp, ra
  remw a3, s10, sp
  slti a1, a1, 1301
  ori s11, s4, 1
  mulw a6, s7, t1
  sraiw a4, ra, 1
  divuw a2, a2, s9
  sraiw a1, a4, 0
  rem zero, a1, t3
  divw gp, t1, s1
  srl tp, a2, a2
  divw s4, s1, s1
  sllw s9, gp, s1
  divuw t2, t2, s4
  srlw s8, s9, s8
  sb s4, -286(t6)
  divuw s5, t3, a5
  remuw zero, zero, t2
  divu t4, s8, s2
  sd t4, -448(t6)
  remu s0, s0, t4
  mulhu t3, s0, a0
  remuw t4, s11, a3
  mul a4, t4, gp
  divuw t1, a4, s10
  remw sp, s3, tp
  remu a5, sp, a0
  srl s8, s5, s5
  sraiw zero, a5, 28
  remuw a2, s10, zero
  slli t4, a2, 63
  remw s4, t4, t2
  remu ra, s4, a2
  mulhu s8, a1, a5
  div t0, t0, tp
  divuw t1, sp, s6
  slli s7, t1, 48
  divw a2, t1, t0
  rem a3, t0, a3
  divu s1, a2, a6
  srai a5, s5, 55
  divu ra, s3, a3
  sllw t2, t3, s11
  slliw s8, s6, 23
  divw sp, s8, s8
  div tp, a1, s8
  mul t3, a0, t3
  div gp, s8, t3
  mul a5, a7, s3
  mulw s8, a6, s0
  remw s6, a5, s6
  divw s0, a6, t3
  divw s8, a6, s0
  remu s10, s4, s3
  divw s0, s10, t2
  mulhsu s2, s3, s10
  remu s1, s2, s1
  slliw s4, s5, 10
  slliw s5, s1, 1
  srliw sp, t3, 20
  remuw t1, sp, s10
  sllw a1, s3, s3
  slliw s2, t1, 26
  remu t3, t1, t1
  remw a0, t1, s2
  rem s3, a1, zero
  divu zero, s0, s2
  divuw t0, s5, t0
  sub a2, t0, s8
  mulhu s4, a6, a2
  mulw ra, s4, a2
  sw s8, -984(t6)
  divu s9, s5, a0
  subw s3, sp, a7
  slliw s3, a4, 31
  divuw a0, a0, s4
  mul s2, s2, s5
  div a2, sp, a2
  remu a0, sp, s6
  remw zero, sp, zero
  slliw gp, s5, 29
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
.word 0xcc61c255, 0xf5facc99, 0x65384c7b, 0xa932201d, 0xf95be787, 0xe2fcc9cc, 0x1257ef62, 0x2477b089
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x0b66ca39, 0xc637c263, 0xd2e91ce8, 0x727f787e, 0xc90b3fb1, 0xfa81e64e, 0x59441121, 0xe4729e43
.word 0xa2b1f726, 0x9472f0ab, 0x305b6a98, 0x710c9b18, 0xef336af3, 0xb53ab679, 0x6b3a53a5, 0xec94253c
.word 0x4f0a80a9, 0x86e77565, 0x0de08396, 0xfa32e9f2, 0xe6381dd5, 0xf103bb68, 0x3aeba94a, 0xfac0631c
.word 0x39dd42a8, 0x98c0bc26, 0xd7662ab0, 0xf58391c3, 0xcdd90250, 0x2574992d, 0x204a9273, 0x62eb1eff
.word 0x97640b8b, 0xc639818d, 0x81fe8eec, 0x5128427f, 0xef60abb0, 0x3478f90e, 0xf4565ff7, 0xcbdd0e67
.word 0x1998f468, 0x8cadc7c0, 0x107e959b, 0xba6bd0a4, 0xc6ad7bdd, 0x5cba7a3e, 0x0a6eeca7, 0x119a7c29
.word 0x7d55270b, 0x2b24ca92, 0xe73b4022, 0x47267c87, 0xfa5a35f8, 0x4c1437c0, 0x3927d54a, 0x7cada6ea
.word 0x6f7563fe, 0xedd07d58, 0x4aa97cee, 0x92a826dc, 0x535b1926, 0xe518f60d, 0x8c0fcdfc, 0x99c8458f
.word 0x659b37ae, 0x55c7fd02, 0x9aece34d, 0xd36af340, 0x5a8bb714, 0x00d664ee, 0xd8454969, 0xc6dcf3c5
.word 0xdee8635f, 0xfb72c566, 0x49986a8a, 0x1e99bbec, 0xdad58706, 0x51b0df2c, 0xd2a43b37, 0xb162ddcc
.word 0x22c8c082, 0x1b79bfd6, 0x7cbe6b86, 0x30c097eb, 0x349888ad, 0xf1dfabe9, 0xc323dfc9, 0x8260ba9f
.word 0x666a20e6, 0x3a2cdc99, 0x180b3778, 0x102f0fb7, 0x497c4f96, 0x639a510d, 0xf24806ca, 0x66a177de
.word 0xa96300ab, 0x476774b9, 0xa52b9b83, 0x63678631, 0x375f920a, 0xfb2d618d, 0x47ffcb65, 0x80282d86
.word 0xa9393313, 0xf586aac4, 0x079f22a4, 0x8107aeed, 0x5c104542, 0x9661bd87, 0xd80165a6, 0x6a9d3f17
.word 0x3ad2d52b, 0x87dc2294, 0x2c6a95a2, 0xd292e340, 0x5072bf82, 0x24e8b1f1, 0x2fbb4f1c, 0xd247e300
.word 0x08dfc51d, 0xb2d6465d, 0xd01e6c93, 0x50bf5bf6, 0x284ae527, 0xe02ac009, 0x26457c0c, 0x61e08c34
.word 0x840566d0, 0x2844b7fa, 0xa4f87dd0, 0x4c56ece7, 0xfb92ef91, 0x8e2a5b4b, 0xf0905466, 0x9bc431ae
.word 0xb0985c58, 0xa852236b, 0xbed9c7bb, 0x4990a64e, 0xbfe8c813, 0x8f03444a, 0xd92e1e59, 0xa292282d
.word 0x07efd47c, 0xb6f4ad85, 0x829de083, 0x386c13db, 0x5138cfa9, 0x38b2df9b, 0x80772751, 0x207a6e6f
.word 0x5e8dcb93, 0x352be079, 0x754260b4, 0xaa4f6f3d, 0xefff0745, 0x1a2cf1a3, 0xda8b6f22, 0x91d485cf
.word 0xf5b5f6d7, 0xdd92f7ed, 0xe2c5f5a3, 0x16a73fb7, 0xf5458ea5, 0x49ac98fb, 0x24d6fa4a, 0x4c0be2c4
.word 0xa619eaf9, 0x29822004, 0x89f79907, 0xdbccfd4a, 0xfc99879e, 0xc60d79fa, 0x03256c04, 0xa4b55dbe
.word 0x2e04e9c8, 0x508e0d04, 0x92da551d, 0x9fd424fb, 0x8e044ebe, 0xbaf6820d, 0xf551f368, 0xb267b54f
.word 0x41feee5c, 0x4be4d5f5, 0x00f73a78, 0x53c05bcc, 0x1470c98e, 0xcd744d30, 0xab00ba90, 0x6a3c9cf9
.word 0x71408aa6, 0x704caa69, 0x3842087a, 0x4bfe2228, 0xed444a40, 0x5b17e5f3, 0x3802972c, 0x2760cd38
.word 0x6ee7d7f8, 0x3522c865, 0x7e0efba8, 0x45898fbe, 0x3fc49cd9, 0x803d14a9, 0xf4bfffd9, 0xed5533f9
.word 0x69d4c565, 0x90816ada, 0x025a5124, 0x48208a63, 0x18809114, 0x8e536600, 0xad0e34da, 0x9e442f7c
.word 0x4e06ab11, 0xc7ac5d90, 0xfd8793d0, 0x3ac763fa, 0xf4cd6821, 0x215edbe9, 0x6e175641, 0xa5b2099e
.word 0x5d5fe8e7, 0xa005e1ab, 0x53ebabdf, 0x62127b92, 0xe9beecee, 0x35819e83, 0x67fd9289, 0x8638d044
.word 0x327b41fe, 0xd689263d, 0xdc75512c, 0x1329f87f, 0x50606dcf, 0xf8fc3f39, 0x4fd4e028, 0x94f2d64b
.word 0x1f990239, 0xb21f53b3, 0x73d971c0, 0x04301534, 0x1a1ce4ea, 0x21b212da, 0x962d85b9, 0x3e5b3919
.word 0xb8364c49, 0xfd02a9df, 0xc0c2cbed, 0xa3f4bb28, 0x665b776b, 0xa45796e2, 0xcab991ed, 0x8c4a3363
.zero 7168
mem_region_end:
