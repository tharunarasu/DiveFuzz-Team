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
  li x26, 0x0000000a00043982
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
  li x1, 0x9a085d1103bf3de2
  li x2, 0xe6d8d616a987c332
  li x3, 0xa24e82acdd8ca711
  li x4, 0x898169dac350578a
  li x5, 0x753bf357eb6429a6
  li x6, 0x6411f693e7d2a18d
  li x7, 0x657c3b191eaf0308
  li x8, 0xa36b57718c1213ce
  li x9, 0xe26881664912900e
  li x10, 0x3d5a584c03cc3447
  li x11, 0x1f249a0c2635bd62
  li x12, 0xadee37036b3f29b7
  li x13, 0xa98fc2ef1e7c164a
  li x14, 0x6dfc74227a48fc3d
  li x15, 0x2fb55566140629da
  li x16, 0xfcebc81610d6d7f9
  li x17, 0x27c8d75af22a90e1
  li x18, 0x5f59c589a7af51c2
  li x19, 0x458fd6515b416330
  li x20, 0xe604822dafc42576
  li x21, 0x1be36f229e805af9
  li x22, 0x712799486ab95124
  li x23, 0xa491ce75f4b05f9d
  li x24, 0x031161b3fd006808
  li x25, 0x1d630300a8a0ba07
  li x26, 0xc98374f8e669d452
  li x27, 0x89cf3b37e08703c2
  li x28, 0xad1295a706db41fc
  li x29, 0x7aeda2ac2ab5507b
  li x30, 0x80bc11e31e3040af
  li x31, 0xc824bfee697fbcb1
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
  div t3, t3, t3
  lwu a1, 1556(t6)
  remuw s9, s9, t3
  fence.i
  divuw s5, t0, s5
  fence.i
  fence.i
  ld s8, -1264(t6)
  sraiw a0, s9, 0
  lw t1, 436(t6)
  slti s0, t1, -1919
  sltu sp, a0, s0
  divuw s8, s0, a0
  or s6, s3, s8
  divu a0, s4, t1
  divuw a4, a0, s0
  sll s1, s6, a4
  fence.i
  lwu a7, -1432(t6)
  divw s9, a2, a7
  remu s8, a7, s9
  divw t1, t4, s9
  mul t3, a7, s1
  divw t2, s4, a7
  mulhsu s4, s8, s8
  div a0, a0, t3
  srliw a3, t2, 1
  srliw s6, a7, 8
  srlw t0, a3, a3
  divu s8, a3, a0
  nop
  slliw a2, s8, 0
  fence.i
  mulhsu tp, t1, s6
  remuw gp, s8, s8
  fence.i
  sraw s2, s8, tp
  addi a1, gp, -1
  mulw gp, tp, tp
  sra t4, a5, gp
  mulw a7, gp, a1
  fence.i
  remuw s9, t4, t4
  rem a4, t4, s9
  andi a3, t3, 1954
  sraiw s3, a7, 31
  sraw s7, a7, s3
  mulw s11, s9, s11
  lwu zero, 324(t6)
  slti a5, s7, -1
  remuw s8, a0, a7
  ori s5, a5, 1181
  remuw s3, s3, s3
  remuw t1, s8, zero
  sltiu a6, s3, 1259
  ld s0, 160(t6)
  divw a7, a7, t4
  mulhsu zero, a6, s3
  srlw t0, a7, a7
  fence.i
  divw a4, a7, t0
  divuw a1, a6, a1
  slli a2, s8, 63
  lb s3, 760(t6)
  fence.i
  remuw s0, gp, a2
  lbu t1, 1589(t6)
  fence.i
  remw s6, a2, a2
  mulw s10, t1, t1
  divw a3, s6, s6
  srai s11, s10, 21
  lb a1, -1023(t6)
  lui s2, 1
  divuw zero, s10, a3
  remw t2, s11, t4
  mul s10, a3, zero
  remuw s7, zero, s11
  xor t4, s10, t4
  rem s0, s10, s10
  fence.i
  divw a7, s4, t4
  slliw s11, s9, 1
  divuw sp, a7, a7
  rem s8, s0, s11
  fence.i
  slli s2, s0, 3
  or a1, s2, t4
  fence.i
  fence.i
  sllw a1, s11, s11
  divuw a0, s8, s11
  fence.i
  mul t2, s2, a0
  remuw s11, s8, s11
  fence.i
  fence.i
  mulhsu s1, a0, t2
  remuw zero, s1, a6
  divuw sp, s1, t2
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
.word 0xd300ef39, 0x1db3dee8, 0x0950f336, 0xbce1c906, 0xdb873505, 0x4cfc0d58, 0xbbc1510a, 0x4afc7643
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0xc0fc76c2, 0x85ca2d84, 0x217d49bb, 0x7a5264e7, 0xe76c72ca, 0xaefa0b47, 0xccd0f89a, 0xd3f5f227
.word 0xa45be254, 0xba655e33, 0x64383b8e, 0x87a36c4f, 0x0155001b, 0xea5b4c8c, 0xb6817a47, 0xb8afb15c
.word 0xfa03a4b5, 0x62893a82, 0x3e974305, 0x3b811fae, 0x7bf8ff81, 0x58d16ed7, 0x5b59e216, 0x7e0e92ff
.word 0xb2c10e80, 0xb868701a, 0x056d0b18, 0x41d75803, 0x2acede42, 0xd523dcc3, 0x47d0735d, 0x0bc0804e
.word 0xad4b9916, 0x356537ec, 0x99e9adcd, 0xaa0ee1a3, 0x3304dfe6, 0x3ce4f1a1, 0x72ba470b, 0x86abaf87
.word 0xb1ab59ee, 0xd38780a6, 0x5ec86e3b, 0xeaeceb0f, 0xd44db97c, 0x5bb0ae2f, 0x456d5bdd, 0x73be6b2b
.word 0x3d91c5f7, 0xd08c9499, 0xe72c742e, 0x83a1f729, 0x89706f63, 0x0df00f0a, 0x69c982ad, 0xb76a941e
.word 0x2955fbad, 0xdc4d0522, 0xbdde11ee, 0xcf6790b5, 0xba20e6e3, 0x11ea1675, 0xb33fb1b9, 0xc1c29de7
.word 0xc80e1ac3, 0xfa35a803, 0xcf2b78a4, 0xa97b3fcd, 0x5b854f41, 0xb2d32eea, 0xe701b283, 0x888c1038
.word 0x86447fc5, 0xc42abe2b, 0x1e54e3e8, 0x00494342, 0xd8cefd7c, 0x6d70fb5d, 0x6218bc95, 0x00cabc7a
.word 0x44cf8062, 0x33b2e596, 0x0476ecda, 0x587b31e8, 0x00c5ae9a, 0x4f38b6bc, 0x67493562, 0xc5767930
.word 0x74f0b3a6, 0x876db8d3, 0x364c8c52, 0xbb8cf33c, 0x8532d3fd, 0x1829e777, 0x958ba1b4, 0x57e46472
.word 0xd3da77bd, 0x658990f7, 0x89f7df30, 0xe6eaf773, 0x12b31b49, 0xbe7343cd, 0x5b636c59, 0xf01511fe
.word 0xdbd3b63f, 0xd54d15c1, 0x442564be, 0xc1468e37, 0x8cbc004b, 0x0f0930be, 0xba6d7c89, 0xff8e9643
.word 0x532b5704, 0x894583da, 0x1197aa5e, 0x9aa5c866, 0x523ed1cf, 0x8716d4fb, 0xb61cd251, 0x50026de2
.word 0xbe4419a8, 0x8f1bf51a, 0x08bf50f6, 0x98af87d2, 0xe95e28ef, 0x0961b6d5, 0xa1ba3425, 0x91a20919
.word 0x4dfdf51d, 0xef89a0a3, 0x04e19f29, 0x5eea655f, 0x2f064d21, 0xb6858302, 0x64ab8dff, 0x4aab8342
.word 0x18dace25, 0xfd5d99de, 0x8c785780, 0xc2e8b284, 0xfa40c42d, 0x54b4ccfa, 0xc7e80dc5, 0xd71cd263
.word 0x9a5b1319, 0x47c3a024, 0xaed01c80, 0x755bd0a1, 0x05218ff8, 0xbd316b80, 0x0fe976c8, 0x8cec087c
.word 0x105390ab, 0xbf6aefb2, 0xbd049a3b, 0x5ea6af1a, 0x6e3bea4a, 0x0f05a6c5, 0x393ea9d2, 0x53a3b4b3
.word 0xe1a6bcd8, 0x9fe37d00, 0x254ea0fc, 0xeb855ff2, 0xe577eb61, 0x88d07316, 0x0f591e78, 0xc69763cf
.word 0x236dfd94, 0x393952e5, 0x353b76ae, 0x9872e21b, 0xe0cf7ed7, 0x1aa8e41b, 0x7709dc78, 0x4119250e
.word 0x0cc812f8, 0x534931fa, 0x4cc82923, 0x69b872b9, 0x2b15d13d, 0x497d65cb, 0x7c812f79, 0xdbe8b9d1
.word 0xc11cc99c, 0xc29d3207, 0x06f2a6fe, 0x54127a61, 0x6b8094db, 0xf92e32f1, 0xd169997f, 0xe3009be8
.word 0x6d3ba0a7, 0xe1afe7bc, 0x2868984f, 0x042f274c, 0xb9cc018d, 0x6d8b898d, 0xb77b7529, 0x7d2825e9
.word 0xc4f4268c, 0x5224de90, 0x926b52de, 0x30b04d5c, 0x18cb1be5, 0xcd83a135, 0x6ae501ec, 0x5e01d2c6
.word 0x5b326661, 0xeef49d5a, 0xd0556055, 0xd2036428, 0xcbcdc914, 0x8b3068b6, 0x40aec324, 0x2b029a7b
.word 0x4906ad08, 0xbb064635, 0x1095e22b, 0x6e30fec6, 0x80ce2be6, 0x71939481, 0xe4b4bc66, 0x06e2a2a1
.word 0xee2045ea, 0x6e34272a, 0xf4967df0, 0xc9d57e03, 0x026de9cc, 0xa08f30b5, 0x93877cbf, 0x0dc0a2cb
.word 0x0b05ca22, 0x59d2df93, 0xfde1d928, 0x24284f62, 0xc2c47743, 0x01f624eb, 0x911ee9ff, 0xce120119
.word 0xfb4b3605, 0x2b45c77f, 0x015d9c60, 0x1c0e8889, 0x351f71db, 0x1a76617c, 0x2846409d, 0x59c282a7
.word 0xf83a7b07, 0x2e500239, 0xc9aeec02, 0x4695d825, 0x8b7a7d23, 0xfcdbb25b, 0x5db8bc01, 0x2f9358ea
.zero 7168
mem_region_end:
