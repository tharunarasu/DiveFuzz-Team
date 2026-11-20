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
  li x26, 0x0000000a006849aa
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
  li x1, 0xdca7446a362af861
  li x2, 0xf28f7d6916c15577
  li x3, 0xa657189a99352fd2
  li x4, 0x0766337af1fbf303
  li x5, 0xafa292e4c98ccd81
  li x6, 0x0609e21f82bb289a
  li x7, 0x716a237e7039e191
  li x8, 0xfda50fccdc2e999a
  li x9, 0xf4d544b7c65890a0
  li x10, 0x2df526d0fbb28278
  li x11, 0x6903874342b3b8a6
  li x12, 0xefed974ae7a169f0
  li x13, 0x7375146acb9fd376
  li x14, 0x03ea1db86cdd56c4
  li x15, 0xe66ac5a6570adb2e
  li x16, 0x7d8a2b93ea3258ec
  li x17, 0x5593ad0132c0741f
  li x18, 0xdffa2979f0ecb8e7
  li x19, 0xbd5771e242e31b98
  li x20, 0xda0675a65bdf6ff1
  li x21, 0x2a60425ebb2a2d6f
  li x22, 0x6c38e8275fdb51c1
  li x23, 0x19b30aaf9ac3acb8
  li x24, 0x15b75e83b3453cf0
  li x25, 0x4b7284fb92d9c74f
  li x26, 0xbb3a08bb6bf31050
  li x27, 0xf88edf3b5fd7422c
  li x28, 0xc52e86d9eb45af60
  li x29, 0xc0ce4a4a20f1f60f
  li x30, 0x648a77caddabc3a5
  li x31, 0xf79d231eddd206e5
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
  and a6, a6, gp
  fence.i
  divu s10, a6, s10
  mulw t3, t3, t3
  and t1, t3, s10
  li a7, -1
  li s5, 66546811928
  divw zero, zero, zero
  addiw t3, a7, -1183
  addiw s8, s2, 510
  divw a1, s1, s8
  sltu s11, gp, s5
  slti s6, sp, 2047
  lbu s4, 336(t6)
  divuw t2, s8, s11
  slliw t4, t4, 0
  mul t1, s4, s4
  divw s9, s1, s6
  mulhsu s9, s8, s9
  remw a5, s9, t2
  sraiw s8, a7, 0
  slliw s2, s8, 18
  lh s0, -972(t6)
  srliw s8, a7, 12
  subw s3, sp, s3
  remw s11, t2, a5
  slliw ra, tp, 0
  slliw tp, s0, 1
  addi s1, tp, 0
  subw a7, a7, ra
  divu s4, a7, s11
  remu zero, ra, tp
  subw t2, s4, t2
  slli t0, t0, 24
  xor sp, zero, t2
  remw t1, t0, s11
  mulhsu gp, zero, sp
  sraw s4, sp, s4
  sb t0, -1700(t6)
  sraw t2, t1, sp
  rem t3, t2, gp
  divw a1, t2, s4
  slt t4, t3, a1
  divu a7, t2, t4
  and a4, s1, t4
  slli t1, a7, 0
  mulhu s6, a1, a1
  lwu s4, 904(t6)
  remuw a3, t1, a4
  addw t2, s4, s6
  srlw t3, sp, s6
  sb s6, 1311(t6)
  remw s7, t3, s2
  mulw t4, s4, t3
  srai s11, t2, 0
  rem a6, a6, s0
  subw a0, a4, a6
  addw s5, a6, a4
  mulw a7, s5, a0
  srli s6, a7, 0
  auipc s2, 1
  divw ra, s2, a5
  sraw a6, zero, s2
  addiw a1, a6, 287
  divu gp, a6, s2
  li t1, 360907917113
  mulhsu zero, ra, s2
  li a7, -549755813888
  lhu t0, -1382(t6)
  sraw a5, t1, a5
  slli a4, t1, 0
  srliw a2, zero, 0
  rem s5, a7, s5
  xor t2, s3, sp
  remuw t4, sp, t2
  mul s8, s8, s8
  sh a2, 1908(t6)
  addiw s7, t0, -1440
  slli a1, a0, 63
  rem a0, t2, a1
  lb s3, 246(t6)
  sw s5, -900(t6)
  nop
  sll a2, a1, s8
  slliw t3, a1, 0
  slli a6, a1, 50
  sltiu s2, t3, 359
  remu ra, tp, t3
  auipc sp, 968005
  and tp, t3, s2
  divw a7, sp, a6
  addi a3, ra, 1
  addw s8, sp, ra
  and a4, a4, s1
  divu a5, s1, a3
  remu gp, a4, s8
  div s9, a4, a3
  remuw s1, s9, a5
  divuw a7, a7, a5
  mul zero, t2, a0
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
.word 0x9d994f52, 0x44c60755, 0xcced4c35, 0x9f2d92e8, 0x946a304d, 0xc5ac7929, 0xe8589cad, 0xd42d206a
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0xe1cfc143, 0x2503a34b, 0x9cfcca87, 0x98c286e0, 0x4e932bfb, 0x2c27eebd, 0xf700e211, 0xb27e6fec
.word 0xb749197c, 0x5f09ccb1, 0x0a73f8aa, 0x9ab08935, 0xbb1fc155, 0x8df40a28, 0xa573668c, 0x29f843bd
.word 0x548ebab0, 0x3180722e, 0xb7c43d24, 0x074e4615, 0x259b28a3, 0x5b51b92a, 0xb5fd9813, 0x9e071331
.word 0x3e813d05, 0x367c0c71, 0x10f85574, 0x59394f98, 0x433f18e8, 0x3ad68431, 0xca9ad05b, 0xfed48f52
.word 0x61b85eb7, 0xc56af8cf, 0x3cc8ec20, 0x4f35c7f3, 0x640defa8, 0x79e6c53b, 0x79ff52c7, 0x22adff91
.word 0x8df77de6, 0xfa240ff7, 0x5f605612, 0x4ff2ca7f, 0xf2c5dd59, 0x39c63d6a, 0x65360a73, 0xc7b970cb
.word 0x57f4a47d, 0xfc1c4375, 0x5a8adff2, 0x5083b1f2, 0x3a9b68fb, 0x34cde0ee, 0x44afe851, 0xa8d8518a
.word 0x7cbfe769, 0x8f6d1f65, 0x5f0d4170, 0x99721a98, 0x948cd2de, 0xd709e0b5, 0x2dafecd6, 0x632c4295
.word 0x67716dc9, 0x6e7242f8, 0x3e34af2b, 0x5feda6f0, 0x9c0db874, 0xc931ab21, 0x17147a55, 0x923804b0
.word 0x8acfd83c, 0x330a3d00, 0xbef316c4, 0xf6cc1762, 0xb303a6c8, 0x0e96393c, 0x70584350, 0xa064de33
.word 0xf64ce0e4, 0xd209573c, 0x593762d3, 0x2c0f13ad, 0x010cbb15, 0xb1c91ad1, 0x5863c37e, 0x23cba2a0
.word 0x5225155c, 0xc9b40065, 0xa4f58dda, 0x4c3af7c3, 0x7f908e4a, 0xc5ca12b5, 0xc2119913, 0x0739e888
.word 0xc7b06464, 0xac2b15e2, 0x2baa9f84, 0xdc1d5cb2, 0x2b4cb0ca, 0x8c7d52d2, 0xedfb4f55, 0x18f2f16c
.word 0xfb67f669, 0xe3e01cf3, 0xf1dd1a2c, 0x124c92b3, 0x0d574783, 0x386bcd38, 0xddbd1979, 0xb28c5e88
.word 0xb2135f8e, 0x8154f81d, 0x079ff0cf, 0x3c2522f8, 0x98d66137, 0x33b7f007, 0xa054ca38, 0xcc241225
.word 0x1cad470c, 0x042f9e95, 0xf371b133, 0x66343cb3, 0x220abd94, 0xe215a605, 0x58372004, 0xff7e424c
.word 0x87a9d7d6, 0xe7afad9a, 0x2a893c71, 0x3580d1e4, 0x40399949, 0x43e944a1, 0x96dbb012, 0x8121f4e4
.word 0x31f26401, 0xbb722d8a, 0x1bfec49a, 0xebaf781d, 0x2d25cdf2, 0xc6c5a6eb, 0x10e9e004, 0x4067659a
.word 0x13dceb30, 0xe2eff085, 0xe88e8630, 0x8f9d8ae7, 0xd145bb03, 0xd0c4fa4f, 0x0e944606, 0xba01c17c
.word 0xb835d03b, 0x551cb359, 0xc3e04455, 0x3d4b4f43, 0x2241d097, 0xa9e088f6, 0x74bafd55, 0xfcd44743
.word 0x1f8eb761, 0x7f5046ba, 0x6bebc771, 0xf8a8a3fa, 0x48771cf3, 0x678f3a56, 0x972c7135, 0xaaf7957c
.word 0x2ed07b3c, 0xc61c5461, 0x17ce48bf, 0x43f20141, 0x0353f087, 0x91d847eb, 0x323cc5d0, 0xa784a9be
.word 0xf93ccc41, 0xdfdf8ea5, 0x8988d881, 0xaa3a94d1, 0x2178b54a, 0xeb9bce58, 0x877e0d14, 0x19ce3ac4
.word 0xc5a9c744, 0x920d2ac3, 0x33eb78d5, 0x38ca6c70, 0x140a237f, 0x0bb44816, 0x9a1f5481, 0xe7a65434
.word 0x09f5b43c, 0x09d9356e, 0x100f9d05, 0xc215f134, 0x4f2e0649, 0xfdf7a901, 0xc9a9f208, 0xbdd8d1c3
.word 0x6885f6dc, 0x853f8c9b, 0xb8237a09, 0x6b922ddb, 0xb16ee19e, 0xccc0afc2, 0x2c098705, 0xa4394813
.word 0x6792dc7e, 0x862cd94d, 0xedca6c67, 0x2e5ba54b, 0xdcdd5390, 0xa24ada45, 0x258fbb34, 0x7dd4756f
.word 0x8d90c8b5, 0x5c8d205a, 0x29e0178e, 0xaabc410c, 0xc31f1663, 0xf46ae1d0, 0x66b821b0, 0x7367226e
.word 0x85292a7d, 0xe9210db6, 0x02821abb, 0xcf455a9c, 0xe2148fec, 0x05cdd1bf, 0x1adc6272, 0x383de964
.word 0xb7888516, 0x86e74bcd, 0x8a9eae26, 0x6d1e4ff2, 0x013a2bbd, 0x4ef6ef44, 0x165c52d8, 0xfd59d07c
.word 0x12aade3b, 0x7b2cd6a4, 0xe44879bc, 0xfae88896, 0x176cf1ae, 0xf01f4ab5, 0x2528f29c, 0x43092868
.word 0x2a63c2d7, 0x038e132c, 0x9d2337cc, 0x3942a6c6, 0x05c5b159, 0xfb00c2c9, 0xf5261377, 0x99e6bf69
.zero 7168
mem_region_end:
