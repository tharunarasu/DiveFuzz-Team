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
  li x26, 0x0000000a00506982
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
  li x1, 0x2beb2f2923d3abda
  li x2, 0x0f124a2d7b1562cb
  li x3, 0x7bfc4a6840362525
  li x4, 0x16112d0b38587bdf
  li x5, 0x38f48211c17ca8bc
  li x6, 0x2d4b46d38fa5e6c5
  li x7, 0x0da197f8de245b49
  li x8, 0xa5bc631c21be2169
  li x9, 0xbfece63929d7e782
  li x10, 0x1bd8352aa27e37ca
  li x11, 0x2bca7f3644455791
  li x12, 0x12d95c13ccdf09f6
  li x13, 0x77d8686b628a2174
  li x14, 0xb334a32b43e3f03e
  li x15, 0x0d41ccfbc21301d1
  li x16, 0xed2310c4544a45b3
  li x17, 0x97c4f3513b742160
  li x18, 0x79d10d1374b42c5f
  li x19, 0x6c6bad74541dbcec
  li x20, 0xae6de1af949c84a5
  li x21, 0xbd297feb90beca39
  li x22, 0x5a6963a9005a91f7
  li x23, 0xb7f51e7449c4f5a3
  li x24, 0xd85f89fd9b61a954
  li x25, 0x12a9aa01be8f9642
  li x26, 0x2d445cb533a414f0
  li x27, 0x638ce86df807dc29
  li x28, 0x1a3a5f080e00b310
  li x29, 0xc696624ed9fbe64c
  li x30, 0x981d1c1ba2c838cd
  li x31, 0x1463f2c9f8cc1248
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
  mulhu s11, s11, s11
  divu s1, s11, s11
  fence.i
  divuw s7, s11, s1
  fence.i
  divu s10, s11, s1
  sraiw a2, s11, 0
  div a1, t0, gp
  sd s11, -1664(t6)
  divw t4, a1, s10
  fence.i
  slli t4, a2, 14
  mulhsu a6, s7, a1
  divw s11, s11, s11
  remuw s2, t4, a2
  addiw s10, s2, -2048
  remu a3, s10, a3
  ld s5, -344(t6)
  fence.i
  fence
  rem sp, sp, a4
  fence.i
  sraiw a0, s5, 27
  fence.i
  slti zero, s11, 1366
  mulhu s6, sp, s6
  divu tp, sp, a1
  mulhsu t2, sp, sp
  mulhu a6, s3, t2
  srai ra, ra, 1
  lwu t4, -1480(t6)
  fence.i
  div s3, a6, tp
  sll a2, t2, a2
  divuw sp, a6, a6
  divw a4, a2, ra
  fence.i
  lw t0, -1704(t6)
  ld a5, 704(t6)
  fence.i
  remu s8, a2, a4
  slliw tp, a5, 0
  rem a3, tp, a5
  rem s3, s4, a5
  mul s11, s3, a5
  fence.i
  remu s2, s11, a3
  fence.i
  divw s5, tp, s11
  fence.i
  addw a1, s2, a1
  sub tp, s11, a1
  remu t0, t4, t0
  remw t0, tp, tp
  mulhu zero, tp, s5
  divw s3, tp, s3
  mul s9, a0, s4
  srai t2, s9, 12
  remw s10, t1, t0
  remu a1, t2, zero
  srai s2, s10, 5
  divw tp, s2, s2
  sltu s0, ra, s0
  mul a6, a4, tp
  fence.i
  remuw t1, a6, a6
  fence.i
  sd s2, 456(t6)
  slliw a7, s0, 31
  remw s9, tp, t3
  slli s8, s8, 51
  fence.i
  sb s9, 1770(t6)
  remuw tp, zero, s8
  remu t3, a7, s9
  fence.i
  fence.i
  divuw gp, s5, a3
  fence.i
  mulhsu s4, gp, s4
  fence.i
  mul sp, s4, gp
  srliw s5, s4, 23
  div t0, t3, sp
  fence.i
  mulhsu a6, gp, s5
  sraw zero, s5, s8
  sraiw a7, a6, 24
  sraw s2, t0, s9
  remu a2, a6, zero
  slt a4, a7, zero
  srlw tp, tp, a3
  sltu s8, a2, s2
  div zero, zero, zero
  mulw s1, s1, s8
  lhu ra, 1630(t6)
  divuw t3, tp, a0
  srliw a2, s10, 31
  mulw t2, ra, zero
  sh t3, 88(t6)
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
.word 0x79b71759, 0x0c9382cf, 0x7844963b, 0xc19d2f9c, 0xb2d16ffe, 0xb2db8263, 0x1fe7812c, 0x7fc5d1ac
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x28cfa71c, 0x91f8d469, 0xbb622c50, 0xd469a527, 0x9c86e792, 0xf01108a1, 0x5bd9cf6b, 0x6f58aef0
.word 0x8b323324, 0xf17f8f91, 0x263d3e50, 0x659f7c51, 0x2428a458, 0xd315ed93, 0x6461d7a3, 0xf1a81161
.word 0xf463947f, 0xb7bde2ac, 0x63385263, 0xdaaa0238, 0x32f72fb2, 0x54486301, 0xe5baf739, 0x122b07f4
.word 0x2cfde6c9, 0xe26c1b09, 0x0f01e0cd, 0x1fe50c26, 0xa584bdc7, 0x37475d81, 0x912b58ff, 0x7fc9aa51
.word 0x2551489b, 0xd44d931a, 0x8c7cbb37, 0x623d5ec9, 0x9b8248b1, 0x51603286, 0x260c3508, 0x7eebef14
.word 0xf69aef6d, 0x63f021d9, 0x15a0bd92, 0xa9441411, 0x02e2daba, 0x3e5d1867, 0x0c15d42e, 0x617bbb77
.word 0x8a2951d7, 0x6e7fb855, 0x0b29ca38, 0x5805c788, 0x4a97cb1c, 0xf4c3c2e1, 0x7d48770a, 0xc33e7f13
.word 0x275931b5, 0x1b372703, 0xeb41b137, 0x680cd606, 0x84055577, 0x1ac0ed6b, 0x95bf0abb, 0x9b578d75
.word 0x9ed88199, 0x4d6bb5bb, 0x542bf99a, 0xd188b795, 0xd9638853, 0x52694322, 0x0f1e6899, 0x369adf56
.word 0x110db9ec, 0x17659669, 0x44c4190e, 0x8809e152, 0xdb56399a, 0x293f04e5, 0x0f53b8f4, 0x1883fdbf
.word 0x8727842b, 0x4e35dbc7, 0x2eee5ecf, 0x238bb3f0, 0x2065c96d, 0x78532d02, 0x741a491f, 0xb2a722e0
.word 0x7e4baf41, 0xb4b28a5d, 0x3904bf8a, 0x3fc23d31, 0x08e20981, 0xe5ae9def, 0xc29efa3d, 0xac9c72e1
.word 0x580851d8, 0x860936d7, 0x6b5affd9, 0x03a0875c, 0x914563b4, 0x6eebb08c, 0x99131330, 0xd30cc318
.word 0x75ee4932, 0x586812e4, 0x17c9864c, 0xd96e4fc3, 0x930e3dd2, 0x275b9d58, 0x2b151687, 0xdbd37180
.word 0x0a0653c5, 0x358f36a6, 0xcb8401dd, 0x6761671f, 0xfe77c007, 0x0aee7c21, 0x0888d4b7, 0xc0b5c8fd
.word 0xfbb5401e, 0x29e44571, 0x5c9f7179, 0x617f722a, 0xc8fd609a, 0x0e1314e9, 0x91f70b95, 0x1d7df735
.word 0xc0fbb23a, 0x6ecfd449, 0x8399c19b, 0xc6db361b, 0x4fe9f312, 0xd87562ad, 0xdf5235c4, 0x065e5c79
.word 0x3e2b5a26, 0xd192ba24, 0x5e894e39, 0xc20c4b25, 0x2a6b1373, 0x5bad3282, 0x0b26896b, 0x33149df6
.word 0xa9a76e40, 0x0009cc5e, 0x1e018825, 0x06f6bf16, 0xcf28c2e7, 0x15f3b2c8, 0xe1c94e45, 0xd9dbd913
.word 0xcf3af993, 0xd4eaf62b, 0x66bd52d2, 0x55330142, 0x7841bdaf, 0x3608bb56, 0x5060111b, 0x0be19851
.word 0x9b4dad66, 0xc83391b6, 0x8bd88a66, 0xd723dc6c, 0xb6ed3001, 0x6974b612, 0x04353d5d, 0xb9c41741
.word 0x2b44efa1, 0x70cb8ec2, 0x009a6aaf, 0x68a2d874, 0x02996ea7, 0x624bd9e0, 0x2c5f23aa, 0xe5fed79c
.word 0x177ba65d, 0xa8b75903, 0x3a4ae547, 0xc1dc0406, 0xcc729156, 0x787702d2, 0xdf923d08, 0x4c3a991a
.word 0xfa125dc7, 0x220fd741, 0x26801188, 0x2a2ecbeb, 0x2e070755, 0x24b255c6, 0xeeabaa03, 0xe81a30d0
.word 0x81da8f57, 0x0dd29f6c, 0x57f9d94b, 0xd05f5d63, 0x40df9e26, 0xa2339786, 0xf1f908a5, 0x649db4b1
.word 0x3edf4f8d, 0x93d852fc, 0x9e0fedad, 0x64ef894c, 0xed20966a, 0x18604a97, 0xff7d1e2d, 0x212f4d03
.word 0x046d53eb, 0x3bf95992, 0x537215f0, 0x5fed0dd1, 0x894d9ad7, 0x308be112, 0x04f4edb8, 0x1c43c5f4
.word 0xd9ae3503, 0xb91220f9, 0xad03e9c5, 0x4ba4765e, 0xb886b8e8, 0x6284bb40, 0x70c4b4a9, 0x94a331f8
.word 0xec6d896a, 0xf1137273, 0x26e62a54, 0xebc3de1d, 0x8138436f, 0x32a14004, 0x311bdcec, 0x829c3c42
.word 0x7c4ab193, 0x96ef0254, 0xa9ebfbc5, 0xd97721db, 0x9af26fa5, 0x0137cb10, 0xd40e423e, 0xf175cfe6
.word 0x8e9ff09f, 0xb3317cd0, 0xad938983, 0x7ea20ff2, 0x35b055d0, 0x37bc8eeb, 0x561455cb, 0x4e3a3a6d
.word 0x39ee04f2, 0x3d02114a, 0xee05b095, 0xc926a007, 0x6c04a1b0, 0xb8f5fbed, 0x6bd9fb6d, 0xfe1545f6
.zero 7168
mem_region_end:
