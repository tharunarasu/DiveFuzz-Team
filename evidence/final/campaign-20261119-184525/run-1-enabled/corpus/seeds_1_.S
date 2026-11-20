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
  li x26, 0x0000000a00446080
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
  li x1, 0xc9de48fdff113a1e
  li x2, 0x6bcc7b9e0a546c01
  li x3, 0x90b123ff0722d193
  li x4, 0xad28d47a8e683f28
  li x5, 0xc1bfc7ab212e03bd
  li x6, 0x299a52879541937e
  li x7, 0x775ace364fd7eba0
  li x8, 0xa714a1e9c0cf17c5
  li x9, 0xef512c58c835156f
  li x10, 0x47eb93cea6360399
  li x11, 0xe685acb714786e96
  li x12, 0xd94d8d21db70a64b
  li x13, 0x8644a1e6d2818add
  li x14, 0x94222becf0217c3b
  li x15, 0xef828079a78b6244
  li x16, 0x70ae31c4b0f125a7
  li x17, 0x4a13b9da9f4e53bb
  li x18, 0xcc2114b8b33f70f4
  li x19, 0x19ec4413125e5cfb
  li x20, 0xb7fe7f406d951908
  li x21, 0xa51bdbee16d2b9ae
  li x22, 0x642a1d5311a6fffc
  li x23, 0xf075cd98502fe65b
  li x24, 0x9bf7088fcf057c32
  li x25, 0x27a3f19ff606c2d6
  li x26, 0x6ab39bee9902e940
  li x27, 0xf44a040b1189b079
  li x28, 0x15ca5c5e7eda2f12
  li x29, 0xcf69ce4e86da070c
  li x30, 0x8c8e6ea3cd4fe2c1
  li x31, 0xcc24754c2ddfdaf7
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
  remu s6, s6, s6
  slliw a2, a4, 3
  divw s5, s7, t2
  srl tp, s5, s5
  srli sp, sp, 63
  mulw t2, s3, sp
  sraw ra, tp, ra
  divw t1, gp, ra
  remu tp, s8, t1
  remuw gp, ra, s8
  srlw s0, t2, s10
  add a3, s0, a3
  slliw s9, s9, 0
  srai a7, s9, 63
  subw a0, s0, a0
  mulw s4, t0, s4
  remu s6, a0, sp
  or a1, t1, a0
  srliw a5, a1, 29
  remuw a4, a1, a0
  slli a7, s6, 35
  sh s6, 154(t6)
  slli t1, t1, 0
  mulw sp, a5, a1
  div s4, ra, a5
  div s6, s6, sp
  mul s8, s8, s4
  lui a4, 736901
  srliw a7, s5, 1
  remu tp, a7, a6
  lwu s3, -524(t6)
  srai s5, tp, 60
  mulw s11, s11, tp
  lb s2, -96(t6)
  mulhu s2, a0, s10
  slliw s6, a0, 24
  divw s10, s10, a0
  slti s7, s2, 941
  rem s11, s0, s2
  divw a7, s7, s6
  mulhu t0, s11, t0
  remu s3, t2, ra
  sh s7, -946(t6)
  remw a2, s3, t4
  remw s10, a5, t0
  xor s2, s2, s3
  ld s5, 616(t6)
  sd s10, 744(t6)
  srl a6, s10, s8
  divuw s3, s10, s5
  mulw tp, s5, s3
  add t1, t1, t1
  slti s11, tp, 1
  mulw t2, tp, s10
  sd t2, -584(t6)
  remu s0, s11, s11
  srli s11, s5, 1
  mulhu s3, s3, s3
  lw s1, -1684(t6)
  mulhsu a7, a5, s11
  divuw a3, s3, a3
  div s2, a7, a3
  mulhu t2, a5, a3
  mulhu s8, s8, a3
  xor s5, a3, s2
  mulw ra, s5, t2
  remu ra, s5, s0
  remuw s1, ra, t2
  sllw gp, a6, gp
  slt s11, a6, s10
  rem s3, s9, s3
  remw s5, s3, s9
  remw s6, a6, gp
  and a4, gp, s5
  div ra, a6, s5
  subw s2, t3, a1
  lh s7, -262(t6)
  sraw s11, s7, s11
  mulhu t4, s2, s2
  rem s3, s11, s2
  srlw a4, a3, t4
  subw a5, s3, a5
  sraw zero, a5, a4
  mulhu s11, zero, a6
  mulw s2, a6, a2
  subw t3, t3, s2
  rem s8, a7, s10
  sll s8, a4, s8
  div a7, a1, s9
  mulhsu s4, a4, s8
  sh a4, -900(t6)
  slli s7, s7, 0
  mulhsu t1, gp, a1
  xori s10, s7, -1
  mulhsu s0, a1, a2
  remu s9, t1, tp
  srliw s9, t3, 1
  slliw s5, s9, 1
  mul s1, s9, a4
  divuw zero, s1, a7
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
.word 0x0ae0285c, 0xebd7572c, 0x188effb2, 0x1581f131, 0xc3af85c1, 0x6d571252, 0x10ee68fa, 0x7b928d4e
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x0c245f28, 0x7e1ca913, 0x44f27a03, 0xd68f20cd, 0x069faf04, 0x0fca7f4c, 0x3509567a, 0x2e16d12e
.word 0xb646b8b9, 0xc04eaf46, 0x1c3c50ba, 0xd1fab115, 0x9459e4c0, 0xf2befffc, 0xfb2d8c58, 0x1786c641
.word 0x15406aa4, 0xd3d88abe, 0x3ceaa0b1, 0x029e04e6, 0x3ca9ff26, 0xcaa0e9dd, 0x0cb2034b, 0x3b1a64d7
.word 0x7fc224ce, 0xeaea9834, 0x539bb530, 0xa23cca16, 0x65b0cac7, 0x78e57905, 0xc89b34b6, 0x282c57ec
.word 0x4816ba0a, 0xe3f4e644, 0x32edfa6a, 0x64b85147, 0x88bb203a, 0xf1996c45, 0xda83b8cd, 0x06ed277b
.word 0x9a4d76d9, 0x6e2bb666, 0x2664c648, 0x0a34495a, 0x163dbe14, 0x465620da, 0x93dfbccd, 0xf4dc9695
.word 0xb9488625, 0x5603758e, 0x6a016cac, 0x0bc3943d, 0x8dad9c40, 0x60200611, 0x554889ca, 0xb5c60146
.word 0xf61276cc, 0xb8341e7a, 0xea1b3d85, 0xd1a2cb06, 0x090af7f7, 0x1dd94d3b, 0x58a9734e, 0x83016f0a
.word 0xd42da0f0, 0x6c31de45, 0x15fb6425, 0x6c5174d1, 0x21e173d9, 0x98fc2cd6, 0xa4979a84, 0x19b3970a
.word 0xa52bd9a7, 0xddba9eb3, 0xdeb6e226, 0xd384e1fa, 0xa7cf51c7, 0x96a1c679, 0xcd71cde0, 0x4d71a75e
.word 0x17fb1bf6, 0x0802f509, 0x318f082c, 0x93672356, 0x6156e64b, 0xf45c3811, 0x6e14f356, 0xf708baf6
.word 0x4a0a5ece, 0xd7643d08, 0xb0f22bc2, 0xf75ead7f, 0x4301b9ef, 0xb4306159, 0xa3da950d, 0x4d80060e
.word 0xa1489823, 0xc19bbec3, 0x74f6c98c, 0xbca011a0, 0x3f68009d, 0xab16a53e, 0x39e898a5, 0xcd3db4dc
.word 0x42785cff, 0xd79c1dd4, 0x23d32424, 0xec495546, 0x04e14fc2, 0x66ad6623, 0xb2e06f6d, 0xe7895cac
.word 0x42d880cc, 0x15961424, 0xab1f70f3, 0xb814efcd, 0xf833de1e, 0xa369b6eb, 0xda984d86, 0x5027e806
.word 0xd0848f63, 0x89399a76, 0x4f5d04fc, 0x61233529, 0xae414122, 0xc555e769, 0x720fbcc3, 0x9e5f5d2a
.word 0x07a143d5, 0xa9a9e81c, 0x57c7b9ed, 0xd2ba6489, 0x52a30dd7, 0x39ee6d25, 0x798da256, 0x1402a274
.word 0x50633739, 0xe3b17493, 0x880be50a, 0xd4cd4ac5, 0x16655521, 0x3ba1b528, 0xfe61c046, 0x2b3e5462
.word 0x9b657e7d, 0xcf9945fb, 0x1a035b07, 0x2d9044f1, 0x597555cc, 0x65c7b9c0, 0x4403252c, 0x42e10c8b
.word 0xc9a7a6bd, 0x2b92a073, 0x06844e5a, 0x99fee253, 0xf3c583e3, 0xc4b94c5e, 0xb330e328, 0x6f81ed3d
.word 0x1e4e78f5, 0xab050ca6, 0xe452f3e8, 0x4b675968, 0xfca7cb3c, 0x36959503, 0x16174fcb, 0x86517555
.word 0x089bc4d6, 0x19e0c696, 0x21247f23, 0xf36d6299, 0xbccd5ec4, 0x3cf30b6c, 0x51df0235, 0xd65468de
.word 0xd82c84f1, 0x653da15c, 0xa395fc7c, 0x90ed8393, 0xe87d3ae0, 0x44388207, 0x6af532f8, 0x3e4c1aca
.word 0x93597dba, 0x6f0e4f63, 0xf747e3f2, 0x76cb6bbe, 0xbdd9d410, 0x00ae84a6, 0x57e0e650, 0xae26194e
.word 0x93ea38a9, 0x502a66e0, 0x3f2aa750, 0xac52b80b, 0x89aed899, 0xc72ccc97, 0x1a67d316, 0xef77d368
.word 0xfa0a3650, 0x7a027165, 0xfc49c382, 0x56b4e45b, 0x9bb213f1, 0x20de09cc, 0x8c4ea282, 0x94361a07
.word 0x3b003472, 0x6d8516c0, 0x110838a5, 0x76cdbe9a, 0xca20dc93, 0x6815bbbb, 0xc07bfb91, 0x2bea1428
.word 0x34345176, 0x702d97bf, 0x7550372b, 0x2046dd76, 0xf42feffe, 0xf9dcfc3b, 0xb5ff450e, 0x04cf5896
.word 0x8f4f0171, 0x51d7b95f, 0x9633f54a, 0x4f068430, 0xf9cadbf0, 0x2b25e460, 0xbbf52b95, 0x918fec15
.word 0x67fcee12, 0x38d57755, 0x04de3574, 0x00bb29cb, 0xd8601e8c, 0x259cf821, 0x975d5006, 0x736eda9a
.word 0x762b398b, 0x594fed10, 0x7be7b0ad, 0x09c7bc8b, 0x71044a1e, 0x335426e7, 0xcd10f530, 0x10410c65
.word 0xaec2be5a, 0xd9c3ad5e, 0x699ed82c, 0x5d85bda6, 0x406ba023, 0xd9f1f8e9, 0x11049673, 0xc095bfa2
.zero 7168
mem_region_end:
