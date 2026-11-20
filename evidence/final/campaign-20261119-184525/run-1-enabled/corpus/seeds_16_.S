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
  li x26, 0x0000000a0064418a
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
  li x1, 0xde09fd73d9d5980f
  li x2, 0xa1407d838604c041
  li x3, 0x9fae1f126e917dce
  li x4, 0x941d67ae7ad37acc
  li x5, 0x42e7cd1d57531eaa
  li x6, 0xbb1ed9f38e60501d
  li x7, 0x770e17da8f3f49e7
  li x8, 0x1311c7bbe99f5a7a
  li x9, 0xfbd0b1697cef6cc4
  li x10, 0xa32d9d6412eea878
  li x11, 0x40ab9ba0778ec15d
  li x12, 0x223907e5730472ba
  li x13, 0xe925835780702a04
  li x14, 0x1e191962dc74bc0b
  li x15, 0x70ba0cc527fcf004
  li x16, 0x479db6f833ef0f53
  li x17, 0x91fd9cf624c6fe33
  li x18, 0x257880f525893b17
  li x19, 0x620d9a8e66174580
  li x20, 0x4a70fadd64abdb88
  li x21, 0x10aca25d1b6faf86
  li x22, 0xc7c5eef6b658b9d6
  li x23, 0x4f5e7e7a7cdcc813
  li x24, 0x06898625c802996d
  li x25, 0x8f96b4e9a4d49152
  li x26, 0x0b0879c1a550e428
  li x27, 0x33071a3094cd3044
  li x28, 0x8a5dd009fd81a2ac
  li x29, 0x640b2c501e3945a3
  li x30, 0x879c7de552fe561d
  li x31, 0x67c2b404441dfdcd
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
  rem s3, tp, s3
  divw s7, s7, s3
  remuw tp, s7, s7
  srai s2, s3, 31
  remw a3, tp, a3
  div a5, s3, a4
  srlw s9, s9, tp
  mulw t3, t3, a5
  remw a7, s2, t3
  div s5, s9, s5
  divw t0, t0, s5
  mulw a6, s6, s2
  slliw s8, s8, 0
  mulw a2, a2, tp
  mulhu tp, s11, s7
  mul s5, a2, a6
  remu s2, a6, s8
  srlw a7, s8, s8
  slli s6, a7, 7
  addi a7, s5, -667
  mulhsu t3, s6, a0
  mulw s3, s3, s6
  div s7, s6, t3
  or tp, tp, tp
  sd s6, 832(t6)
  srli a4, a4, 35
  remw a3, a3, s3
  divw s0, s0, s3
  rem t1, s9, t1
  remw s9, s4, a4
  mulhsu a0, zero, a4
  divw a5, t1, s2
  mulhsu s9, t1, a7
  divw s2, s2, s2
  divu s3, a5, s3
  divu a3, s3, s3
  rem t2, s10, s3
  divw s7, ra, s7
  add s11, a1, a4
  sraw t2, s0, a1
  divu sp, s0, ra
  slliw t3, a1, 22
  rem ra, s11, sp
  xor a2, t2, sp
  mulw a6, t3, ra
  sllw s1, ra, a6
  remuw a7, a6, ra
  sll s7, a7, s7
  xori s7, s4, 1260
  srli a4, s1, 58
  srai s8, s7, 32
  remu a5, s1, s7
  sb s4, 1062(t6)
  mulhsu s6, t3, s3
  divuw s0, a5, s0
  divuw t1, t1, t1
  remu t4, s1, s1
  div gp, s3, s0
  mulw t2, s3, t2
  mulhu a4, a2, s11
  divw s4, t4, a7
  sd s11, -1912(t6)
  divuw sp, tp, s2
  divw s10, sp, s4
  remw a2, gp, gp
  remw s9, s10, s9
  xori t4, s2, -1
  slli s3, tp, 1
  divw a7, s2, a7
  rem s10, s7, s7
  srl a5, s6, s0
  sraw t0, t0, s1
  slli a1, t2, 52
  remw s7, s1, s7
  divw s3, ra, t4
  divu a5, s7, s7
  sb ra, -1848(t6)
  divuw t1, t3, s7
  and t2, t2, s3
  mulw a0, gp, t1
  lbu s1, 917(t6)
  remu a2, a0, t2
  divw s6, a2, s2
  addi zero, t1, 1491
  divuw t3, t1, s0
  mulhu s2, t1, s0
  sraw s9, s3, a7
  addw a1, a1, s6
  divuw s8, s9, s2
  subw s1, s1, s9
  sltu a6, a6, s9
  xori s6, a6, 1350
  sh t1, -1300(t6)
  divuw s0, a3, s11
  divu tp, a1, tp
  slliw t0, s5, 16
  srlw ra, s11, t3
  divu t3, t3, ra
  divuw s0, s0, s11
  sraw a5, s0, a3
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
.word 0x65ac6b6d, 0xed531db8, 0x0c7727be, 0x1a58e031, 0x1dbc78f0, 0x201fa011, 0x7940c674, 0x48a90526
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x8361db31, 0xaf606a6c, 0x7ebf8483, 0x2810d904, 0x84f3655d, 0x7983f269, 0xfb7936e6, 0x9170f6c0
.word 0x087d36a0, 0xe4f30dbb, 0x0aa62885, 0xb5aebe48, 0x2792a444, 0xbc805af3, 0x59a49b46, 0x51700b4c
.word 0xc9a49147, 0x49ca7eff, 0xb53bfe5c, 0xa1c88be1, 0x9af0015c, 0x384652e6, 0xa2076ab8, 0x8c01eb9a
.word 0x5561c933, 0x02b48868, 0x6b409222, 0xa253c324, 0x8a1e24ca, 0xa50b7ccf, 0x4eb76033, 0x58c1b19e
.word 0x1e3b871b, 0xde3304c2, 0x270f730f, 0xde16bf20, 0x37bfa6ac, 0x977a4e6f, 0x0822381a, 0xcf00555b
.word 0x7073c4f7, 0x263af9aa, 0x6f6bfda8, 0xe274f708, 0xc528d473, 0xa0058e45, 0xad2c4daf, 0xd4f88702
.word 0xa59d4883, 0x5cf0d551, 0x526451f1, 0x8ee28ce2, 0x5faae5b4, 0xe86d68c9, 0x868e55a1, 0xcdeb4227
.word 0x4c787484, 0x8db4617e, 0x20c0837e, 0x7505a0f4, 0xc4b9da37, 0xbdfefab0, 0x379c6b9d, 0x7933cdc0
.word 0xd8be237c, 0x9eeefbe3, 0xe8bd98a6, 0x8c1ba2b5, 0x0f8f8f89, 0xcf34f95e, 0xddaf50aa, 0xe44c64d3
.word 0x180a114d, 0x7f1a6b6a, 0xae0f9006, 0x0d51e5bb, 0x10becf0b, 0xe98663ea, 0x65e00624, 0xa9259de1
.word 0x13346291, 0xaab1867b, 0xaafeaf88, 0x4042e54e, 0x22995b74, 0xd85ef1fb, 0x5feb0c9b, 0xde08664e
.word 0x2a634b6d, 0x74b0325b, 0xbbdf553c, 0x19e924e7, 0x1b3f5049, 0x0fc69cb9, 0x25cb8c75, 0x9e64c163
.word 0x3a187f22, 0x433e0e00, 0x8d52c7dc, 0x3800ad47, 0xd8488619, 0xb33a5bcd, 0x0d8a6988, 0x741982ca
.word 0x2f98da90, 0x2e0daba7, 0xfde4a4e7, 0xcb910939, 0xb6d4ea75, 0xebd29ab2, 0x5d6aac1d, 0x0b50ac62
.word 0x8e1a02ba, 0x637eac4a, 0x1840ceaf, 0x9ebeb78c, 0xf8510883, 0xe822e923, 0x5458598d, 0x627a0b05
.word 0x1f7d1bc5, 0x1eb33f09, 0x09a19db9, 0xbe8d6810, 0x4aaac924, 0x92fd032b, 0xe0ceab70, 0x37c101d0
.word 0x8cba3a3f, 0xb202e35a, 0x340c7c6b, 0xd309c34b, 0x14da0df7, 0x16988799, 0x8ea1617e, 0x9f282733
.word 0xc73e11b1, 0xe5590f1b, 0x2601b096, 0xeca88e12, 0xf8076c32, 0x9370917f, 0xb7659dd5, 0xddbbc678
.word 0xc53d6a13, 0x9f183567, 0x61ba6a07, 0x71005aac, 0x6019e3f5, 0xef9e76c6, 0x666466f1, 0xd75902a6
.word 0xc8b1d949, 0xd3dfb38c, 0x7f30cf92, 0x0920889a, 0xa1e7bc98, 0x749d3591, 0x876a46ca, 0xa850a76e
.word 0x9e5dd518, 0xbe29b21e, 0x1e892784, 0x363173a5, 0xcc6b32ca, 0xef86f572, 0xcd77dd79, 0x65bc05af
.word 0x7dddde52, 0xfafd275b, 0x9f77d419, 0xfbc0b2ae, 0x0874b22b, 0x7a5ef0d8, 0x1e4eb6a6, 0xbd4cdb91
.word 0x488d7669, 0x2de5e2c7, 0xb75cffa3, 0xecef83e1, 0x1f0498d1, 0x146415bb, 0x860a1d66, 0x4babe09a
.word 0xa50d4c8a, 0xf3da0426, 0xa257a2ca, 0xf726b758, 0x56be5a85, 0x5b1dca6e, 0x409e58b3, 0xb07516a7
.word 0x60008dc0, 0x34348ffc, 0x077795a3, 0x91d548d9, 0xde9f5612, 0xc4f98699, 0x5125491e, 0x603a317d
.word 0x98312961, 0xb3bd3d8b, 0xe4e28a1f, 0xe1ed27f2, 0xab818166, 0x9ab5b3e0, 0xbaef5ab6, 0xf8172423
.word 0xfd25d894, 0x31098d05, 0x769a6d2b, 0xccffd263, 0xcd5b0af6, 0xbbf7dd87, 0x483f33db, 0x574e25f9
.word 0x850f68e1, 0xed20f0da, 0xf733109a, 0xf8215fcb, 0xbb89d759, 0xbb6e84d3, 0xb0f12692, 0x0ce87cd3
.word 0xb4b29759, 0xc91cb733, 0xa688eeb5, 0xdd932287, 0x6ef2921c, 0xd9e32a77, 0xf3262ffd, 0xd95cf08b
.word 0x14bc896e, 0x7f8859a7, 0xac1bf21e, 0xf4dfcd41, 0x1a3fdf29, 0x6f6d9d5b, 0xd80260e9, 0xf2e8cea9
.word 0x140a22ad, 0x16b571e3, 0xbe559999, 0x9e77e7f9, 0xc4c3c6b1, 0xc3799ca5, 0xd22b52bb, 0x80f518ad
.word 0xf479f72c, 0x4a533088, 0xc5bd4e5a, 0x7c9ec3b8, 0x63fea7fc, 0xfccc42b4, 0xd85966cf, 0xc92169d9
.zero 7168
mem_region_end:
