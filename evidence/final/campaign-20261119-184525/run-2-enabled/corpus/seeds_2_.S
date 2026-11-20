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
  li x26, 0x0000000a001c18a2
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
  li x1, 0x9dd4bc9662c75922
  li x2, 0x81e69c9b291339d9
  li x3, 0xf621aa2566de3c18
  li x4, 0x77aad0d794393266
  li x5, 0x10ffcc2a59730b89
  li x6, 0x5d956b120738d288
  li x7, 0x75feabafa75f9dc7
  li x8, 0x563da2bd928bbe5a
  li x9, 0xf3e71d03470481f5
  li x10, 0x83acc7636c8352fb
  li x11, 0x8143492d121bee7b
  li x12, 0x560d59c8d34fb6bf
  li x13, 0xee5f60466df7e23d
  li x14, 0x972718018bab2878
  li x15, 0x00fdee33a32e8bb0
  li x16, 0xd855dff215602a98
  li x17, 0x42a4ae715204cdb3
  li x18, 0x0b2e0b327c7af62d
  li x19, 0xeb6af0fe1a50b071
  li x20, 0xddfba3c1277cff03
  li x21, 0xcc1533221ef9b300
  li x22, 0x3e8c50884cfcc4e0
  li x23, 0x823893a17faaacfa
  li x24, 0x84cc63b203cd5179
  li x25, 0x341088c98ce0446f
  li x26, 0x098ccde0a27be919
  li x27, 0x446a4ee5a789f824
  li x28, 0xb24c8c857356c489
  li x29, 0x111efd0fc087424c
  li x30, 0xe6c0b2d509f52a87
  li x31, 0x92fcf77bc67ae2d5
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
  rem s9, s9, s9
  divu s0, s3, sp
  slliw s2, t0, 1
  sllw t0, s3, t0
  srlw s4, s9, s0
  divw a5, s2, s4
  remu s11, t2, s4
  divu t2, t2, s11
  mulw a2, s1, a6
  slliw s6, s1, 19
  remu t4, s11, s11
  divuw a6, a2, s6
  and zero, t4, a6
  sw zero, 24(t6)
  divw s8, a2, zero
  sd a2, -1216(t6)
  sraw s10, t0, s6
  srliw s6, s6, 0
  mul a4, s8, zero
  divuw s9, s10, sp
  sraw s0, t2, t2
  divuw sp, s6, sp
  div s8, a3, s6
  mulhu s0, s2, s0
  sb s8, 1391(t6)
  sub tp, s8, s8
  sraiw s10, s0, 31
  divuw a2, tp, s8
  mulw a0, s1, s11
  mulw zero, a0, a0
  and t0, zero, s1
  srlw a6, a6, a0
  sltiu a0, a4, 2047
  mul t4, s7, a4
  sllw a2, a2, s8
  addi a5, a6, 1224
  mulw sp, a5, t4
  sll a1, zero, a5
  rem sp, s11, a4
  divw s8, sp, t4
  remu s1, t4, s8
  mulw a1, sp, sp
  mul gp, gp, s8
  remu s10, a1, s10
  sll a5, t2, gp
  mulw s6, gp, gp
  subw s0, t2, s10
  mulhsu t3, a2, s0
  srlw s7, s2, s10
  rem sp, t4, a0
  srli s6, a6, 63
  mul ra, s7, s7
  divw gp, s6, gp
  mulw s5, sp, ra
  addi t4, ra, -1
  slliw t0, s2, 21
  remuw s8, s11, zero
  sraiw t1, t1, 29
  slli a5, s4, 46
  mulhsu s1, s11, t1
  mul a0, a4, a0
  remuw a0, s0, zero
  subw s1, zero, a5
  sraw a6, s9, s9
  remuw s10, a6, a0
  mulw s2, s5, s2
  andi tp, a6, 2047
  mulw zero, s9, tp
  srlw s0, s0, tp
  slli s4, s9, 19
  lui s1, 0
  mulhsu s2, a7, s4
  divu a2, t3, s0
  srl zero, s0, zero
  div s5, zero, t2
  divuw a5, t2, a0
  remw sp, t2, zero
  or a0, a0, s5
  divuw a5, s5, a0
  divw s5, s5, s9
  sraw a0, tp, s7
  slliw t4, s9, 1
  sllw t1, t1, t1
  mulw s1, sp, s1
  slliw s3, s2, 9
  remw s10, a3, a3
  remuw a1, s3, s7
  srl a6, s3, a1
  slliw a3, a6, 0
  sb s8, -1244(t6)
  sll s11, a1, s10
  rem a4, t0, s8
  lw s4, -1712(t6)
  and s6, s11, a4
  subw t1, a4, s6
  divw a0, t1, a7
  remw a4, a4, t1
  divw s2, a0, s2
  divu s5, a0, t1
  div a6, s5, s9
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
.word 0x7f90af1c, 0xd77596bf, 0x68826bdf, 0xe339a768, 0xa200d7e5, 0xb1b6cd67, 0xe40281bd, 0xfb1a4ec7
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0xcd41dabc, 0x89b46255, 0xe8f2298f, 0x1bbe9a0c, 0x1ef0d934, 0xccc1ea2e, 0x79daeb3f, 0xa8128c36
.word 0xdf721e52, 0xa206ddb8, 0x5adab225, 0xa1eaa86b, 0x680e90dc, 0xcb9ede97, 0x16d160f8, 0x5a2f04aa
.word 0xa132a84e, 0x0becc79c, 0x06508b52, 0xd7eef0ea, 0xcd695c96, 0xebd8cabd, 0x1689f744, 0x077e93f2
.word 0xa88862a2, 0x637ca3cf, 0x4817cc6c, 0xf7c0c887, 0x25daaa48, 0x5ed7b4b2, 0x38f2b9bf, 0xe87e3c53
.word 0x94c6f1c8, 0xd7fef582, 0x5dd7acd7, 0x9a803a68, 0xd23f9306, 0xbcae5a5d, 0x040e9d36, 0xe51fea9c
.word 0xbf86f650, 0xd4a93e53, 0xa5868e6e, 0x3018bdf5, 0xfba452d9, 0x29a18901, 0xa522ba0d, 0x2ca77161
.word 0xa6846e2a, 0xb5a253ec, 0x269ef73a, 0x353ae5a0, 0xfa415b4c, 0x195ce877, 0x06fcf076, 0xb03f6450
.word 0xbb69a30e, 0x2f08e297, 0xc26b5ba0, 0xa7466e38, 0x83df377a, 0x445b01c2, 0x6cce7d76, 0x61c62928
.word 0x5a90b466, 0x3c60c4aa, 0xf60d1610, 0x43e82c67, 0x8a029d28, 0x9fd40306, 0x3319e081, 0x7e46d5b6
.word 0x0d1e9e95, 0x8ab34eb4, 0x1c65ca70, 0x5cd78fb9, 0xaf9d821c, 0xea663207, 0xc71a1674, 0x26461a0a
.word 0xe3a6f8c9, 0x6122e63b, 0x8e1c8f4b, 0x7532bfc4, 0x9057c871, 0x40ab0797, 0xed30e5d7, 0x29417359
.word 0xd5ee9cd2, 0x467e8b33, 0x7168a276, 0xb4a1c1e8, 0x3f2415a7, 0x40b7fa2e, 0xe753ee18, 0x537f1117
.word 0x652b7cce, 0xe7537478, 0xf055958b, 0x99b4c395, 0x4e0d025b, 0x7d51cc50, 0x05a5e682, 0xbabec020
.word 0xd73bd148, 0xd218881b, 0x44bcf5db, 0xc965c368, 0xe89eab94, 0x907a647c, 0xd586bdf7, 0xe45747a9
.word 0xe33d5af1, 0xb4f25550, 0x004c45b2, 0x3ecfedc8, 0x82ec62e7, 0x23fc5682, 0x7816eea2, 0x96a65afd
.word 0xc6971fdf, 0x237570f8, 0x097f4d1a, 0x9880c568, 0x205596ae, 0x4d73ee40, 0x83b71ec4, 0xc7a1406f
.word 0xe1160451, 0x68fdf3bc, 0x4a22bb7c, 0x7df97769, 0xa719de90, 0x27350b89, 0x2f5c256f, 0x7cef99b8
.word 0xd968cb6b, 0x757272c7, 0xb63210a1, 0x6a1546d8, 0x4bbf16db, 0xdf1eb18c, 0x4e33bd39, 0x9dc4165a
.word 0xa561214e, 0x4219b8e2, 0xdf12ba75, 0x8358f785, 0x724cfa6d, 0x04fa09d5, 0x98dba5f1, 0x21b49e7f
.word 0xf145c353, 0xf42e56ba, 0x520ec82d, 0x09c11559, 0x848de740, 0x29edb7a9, 0x29ad6897, 0x901f80da
.word 0x3cc76991, 0xf07cb200, 0x55cd0644, 0xfd1e2062, 0x59c64b33, 0xcb5a47bc, 0x61a7c03d, 0xd660f468
.word 0x050fc445, 0xcbdd20d1, 0xe1e48b77, 0x869fb008, 0x094ae54d, 0xef4843ba, 0x5e24863b, 0x2278c2b7
.word 0x52307ef0, 0x8b6df063, 0xbd7d192c, 0x0f1686df, 0xef5a748a, 0x43d6b4b4, 0xb25f1837, 0xa4963c3a
.word 0xa74ee386, 0xac3a708d, 0x73d46e58, 0x2d6c8612, 0xba1f162a, 0xcf25e96c, 0x6c90a8b1, 0x05040880
.word 0xed5f3b86, 0xd0b96658, 0x397ee907, 0x213ecfb7, 0x412548ab, 0x9ed46a01, 0x08e63241, 0xae0508e1
.word 0xbf153fc3, 0x009ea434, 0x399c8579, 0x3c2132f2, 0xe0f31250, 0x370023ff, 0x8c6abbd6, 0x74216a70
.word 0x92a5711e, 0xf87395e5, 0x4c02f963, 0xc91418a7, 0x8234c76d, 0xafc5c9b7, 0x5ae92487, 0xafff7b82
.word 0x286575bd, 0xe9b5d635, 0x8f739158, 0x3943fa4c, 0xb0c83cea, 0xa2ddc0d6, 0x79eeee24, 0xe97481f3
.word 0xe9230cca, 0xda4e9976, 0x95a05025, 0x8bc2ba50, 0x01f12063, 0x1f1cf911, 0x34719690, 0xfff4fb37
.word 0x44973b7d, 0xe807d33d, 0xb66ca757, 0x0afedf6c, 0x9fecae1a, 0xadb2cc2c, 0x4122364b, 0xca522b57
.word 0x4dea24f3, 0xe338abf5, 0xc6e35c35, 0xcadd072e, 0xc80f1049, 0x0871d039, 0xa1b87e87, 0x6f33874b
.word 0x6fe058bc, 0x5e60616e, 0xad0da70a, 0x3cf97a83, 0xe2cb1ebc, 0xc566879c, 0xabdb4c32, 0x8eea16b8
.zero 7168
mem_region_end:
