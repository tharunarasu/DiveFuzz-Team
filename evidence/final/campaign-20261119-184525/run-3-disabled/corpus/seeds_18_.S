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
  li x26, 0x0000000a0064190a
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
  li x1, 0x000299ed8d20d410
  li x2, 0x3e33dbcfa7980b57
  li x3, 0xd12e34e5c5cc2dc1
  li x4, 0x3a11b5c687396662
  li x5, 0x6df35d098aa9213f
  li x6, 0xa01e8bda46b77044
  li x7, 0xd7609317db4b80ad
  li x8, 0x426939311aedb929
  li x9, 0x8f72034ca94ae72d
  li x10, 0x60638a45d1c0d153
  li x11, 0x5e67610be6338631
  li x12, 0x0f0362d406d15984
  li x13, 0x9a928b44a4c7d754
  li x14, 0xb617fb37e0ff7909
  li x15, 0x9152a29fa3540bb9
  li x16, 0x1497cded14136c98
  li x17, 0x872dc80aede89af1
  li x18, 0x3a00fe1a17c12242
  li x19, 0xb69889115b837fb2
  li x20, 0xbd9f4eeb770a210c
  li x21, 0x1fd53b4ca6002456
  li x22, 0xe0ef94a8ad2bc9e7
  li x23, 0x57cae23ea1f1750d
  li x24, 0x563b3d73a89ea942
  li x25, 0xf97d2f35aec74af1
  li x26, 0x390497b31a0cd1aa
  li x27, 0x16ea67fed6a5f71f
  li x28, 0x3e6ef7b260182d21
  li x29, 0x560e146c97d1176d
  li x30, 0x0c4c07a20eee3d49
  li x31, 0xad5d700cf1f90339
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
  divu s4, s0, s4
  divuw t3, t3, s4
  fence.i
  addw ra, ra, s4
  srai a6, t3, 61
  slli a4, a6, 63
  divu s1, t3, a4
  remu t1, a4, ra
  divuw a3, a3, t1
  remw a7, s3, s1
  div a1, a7, a3
  andi s3, s1, 2047
  fence.i
  divuw s0, t4, a7
  remw tp, tp, t0
  fence.i
  auipc s6, 0
  mulw gp, gp, a1
  addw gp, gp, gp
  fence.i
  fence.i
  srai t3, s0, 40
  div t1, s0, s0
  divw sp, sp, t1
  remu t2, s6, sp
  divw s5, s7, t1
  slti s9, s5, -1005
  div a6, a6, sp
  mulhsu gp, gp, sp
  addiw a4, s5, -2048
  divw a7, gp, s5
  srliw t3, a4, 21
  mul sp, a4, sp
  fence.i
  mulhsu s0, t3, a4
  fence.i
  remu a5, s0, t3
  mul t4, a7, s0
  remu s3, sp, s3
  fence.i
  rem a0, a5, a2
  fence.i
  fence.i
  remu a4, a0, a5
  remuw s1, s1, s11
  sw s8, 336(t6)
  sraiw t2, s8, 17
  mul s8, a4, a0
  slliw a6, a0, 15
  mulhu s10, a7, t2
  mul a3, t2, a3
  fence.i
  divuw s5, s8, s6
  mulw a0, s8, a6
  fence.i
  and tp, s5, s4
  sraw s9, gp, tp
  mulw gp, s5, a3
  mulw s0, s5, s0
  mul s6, tp, gp
  div s8, s9, gp
  lwu t0, 476(t6)
  slliw a3, sp, 0
  mulw sp, sp, s8
  sll t3, t3, tp
  sd sp, -616(t6)
  sraiw t2, sp, 14
  divuw s10, t0, s10
  divuw a0, a3, s10
  remuw s4, s4, s10
  sra s1, s10, s10
  rem a1, a0, a0
  fence.i
  rem zero, zero, a1
  sw a0, 512(t6)
  fence.i
  fence.i
  mulw zero, a1, a0
  mul s5, a1, zero
  remw a7, s10, s1
  lhu s10, 1132(t6)
  divuw t3, t0, ra
  sh a5, -242(t6)
  div s3, s10, s5
  subw s7, t3, t3
  lui s4, 0
  auipc t2, 222273
  lw a7, 636(t6)
  subw s11, s3, s7
  ld t4, -256(t6)
  subw s8, zero, s4
  fence.i
  mul s9, s11, a0
  mul a0, s11, a7
  fence.i
  divu s10, a0, s10
  remu s7, s9, s8
  rem gp, s8, gp
  srl s2, s2, s9
  sll sp, s2, s10
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
.word 0x83a2270d, 0x825bd118, 0x988ae564, 0xd2284e11, 0xc2bf3952, 0x1e0c7c62, 0x050a0831, 0x1a205b22
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x1c8f734d, 0xab5e2003, 0x24caa2fc, 0xcb9c226d, 0x365859be, 0xd7e79fb3, 0xfcbcbf41, 0x31ed708d
.word 0x12e6779f, 0x8d3f05d1, 0xe9b22d85, 0xbb4f4fde, 0x1cd4830c, 0xf4c2a4c1, 0x88689437, 0x994aa496
.word 0xb0bc25d6, 0x6fe66574, 0xe2ee2017, 0xab255ed5, 0x51c6d7b0, 0xa2ca8811, 0x6bbc54c1, 0x7622a05e
.word 0x922609f1, 0x8d586df3, 0xc8d4fe1b, 0x3811c5f0, 0x70e84a06, 0x02231d11, 0xe1022010, 0xdbf1d9a9
.word 0x568221a2, 0xc7341149, 0xc636d8d5, 0x337d8e5b, 0xeaac5d8d, 0xb64dd64f, 0x11837454, 0x7db87c24
.word 0x8c534223, 0x97557ace, 0x45535c7e, 0xac772edc, 0x6d3de8ca, 0x8099ce53, 0x378c01d7, 0x472dee48
.word 0x73a3273e, 0x8f25127b, 0x2b0983de, 0xceaf7bac, 0x5539c845, 0x2e3ff28e, 0xe7ae3933, 0xddbb8854
.word 0x5efacdbf, 0x8c167233, 0x0c3d07c0, 0x606e9684, 0x5c64d08f, 0xb9b277e8, 0xa3d2d8d8, 0xc6ad2527
.word 0xfc1bc29e, 0xf76d8abb, 0x2ae0d7b0, 0x03f19d5f, 0xfa9f26d6, 0xc94e4108, 0x08bfb83d, 0x026dd8b5
.word 0x346c3adf, 0x5144e7f2, 0x884ee689, 0xff2b2b2a, 0xd70b06dd, 0x5e1bebc0, 0x6d7a504d, 0x08611c87
.word 0x2bc173c0, 0x7a8bc4ce, 0x833bd443, 0xffa2fc71, 0xd69a2a20, 0xed33e51b, 0x438f064e, 0xb0fd2388
.word 0xf48acd9b, 0xc2489623, 0xa1595c43, 0xbcee2304, 0x0a2e8b09, 0x36743690, 0xd1e60c6b, 0x2bb564f8
.word 0x6f1a5082, 0x732dabae, 0x3710ccc8, 0x926fcb16, 0xd9d743df, 0x06f8be11, 0xa5b60d74, 0x801cb2bb
.word 0x500183fb, 0xb4d1ac20, 0xe396520f, 0xf0860ffb, 0x8ca052f1, 0x1dafa34d, 0x0e71a7e5, 0x8c130801
.word 0x1917fb6f, 0x3908f503, 0x8eba21aa, 0x8d21693c, 0xa2a2a087, 0x9c11fe8f, 0x4219a086, 0x508e949f
.word 0x4275d0bc, 0x8f04dc5b, 0xe5f8dc3f, 0x5e665393, 0xab5d98ba, 0xc1746bc5, 0xf7e8f964, 0xa321fc00
.word 0x44adfdd6, 0xbc58f2f1, 0x2f97e427, 0x7b7dd2a2, 0x02fcb32f, 0xfa1aadb0, 0x8ac6e7fc, 0x228c3565
.word 0xd28b06bf, 0x04c7138a, 0x8e6f5df3, 0x56caaa63, 0x924d50a5, 0x259e2f62, 0x656cad6d, 0xcf1624d0
.word 0xddbdd40b, 0x4cbdad79, 0x8a8ccd8a, 0x715a8138, 0x04ac178c, 0xb7f200f8, 0x05df65ee, 0xb7a0e1de
.word 0xf8d70941, 0xea9c8683, 0x74647940, 0x6568e6e2, 0xc2ef2948, 0xc2b2531c, 0xe0853e59, 0xbbea1785
.word 0xb592a785, 0x5182e4f0, 0x554486de, 0x4c7d632f, 0x61eaa3a6, 0xca485a43, 0x413f7519, 0x7d7d8039
.word 0xabb1c693, 0x6cabe45d, 0xc55216c1, 0xd796c113, 0xd968337e, 0x7b55c705, 0x05092d19, 0xa327c53e
.word 0x821754f2, 0xac4d335b, 0x7fa20af2, 0xb5152bd8, 0xcad072bf, 0xfa5924d2, 0x74190a37, 0xf05779eb
.word 0xe01a6353, 0xeb67c024, 0x98218aa0, 0xc3254e10, 0x68f0c3f9, 0x21ddaeae, 0xe6f6c450, 0x5ff989cd
.word 0xd11efa79, 0x3c44dcdf, 0xb88524a5, 0x7a7bc360, 0x574985f9, 0x29eb25b9, 0x7b36590c, 0xe1f0a805
.word 0xd14ecfb7, 0x62a0500d, 0xf264276a, 0x86d152ac, 0xf1922ea9, 0xc8287997, 0x1b1c73a7, 0xc67f5ce8
.word 0xaea32a2f, 0x14bd5a95, 0x3f286bef, 0x576e820b, 0x15aed77b, 0x12abe48c, 0xaaee8ea4, 0x0bca56d4
.word 0xdcfce999, 0x7e0ed642, 0x256579a4, 0xc4a23eaf, 0xcce9a696, 0x9eaeca1b, 0x5b4d3b96, 0xcc679606
.word 0xb81c8ba5, 0xf7fa2a06, 0x42c79eb3, 0x24b28b38, 0x365653db, 0x9cc5c1b8, 0x63c37725, 0x17b2e212
.word 0xd0c4e386, 0x99346846, 0x08f7d09d, 0x943c8a75, 0x1a0daded, 0x55998f8a, 0xe824e1f4, 0x6ddcae31
.word 0xb75d07e6, 0x714dcf56, 0x42f2f5e8, 0xf3125407, 0xfa811307, 0xca1550a0, 0x987c20b9, 0xb35efc6b
.word 0x8e97a3ce, 0x702d3508, 0xccb1c0bd, 0xc190ee4d, 0x47758c96, 0xf738ce4a, 0xf75602b6, 0x37ce57df
.zero 7168
mem_region_end:
