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
  li x26, 0x0000000a007809a2
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
  li x1, 0x07276b197a78dbfc
  li x2, 0x187faba531edb3e7
  li x3, 0x5c157132b8e77948
  li x4, 0x77013a558de45f3b
  li x5, 0xf819aa082460f61d
  li x6, 0xbbb92e096bb707e0
  li x7, 0xc886de1d39250f10
  li x8, 0x4b8f841e9ef83a70
  li x9, 0x0df2e9c2f65a9678
  li x10, 0xe3a7d06cc8f4d196
  li x11, 0xda0cccd5b5439fd4
  li x12, 0xf653e525dd3aa4be
  li x13, 0x8988ec58e6a504ca
  li x14, 0x92e66dc6231f8743
  li x15, 0x11acf776745c7935
  li x16, 0x1c8d9718601173c3
  li x17, 0x66ab17ef893ebc54
  li x18, 0xb1cd5325ccd973d8
  li x19, 0x1b41bc6f06fcd40c
  li x20, 0x990c780d81b1dec3
  li x21, 0xc19339385268b3f3
  li x22, 0xdaae85472311ba48
  li x23, 0x84b0b0611051ddb9
  li x24, 0x10f0e03d413f8254
  li x25, 0x115b2ae3ef8f86dc
  li x26, 0xbcd0f4d129bf1178
  li x27, 0x5e1a271222612d96
  li x28, 0x2f2496e9d3e59c6e
  li x29, 0x3d8f257cee6b9820
  li x30, 0x91a59f780bc1085e
  li x31, 0x66e0503250386b70
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
  remw t0, t0, t0
  rem ra, a5, ra
  remuw t4, a6, a6
  div s5, t4, t2
  sll s11, s3, t0
  sd t2, -1848(t6)
  rem s10, gp, t4
  mulhu s1, t4, s10
  sltu t0, s10, t0
  addw s0, s5, s9
  div s9, s10, t0
  divw t3, a1, s1
  div a5, a5, t3
  divuw s11, t3, s11
  auipc a0, 367856
  divuw t4, a0, a5
  subw tp, s11, tp
  divuw t2, gp, tp
  remu s0, s11, t2
  divuw s11, tp, tp
  slliw s5, sp, 1
  add s3, s5, a4
  addi a6, a2, -840
  mulhsu a2, a6, s1
  divu sp, s9, sp
  sltu a1, a6, a0
  remw zero, tp, a2
  auipc t0, 778252
  sub s2, s2, s7
  mulw ra, a7, s2
  remu t1, ra, t1
  divw gp, sp, gp
  remu s2, ra, ra
  auipc s6, 368009
  sub s5, t2, s6
  mulw s2, s6, s5
  addw s5, a5, t1
  sltiu tp, t2, 1863
  mulw ra, s6, a5
  divw s4, s5, ra
  divuw s11, tp, tp
  div t2, s11, ra
  sb tp, -1754(t6)
  remuw s11, a3, s11
  lui a0, 660950
  divuw s8, s8, a0
  subw s2, s2, s2
  divw a0, s4, s10
  mulw gp, s4, t1
  sraw s3, s6, s6
  sraw a0, a0, s6
  subw s5, t0, s6
  mulhsu t0, s3, s6
  slti s8, s8, -2048
  rem a6, s5, t0
  div a2, sp, sp
  mulhsu s9, a6, sp
  sd sp, 712(t6)
  remu s10, s8, s10
  mul s6, s6, s6
  rem s11, s10, a5
  sra s7, s1, t2
  srliw s3, s6, 29
  rem s4, s3, s4
  addw t1, s4, t2
  sraiw gp, s11, 29
  remuw s1, s1, t1
  remu a7, s1, a7
  mulhsu s5, s5, gp
  mulhu s3, t1, a2
  mulhsu sp, a2, a4
  divuw t3, t1, s2
  mulhu t4, t4, t4
  mulw t0, t4, a3
  sra sp, tp, tp
  sraiw t0, t0, 0
  sd s4, 1368(t6)
  divw s7, s7, a5
  rem ra, t3, s7
  remw a5, a5, ra
  divw s6, a5, s6
  divu t0, ra, s1
  addw s0, a5, t3
  mulw s5, s5, t0
  sraw s3, s0, s1
  remuw gp, s4, s3
  sb s4, -1720(t6)
  slli t0, a3, 1
  sltiu a1, s4, 0
  divuw t1, s9, t1
  divuw s7, s9, t0
  divw t0, a4, t0
  slti s3, a2, 1
  addi t0, s1, 1
  divw s3, gp, a1
  divw zero, gp, ra
  mulhsu a5, s3, s5
  divuw s10, s9, a4
  mulw s6, zero, gp
  ori zero, sp, 1
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
.word 0xd9a0127f, 0x427913a4, 0x534cec52, 0xb70f067c, 0x30143660, 0x17a383fb, 0xd039cd19, 0x91739483
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x3764db78, 0xd38247ca, 0x54183ee6, 0x6c7619f8, 0x8e99e865, 0x1f76ae12, 0xac5a69dd, 0x41c7e847
.word 0xec6b4172, 0x608272c0, 0xb6e305ee, 0x975e5623, 0xf7c47de8, 0x7d17e92d, 0x0b6595b1, 0x61bbe0cb
.word 0x812a3e8d, 0x2a7ee108, 0x6297d3a3, 0xb2994ec5, 0x336bbea6, 0x00873a39, 0x3aca60d6, 0x991c50af
.word 0x30c1db02, 0xd45021a8, 0xa8a382e4, 0x6e35b8cb, 0xc19516a7, 0xc8fbf2e0, 0xede71a59, 0xbe3e6476
.word 0x3583ff24, 0xd09ea2fd, 0x2b2eb148, 0x2de1df98, 0x08b86a69, 0x87f2761c, 0x4441aa9b, 0x6b445c07
.word 0x2f9650c5, 0x5e990337, 0xdbb320d3, 0x0dcfb3b4, 0x45486cdb, 0x7ee8581b, 0x660b6184, 0xd7bc54ec
.word 0xbb045c42, 0xb0a9b68d, 0x5a393763, 0x20efe3c8, 0x80d11a0e, 0xb9d33ac0, 0x9a68c0d2, 0xb2ad7134
.word 0xbb3813b5, 0x76c1d38e, 0x51d3aab9, 0x83624aeb, 0x7ae9a8b8, 0x4f04dee1, 0xe5c2be92, 0x4a1ebc50
.word 0xc2192fb0, 0xf930885a, 0xe5ce647e, 0x45e43655, 0x983f88ea, 0x7a0c0905, 0x1bcf2f32, 0x1b789bd3
.word 0x43ee1101, 0x4821054c, 0x3ec64909, 0x3a7f0587, 0x5246cb5d, 0xc42b23f3, 0xaddb017d, 0x8230c778
.word 0x4e47edf7, 0xd583e292, 0x585e4120, 0x08781529, 0xffd68c04, 0xb41ef584, 0x5c9b1a85, 0x30949c3e
.word 0x011ef931, 0xb4bc3f8c, 0x747e96cd, 0x37f5ae9c, 0xc7d2229a, 0xa9b4efa2, 0x00ab7533, 0xf3d527f6
.word 0xa9eba072, 0x4209d78b, 0x69d8b938, 0x910dc076, 0x96512344, 0xb2d72e1d, 0x036cb97b, 0xfe360e05
.word 0xb806f9c9, 0x13a5e892, 0xd3a22dd1, 0x3faefad2, 0xe71cf833, 0x804b95bb, 0x68224f3c, 0x26369cda
.word 0xc2d00f2c, 0x1766ca53, 0x75ef1c11, 0x0003bd3e, 0x84ee98a8, 0x60ee91f3, 0x4ca0e82f, 0x441f5a8b
.word 0x202cc34e, 0xbef27c7d, 0xfb9929b6, 0xbae3a339, 0xdd61fad0, 0x53f9f20a, 0x08922c9d, 0x346cf9ae
.word 0x6d08dfd6, 0xf19c510d, 0x75e67410, 0xf442aefa, 0x6b64a9e5, 0xc8c41df5, 0xbc7b8694, 0xc4f035fe
.word 0x90ea08c2, 0x99eb0da2, 0xcedb4ff6, 0x35b191c4, 0x8b1fecdf, 0x6d7ff402, 0x7614828f, 0xa1d69ed8
.word 0xe8cc548c, 0x68b4be10, 0xe532b780, 0xb4081223, 0xd7d747b6, 0x4e03a537, 0xaa717d12, 0xa77a99b1
.word 0xa564125c, 0x56fe756c, 0x41a0687d, 0x5d49dc4d, 0x809cec40, 0xa187eb70, 0xf35201d0, 0x86348bfd
.word 0xb8674fcd, 0xd5b02198, 0x5e6403f9, 0xceb65459, 0xc6c5730a, 0x72e822d2, 0xcfc6800c, 0x26e0be7c
.word 0x7681d1a1, 0x037f2b82, 0xf2c1659a, 0xf666d274, 0xa6e8f008, 0x8f19e816, 0xb2492815, 0x0e800e67
.word 0xaf7bb908, 0x01c93a0f, 0x4e70643e, 0x25be4729, 0xdc047e43, 0x615d07e1, 0x0d42f0a2, 0xdc015335
.word 0x5496d710, 0xa2b7b1cd, 0x7603b9c1, 0x3e9f98ed, 0x44965c7c, 0xd567b7af, 0xd2016796, 0x43bd6750
.word 0xcd7ad5d9, 0x690f3d40, 0x446ab29c, 0xedd34c44, 0x15e842e0, 0xce48cf71, 0xb4624766, 0xe32391eb
.word 0x1437210e, 0x649a8fc6, 0xc4e6ad9c, 0x50083c6d, 0xeae9403f, 0xf39adf71, 0xf1e48dae, 0x211f6df4
.word 0x1f498678, 0x2e7ffdfd, 0xbfbcc6fd, 0xb7bc1c4f, 0x8e714753, 0x3383b129, 0x59a725f1, 0xd48e3ee1
.word 0x5e52d7c0, 0xd47fbf3a, 0x2eecb755, 0x7b427870, 0x022bf397, 0x55b4cb4b, 0xd1d9487d, 0x17f9db0a
.word 0xbf07f65a, 0x31bbb547, 0x57583022, 0x11a850c6, 0xbd64108a, 0x71bd4991, 0xc3497c55, 0x5b0c35ac
.word 0x4b4e8518, 0xd2305758, 0x5efdf740, 0xb58e83e4, 0xa7887def, 0x9041b5ab, 0xa7794911, 0x46f42310
.word 0x5be957b9, 0x14816791, 0x8e2f91a9, 0xdce855b9, 0xdebb1a4f, 0x10be6d54, 0x18e6cb1c, 0xf0e0ccda
.word 0x8881d0d9, 0x44e05cff, 0x5f25b20f, 0xd6c895da, 0xc220b278, 0x8e29d679, 0xcda59e67, 0xe9ec2e38
.zero 7168
mem_region_end:
