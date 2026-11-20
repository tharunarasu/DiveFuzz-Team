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
  li x26, 0x0000000a00441880
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
  li x1, 0xb6ec7f9024a81c33
  li x2, 0x20b4179b06d59f4c
  li x3, 0x17c4ee5e27464377
  li x4, 0x83418144d61a9718
  li x5, 0x6e6bbdab531b31be
  li x6, 0x07f14cba4d8c006d
  li x7, 0x6d4f024a1e2be049
  li x8, 0x7a9f05df1ef65bc3
  li x9, 0xbb50d887f7d3d0f8
  li x10, 0xdf2cd35c0cee93ed
  li x11, 0x4b86f3d7fbd46bc1
  li x12, 0x079e03318d619b09
  li x13, 0xe52cec753f57f80f
  li x14, 0xd89ef93a0414410e
  li x15, 0xb28da222e1b3dd75
  li x16, 0x4903753163c370e9
  li x17, 0x71ad1af8f2ca46e3
  li x18, 0xb7409c2d0efa974e
  li x19, 0x2ff0ea7acc288afc
  li x20, 0x7cec5a92a9313104
  li x21, 0x6c59e5a5cf101971
  li x22, 0xcd537a6a7db6a004
  li x23, 0x64e5239fb7e83f45
  li x24, 0x2a44aa1070aa7b32
  li x25, 0x77b3212a3c30a6ec
  li x26, 0x2c11496b21bd498c
  li x27, 0x2c5fb06078ec48fb
  li x28, 0x28560d55bc8a56f2
  li x29, 0x76b99d43054047c7
  li x30, 0xfc5d013b275a3ea1
  li x31, 0xc3884dfceb2a326a
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
  mulhsu t1, t1, t1
  sw t1, -604(t6)
  remw s1, t1, t1
  remuw t3, t3, s1
  remw s6, a5, a5
  remu ra, ra, s3
  remw s8, ra, ra
  mulhsu t1, s6, ra
  remuw a1, s8, s4
  slli zero, zero, 42
  lh s2, 1652(t6)
  sraw a1, gp, t3
  mul s7, t0, a1
  sltu a4, s2, s2
  sraw s7, t3, a4
  rem s4, sp, s6
  divuw a7, s4, s4
  remuw s5, t2, a1
  srai a1, a1, 1
  or s9, ra, a1
  mulhu a7, a7, a7
  divu t4, s7, s8
  mulw a1, t4, a1
  mulw t2, t0, t0
  sb a1, -303(t6)
  slli a4, s2, 37
  sltu s9, s11, s9
  srlw a7, s9, t4
  addi s11, s9, 0
  remu s1, t1, t2
  div a3, s0, s9
  mulhu s0, s7, s7
  mul zero, a3, t4
  or ra, tp, ra
  remw s7, ra, s7
  andi s2, ra, -1
  divu a5, zero, s4
  subw a2, s2, s6
  divw t3, s1, sp
  mulhu s3, sp, sp
  sw t3, 1844(t6)
  remw t4, t4, t4
  srliw s1, t4, 0
  mul a3, gp, a3
  mul a1, a3, tp
  sh a2, -162(t6)
  sh s1, -1680(t6)
  mulhsu s1, s9, a1
  addi s4, s3, -1
  remuw s8, s8, a6
  mulhsu s7, a6, t0
  divw s9, s10, s8
  divu a7, t2, s3
  srai s9, s6, 54
  srli s11, s11, 5
  mulw s2, s9, a7
  remu s0, a6, a7
  remw a2, a7, a7
  divw a5, a5, a5
  ori a7, a7, -1788
  remuw s4, ra, a6
  mul tp, a5, a7
  divw s8, a7, a2
  mulhu ra, ra, a5
  or zero, s4, tp
  sd ra, -144(t6)
  mul t0, t0, ra
  sraiw ra, s8, 1
  addw a4, s8, s8
  sh ra, -356(t6)
  sb t0, 379(t6)
  divu a0, t0, a2
  lhu t3, -298(t6)
  sraw s7, t0, a0
  sltu s0, a4, s0
  srai a5, a2, 49
  mulhsu s3, s8, s3
  mulw s8, s0, t2
  srliw t4, t2, 27
  div t0, t0, t2
  divw s9, s9, s10
  mulhsu a3, s8, s5
  mulhsu a0, sp, s9
  divu s8, tp, a3
  divw s7, tp, t2
  remuw t4, tp, t4
  mulw ra, t4, s8
  xori s6, t2, 1152
  divu s0, ra, s0
  slliw a7, s4, 21
  mulw s5, zero, s5
  srlw gp, gp, tp
  xor s10, sp, sp
  srliw s8, gp, 0
  srlw t2, t2, a7
  sw t2, -1512(t6)
  sraiw a5, t2, 10
  sra t2, s10, a5
  remw a1, a1, s10
  divw s6, a5, s11
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
.word 0x8860abd0, 0x5b7cb07f, 0x8dee300d, 0x07f18001, 0x9b60486b, 0x534c838d, 0x25e47ac1, 0x4fe746e4
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x70c05067, 0xa74d6b15, 0x63b608ec, 0xe05eacbf, 0xb892fe9c, 0xf19e267d, 0x7d6a0fb3, 0x6d6dc210
.word 0xa7eb2b7f, 0x38aa76a0, 0xeb3c3b3d, 0xbcd5e1a9, 0x7c900bf0, 0xf9b60604, 0xcc174556, 0x6e75db04
.word 0x905d30bf, 0x195370d8, 0xf6052dc7, 0x7018c74f, 0x79f87eee, 0x6934dfb0, 0x3fb0b59b, 0x4320584d
.word 0xf2f2dc9b, 0xba07e4d4, 0xbe0285e4, 0x38018e44, 0x24b38b89, 0x6f269675, 0x5bd91bec, 0xc2e18f41
.word 0x7e4e57d0, 0x8e457e1c, 0x0dcbba58, 0x1a2b10ce, 0x37d97138, 0x46429b2c, 0x1c411d02, 0xe101b84d
.word 0x1c35d912, 0xb37ba9d1, 0x154dd097, 0x6071377d, 0xdad700f4, 0x84efecf3, 0xd685c3ef, 0xfcf9b27c
.word 0x7f3672ac, 0xdb8eed25, 0x569d925a, 0xc0606fc5, 0xe27d7317, 0xb7bdc4dd, 0xc5d025c8, 0xc42e3e71
.word 0x7017aa51, 0x208f758a, 0x5d131420, 0xf2915c92, 0xffd2f79c, 0xe62a708a, 0x02eb97a0, 0x197e4fae
.word 0xaf12fdd6, 0x53ab824e, 0x93e8958f, 0x359a6124, 0x47920a12, 0xd92962d6, 0x866f6958, 0x07142f9a
.word 0x3229d802, 0xc9a438a9, 0xb1857bf8, 0x5207d043, 0xac837e8c, 0x84b9ceca, 0xafd71e7f, 0x7dcb0580
.word 0x9ad6d849, 0xc9baeb05, 0x09c9ece4, 0xcfdfc935, 0x01f2439b, 0x6b9c5bc0, 0xbfde418c, 0x3c6af014
.word 0xfef37332, 0xd2d0a4e1, 0xacddc472, 0xa9380ce2, 0xf6847b5b, 0xc356da9c, 0xe20125b6, 0x58ca9822
.word 0x6ef6d7f6, 0x95f8c277, 0x95718767, 0x0fa56b7a, 0xf2f4c817, 0xbe95049e, 0x080032a7, 0x060c94aa
.word 0x36b5a976, 0x28163bca, 0xcff7d9ab, 0xa1201a6b, 0xf8c37fd1, 0x8140f347, 0x1b4d4cd9, 0x4c28318f
.word 0x8d9a05fb, 0x5acbee7a, 0xf39f196e, 0x9b166f63, 0xb9a6537d, 0xc505e9c0, 0xdc547208, 0x63dddf2a
.word 0x3dbd62a6, 0x41f0ce9b, 0x635bd2a3, 0xf98816ef, 0xbedc83da, 0x451b84be, 0x3f7ac451, 0xd154a587
.word 0x565bda28, 0x8401656e, 0xe86d2e58, 0x2d8fe2dc, 0xe755d190, 0x413e6df8, 0x88f1c610, 0x3be3feea
.word 0xa01fa4a4, 0xf9c6db7f, 0xe2de20f6, 0x09b8926d, 0x02cc1a11, 0x57368ac6, 0x307ddfc5, 0x1798ef08
.word 0x50bc704b, 0x76a9f4fc, 0xd5bbef2f, 0x13f11d25, 0xe3c88ba9, 0x233d5942, 0x85b48d41, 0x2b36736a
.word 0xd08a5309, 0x3a099508, 0x044372fa, 0x8350acfe, 0x894d156a, 0x4db353da, 0x736a0278, 0xa76bf8e5
.word 0xab295d49, 0x8850fe71, 0x1a665330, 0x7e8bb656, 0x39528b5f, 0xb8b250b2, 0x44bd4b35, 0x8d70510f
.word 0x9dd25090, 0xa9fd0d62, 0x3ce11d1e, 0x9bd71ec2, 0x68cc82f4, 0x122f7af4, 0x91e08422, 0x8c143d9b
.word 0x9d6a8013, 0x5e2d18a8, 0xfa957899, 0xfd4bcf32, 0x4d64eef6, 0x82a58681, 0x07fcfab3, 0xc855a954
.word 0xec25bb75, 0xac9932cd, 0x9fb2dc97, 0x5b88e2e6, 0xd9c8a600, 0xc9e60562, 0x70fa629a, 0x3634e17d
.word 0x9c0c8b3d, 0xa7e7fa20, 0x3dc7c35d, 0x3b0d2e0b, 0xc4b01925, 0x7cac3e29, 0xa5308d3b, 0x6808d231
.word 0x76e5ce4a, 0x07d3853c, 0x990f55c2, 0x621eacad, 0x84bdcb55, 0x166ef84e, 0x1b1de1b4, 0xd6debf2e
.word 0x5fa3ffb6, 0xed36c5aa, 0x5843e630, 0x03b32d68, 0xe2027a44, 0xa8aaf804, 0x819ed299, 0x2c666d6a
.word 0x19358634, 0x628f51aa, 0x4f7f1e97, 0xad8a710b, 0x188beacc, 0xbd4cdf46, 0x2170a70e, 0x672d4790
.word 0xa12110c3, 0xe66b4f69, 0x734b69be, 0x861ace50, 0x900f7806, 0xb090cd47, 0x231b1527, 0xb45a6d9c
.word 0x7c2a1005, 0xba37fb46, 0xfed977e6, 0x6a9f9ca5, 0xe54151bd, 0xdcea392e, 0xafc3c681, 0x211eca2e
.word 0xf213c03a, 0x4db7aa96, 0x2ea57b31, 0x5e47a6b1, 0x428bf619, 0x37692936, 0xbc7e31a2, 0xfe7c6dc3
.word 0xf0ad4d0b, 0x5510003f, 0x0ebcbf10, 0xf5ea1d6f, 0xbbc40267, 0xa2e851a6, 0xbb954554, 0xc1d09503
.zero 7168
mem_region_end:
