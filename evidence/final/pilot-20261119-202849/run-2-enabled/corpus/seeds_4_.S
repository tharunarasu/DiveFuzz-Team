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
  li x26, 0x0000000a0048790a
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
  li x1, 0xf8aa726b66778a47
  li x2, 0xd225d284ec26968e
  li x3, 0x42c8b72b1d5888a1
  li x4, 0xc94e90031ed4060e
  li x5, 0xf01e8e03fb801672
  li x6, 0x917279b000b9f9b3
  li x7, 0x29de43e743c3786b
  li x8, 0x3f19b9c4661dc5db
  li x9, 0x102c3a2e081521bc
  li x10, 0x7ab0e6bee366b86c
  li x11, 0x2956a7bcf29499b7
  li x12, 0x73c9c493c102c6f9
  li x13, 0x1d6fd6c70adbe06c
  li x14, 0xb6b373dc677c0492
  li x15, 0x070c04d14f83d47e
  li x16, 0xf5b3c6b5518b872a
  li x17, 0x7fca43860062cb5a
  li x18, 0x59bf098c8c4d7e3f
  li x19, 0xd5c148d7dab4bf41
  li x20, 0xe28fed68cc642ebf
  li x21, 0x6116514c44300a93
  li x22, 0xa637ea7f1318736b
  li x23, 0x1d1c90e379899d94
  li x24, 0x5979e930ce140186
  li x25, 0xd928f002726feaac
  li x26, 0xaf417aa1cb5d096c
  li x27, 0xcb1d7f06cf60a8e6
  li x28, 0xd7daeffffe143656
  li x29, 0xb84aeb2aae52ed36
  li x30, 0xb1871f8edae6162c
  li x31, 0x3a2674549c0c71ca
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
  addi gp, gp, 1668
  srli t3, t3, 31
  divuw s3, a2, t3
  mul a1, a1, s3
  mulw a0, gp, gp
  divw a4, s3, t4
  divu t1, a4, a1
  srli ra, t1, 2
  slt a6, s10, a6
  remu s7, a6, s11
  sub gp, t2, s7
  mulhu a1, gp, gp
  sw gp, -56(t6)
  mulhsu s0, s0, a1
  mulhu s9, t2, gp
  remu a2, a2, gp
  divw ra, a2, a2
  mul zero, zero, s5
  remu a1, s5, t1
  remw t1, t4, s1
  slt a1, t4, a1
  mulhsu s11, s1, t1
  addw s6, t1, s0
  mulw a7, s11, s11
  remw zero, t1, t1
  sraiw s2, s6, 0
  rem a4, s11, a3
  lwu a2, -1556(t6)
  remuw s8, a4, a4
  sraiw a0, s8, 9
  rem s0, s9, a0
  divw tp, a3, s0
  mulhsu s7, s9, s0
  srai a3, s4, 1
  slliw zero, a2, 31
  slti s8, a3, 0
  srli s1, s8, 1
  divuw ra, s1, a5
  remuw s10, zero, sp
  sraw s3, s3, s3
  divuw t2, s1, t3
  sraw s11, t2, s11
  xori t3, t0, -1067
  div s2, t4, s11
  srli s5, t2, 0
  and a1, t0, t0
  lw s10, -452(t6)
  divw sp, s5, a1
  sub s11, a1, sp
  mulhu s2, a1, s2
  remw t1, gp, tp
  sraiw zero, s2, 31
  divu ra, ra, t1
  remuw a4, s2, zero
  remw a7, zero, t1
  divw t1, t1, a7
  add sp, sp, s10
  sraiw s1, s1, 17
  remw a0, s9, s1
  slli s9, s1, 35
  sb a7, 931(t6)
  mulhu t3, s9, a0
  srliw gp, s10, 26
  sraw a6, a6, t4
  sll zero, gp, s10
  mulhu s2, s2, s11
  mulw a0, s2, s3
  mulw zero, a2, t0
  srliw a6, s2, 31
  divuw s7, t0, zero
  lui s0, 903496
  mul a3, t3, a1
  mulw s5, s0, t1
  divw s11, t1, s5
  lb s2, 1449(t6)
  divw s0, s0, a6
  ori t3, s11, 1667
  mulhsu tp, a1, s3
  div tp, t4, s7
  sb s7, -863(t6)
  xori a6, tp, -1
  div t3, t4, t3
  srliw s5, s0, 8
  or a5, a6, s5
  and t3, s7, s5
  divuw s10, s5, t3
  addw sp, t3, a2
  remuw t4, s10, t2
  sd s10, 456(t6)
  divuw t2, t3, t2
  remw s11, t3, t2
  divw a5, s6, s6
  mul s8, t1, a5
  sd ra, 1784(t6)
  slt t1, a5, a7
  divu s4, a7, a5
  xori t4, t1, -1
  divw s3, s5, a0
  mulhsu zero, tp, t3
  xor s2, tp, tp
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
.word 0xe392cf17, 0xc8970fa5, 0x7883479e, 0x2fe211b8, 0xbecc8b93, 0xe36f6b65, 0x53130029, 0xbfd6b0ee
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x38ee23d9, 0xd7782102, 0x07bdd7dd, 0x28392fa3, 0x98cb1774, 0x36a0524d, 0x74e6f3f7, 0x27cdf57a
.word 0x88be03cf, 0xe6644cb9, 0xeef14413, 0x3c934263, 0xd91f2f5b, 0x36044d00, 0xa2b08b2e, 0xd2599b3b
.word 0x2d432b1f, 0x4973d07e, 0x9be74bab, 0xbfdc52a9, 0xa9f7090c, 0xfe193e01, 0x5694757d, 0x5ce7a40d
.word 0x9774df38, 0x60dd6447, 0x1d9e812f, 0xbba19f4b, 0xc997997b, 0xad68aaf2, 0x129a7626, 0x21b9191b
.word 0x79ecc34f, 0x01021bac, 0xd588efb3, 0xeeca3157, 0x1bc685e8, 0x68c5fa15, 0xdeaa3688, 0x31cf2174
.word 0x1bd0a906, 0xfeced8fa, 0xe19f4ad0, 0xede41fce, 0xd0daaef5, 0xb2f71644, 0x9dbafa5d, 0x7c9858d7
.word 0x3c0904ce, 0x68d9589b, 0x3963e561, 0x22f4cf38, 0xa7b3577f, 0xc720b7f6, 0x840a5391, 0x57167796
.word 0x20fea36c, 0x86638a50, 0x198a9ec9, 0x214c9b2b, 0xc35f8e56, 0xbeea0ebe, 0x38995eec, 0xc147f2e3
.word 0x77908b8c, 0xf63de922, 0xae611845, 0x0a91723d, 0xa2cc8f49, 0x79638d00, 0xc518a122, 0xec620ad8
.word 0x8c3a5cbe, 0xcc6e0f26, 0x29981bba, 0x6fe2eda4, 0x46d6aea5, 0x4fca6057, 0x7b9639ae, 0x36385588
.word 0x5ba7e4b1, 0xc0dd00f3, 0x363c2344, 0xc4bb9536, 0x3ca85492, 0xc1cae023, 0xdc48ef54, 0xc00cb687
.word 0x3be7b8ff, 0x79353e46, 0x79eed3e5, 0xa770f086, 0xd31c7fa7, 0x8d0eb159, 0x95ca1390, 0xcd12a132
.word 0xbbe401a6, 0x55e65455, 0xba58c1c0, 0x112eaa39, 0xc5de940d, 0x8e6b2d9e, 0x13a852b7, 0x43956d85
.word 0x3e69c458, 0xb3a1bde9, 0xe23a8ea1, 0x9d184371, 0xcaf9552e, 0x52330a90, 0x38a979b2, 0x6ed4eebf
.word 0xbc36df9e, 0x0d7f43e5, 0xe19e3c6b, 0x5206698f, 0xebcc3ce3, 0x96afaf20, 0x0bd8ece3, 0x40317a06
.word 0xc88462ed, 0x1a69aa77, 0xe5c69a44, 0x9362f2be, 0x16d38417, 0x9e1e6dd3, 0x20c15f31, 0xf82a996a
.word 0x97bdca9f, 0xa9c221d9, 0x084f9365, 0xef729e14, 0xab5b6c26, 0x6b2884c5, 0xf9be821e, 0xbf3d31e3
.word 0x7c8c21f9, 0xd710d259, 0x6f87e3dc, 0x05b82d09, 0x0b356b8b, 0x096a1ca9, 0x5ca7dbb6, 0x6aaaa3ad
.word 0x851aef70, 0x18928af8, 0xc3d0b104, 0x70fc8d6e, 0x6f6f22b3, 0x9895326b, 0xe5041908, 0xce4f425d
.word 0x998a6416, 0xc80d419c, 0x2e8273d9, 0x7b56c8e0, 0x3714595e, 0xae428849, 0x4fb8e208, 0x1358056d
.word 0x91749371, 0x7810931d, 0x8d07bf3d, 0x96f34942, 0x314f831c, 0xf99f51b4, 0x9e9d1eef, 0x627e53a8
.word 0x7c808f2b, 0x341e4d18, 0xdac9d775, 0xe5198878, 0xb585e292, 0xf8842a9f, 0x8ddc5602, 0x042dd034
.word 0x460b6a50, 0x4e0c7225, 0xcea7defa, 0x582ebf02, 0xfd843f1f, 0x23a9c63e, 0x1d69d89f, 0x7b26bc4a
.word 0x3eaddf99, 0x009785fe, 0xcc3437cc, 0x5a91a5e0, 0xc3c928d1, 0x042b7237, 0xac0836ba, 0xd7cc18c6
.word 0xf6d8515a, 0x0c5b7dcc, 0x52ad7147, 0xb9626583, 0x89f25640, 0x101c1997, 0x7b109541, 0x28406788
.word 0x222ff49c, 0x1167bd19, 0x9450f4b4, 0x8a132dbe, 0x4eda7281, 0x9b4b7638, 0x0bf4fbd0, 0x76d41415
.word 0xdf20046d, 0x378737b6, 0xcee14252, 0xb314e766, 0x46ccd9de, 0x2b80ceac, 0x5280e21c, 0x2c4f5941
.word 0x16f929bf, 0x912a8331, 0x3edc1f40, 0xde1ecc9c, 0xae8efb0a, 0xd9915802, 0xe89d624e, 0xbce1295e
.word 0x1245937c, 0xe812be19, 0x986cf3e2, 0x696937da, 0x913b2e3c, 0x65cf2525, 0x503cfbbb, 0xf01c5fb3
.word 0x1df88273, 0x37835b35, 0x2f8933b7, 0xea0b165b, 0x92a3d836, 0x63340af1, 0xd7079ecb, 0x61d96a67
.word 0x54705f43, 0xba07f42f, 0x566407ad, 0xaa937a73, 0x410e44ee, 0xebcad406, 0xaa2bae0e, 0x59ae6c23
.word 0x2a28cc21, 0x2c9abf1c, 0x138e4d99, 0xab67f1eb, 0x9a4e28c9, 0x735cc4b5, 0x9ccfaf1e, 0x0cfde8ee
.zero 7168
mem_region_end:
