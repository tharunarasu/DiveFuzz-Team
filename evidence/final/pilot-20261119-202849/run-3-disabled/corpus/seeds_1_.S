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
  li x26, 0x0000000a00247808
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
  li x1, 0xcfe84ec1981eac9c
  li x2, 0x57f16088e1edcd6d
  li x3, 0x1f804ed56e4368aa
  li x4, 0x89f7111ac5dfa388
  li x5, 0x703d837e664f6df0
  li x6, 0xc964ad529d387138
  li x7, 0x1c801de031d9daf5
  li x8, 0x788150651b37b2c5
  li x9, 0xc9bbd5c7706a50ba
  li x10, 0xc63ffb9c6e1765a5
  li x11, 0xcdcd30775fb42b63
  li x12, 0x84b7127150ff5e59
  li x13, 0xe4c2f149a5451df0
  li x14, 0x115c9fbe0b0b8516
  li x15, 0x3a99bfbd54b4582f
  li x16, 0x6a288902d0f883c5
  li x17, 0x00382ae43d83f647
  li x18, 0x0c0f11ea6ff01f9a
  li x19, 0x972139f4ec9c0d08
  li x20, 0x0ea67c56149e9043
  li x21, 0x0f46696ffc3648e9
  li x22, 0xd61ea1479406561a
  li x23, 0x1743eb0c2a6b4685
  li x24, 0x1af3c76b0e9d2e82
  li x25, 0x70307a6dbd6e5f28
  li x26, 0xc328fa17dada6db0
  li x27, 0xd1e56b5c86354643
  li x28, 0x5dec7c010eae8061
  li x29, 0x2cb56f64d107c4dd
  li x30, 0xc6fb72eeea324027
  li x31, 0xe55adff75d9d505a
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
  fence.i
  mul s8, s8, s8
  remuw s3, s8, s3
  fence.i
  addiw tp, s3, -2048
  mulw a0, s3, a0
  lhu sp, 160(t6)
  divw a2, s1, s3
  addiw t2, tp, -1985
  sd t2, 2016(t6)
  fence.i
  divu t0, t0, t2
  fence.i
  sraiw s10, sp, 13
  fence.i
  fence.i
  divuw s6, s6, a2
  ld zero, 136(t6)
  lh a3, -1660(t6)
  remw sp, s6, s6
  div s3, t2, t0
  fence.i
  div t2, s6, t2
  remuw s10, tp, s6
  fence.i
  sllw t3, a7, s5
  divuw s6, sp, s10
  remuw a3, s3, s3
  xori s0, s4, -1
  sllw a5, t3, a5
  fence.i
  remw s1, s1, s1
  mulhu sp, a2, a3
  srli s10, s0, 0
  mulw a4, sp, s0
  remuw s5, s1, s10
  xori a0, a4, -28
  remw s5, a4, s5
  fence.i
  remw tp, s5, tp
  divuw t4, a0, s10
  sraw t1, s5, a4
  srai s11, s5, 37
  remuw t2, s11, a6
  divuw a4, s11, t2
  srli zero, a4, 63
  fence.i
  sllw tp, a4, tp
  xori a3, t2, -796
  divw gp, a4, gp
  fence.i
  slti a5, gp, 0
  and sp, zero, tp
  fence.i
  remuw a1, a1, a1
  divuw t4, a1, a5
  fence.i
  divu s10, sp, a5
  divuw s8, s10, a1
  sraiw gp, s10, 0
  addw a4, s8, t4
  fence.i
  fence.i
  remuw a3, a4, a4
  sllw s9, a6, gp
  remw tp, s8, tp
  remw s8, gp, tp
  sraiw s7, s7, 0
  fence.i
  sd s9, 1072(t6)
  fence.i
  remu t4, a3, s5
  fence
  divuw s3, t4, t1
  remw a0, s3, s7
  remw a3, a3, s3
  lw t2, 168(t6)
  sltu s11, t2, a3
  divu s8, a3, t2
  li s0, 9810181847
  remuw tp, t2, a3
  fence.i
  fence.i
  divuw s3, s10, a1
  add t1, s11, s8
  lh t0, 1766(t6)
  fence.i
  sraiw s4, s7, 31
  divuw s8, ra, s3
  mul a4, gp, t1
  srl s6, s4, s8
  mulhsu s4, t0, s6
  lhu zero, 1866(t6)
  fence.i
  sb s8, 903(t6)
  lw t1, -48(t6)
  fence.i
  mul a1, s4, s6
  fence.i
  addw s7, s6, gp
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
.word 0x2727cccc, 0xdbc3dde0, 0x9f1ad770, 0x062d3d0c, 0x56ce82c4, 0x861f1894, 0x19a69abb, 0xd52362eb
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x5307ad29, 0x0e844051, 0x16816181, 0x23f92f70, 0x059fdf5f, 0x52c42504, 0x3ba653fc, 0xd3362bae
.word 0x89650ac2, 0x7157327e, 0xd5e58d21, 0x4bf50ea6, 0x69ded525, 0x23a7c54c, 0xda339368, 0x1a82315a
.word 0x38f7d4e2, 0x94b5f2ce, 0xf46d3db0, 0xd175aa73, 0xff7e9d68, 0x5d86aa23, 0xe30f44d7, 0xab3e3168
.word 0x3905cf70, 0x59829334, 0x9759437e, 0x8de6d9c2, 0x0c0db4e3, 0x12b76fad, 0xbfa17a15, 0x9b8ba4a1
.word 0x96c48421, 0x4b45a4ae, 0xb21cf853, 0xdeb3ab90, 0x428a1e67, 0xc4c6c52b, 0xdfd287b6, 0x12f715d3
.word 0x9aee1709, 0xdaed074e, 0x1be2786c, 0x4d864875, 0x0d3ef20d, 0x53617070, 0x928ff918, 0xbcb56bab
.word 0x2184b7a5, 0x715a284b, 0x560d22ca, 0x763eb9c7, 0x614dbfe6, 0x0b908650, 0x58daa653, 0xa0fb1580
.word 0x54c2d610, 0x982720e3, 0x49d62a65, 0x7d27b97e, 0x4ecf6fd8, 0x5f21fdfd, 0xd68845b4, 0x0af1f0b8
.word 0x2261a2ba, 0x5c770a64, 0x91ae8118, 0x2dbda0c0, 0x8f4340ae, 0x3d9ec595, 0xafb2f319, 0x22e40cc1
.word 0x29407e27, 0x1e0ca40d, 0xc932fce2, 0x85f15ec9, 0x2d073f43, 0x91eeb931, 0x977de3d6, 0x501cf19a
.word 0xe08033ca, 0x7e8f03e3, 0xcc2d7795, 0xc97e2852, 0x89cbd93c, 0x3162b845, 0xac8c7aa2, 0x33a892fd
.word 0xcdcd85e6, 0x7c8257e5, 0x09650e6a, 0x5d310596, 0xfb93ee65, 0xf3f413b9, 0xaca98ce2, 0x26d86989
.word 0x9e252dd8, 0x8e76c76e, 0xe106f4e7, 0x3aa38b00, 0xc50fffba, 0x6f51e4b9, 0x9bdd3911, 0xd70c28a1
.word 0x003f8203, 0xa6a816c0, 0xf62692c2, 0xde7d1561, 0xfb9d243a, 0xf3decdce, 0xbdf6a7a3, 0xbb4c472e
.word 0xfd8b3361, 0x636c3aab, 0x73a98ac2, 0x44972261, 0xf89dd6cf, 0x22fa830e, 0xbe8f95ba, 0x5ace891d
.word 0xd24a9b12, 0xeeec1f8c, 0xb5f79a28, 0xe185f11a, 0x83e8a309, 0x03549bff, 0x3ed59da4, 0x542266ff
.word 0x8100e2e4, 0x59e204ce, 0x863dffe7, 0x742cd12b, 0xfb602a34, 0xa2cc992c, 0x72e1f825, 0xae9c306e
.word 0xfd2ed6ef, 0x73e112bf, 0xe3787d3b, 0x3e7ae61c, 0xe583267f, 0x6ea8742d, 0x767b0724, 0x8e7a6b61
.word 0x9b5e8982, 0x61001b05, 0x26fdd5ef, 0x74282da7, 0xb3744294, 0xfe4de137, 0x735a5d63, 0x694c27ba
.word 0xdb1aa9b6, 0x3fc0525b, 0x437ad02f, 0x6c364f92, 0xad5bbbdc, 0xe760f5bc, 0x9900b1ce, 0x6276df06
.word 0x6217a12b, 0xac16b370, 0x722197d0, 0x484c203b, 0x6347841c, 0x06310faa, 0xd4705dab, 0x73498ae3
.word 0x68b9d0b3, 0x9d6b5dc6, 0x53912d2f, 0x1866c2cb, 0x2e30e71f, 0xa98e4633, 0x4291027a, 0x7125aad0
.word 0x10fa7e0b, 0xe0e8451c, 0x66625f32, 0x7e29d0d6, 0xac776295, 0x1c4b9aa6, 0xf521951a, 0xec2ebae0
.word 0xc6466a12, 0xf72e96af, 0x2f467564, 0xdfc63c67, 0x33606886, 0x157308a9, 0x661512c0, 0x1edfb1b1
.word 0x28b3b19b, 0xcaa0eb42, 0x8272e056, 0xeb14ba85, 0x6458fe21, 0x925b439f, 0x3c88e963, 0x76cac6c5
.word 0x4a8563b1, 0x437f805f, 0x4c43a3c4, 0x20a147e6, 0x295ef54f, 0xbb8aa155, 0xd1577681, 0xc1be8b17
.word 0xfc95018c, 0xab06c0d8, 0xece52a32, 0xfc4fd4c2, 0x75476cdf, 0x2efd83df, 0x63c5c202, 0xd0769e28
.word 0xc76ead4a, 0xfa949acf, 0x67fb3f5b, 0xff360574, 0xac7db4dc, 0x0f25576d, 0x1a84d70f, 0x5b3df230
.word 0xaef4727e, 0xf93f6a18, 0xc2313938, 0x7f4c29b9, 0x91c7edce, 0x60721997, 0x0e9d756f, 0xf29f9312
.word 0xc8705aa4, 0xdc0ab506, 0x8f4619af, 0x2bb5fec1, 0x8b0b26c4, 0xccb41c4f, 0xd03a17f3, 0xc46c737c
.word 0x845b5888, 0x4ba6b184, 0xf057828a, 0x4088dd21, 0x572fd970, 0xb2374a97, 0x9a5446d7, 0x5f9ca79d
.word 0x06594f07, 0x5c900c7a, 0x9734dfda, 0x242eda02, 0xcb19f100, 0xb0162e43, 0xf295fb60, 0x6df32446
.zero 7168
mem_region_end:
