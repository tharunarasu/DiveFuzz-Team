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
  li x26, 0x0000000a00743908
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
  li x1, 0x512b65a39ad57e47
  li x2, 0xc0a123fff2c8a6c4
  li x3, 0x37f66eae9321c4e1
  li x4, 0x9b014c641b71481c
  li x5, 0x85866789248446c7
  li x6, 0x3705e33829ced2f6
  li x7, 0x3fd7ae1d5b8777d4
  li x8, 0x2cf921d679c422e6
  li x9, 0xf3ca0a3a83f43d48
  li x10, 0x49a12e9af9e1c90e
  li x11, 0xe9bb061ddfae53bf
  li x12, 0x6288962070dbf1f0
  li x13, 0xb0c5673bba0e9451
  li x14, 0x0445d809db9e9516
  li x15, 0xd77d2c6946e13f21
  li x16, 0xdbd34921c0ba99dd
  li x17, 0x67a3fc12d8b931c1
  li x18, 0x72a9946837e74238
  li x19, 0xde6f87f604b8f631
  li x20, 0x4e8d3196a4e0be62
  li x21, 0x26a6c4da4e03a3fc
  li x22, 0x024e700597310a50
  li x23, 0xcaaeebd2e5c5e4fe
  li x24, 0xaab8195a08a46b95
  li x25, 0x694d5de0b62d1cb9
  li x26, 0x1c1d70c3f15f1627
  li x27, 0x7ff1b0a0b735919f
  li x28, 0x06750f99c70c0037
  li x29, 0x814d9f2d28775786
  li x30, 0xb8ee6cde9e20a7aa
  li x31, 0xcf38125683cd11f6
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
  or a5, a5, a5
  divu s8, s8, a5
  sraw t0, a5, a4
  divw s4, t0, s4
  sraw s2, s2, zero
  mul a1, a7, a1
  slli s7, t1, 0
  sraw a3, s9, s2
  sll s0, s7, s9
  remuw a5, s2, a5
  mulhsu t1, a5, t1
  sd t1, 624(t6)
  divw s5, s7, s7
  mulw t3, s0, t1
  div s4, a5, zero
  slli s11, t1, 0
  mulhsu a3, s1, t1
  sd a3, 8(t6)
  add zero, a3, t3
  addi a5, s11, -1
  addw s1, a3, gp
  srlw s1, a6, s5
  remu t2, a2, s11
  slli s9, s1, 1
  mulhu a1, a6, s0
  srai s3, t1, 0
  divuw t1, ra, t1
  div s9, gp, a4
  xori a6, a4, -1
  mulhsu a0, sp, s11
  mulhu gp, ra, ra
  srai a6, gp, 29
  remuw t4, t4, a7
  remuw s10, gp, gp
  divu tp, gp, t3
  remw a3, a6, tp
  mulhu a6, t4, a1
  sltu tp, t4, a6
  mulhsu s2, t4, t4
  sraw a6, s10, a0
  divuw t1, t4, s7
  andi s6, a0, -49
  div a1, t1, s6
  sraiw a5, a5, 13
  li s11, -434302737306
  remu s11, sp, s6
  divuw sp, s11, a5
  sub t2, t2, a5
  remuw s4, a5, s4
  div zero, a5, a2
  sd sp, -1472(t6)
  mulhu s9, s2, s11
  remu s6, t2, sp
  li t1, 257638674732
  srliw t3, t3, 23
  divw a6, s1, t3
  sll s8, s7, s6
  remw a4, t3, a4
  sb a6, 1512(t6)
  divuw a2, t3, a7
  srlw s5, s8, a4
  div t3, s5, ra
  remw s8, zero, s8
  divuw s5, t0, t3
  divw a3, t3, s7
  lui t4, 84398
  rem a4, t4, s5
  mulhsu a0, a0, zero
  remu s2, s7, s5
  ori zero, a4, -1767
  and t4, t0, t0
  divw a3, s5, t2
  mulhu t2, a5, a2
  srai a4, s3, 48
  slliw t3, t2, 21
  and ra, t2, sp
  add a0, s3, zero
  divw a1, a1, s3
  sra a2, a0, ra
  rem sp, t1, ra
  mulhu t4, a0, a1
  divuw s9, s9, t1
  remu a4, a0, s10
  mulw s3, s1, a4
  mulhsu s1, tp, a4
  mulhu a5, a4, a4
  divw a1, a4, a5
  sra t1, s1, s3
  divw a0, a2, a0
  or a1, s5, s7
  sllw a3, a1, a3
  srliw s0, s6, 1
  divuw sp, sp, sp
  remw s9, s3, sp
  mulhsu t4, gp, a6
  mulhu s2, a6, s2
  divw s4, s2, a7
  divu s7, s4, t4
  divuw s1, a7, s7
  rem s8, a3, s7
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
.word 0x526f46b4, 0x869db0cc, 0xd5e238f1, 0xe8c9b238, 0x0badfff3, 0xa2378fa1, 0x482e9f05, 0x38489332
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x645f738b, 0xf438808c, 0xa064a99b, 0xd1d4c3a7, 0x322bd04e, 0x59ed4615, 0xd3fe1885, 0xb7856691
.word 0x0019ef6f, 0x283b8492, 0x86693d9d, 0x657c3e98, 0xbc460485, 0xb77a249d, 0x607150f6, 0xae4f463d
.word 0x2abd5f27, 0x0bae6e9d, 0xc47eda11, 0x1ab478ee, 0x39f9bc72, 0xb29140e8, 0x729c4ef0, 0x254d5b36
.word 0xd79dc9ee, 0x2dd7fcf1, 0xe9bf03c6, 0x7962d6b7, 0x22c1920c, 0x4a100320, 0xdad88f03, 0xf6e99116
.word 0xfc8f4550, 0xf5c046d4, 0x36b94cc9, 0xe0e0397e, 0xc36f37fb, 0xbdb5fde0, 0xc4510c1d, 0x6647b456
.word 0x07fa0b11, 0x35428473, 0x317d4fa3, 0x9de3bd66, 0x171695b4, 0x96ade27d, 0xad735d5b, 0xbc185e69
.word 0xb42ae244, 0xce63bef7, 0x14d95c38, 0x12fd14e7, 0xc6ee7b69, 0x2454ffb0, 0x59b8f306, 0x33e4e469
.word 0x300e6e47, 0xb8b63fe8, 0x55fcc6b5, 0xa9f54eda, 0x53001b3d, 0x8ccd6a32, 0x45fbdf38, 0x857430fa
.word 0x936962be, 0xdd9c3038, 0xb50980d2, 0x00248473, 0xff03dfd5, 0x0f5fe011, 0xc5ca328c, 0xcf274717
.word 0xc770daf9, 0x2de11741, 0x86ebc05f, 0x00fce572, 0x5ac8fcb6, 0x963e0f14, 0x260d15fe, 0x42868323
.word 0xaf3b510f, 0xfcc27afe, 0xa3588d93, 0x0acc3877, 0x4dc7b92f, 0x30c09bf8, 0x69f181ff, 0x6986f2a1
.word 0xe83e10e5, 0x98cb0125, 0x4ac99bdc, 0x0e5eb60a, 0x143a3b6f, 0x9ab1a366, 0x26765f79, 0x10b85f6e
.word 0x0f663c4d, 0xcb25b1b6, 0x43d19ec1, 0xc43ed828, 0x72f19b54, 0x48eaee07, 0x0c0e8178, 0x7026024b
.word 0x37d563cf, 0x898d4ea5, 0x1f45f6e9, 0xab999278, 0xb3d0bd35, 0x3a5f4492, 0xea8833fa, 0x2a80ff90
.word 0xb8078e5b, 0xb97164fc, 0x74373746, 0xa29f871d, 0x15723404, 0x4bf02466, 0x9de045c6, 0x7d145520
.word 0x50eb7a0f, 0xef507be8, 0x03f7b2d8, 0xe4c41e2a, 0x15c9efe8, 0x18e752d4, 0x5fe911d3, 0x2e8ec62c
.word 0xdfcfc9a9, 0x557a95df, 0x4f93a4b0, 0x1eb562c5, 0xdd7bd9c6, 0x1e00450c, 0xacd18523, 0x2034b652
.word 0x2765afcb, 0x782c75c7, 0xaabb02c3, 0x6aa8789c, 0x03a28ae9, 0xb5ecd5f4, 0x852c44d3, 0x02e451f8
.word 0x7a406a86, 0x1366a770, 0xe5df90bf, 0x816dc203, 0xf2a8c875, 0x5a18ff24, 0x68b3a781, 0x3af94dc7
.word 0x18cc85a2, 0x2e46f630, 0x5cf710f7, 0xf445a939, 0xcf720690, 0x4880dff7, 0x6fb88856, 0xbb9ac691
.word 0xb7dddd19, 0xf437a351, 0x08ea4204, 0xd88c702d, 0xbb2ff0e5, 0xbf62597d, 0xd1524131, 0x63fbccaf
.word 0xec6fac74, 0xffaf9f12, 0x00d9d218, 0x865a3f0b, 0x4a054eac, 0xb61f692a, 0xd375cb19, 0x38906e30
.word 0xecec91e4, 0x58c26567, 0x70b1fee3, 0xf029e952, 0x7387fb27, 0xa5b071d0, 0xace4d26c, 0x19be78c5
.word 0x216f0729, 0x1b4d6062, 0x50dc91cc, 0x8d973d02, 0x890293a2, 0x79485984, 0xf03632a8, 0x38dda842
.word 0x83231a26, 0x3edafd04, 0xd4145c6b, 0xde6fd45d, 0xa9750b6a, 0x0ecc04aa, 0x91143d38, 0x63de4659
.word 0xb90616b6, 0x6c027f49, 0x16d8010e, 0xc9b2acbc, 0x4128fe3c, 0xf16af974, 0x78ed65f5, 0x1b9c8eb6
.word 0x81ede8d9, 0xc740e5d8, 0xe9958067, 0x8715c8ec, 0x21ecca96, 0x868e0ac0, 0xd36f4cae, 0xc15342e2
.word 0x4e637329, 0x1e768993, 0x2cc4b95b, 0x60b46068, 0x586826b6, 0x69ae893f, 0xbabcde6e, 0x4698dff4
.word 0x7f8014ce, 0x7485fdb0, 0x9e5432fe, 0xd6f3459a, 0xd1d4f2e5, 0x2e39d65c, 0x7c559932, 0x997469bc
.word 0x5edfb9e1, 0x48ed0a80, 0x73135292, 0x92b7fc4b, 0x6a4b3faa, 0xa45e6ced, 0x1ea20fc5, 0xc4d5e2f5
.word 0x81decde5, 0xa6cd5751, 0xcaa09460, 0xff8f72cb, 0x2195ac09, 0x37605fec, 0xe8cc615c, 0xfef0c032
.word 0x593c5cc9, 0xaa0965b7, 0x0a7e6892, 0xdd5c3180, 0x5c584236, 0x182a321d, 0x46fbe08d, 0x1ed87dd6
.zero 7168
mem_region_end:
