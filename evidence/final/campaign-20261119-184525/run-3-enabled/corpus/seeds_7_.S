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
  li x26, 0x0000000a00640108
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
  li x1, 0x28c357da9b289133
  li x2, 0xeca7e2e1d3e27795
  li x3, 0x76e325668650d4c5
  li x4, 0x1d804a4d6c080544
  li x5, 0x7cba569fe1e0cdef
  li x6, 0x146a54adf32da07a
  li x7, 0xdaa1f310fc76d8e5
  li x8, 0x9003ac6fb6adb328
  li x9, 0x8ddab71fb5fa2ce6
  li x10, 0xab49c05a0fa0fec4
  li x11, 0xc2649fefdb66a651
  li x12, 0x620d7066f4d3ef34
  li x13, 0x2b1a2e6caecfb71f
  li x14, 0xe158858a7b71bca4
  li x15, 0xee412427f0b79dd1
  li x16, 0x9c46a7678524cc21
  li x17, 0xe497067eea2e47cf
  li x18, 0xea725210554fcca8
  li x19, 0x9b2dd5642f212095
  li x20, 0x1da73e6c11f76b03
  li x21, 0xefd3e1c2b6cf51b4
  li x22, 0x20e14fee5f26f623
  li x23, 0xad1cd4d9518f86c3
  li x24, 0x99790ac5d06b2a2b
  li x25, 0x146e3db5247378d2
  li x26, 0x33c2647776ace859
  li x27, 0x51e15268e5831e93
  li x28, 0xa0c454d6586f6269
  li x29, 0x0a93bc23b0760ea1
  li x30, 0xb51990445291502c
  li x31, 0xa2709cbcdac14a7c
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
  mulhu s1, s1, t4
  mulhu t4, t4, t4
  divw s9, s7, s10
  divw s2, a2, gp
  mulw s3, s3, s1
  mulw t3, a2, zero
  rem s10, ra, a2
  divuw s8, s8, s10
  mulw s11, a7, s10
  mul t1, s10, s3
  divu s3, s10, s11
  or a0, a0, s8
  div s6, t1, s3
  remw t4, t1, s6
  sw s11, 1264(t6)
  remuw a5, a0, a5
  divw a3, a5, a0
  divuw a7, s5, a5
  mulw s5, a1, a3
  sd a7, -1688(t6)
  div s5, ra, tp
  sub gp, s5, a6
  divuw a5, a5, t0
  remuw s6, t4, s5
  divw a3, ra, a3
  sb gp, -166(t6)
  lb s2, 394(t6)
  remw a0, a3, gp
  remu t3, s6, a0
  remw s5, a0, s6
  remw s3, s3, s3
  srliw s4, a0, 9
  sra a3, a3, s3
  lui tp, 363316
  sh a6, -1414(t6)
  mulhsu a0, s7, a6
  divuw s8, a0, s1
  auipc t2, 572215
  srliw s11, a3, 0
  divu s1, s2, s8
  srliw s2, a0, 0
  mul s5, s2, s2
  rem a0, t2, s1
  rem s6, s11, s1
  sltu a3, a2, s2
  div t2, a3, a0
  sraw s9, s5, a3
  lw tp, 1004(t6)
  remuw t4, s9, s7
  add gp, t4, t2
  rem t0, s7, a3
  div t3, s4, gp
  sh s2, 1802(t6)
  sraw a7, t0, s10
  remw t2, t2, s9
  mulw s2, a6, ra
  rem s3, a7, s8
  mul s11, s11, s3
  mul s4, t1, a0
  slli a4, s10, 0
  sltu a6, s4, t1
  mul s0, a4, t1
  mul s8, s0, s0
  remuw gp, a4, s8
  srlw sp, t3, s0
  slt t3, s7, s6
  divuw s0, a4, a4
  and a7, a1, sp
  mulhu s11, t4, ra
  xori s3, s2, -1
  divw s10, s10, s2
  srliw s9, s2, 25
  remuw s1, s11, s2
  slli s1, s10, 32
  mulhsu gp, gp, s10
  sub a4, a3, gp
  divuw a1, s1, s4
  addw t4, t4, a1
  mulhsu t3, a4, s7
  mulhu s8, t4, t2
  div gp, gp, s8
  divu s5, t0, a2
  rem s7, s3, s2
  remuw tp, s5, s6
  srli a7, s7, 0
  subw zero, s7, tp
  sllw t3, a3, s5
  srai s2, a1, 1
  mulw t1, t3, t3
  remw tp, a0, t1
  srliw s7, s7, 21
  rem tp, tp, a2
  remu t4, t4, s6
  srli s0, a2, 61
  remu a0, s4, a0
  slliw t3, a0, 17
  mulw a3, a7, t3
  srli t1, a6, 54
  slliw s11, s6, 31
  divu t2, s11, s6
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
.word 0xa1eede5b, 0x7cf07755, 0xbce081df, 0x5c593684, 0x381d571b, 0x0149568b, 0x4736328c, 0xaa834c6a
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x8505dc84, 0x7dba4f7b, 0x2235aff8, 0xc82013da, 0x512fe361, 0xc8640794, 0xb39aaf3d, 0x3b0bd089
.word 0xc8f8b3ec, 0xd6b767d3, 0x6d742f01, 0x44dfb8ac, 0x1e7c53d3, 0x7129fe2d, 0x3829ea77, 0xf7835df8
.word 0x887505ea, 0x363d0069, 0x619fb3fc, 0xea6561db, 0x30969d95, 0x9e536832, 0x76b290fc, 0xf253d124
.word 0x139a8e1e, 0xf642608d, 0xa3dad96e, 0x765f7f81, 0xa4fee737, 0x9ddfba95, 0xd03d34e0, 0xf9573d99
.word 0xc94786b6, 0x2a6ccadd, 0x0011a0b9, 0xfc129b5f, 0x1eca8ef3, 0xe65ca000, 0x453f19ae, 0x1181a6c1
.word 0x0e902849, 0xd9745d5c, 0x106f0951, 0xc22540f6, 0xba6b29a7, 0x454200ef, 0x0f285cbc, 0xb43ae5dd
.word 0x14bfd466, 0xf2fd6d93, 0xb2f93cbe, 0x6df8f717, 0xd138de8a, 0x8ffe9a30, 0xddabbdaa, 0x612dc3af
.word 0x50adf72c, 0x383c68c0, 0x01610bb8, 0xa19d9071, 0xa2cba3eb, 0x321eeea0, 0xc2fcf7b3, 0x2f21f892
.word 0x6e21e45d, 0xef32b11d, 0x71821596, 0xa804b3c2, 0x278905fc, 0x63b9c4b0, 0x87806e45, 0x182bb8f2
.word 0x555b5184, 0x4f0d22b3, 0x98cc3227, 0x454b950c, 0x61f286b4, 0x4a355c17, 0xae82081f, 0xe24a3a12
.word 0x6813d653, 0x61d378f5, 0x42e53513, 0xf637aaa1, 0xdfe49aa8, 0x9eb4d61f, 0x92cb8b47, 0x4cb63275
.word 0x1fa6c3da, 0x1186fb49, 0xe28bc5e3, 0x403f2868, 0xaa1d37c2, 0x728e2457, 0x9a2ae412, 0x28a80735
.word 0x5c249922, 0xd89cc2af, 0x4e51e109, 0xf44bc8a3, 0x564b93fd, 0x936d3b80, 0xf1cdacf7, 0x47727128
.word 0x1e08abab, 0xadcfce73, 0xbc0ea987, 0x37aab48a, 0x9ac299da, 0x6db5b9ea, 0xa9e44bc1, 0x4c5310db
.word 0x349415e2, 0x9eaa239f, 0x7562edce, 0x158a57d0, 0x26e28c1d, 0x9afe51d4, 0x4461ab63, 0x95e02973
.word 0x03f7bf3a, 0x120fe6d9, 0x84f9945e, 0xd8d6f364, 0x8edaf1b8, 0x9f47d988, 0x95b451e0, 0xeef073f1
.word 0x289d5d15, 0x911f6358, 0x448367a6, 0xebd6e441, 0x9f99cf4e, 0x93256e04, 0x6fd6c3ef, 0x40371070
.word 0xffd39f1e, 0xb9222f92, 0x92db9e0c, 0xc82b2603, 0x0f9cc481, 0x3885e1aa, 0x043350cf, 0x16e0a093
.word 0xfbeef748, 0xce2bee93, 0xd2fc5026, 0x181c3dcc, 0xf5245e53, 0x83fe9a73, 0x6771f871, 0x4c97c3ef
.word 0x21a4cc15, 0x071af931, 0xa72f9c37, 0x3a11c0e8, 0x7402d965, 0x72ae1a30, 0x4483d92e, 0x9bb15a72
.word 0x8f3748a9, 0xbf1a0e7c, 0x7698e7d4, 0xdbc11c3d, 0x85cf7600, 0x0486d27c, 0x9818c0b9, 0x23ba884e
.word 0x7020b5de, 0xf043c5e7, 0x2de53d55, 0x1732aeaa, 0x544d7426, 0xf03542cb, 0x8ea7034d, 0x7dd5cd88
.word 0x0f1f5390, 0x0c236cc3, 0x1f627f28, 0x99e3cbd6, 0x2aa979e9, 0x31a5ed6e, 0x80da1b83, 0x59176882
.word 0x8182202f, 0x1f2d4c82, 0x3ecae4cd, 0xe9af90ad, 0xe5f816e9, 0x44fdd4fe, 0xbcd98481, 0x2602927b
.word 0x0dcd6e33, 0x13b1d384, 0x6ff43a78, 0x05cacafe, 0x36ee3dec, 0x14021404, 0x99c2bdbd, 0xdc6f59ed
.word 0xf088df25, 0x2d2f00ae, 0x7cb6c9cf, 0x4a9db4c7, 0x88c47ca7, 0x92e713eb, 0x82e8abf0, 0x35c54593
.word 0x7f5e5a46, 0x95939f27, 0x6bbeac34, 0x1dbd29c6, 0x0790a25e, 0x88ee4292, 0x4ed4edf7, 0x8eab2706
.word 0xbb7364da, 0xc7c04ffb, 0x2f10b317, 0x7307388a, 0x376503e4, 0x19d8903e, 0x2d2ab29b, 0x8d259872
.word 0x95b29c1c, 0x552bb13c, 0x886d3b97, 0xd977d7c8, 0x51398c5d, 0xc0cb6bc3, 0x6e0b237c, 0x3082b4ff
.word 0x0fc1944b, 0x3b8e3674, 0xdc11ccb7, 0x2966f9fa, 0x5165e1f3, 0xe7a67d27, 0x415fe969, 0x63a4a55a
.word 0x39e5fd1c, 0xf9552540, 0xaddd71e2, 0xf94b71e9, 0x77af85d6, 0x9e442fec, 0x6b9849e3, 0xb3fbd0e8
.word 0x7e48fbb9, 0x234094f4, 0x55fa78ca, 0x1ffbb4ee, 0x3730fe6c, 0xe0ca3960, 0x2467a3a9, 0x134d758e
.zero 7168
mem_region_end:
