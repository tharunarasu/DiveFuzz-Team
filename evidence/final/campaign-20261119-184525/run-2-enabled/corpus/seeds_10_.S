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
  li x26, 0x0000000a00284100
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
  li x1, 0x52d0d9532c59f707
  li x2, 0xf135f15967f43af9
  li x3, 0xe91daf5082f79aca
  li x4, 0x9afe711b75d3fd43
  li x5, 0x1c884c4404fc4aab
  li x6, 0x4a57523ea9c0bb92
  li x7, 0xa18c9b84ed29d447
  li x8, 0x9bb99dec618c772c
  li x9, 0x2a84c49fd4c48745
  li x10, 0xd4d232a06366b15d
  li x11, 0xe26fab64b63e2f74
  li x12, 0x8c3718bacfbfcb7c
  li x13, 0x4d14577686690e9b
  li x14, 0xa6014d72a567e07f
  li x15, 0xde00e7e43c0732ca
  li x16, 0x3eacd1799899136e
  li x17, 0xc1f56bef983b57af
  li x18, 0xef1a1da2df7e9ee0
  li x19, 0x963d8fe40c00597d
  li x20, 0x93817e399c80442e
  li x21, 0xc78009fddf332c68
  li x22, 0x2e59548b06d93df7
  li x23, 0x1eb6df1a97e3fe6b
  li x24, 0x7194d42876657486
  li x25, 0x966e484b893f5ee4
  li x26, 0xec60ae2a67c26dcd
  li x27, 0xbbf29d88b76d1c63
  li x28, 0x7faffb9abd716fda
  li x29, 0x61dee7d3f1a84e9c
  li x30, 0x3bd8e9cee09306ba
  li x31, 0x00fc2e3a85f4f7b6
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
  rem gp, gp, s11
  srli a0, gp, 63
  srl a3, a3, zero
  srliw a0, a0, 13
  lbu a2, -1332(t6)
  divuw t3, s8, zero
  or s0, s0, a2
  subw s7, t3, a3
  add s1, a2, s4
  divu sp, t4, s7
  slliw a1, a1, 0
  mul t4, s8, a1
  remu s2, s2, t1
  sraw s9, t4, s1
  divuw t0, t4, t2
  srai t3, a2, 42
  sraiw a4, a4, 0
  xor zero, s2, s2
  srai a3, a1, 9
  remuw s10, a4, t3
  subw ra, s10, t3
  slliw a4, s5, 31
  remw tp, s5, s6
  mulhu t0, s5, t3
  divuw s4, a4, a1
  mulhu s8, s4, s8
  sd a1, 224(t6)
  sra s0, s4, s0
  or t4, a2, s6
  lui s1, 787242
  remw s0, a2, a1
  divu ra, s0, a6
  srai a6, a2, 0
  ori s6, a0, 1844
  divu s4, s7, a7
  divuw sp, a0, sp
  sll t2, t2, t3
  sd gp, 952(t6)
  divuw s10, s4, t2
  srliw t3, zero, 28
  sb s6, 369(t6)
  divuw s3, s9, s3
  divuw s9, s9, s0
  mulhsu a3, a3, t0
  remw s2, s2, s9
  ori a5, s9, 725
  subw s3, a2, s3
  ori t4, s2, -1531
  mulw t0, t0, t4
  remw s10, t2, s2
  addw t3, t2, t4
  srli a3, s10, 29
  sd t3, -1104(t6)
  mul t4, t3, s0
  slli a5, s6, 63
  sd a3, 968(t6)
  srliw s10, s0, 10
  remw a0, s5, a0
  divuw tp, a5, tp
  srai t2, t2, 33
  mulhsu s11, s1, s11
  mulhu t1, s6, s11
  divw t3, s4, t3
  lui s8, 24896
  xor t3, a4, t3
  andi s2, a6, -2048
  mulw zero, s3, a6
  sltu gp, gp, s3
  mulw s11, s11, gp
  divuw s6, s3, s8
  subw s9, s4, s11
  srliw s10, a3, 28
  mul a6, s10, s6
  srai zero, s10, 45
  remuw s11, a6, t3
  mulhsu s2, s11, s10
  sd s1, -568(t6)
  addw s3, s11, s11
  remu a2, s11, a1
  xor zero, s3, s2
  xori ra, s2, 303
  srlw t1, zero, a2
  divuw s11, ra, zero
  remuw a4, tp, a0
  srai ra, ra, 60
  mulhu s2, ra, a0
  mulw t2, a4, a7
  srli a6, a6, 63
  ori s4, ra, -144
  subw a1, a6, a1
  sd s4, 616(t6)
  lui zero, 10828
  mulw t3, t3, s4
  srlw s7, s7, zero
  srl a2, a7, ra
  slti gp, s7, -2048
  remu s2, t3, a2
  srlw t0, s7, s6
  divw a7, s0, t0
  div s7, s7, zero
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
.word 0x7c67a5e0, 0xc6f4a4de, 0xb03dfa29, 0xe4ab60d6, 0xc3ebc434, 0x2e6e8396, 0xcd77e111, 0xb21cfa4e
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x379e09ec, 0xb7cc6aae, 0x9aefbc36, 0x7be7cac1, 0xbc903bc9, 0xcb73a743, 0x0e812d39, 0x667447b5
.word 0xd55640dd, 0xf2268460, 0xb28c8244, 0x3e2589bb, 0xed3d9ce9, 0xf166b6f7, 0x5a6d2b22, 0x8a92fb2e
.word 0xc7ae5e69, 0x3831dbdb, 0x1153b2ef, 0x19e69548, 0x8fb82623, 0x5f4ecd2c, 0xcb207437, 0xdf37adca
.word 0xc111625d, 0x64c18627, 0xb9b225c1, 0xa2e2fea3, 0x38156ef1, 0x41f86b1b, 0x0e202db1, 0x8b611236
.word 0xf1fe3610, 0xbc34f2ea, 0x847e1ebd, 0xd5a3869d, 0x33ee8af3, 0xb455a118, 0xd1c0199c, 0x6b4cc082
.word 0xf9ee7a3e, 0xa6f268ca, 0xcbad881a, 0x1537cb26, 0x8889e0d1, 0xd74a7d16, 0xe70e6c8e, 0x4fdcecdb
.word 0x62aac0d1, 0xf4bfcd43, 0xa2f162eb, 0x925f3027, 0x1555a2c4, 0x5a5bda09, 0x9dfdfa63, 0xf3fe4099
.word 0xed880815, 0xaf95c8b5, 0x7a7f56be, 0xff802fbb, 0x4d115375, 0x6c12593d, 0x7cfe9609, 0x279def17
.word 0x57b1bba9, 0xcba572f5, 0xf9eb9457, 0x00e0cbcb, 0x75d29641, 0x90906112, 0x03dbba70, 0x41a4d801
.word 0xb8756e59, 0x315633b8, 0xc56a0464, 0x3f9568da, 0xeec04989, 0x2086a533, 0x7757ecc9, 0xfcc11045
.word 0x88275162, 0x6c1d905a, 0xe5ab7111, 0x6e5d7c1e, 0xd88e1ed4, 0xf362be4b, 0x9ddfd9d9, 0x21f7f183
.word 0x2f05a38c, 0xa0749e19, 0xf3c662fc, 0xb7fdecd0, 0xf8a4390b, 0x90f92e4a, 0x642acadc, 0xc8080026
.word 0xd8f2f979, 0x0812d570, 0x463410c9, 0x60ac0696, 0x65cc1b37, 0xa89e0329, 0xe4db2fcf, 0x8a8a8de1
.word 0x4266a2c1, 0x8db6faa8, 0xda5eba06, 0x3e6790f0, 0xce3e64f5, 0xac361119, 0xe73ba884, 0x578027eb
.word 0xd4812c57, 0x362f3bc9, 0xb0a4b3a4, 0xa3cfdec0, 0x336e6f1f, 0xa64abce2, 0xe723cbbf, 0xf5db66a1
.word 0x11b87cb4, 0xd6a8794f, 0x241c57cb, 0x5965c2ae, 0xaab0cb27, 0xae2185a6, 0xb0ea6d78, 0x5a2f2ac6
.word 0x207dd435, 0x9df92d27, 0xe86817c3, 0x9df3a4ca, 0x5f1babc7, 0x9c8bd968, 0x90aba2ee, 0x01f6dd9c
.word 0xbc8b3895, 0x140482c5, 0x8d200c80, 0x3550b633, 0x04b5edd7, 0x571b6245, 0xeeaa352b, 0xdfb229a1
.word 0x3ad3a7be, 0xcb58ac11, 0x7a4a7308, 0xb27dec5f, 0xfb627b6a, 0x5dde7616, 0x5799d4d1, 0xe1c2148c
.word 0xd9752d46, 0xab1bdc97, 0xcb4135dd, 0x8a1c4e75, 0x422d2cc0, 0x042fbc8a, 0x9e7fd8e5, 0x39f9e355
.word 0xf6e65f5f, 0xc776e4f9, 0x921bc90a, 0x56625c4d, 0xbe926687, 0x3d03d3c9, 0xc3f23858, 0x1ca87aab
.word 0xf2501edd, 0xdf82338a, 0x27ab953b, 0x5f4444bf, 0x5e93e7e5, 0xc83cb065, 0xcafaeeea, 0xb93264a4
.word 0xf07cf62e, 0x2220eef3, 0xd547a753, 0x8a699ad1, 0xa5e1c02d, 0x4c54eacc, 0x886af67e, 0xcc17bd48
.word 0xbbf04816, 0xfb7850bf, 0x76b4963f, 0x097e0a53, 0xd950c85a, 0x7d48922d, 0xfad3ee99, 0x698bfd1f
.word 0xb1355672, 0x6fe5ef36, 0x629c6a65, 0xe8ae8303, 0x2192f2d2, 0x62b4bed5, 0x1b8b4a8f, 0x2980e1cd
.word 0x6ded8889, 0xd3e3395f, 0x105bc9fd, 0x59d4c468, 0xaaf33fb9, 0xb459c69d, 0x9ad93bcd, 0xe299d196
.word 0xf86e9b78, 0x6a8b9feb, 0x8ced1082, 0x4a832ffd, 0x4642103d, 0xc900d99f, 0x13e7a68a, 0x851acae1
.word 0x13733737, 0xbf604be0, 0x42eae415, 0x9990aeb9, 0x03db8f5b, 0x1b5a9625, 0x085d263e, 0xd3b60fcb
.word 0x3d6bfc4c, 0xcd99dedd, 0xd81d41ac, 0x681e461e, 0xeda76996, 0xe0c54ad8, 0x019dd2e2, 0x3dfa8419
.word 0xbbbdd15d, 0xde0bc207, 0xec3f115a, 0x9999008f, 0x27965669, 0x4437b0db, 0x4bb1ec55, 0x9d197a97
.word 0x8dba8a93, 0x93f93322, 0x18e668e0, 0x00249f83, 0xfa784ae9, 0x9b22a8f3, 0xaf7537ed, 0x0062ceda
.word 0x5a232234, 0x2187b2ef, 0x8447503b, 0x69598312, 0x8502109c, 0xdaaf9d8d, 0x81e42542, 0x4328913b
.zero 7168
mem_region_end:
