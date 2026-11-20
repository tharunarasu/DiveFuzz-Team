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
  li x26, 0x0000000a002468a0
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
  li x1, 0xbdfa20e8b4e87856
  li x2, 0x8ac6bb5dd5e20b0b
  li x3, 0x90a242c45b616c5c
  li x4, 0xc8a4415e8c2696a8
  li x5, 0x45fec6d02b60d7f2
  li x6, 0x6cd7fcf62664afb0
  li x7, 0x9118bdeb283f38d0
  li x8, 0x8d6a9739c9d8d00d
  li x9, 0x9de89e99b33d5477
  li x10, 0x9f16531c9f8c6f66
  li x11, 0x2c9189748bbb9175
  li x12, 0xa4afbe9dcc678d0d
  li x13, 0xf26b893c68be2176
  li x14, 0xea94b803425e86e5
  li x15, 0xee33e08cd6040c89
  li x16, 0x42845831693c817c
  li x17, 0x0e4d7100a0effa50
  li x18, 0x9b20b882f841ea49
  li x19, 0xcd9b19fd40e1e7bc
  li x20, 0xdbd2809e05a7fcf1
  li x21, 0x43956e13e2e8379f
  li x22, 0x915d3de0610157ce
  li x23, 0x20fec5f702d114ad
  li x24, 0xcab56b645a33bfb6
  li x25, 0x6d2e210319a16eb0
  li x26, 0xb4ca5e6b8f95ab4b
  li x27, 0x094994b21f9182bc
  li x28, 0x5e73c75a75282e51
  li x29, 0xce609cdb886beed8
  li x30, 0x04b3d2a649374105
  li x31, 0x2373addaac32e0e0
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
  slt a6, a6, a6
  fence.i
  slli s6, s6, 63
  remuw a0, a7, s7
  lb a5, 1656(t6)
  slliw s11, a5, 25
  fence.i
  sll s0, s6, s0
  mulw t0, t0, a0
  fence.i
  mulhu s3, a0, ra
  lh t4, 1876(t6)
  srlw a2, t4, s0
  srl t1, a2, t4
  fence.i
  srliw s6, s6, 0
  divw s9, a5, t1
  srli ra, s1, 2
  srliw s2, t1, 23
  div a6, s9, a6
  rem zero, zero, a6
  srlw gp, ra, gp
  nop
  sw s9, -1812(t6)
  divuw t2, zero, t2
  divu t2, ra, s2
  fence.i
  sllw s8, s2, gp
  add s5, t2, s5
  addiw s2, s5, -2048
  lh s6, 336(t6)
  sllw a0, t1, s6
  lwu s0, 1628(t6)
  fence.i
  remuw sp, a0, s2
  remuw s1, s2, a0
  remuw tp, s1, s0
  remuw a1, s0, a7
  mul gp, s6, tp
  div zero, sp, sp
  xori t3, s1, 1162
  mulhu t1, s0, gp
  slliw ra, t1, 12
  fence.i
  remuw a0, ra, zero
  addw a4, zero, a0
  fence.i
  addi s7, t3, -1819
  addw t0, a4, s7
  fence.i
  or sp, a4, ra
  remuw s0, t0, s0
  sd t0, -1144(t6)
  divuw zero, t0, t0
  fence
  remuw a2, a0, t0
  fence.i
  divu a1, zero, sp
  srliw t0, a2, 22
  lui s3, 841383
  mulhsu a4, a2, s3
  slli a0, s3, 0
  and a7, a1, t0
  rem s7, s3, t0
  divw a1, s7, a7
  lbu s1, 1711(t6)
  srai s3, a0, 1
  slli zero, s7, 0
  fence.i
  sd a7, 920(t6)
  addiw t2, t2, 344
  divw s9, s9, s1
  sub s5, t2, s1
  fence.i
  srai a7, s9, 0
  div t0, s6, a1
  lhu s11, -1414(t6)
  addw s7, sp, s7
  divu a2, t0, a1
  div sp, t0, s11
  addw a1, t4, s3
  ld s4, 848(t6)
  mulw gp, s4, a1
  slli s5, gp, 0
  addi a5, t4, 2047
  lbu a2, -1652(t6)
  fence.i
  mul t1, s7, a5
  srli t4, t4, 63
  sh a2, 900(t6)
  srliw s2, sp, 20
  srl a3, t4, a2
  fence.i
  fence.i
  div s5, t1, a2
  fence.i
  remu s7, t4, t1
  divuw t4, a3, a3
  fence.i
  divw a1, t1, a3
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
.word 0xf137aa29, 0x1c14f722, 0x512558c3, 0x64699ffc, 0x0af07221, 0x6f0b1c42, 0xaa649f3f, 0xd7a2806e
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x0cfdca04, 0xddbf1117, 0x13358774, 0x3b52a999, 0xe6b3316f, 0xe1c2df54, 0xf807fe94, 0x48b768fb
.word 0xa16ff0dc, 0xdfad392d, 0xc631b781, 0x035ef17a, 0xaecb271b, 0x4a7f0424, 0xd93aea23, 0xaea1b271
.word 0xfe55a484, 0x02117700, 0x4b4dd026, 0xfd4b6a0b, 0xcbc322b0, 0x75112f26, 0xdc4025b4, 0x0eeabd31
.word 0xa5ce83ec, 0xc55875b5, 0x5b8683a6, 0xfcf102c5, 0x64cfbe2e, 0x33db4da7, 0x795f8ba2, 0x96ca5f26
.word 0xd1601ac1, 0xc12930b1, 0x38b5e85e, 0x0db75f88, 0x4b07ef8c, 0x27663671, 0x065d499c, 0x5ccadace
.word 0xbd7f8fee, 0xdcbbe074, 0xc059c279, 0xbfa12899, 0x138c67fe, 0xdcf088f4, 0x68646adf, 0x01ca7782
.word 0xd1ddf82e, 0x0f749d1b, 0x1cded5f2, 0xa8c684da, 0x12e69ff8, 0x7f6782bf, 0xe35d7fc7, 0x41f69191
.word 0x5b637d31, 0x0163d258, 0x3cfc197b, 0x3edeeca4, 0x4e24b810, 0x58a842ee, 0xdb3a4f49, 0x8f4f2c3d
.word 0xca7f183c, 0x90d0449d, 0x9e4c01ae, 0x58de1dbd, 0xe79b9e6d, 0x26295dbb, 0x69698d27, 0x5633bf3a
.word 0xdddee9b6, 0x79c1c792, 0x0ecf7b12, 0x2b97c868, 0x46c8e320, 0xb594516d, 0x7d06f175, 0x1cfadf18
.word 0xc48cb40a, 0xa715dc96, 0x9109bed6, 0x859ce60d, 0x6bc8d982, 0x6012e3c8, 0x2e837dd7, 0xb3a6733b
.word 0xb9ba0702, 0x000a210b, 0x6a237e03, 0x51161ec4, 0xe8a79543, 0x3cc8ecfe, 0xda01683d, 0xb85a005b
.word 0xa33c34eb, 0x3ddbde50, 0x344fd293, 0x7dae958f, 0xe18a1018, 0x491dcee5, 0x3aa409d1, 0x33408754
.word 0x4c54a7a9, 0xab640c8a, 0xdbcb4134, 0xa14e67a1, 0x91b88604, 0xb8dcf622, 0x4bdca958, 0x1ecc6638
.word 0xc0ea1396, 0xdab48f9b, 0x5971ff68, 0x60b28d3d, 0x1a6c1745, 0x489229a1, 0xd9c23b89, 0x2be7034a
.word 0xc7b8b21a, 0x8b872ed8, 0x7c97d237, 0x592dc9d4, 0xddb2b905, 0x9b8369ea, 0xf033d88c, 0x65468d43
.word 0x4bec884f, 0xbde9cd20, 0x1d92dbe0, 0xa4cedeef, 0x4a880fd4, 0xab62d837, 0x7d8fd78b, 0x54451070
.word 0xe640fbfb, 0x8a9a3750, 0x6d0d32fe, 0x5e4f805a, 0xb24cce55, 0x3fe1cf75, 0xec394fce, 0x99009457
.word 0x699debd2, 0xc432591d, 0xd23f47ca, 0x1230b2fa, 0x8dd9e3f6, 0x46803dd5, 0xafece331, 0xdbc8d6a4
.word 0xdbc6e3cc, 0x23983417, 0xe850716a, 0x11d0e3a6, 0x99c1875f, 0x82301198, 0x30ba8203, 0x3414fcc2
.word 0xc5f79775, 0xfcddd41e, 0x39b4ad19, 0x45fb4fa6, 0x20831b9a, 0xa05ba40f, 0xcf1491dc, 0x60ecbc4b
.word 0xd882f47c, 0x349b98b9, 0xd1bc274e, 0xf810060f, 0x94fa208b, 0xdd2d32a1, 0x889c92d2, 0x8d29589c
.word 0xaccbe034, 0x9a470a54, 0x4eb1c698, 0x5db43390, 0xdddce826, 0x751a4000, 0xc531c15a, 0x2b9e6e19
.word 0x77f58a28, 0xd4eeca16, 0x4b0c8a2a, 0x8ad587b8, 0x53cb4f7c, 0xc2e6b4a5, 0x4ca6d6e9, 0xe3b19a79
.word 0x5dddf9f2, 0x10a02221, 0xaf93bb5f, 0x54956d95, 0xbf285ff5, 0x7ebdf690, 0xbecfdb68, 0x7412b432
.word 0xce8d8988, 0xd93e1dff, 0x3e95f304, 0xdf433990, 0xa9403107, 0x104459df, 0x93af8b91, 0xa55bd760
.word 0xf65c7d45, 0xb8a33d74, 0xd65dd5ec, 0x9d4cc4bf, 0x129d1f40, 0x5803dd85, 0x4fbb3b0b, 0xefd5b3f9
.word 0xf2e6fb66, 0x35d1bfba, 0x719b01b7, 0x3169de13, 0xa8130d15, 0x6cbea75d, 0x1f24c9c8, 0x9c70ab46
.word 0x7c753a0d, 0xb5e28ed0, 0x8f02194f, 0x7afe68f9, 0xad225f26, 0x6f7ec5c7, 0xc024e5ba, 0xeb19eaca
.word 0x0539bac8, 0x577a9a26, 0x57b4af83, 0xa6aa6ea3, 0xf539d18d, 0x3c3f008b, 0x3f7c1f2b, 0x8f839919
.word 0x0e9c5c91, 0xe6d55472, 0x6fb2862f, 0x7298518a, 0xa062fa34, 0xbba1956e, 0xb02729dc, 0xa9c969fc
.word 0xce803b80, 0x66f652dd, 0x47f44f81, 0x5cc39858, 0xd78344ec, 0xf0d51a40, 0x7d74923d, 0xf1059ac0
.zero 7168
mem_region_end:
