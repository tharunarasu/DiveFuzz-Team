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
  li x26, 0x0000000a003c7982
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
  li x1, 0x7eddd2a3cdefec91
  li x2, 0x694f0df1e249a224
  li x3, 0x5480799f80048ab2
  li x4, 0xa5288feea0dd6ded
  li x5, 0x3b1f2e06bf67f77f
  li x6, 0x3b5ccfa5b7d38265
  li x7, 0x0b9fcf2f4d984732
  li x8, 0x9c6db6df3add95e3
  li x9, 0xee63f290e606a3ba
  li x10, 0x973d34d1610ca208
  li x11, 0x1157d2bc1d8a81de
  li x12, 0x6cefab7741622905
  li x13, 0x97db55ef4806247f
  li x14, 0xdb641702716ae860
  li x15, 0x95524e4c8d96dc70
  li x16, 0x5746032741ffdf86
  li x17, 0x347f4e7791fffefe
  li x18, 0xf1bc15606a8682e1
  li x19, 0x1b4919b7213a4966
  li x20, 0x2e34a7fd0036da7b
  li x21, 0x86b66d2feed95ca7
  li x22, 0x87d7a724e160b482
  li x23, 0x64298e8001639efd
  li x24, 0x027db81a66f8efa7
  li x25, 0x38ea7523146e431b
  li x26, 0x3f3ccdb3395bf7a0
  li x27, 0xcb89494f08527808
  li x28, 0xc535e7b3f29e0f79
  li x29, 0xedb48276785e72a2
  li x30, 0x101feaa821fc8430
  li x31, 0x345ec16d78328290
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
  mulw a0, s0, a0
  fence.i
  divuw s11, s11, a0
  remw t0, zero, s11
  addiw tp, a0, 1
  fence.i
  srlw t1, s11, s11
  remw s2, s11, a4
  fence
  ld s6, -872(t6)
  mulw s4, a7, t1
  slti s1, s6, -1765
  remu s11, s4, s9
  mul gp, s9, s6
  div t3, s4, sp
  fence.i
  divu s9, t3, gp
  divw sp, s1, gp
  mulhsu ra, ra, s9
  and a1, gp, ra
  remuw a1, ra, gp
  sltiu s11, ra, 0
  fence.i
  divuw t4, t4, t4
  divuw s2, ra, s0
  sllw s6, a1, t4
  fence.i
  addiw a7, tp, 1
  mulhsu s2, s11, s11
  remu a4, a3, ra
  andi a3, t4, 2047
  remuw ra, ra, a3
  divuw a2, a7, a4
  and t4, a2, a2
  remuw a1, a3, s8
  fence.i
  fence.i
  divw s9, a2, a2
  rem t1, ra, a1
  fence.i
  divuw a5, t1, s9
  sd a1, 568(t6)
  fence.i
  remw s11, s4, a7
  remuw tp, s9, tp
  remuw t3, a7, a5
  addiw tp, ra, -1
  divu t2, s11, t0
  srli s7, t3, 63
  sllw a3, tp, a3
  fence.i
  divu a0, s7, s7
  remu s1, t2, s6
  remuw s6, s1, a3
  sraw s9, s7, s6
  div s3, a3, a0
  mulw sp, s9, s6
  div t1, s9, s3
  fence.i
  mulw a2, sp, sp
  fence.i
  slti a0, s3, 652
  mulw s10, ra, s10
  fence.i
  slliw a7, zero, 10
  srlw s6, t3, s6
  fence.i
  divu s9, a0, s9
  rem sp, s10, a0
  srai zero, s10, 63
  ld a3, -1880(t6)
  remw s10, s10, a3
  sltu t2, zero, t2
  auipc t3, 0
  mulhu s0, s3, s0
  fence.i
  remuw s8, zero, t2
  remu s7, zero, t3
  srli s4, s5, 24
  lui a4, 1048575
  fence.i
  divu s6, s4, s1
  divw a6, s5, a6
  mul t1, a7, s4
  divuw t4, a6, t1
  fence.i
  remw t2, t4, a6
  remu zero, s10, zero
  fence.i
  mul s2, a7, t4
  sd s2, 1072(t6)
  fence.i
  sb t1, 651(t6)
  fence.i
  mulw s2, s2, t1
  remu a0, t2, t1
  rem a1, zero, a0
  fence.i
  rem ra, t2, t2
  div s5, s5, ra
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
.word 0x61cbec4f, 0x79554e01, 0x62c41269, 0x923bfe6c, 0xcd92680c, 0x9aaf516d, 0x57fd6cf2, 0x20a469b2
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x8ff2aa51, 0xe1943678, 0x6c733c05, 0x84ff7865, 0x9ef34ea0, 0x08649093, 0xabc139a1, 0xb929bff7
.word 0x8acf8a64, 0x6f660005, 0x3af5ef96, 0xcc70c3c9, 0x0dcf423c, 0xfda7afe6, 0x0717d2e1, 0x5473f7c7
.word 0x8fcc6cf0, 0x2497c509, 0xcd712ac7, 0xa50103e9, 0x8647a9e7, 0xc0e4b7a5, 0x6da79ee1, 0x6d09b896
.word 0xbeed880a, 0x9c5eeec8, 0x0a71ba1b, 0x2bc60388, 0x21931f3a, 0xe1f039bd, 0x2db35a82, 0x2db020e0
.word 0x45350cb7, 0xc468b248, 0x40adf905, 0x02f297b0, 0x8fcb4e6d, 0x5547f667, 0xce9cce90, 0xa9bc1797
.word 0xcf44b225, 0x341f412e, 0xdfba2ffd, 0xf824705e, 0xf3e4d20e, 0x30505e3b, 0xbe7f3a34, 0x0b8ed4cc
.word 0xa154a8ff, 0xe4021e91, 0xe620bf56, 0x2a418d56, 0xc772d1a7, 0xaad7dad4, 0xb489ef4b, 0x970cc0bc
.word 0xdede4303, 0x53fb4ad5, 0xcfae786e, 0x70610c5d, 0xe02e5346, 0x7dbd3ecd, 0x04138537, 0x473fff6a
.word 0xfd0bfb9c, 0x20b9e184, 0x068b336a, 0x9612eb20, 0x4fadca04, 0x4a989187, 0x95878f3c, 0x89081eaf
.word 0xb736b7da, 0xbe543486, 0x7cd7cb3d, 0x0655cb49, 0x99ae83fc, 0x26619750, 0xab76b1f2, 0x1233ac69
.word 0xf2d1f41b, 0x7efa79ea, 0x59a8d88c, 0xa218ce73, 0xa93792b1, 0x9ac60862, 0xb1953c89, 0x448e713b
.word 0x7a63bf20, 0x856602d4, 0x40bc8af8, 0x974b7615, 0x1f69e5cb, 0xec7fe4ea, 0x061f4583, 0x7c83a6bb
.word 0xb6fe1db2, 0x1587e6c6, 0xf0d305d7, 0x986cf005, 0xf383889f, 0xeaf5cc49, 0x16a9ca26, 0xb6554c1c
.word 0x22b21782, 0xe56dd787, 0x8da3dd8a, 0x2f125018, 0xbec32a2d, 0x5e62df45, 0xfffd81c1, 0x69cded01
.word 0xaa7eb0ac, 0x53a65bec, 0x11d5d3fa, 0x44226541, 0x10cbbee6, 0xb1fad5f6, 0x992cd502, 0xdefdb440
.word 0x954304f9, 0x3d6866c9, 0x915673ee, 0xa403c37b, 0xa24f8c1e, 0x9a8c3288, 0x6327556b, 0xc4be886d
.word 0x8dbc0dd7, 0xb16b95b4, 0x35e81323, 0xbd55f515, 0x3547c6b7, 0x9f10b67f, 0xc65fd8f9, 0x1c836736
.word 0xa8751e8b, 0x8b7e5cdc, 0x3b795053, 0x4aeea907, 0xf27c6d2c, 0x5fbaaeb1, 0x5223b331, 0x4b695b40
.word 0xc1aef11a, 0x4b9ee84c, 0xa32f3722, 0xab689dcb, 0x6f2898a6, 0x2e7fe106, 0x9593d91d, 0x0d577fb8
.word 0xb9c58cea, 0x07a3d239, 0x98d744b6, 0x2a1861d6, 0x9a568c34, 0xbdb15989, 0x899b5e20, 0x41cfcb87
.word 0x0c531cb0, 0xe71d6437, 0x0f7d3a6b, 0x34e9b781, 0x5da45860, 0x74f5fce8, 0x3dcf45c4, 0xbb176914
.word 0x70d9dc18, 0xf6278715, 0x7e83d445, 0x54611a54, 0x83b3ecab, 0x954007e7, 0x90e8688f, 0x2c21d92f
.word 0xbd602685, 0x7c011b3f, 0xa0e386ab, 0xf7db6082, 0x27385af7, 0xe830aef2, 0x78dd1b0c, 0xda3fd0c9
.word 0xb85c6db1, 0x5b6c7452, 0xa5cec37a, 0xf9f80c24, 0xa2859416, 0xe989fda9, 0x4e4f28c9, 0x8a0d3c3b
.word 0xc00ab303, 0xa177a208, 0xc1f5fafe, 0xa2fd9290, 0x3d6baa93, 0x0925969a, 0xf98b8d3e, 0xab4a76a9
.word 0xd3978387, 0xbe51f6ef, 0x179c7ae5, 0x9633c7b8, 0xb0a377fc, 0x5c3c6c93, 0x7353ed89, 0x3dad0e8a
.word 0x1e1cabbc, 0x50260fa0, 0x5371fc10, 0x2c57e44c, 0xdb40ecd7, 0xb5cae9fa, 0xb302991d, 0xbead97b1
.word 0x9a4033dc, 0x2db50773, 0x761f0be5, 0x25dca9ba, 0x35a20b9e, 0xf134936e, 0x3323cfa7, 0x95f9ea1c
.word 0x2a2249e7, 0x4bc07a0e, 0xf94dd2e3, 0x4496854f, 0x8de425d2, 0xd8bc2f8d, 0x73dec679, 0x391e31b6
.word 0x3891bbb0, 0x8256cc52, 0x0bb85680, 0xc3b23d95, 0xe139a3ba, 0xfb80f9c0, 0x78b67d02, 0x02da8082
.word 0x5a17a585, 0x4e260eb5, 0xce11bef9, 0x0bab06b2, 0x707901f3, 0x5b06512b, 0xdae87bf5, 0x09723fb0
.word 0x6f3344b3, 0x826c66fa, 0xbfa78b69, 0x1848a17e, 0x91f6234a, 0x5a55e556, 0x0f8a190d, 0xd0545693
.zero 7168
mem_region_end:
