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
  li x26, 0x0000000a00187800
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
  li x1, 0xa3684e156f31cee6
  li x2, 0x08b99cf2873759f6
  li x3, 0xc599302a7579b9dc
  li x4, 0x9ab09a71a3917eb0
  li x5, 0x05d2bba6c417d4d2
  li x6, 0xbfd529d31437dd15
  li x7, 0x39ff44bd2a2721de
  li x8, 0xf1a8727133b8813a
  li x9, 0xada6d46b6e134fef
  li x10, 0x9d802ba4968dd8ba
  li x11, 0x9c3ddaa7567cc54a
  li x12, 0x3192756ef4cd626b
  li x13, 0x53550dff793d0ca8
  li x14, 0x4b15a42f73c41d3c
  li x15, 0x0819ad854a18d813
  li x16, 0x66653b549554c055
  li x17, 0xee37fcf828f94014
  li x18, 0x5d02f3ca39f275b2
  li x19, 0xdae8461a51b324c8
  li x20, 0xf7fcf8109c323621
  li x21, 0xb6085223e3213810
  li x22, 0x5737da8c74718889
  li x23, 0x1137fe6643293e59
  li x24, 0xa504f7824283d2c0
  li x25, 0xd927bb3930c0eea9
  li x26, 0x198824041e5d7ecd
  li x27, 0x82a56a7024e96582
  li x28, 0xa67a61a8af33ec53
  li x29, 0xff23cfe383d2dfab
  li x30, 0x033e74cd3cc762c5
  li x31, 0x2907be8f5a16430d
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
  srliw s1, s1, 31
  mulhu zero, t4, zero
  remuw s9, s1, a5
  remw a4, zero, t1
  divuw a2, s3, a2
  remw s10, a0, a5
  sw t2, 516(t6)
  slliw ra, gp, 31
  divw t3, s7, gp
  addi t2, t3, -1
  sraw t1, s7, t1
  srai a3, s8, 0
  remuw s10, s10, s10
  auipc s4, 691215
  mulhsu tp, a1, a1
  remu t4, s4, s4
  slli t0, tp, 15
  srai a2, t4, 47
  mulhu a0, s4, a2
  remw s5, s5, a2
  remu a1, a1, s5
  divw s10, s5, s10
  divu s3, s5, s9
  mul a3, a1, s10
  remu sp, t1, s3
  srliw tp, s3, 12
  div s8, s3, sp
  mulhsu a7, s10, tp
  addw a3, s4, a3
  slliw s7, tp, 30
  mul a1, s7, zero
  mul s11, a1, s7
  sllw a6, a1, s7
  sd a3, 832(t6)
  slliw s10, t1, 0
  divu zero, t4, t1
  rem a2, tp, tp
  sd gp, -1976(t6)
  mulhsu a1, a1, tp
  remw a5, a2, tp
  divu s2, gp, gp
  andi s7, a5, -1868
  srliw sp, s5, 31
  remuw ra, s2, s5
  remuw a0, a5, s5
  srli a0, ra, 33
  mulhsu s6, s6, t0
  andi a5, a7, -2006
  divu a5, a5, ra
  mul a4, s10, a1
  ori s9, gp, -2048
  slt a0, a5, gp
  slt t2, s9, a5
  addw t0, s4, s11
  mul s0, s9, a3
  or s2, s4, s6
  divu t1, t1, t1
  sb s2, 1225(t6)
  slli a3, a6, 21
  mulhsu s9, a5, s0
  div a5, s9, s4
  divw s10, a5, s0
  sra s1, ra, s10
  xor s0, s0, t4
  mulw s9, t3, s0
  sub s2, sp, s10
  mulhu t1, a6, t1
  mul tp, s7, tp
  srl sp, tp, sp
  slt t2, sp, ra
  addw a2, s6, s2
  sd a2, 248(t6)
  remuw a0, a0, s6
  sw a2, 1736(t6)
  srliw ra, a2, 20
  div gp, a6, ra
  mulhsu s8, s1, t0
  addw ra, a6, s1
  rem a6, s0, s0
  remuw tp, s8, s0
  mul s6, tp, s6
  slti t4, a7, -575
  mulhu s8, t4, s0
  div a2, s0, s1
  mul a1, a2, s0
  rem a7, s4, a1
  mulhsu tp, t0, s5
  remuw s10, s10, tp
  andi s7, a1, -1149
  rem s3, a1, a1
  sb s0, 1731(t6)
  sd s4, 1960(t6)
  div s6, s5, a1
  slli s10, s6, 47
  slti t2, a4, 2047
  add t3, s10, t1
  add s7, sp, s0
  slliw s4, s0, 31
  rem t0, s0, t4
  remuw tp, tp, zero
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
.word 0x03f52e52, 0xd186a182, 0xcd511dc3, 0xc3c14ba8, 0xc87f6d42, 0xf300db0d, 0xa1c4de75, 0xa35a0b82
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0xb1af546b, 0x0a7984d0, 0xa863fb82, 0xdb03f85a, 0x3869c9bc, 0x55eb4c26, 0xd069f249, 0x60762c51
.word 0x5b305793, 0x103fb431, 0xb48756e0, 0x68172942, 0x544cc446, 0x7473c56b, 0x96c05d63, 0x34d49844
.word 0xf5c21f85, 0xf2ba5aca, 0x3feffb32, 0x40698662, 0x07106ff4, 0x0a96fe74, 0xdcdc0242, 0x16855963
.word 0x381bbcd4, 0x4ab2a492, 0xe7fa22e3, 0xe1d8948f, 0x8edbd82a, 0xaa41afa8, 0x9368fa78, 0x5c86dd7f
.word 0xd268990f, 0x10eb14e0, 0xe5a0757c, 0x4be9dc58, 0x473ccd7b, 0x2d163049, 0xd9f82f49, 0x8b0b07ac
.word 0xa6e6f850, 0x2d823e4b, 0x437d8cc9, 0x1e1ac359, 0xbc020485, 0x38dcc960, 0xb1c98830, 0x3154d5e9
.word 0xa56dd845, 0x5ecb2629, 0x3c60ddf0, 0x5398972a, 0xfc6ebc2b, 0x0aaa18a9, 0x62687379, 0xcf760d6d
.word 0x1400209c, 0xbfb81d46, 0xdf63e5e9, 0x0d849d10, 0xc8625ffa, 0x69029d55, 0xd3fd975c, 0x56ce4e2a
.word 0x24b83287, 0x666d8dda, 0x79cc83ee, 0xf5fe21eb, 0x57ebb34b, 0x4d76a4b6, 0x75d2a89a, 0xe3e9159a
.word 0x4c647637, 0xc8f94414, 0x048b6cee, 0x7ca6c237, 0x918a1c86, 0xd6ea9130, 0xfd337ef9, 0x6fb6ee4b
.word 0x7874bcbd, 0x2ae19b31, 0xaaa07f3b, 0x7c9ff00e, 0x9b5ea89b, 0xc33da178, 0x4139ab49, 0x2fe43f5d
.word 0xe112a0f8, 0x1e666ad0, 0x532118a3, 0x47cc8505, 0x8f24249a, 0x03b37fab, 0x5db4f014, 0x37f4d76d
.word 0x9ca5e3ca, 0x316ddb85, 0x4e9504d0, 0x49149cc5, 0xa288440d, 0xc5add0af, 0xac6e9233, 0x1add7bea
.word 0x63dc9c2f, 0xb43eea90, 0xb6b389fc, 0x4cfd5eb1, 0x62db7330, 0x2077d667, 0x72c67f04, 0x247ce1b4
.word 0x327bb853, 0xa1d71bfd, 0x62b98bcd, 0xfba557a8, 0x34f2c7b4, 0x871887e9, 0xebf3b7b6, 0xd1ba9922
.word 0xf936fbfa, 0xfb5e43df, 0x2324d51a, 0xe908cbed, 0xdd0eb857, 0xa196ad3e, 0x93fbaa48, 0x5af1d8d5
.word 0x807e171e, 0x0b3c3b79, 0x75c2fd17, 0xd948420f, 0x25e85399, 0x287c04a4, 0x535c4e59, 0x30123687
.word 0xeb761d6c, 0x6d4971af, 0x3e01a0ce, 0xb70dfe3a, 0x8971e52c, 0x58edca2a, 0x78c7e0f6, 0x6dd3c34a
.word 0xad89e457, 0x4117ebf7, 0x9c78d5fd, 0x5852e529, 0x67e57d42, 0x3d50aa99, 0x0474eab4, 0x3d10531c
.word 0x502e44fb, 0xf233436d, 0x7070a771, 0x95a062ce, 0x9b570de8, 0x1cddcfdb, 0x04c2cc88, 0xc01f7d73
.word 0xf1a2fa16, 0x7f5a4ed0, 0x9b57837a, 0xc2a230fd, 0xd4ab1b94, 0x94b70b0e, 0xdd3e87a3, 0xfdfcc7e7
.word 0x0c9172c0, 0xef0b2daf, 0x64931d51, 0x6a0b8bdf, 0x6ac7f88c, 0x4bacaef6, 0xe5006a45, 0x531ac438
.word 0xbfe3c812, 0x5ed3ea29, 0x2f4e6b89, 0x65f9f5d3, 0x5e34ad3c, 0xb36ebfbc, 0x1d0b05a7, 0x1461a63a
.word 0x810f19b0, 0x1757a9f9, 0x393dc6fb, 0xc2bb9598, 0x5249177b, 0x88bc8635, 0x6c45186c, 0xb596112b
.word 0x3e588e42, 0xf8db0df6, 0x98d62425, 0x8b741694, 0x504a08da, 0x326d8559, 0x0fa089e1, 0x55376393
.word 0x5227cb1a, 0xe0d1d5e2, 0xd197d747, 0x0a2bb52b, 0xaa628804, 0xf5452c48, 0xf7864f82, 0x76342a24
.word 0xd0a0035b, 0x022751ca, 0x3d9f2eec, 0xed840091, 0x6417e69a, 0xa4d55244, 0xc6a2c168, 0x83b1b74f
.word 0xf4f91a08, 0xb9229646, 0x714eb2d1, 0x08553004, 0x6786bcf6, 0x77352a08, 0x5c9f0ad3, 0x157669c5
.word 0x48c855e1, 0x09bc14d1, 0xe06aef22, 0x04cb779d, 0xd9d56b5d, 0x38fd3751, 0xb95d4d86, 0xbf783f0c
.word 0x92db11ed, 0xb92f813a, 0x660e0125, 0xf7b91827, 0xad477511, 0x8e1ba37a, 0xe0604584, 0x5ae7e1ab
.word 0x41b6818d, 0xf084600a, 0xeeda6e03, 0xcbb4aa33, 0xf48b0ffd, 0x8d191d46, 0x22411747, 0xd0cad429
.word 0xf99bdd70, 0x862ef35e, 0xfdc6e74b, 0x0187cf75, 0x625d0ebc, 0x949a7be7, 0x88a0b353, 0x9bdf78cf
.zero 7168
mem_region_end:
