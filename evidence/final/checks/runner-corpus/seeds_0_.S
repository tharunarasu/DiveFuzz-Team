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
  li x26, 0x0000000a006c41a8
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
  li x1, 0x765715635f7b8aa1
  li x2, 0xfd8f7e14051f4c30
  li x3, 0x5eb8239bc1cba261
  li x4, 0x228b953436b5b4a9
  li x5, 0xc6d215e774e5cff2
  li x6, 0x007699b7acecda4d
  li x7, 0x22794a1e777df80d
  li x8, 0x30c88331f3a3461c
  li x9, 0x5eb3d61f64e082ca
  li x10, 0xf194ddc45bb4f9cf
  li x11, 0xc80f241f1a6cc36e
  li x12, 0xa962667b0761a917
  li x13, 0x378a0bd51e465c78
  li x14, 0xc6e69072926507e9
  li x15, 0x27015a681d889543
  li x16, 0x473e47057fc55a3a
  li x17, 0x95735ecf2664089d
  li x18, 0xbe48bf55cb56254e
  li x19, 0x3028ecde092f37ba
  li x20, 0x07149b9ec6ab386a
  li x21, 0x570fc085ef45ae76
  li x22, 0x60700f46f27c35e1
  li x23, 0xf34d161e775a18b4
  li x24, 0x98e68037cf706256
  li x25, 0x6a8fb6652bbcb3f1
  li x26, 0x65586665f59c752b
  li x27, 0xdab405fff9f77d68
  li x28, 0xfb7bd81cb824ddbf
  li x29, 0x139e5f94f7f0cf06
  li x30, 0x7b3f57de9fd3b7df
  li x31, 0x8cc4d748f8c153f7
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
  lhu s11, 562(t6)
  div gp, s11, s11
  fence.i
  div s6, s11, gp
  srliw s3, s6, 7
  remw sp, s3, gp
  remuw a5, a5, sp
  addiw s5, ra, -1
  mulhsu s0, a5, t3
  mulw s9, t2, s0
  divw s7, a5, a5
  lbu t2, -101(t6)
  slli s9, s0, 1
  remuw sp, s5, s9
  remw a2, a2, s8
  divw s4, sp, t2
  rem s0, s9, s0
  auipc s1, 310228
  remw a3, s0, sp
  sltu a0, a3, s1
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
.word 0x62c37909, 0x2e7a1a17, 0x14c336b2, 0xd94e5f3c, 0x3537fa29, 0x8292a019, 0xdd92b2b4, 0x3bf2747c
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0xd787d498, 0x68d232ba, 0x624a5151, 0x6526ed27, 0xb6b21241, 0xc8ded09a, 0xe69eae42, 0x64d5aa29
.word 0x595e4682, 0x0665e00a, 0x44772508, 0xfd6fc44c, 0xfc1add53, 0x12894840, 0x5e6d080f, 0x5b40c8bc
.word 0xecbccc7b, 0x7087d6c3, 0x40f9b420, 0x44a05ef8, 0xf66e2e3c, 0xa5e6512d, 0x09a510fd, 0x069f1abc
.word 0x5a7f5824, 0xf803bd74, 0x703ffced, 0x7ad97240, 0x0dd245e5, 0xc7b9f68a, 0xd00e6aeb, 0xcde2ffd1
.word 0xf0b1df4a, 0x3631d897, 0x6968ccf2, 0x161101bf, 0xb1d52d29, 0x84278e6c, 0x439c6045, 0x0ca2b1eb
.word 0x4e4c90a9, 0x368ae16c, 0xab44f9cb, 0x8c2f7ee5, 0x83830cfa, 0xbdb40990, 0x19d93e66, 0x1f55b3a4
.word 0xfd6578a9, 0x04541672, 0xfd4c41a5, 0x2d3186fe, 0x9c86a365, 0x58ac6b39, 0xec83113f, 0xb7d0972d
.word 0x55c88f88, 0x4a77a93b, 0x6e2880e8, 0x89c1fe91, 0xa2febb06, 0xcf376b52, 0x13192a43, 0x215a4a8a
.word 0x0b7b44ae, 0xe498f6d6, 0x833fc5b7, 0x83dd2e4b, 0x320a2ef0, 0x4d9e0168, 0xc042a062, 0x0380a826
.word 0xa22ffd72, 0xcd391e5c, 0x68709bee, 0x17379e15, 0x7c954f5c, 0x9c9d84a2, 0xb0d43106, 0x371d38fb
.word 0x20d91a85, 0x847bd506, 0xc635d191, 0x89c3fd61, 0xd5207d86, 0xfe424dbb, 0x346864a5, 0x0033b1ef
.word 0x21aaa706, 0x849f903f, 0xc0d353a7, 0xed476c35, 0xa8905811, 0xcbb52be6, 0xcbdfb83d, 0x970aa39d
.word 0xffb97a76, 0xb97b4a58, 0xb771b54e, 0x1288b083, 0xecb09ba3, 0xf9c5eae4, 0x34ef262e, 0x4ea3cbdb
.word 0x66ca8693, 0xec39ff67, 0xe335a2c0, 0x43e63f73, 0xb67e9a69, 0x20a12acc, 0xa48e6b1e, 0xddec8b19
.word 0x654fcd71, 0x407d0502, 0x3bd5b42f, 0xc77b12f7, 0xdd8875d3, 0x6da93b3c, 0x0c312b31, 0x2b22462d
.word 0xe5d4367b, 0x1df9e330, 0xd65d1c95, 0xcd2cdc81, 0xf1898514, 0x6e4463ce, 0x095af586, 0xff8b13cc
.word 0x8a1cb994, 0xbad58cbb, 0xb96cb40a, 0x06067f0f, 0x67849c4b, 0xba7b8fb5, 0xf38edb64, 0x7ef06afb
.word 0xab7d3405, 0x9a3ebbdc, 0xd5fdb74c, 0xcd72ef3e, 0x0ae159fa, 0x6703e17e, 0xf3630c40, 0x95aefb11
.word 0x2d3184d6, 0x57cbfbba, 0x5005c8d0, 0x88b15eb9, 0x61b223b3, 0x2300cb94, 0xc27fcc49, 0x26e0a88e
.word 0x181c1e4d, 0x035d413f, 0x705309c8, 0x85259f7d, 0xdb47c858, 0x6145be91, 0x950d2500, 0xb542926a
.word 0x5260afbf, 0x65d0d493, 0x90822184, 0x752f3000, 0x286dc07c, 0xed8a04d3, 0x155abd21, 0xf647dfa8
.word 0x72c852f3, 0x8d54cb97, 0x3e898479, 0xa4fc5cfb, 0x8e8e1ebc, 0xf5d33d60, 0x1d32869c, 0x7f2054c1
.word 0x2bfc8cb4, 0x665a803f, 0xb30696a3, 0x19d9d4ff, 0xca6e9eca, 0xccbda74f, 0x231544b4, 0x8e112591
.word 0xd4c610aa, 0x0af92532, 0xc319f970, 0x0dfbbc46, 0xb22c2fad, 0xf72f9171, 0x8da5cf06, 0xee76e661
.word 0x1ca7d9f7, 0xab50353b, 0x4ab30327, 0xa384f674, 0x06cd0657, 0x0262c186, 0xdcdae2aa, 0x9420f2a2
.word 0xdac8feeb, 0x0eaef328, 0x12396a99, 0x7f582e9b, 0xdde150fb, 0x717587a8, 0x3b5bd6fc, 0x9147fbb9
.word 0xf6a978a5, 0x63f564d2, 0xb18c9d35, 0x257664b3, 0x5bfa7694, 0x9cf29d49, 0x7ff3c761, 0xc872aa4a
.word 0xa2d241ad, 0x8ba35317, 0x7e0e417c, 0x6ccea678, 0x8f7df29e, 0x9e0138c5, 0xce8b91cf, 0x6d859b4a
.word 0x1259ea4c, 0xf4b1c73b, 0x5bae4581, 0x9d3a51f2, 0xf0d7e889, 0x6837116d, 0xae398e0a, 0xb62df705
.word 0x747835aa, 0xa0e2a9e0, 0x001d8fce, 0xda4e538a, 0xcb43b16f, 0xce785ce1, 0x58b64fc7, 0xf5685f63
.word 0x7f7eaf39, 0x5934c5dc, 0x3b6c4797, 0x5befeb5a, 0x2f7cb222, 0x96de2e37, 0xf75752e6, 0xdca28676
.word 0x483036f5, 0x240372a6, 0xd14ff005, 0x013f5eb3, 0x197d5375, 0xc9d2399f, 0xcdd8aeea, 0xdbeace46
.zero 7168
mem_region_end:
