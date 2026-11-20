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
  li x26, 0x0000000a00143820
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
  li x1, 0x323d4226340b4be4
  li x2, 0x13f46772956fba87
  li x3, 0x7e0269edac79ca6e
  li x4, 0x82b4ef4e292a463c
  li x5, 0x19018b15bf1acc83
  li x6, 0x567433089217873d
  li x7, 0x03d28c0976bb95db
  li x8, 0xfc5d96cc82bdb472
  li x9, 0xdd69cf342265e6d6
  li x10, 0x5a8e3ffc98782bf7
  li x11, 0xa0edf46df8790ba9
  li x12, 0x23e686672355aca2
  li x13, 0xa3ee7d60b1067288
  li x14, 0xdd56002675053087
  li x15, 0x376d37e8c6ef96d9
  li x16, 0x040525d06dcbc86f
  li x17, 0x2bf4b077c98fb7e2
  li x18, 0x754d6c2d741de2ef
  li x19, 0x4df37ea24cc8eb38
  li x20, 0x372477b244926a42
  li x21, 0x5f7db1ff69ef7335
  li x22, 0x56e8a868e5446806
  li x23, 0x089e34cd56c83e9b
  li x24, 0x88b2758571a4df44
  li x25, 0x50cbcd9f442d32a0
  li x26, 0xae18ff4130f35297
  li x27, 0x239842b9d79b6484
  li x28, 0xc6dd4378211cad14
  li x29, 0x57638ff88bb63ad2
  li x30, 0xe4c6165cb0606cc9
  li x31, 0xd2d5d7c55035041e
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
  divw s0, s0, s0
  lw a2, 632(t6)
  slli s4, a2, 37
  mulhsu s8, s4, s4
  remuw a1, s0, s8
  ld s2, 376(t6)
  remw a6, a6, a7
  fence.i
  slt s1, s1, s2
  fence.i
  divw a0, sp, s2
  fence.i
  remw gp, s2, s1
  srliw a4, s1, 31
  rem s7, a4, s1
  fence.i
  srai zero, gp, 0
  fence.i
  remw s0, s7, s0
  fence.i
  fence.i
  remuw a2, a2, a4
  srliw a7, zero, 1
  fence.i
  lbu t4, 769(t6)
  sllw s11, s0, zero
  sraiw s6, a5, 1
  fence.i
  mulhsu s1, a7, t4
  slt s9, t0, s1
  subw a0, s11, s4
  lh s1, 1190(t6)
  remu ra, s9, s6
  lw s2, 1564(t6)
  divw a2, s3, a2
  srli a4, a2, 60
  fence.i
  remuw t0, t3, s2
  add a6, a2, ra
  mulhu tp, s2, a6
  sb gp, -274(t6)
  sd t0, 304(t6)
  divuw s10, a6, tp
  divu zero, s0, a4
  divu tp, s7, t1
  sd s1, 1544(t6)
  sra s11, a6, s11
  fence.i
  rem s2, zero, tp
  fence.i
  remu ra, s10, s2
  mulhsu t4, tp, s2
  mulhu a7, a7, s11
  remuw tp, a1, t4
  fence.i
  lui s4, 0
  remw s11, tp, s11
  fence.i
  sra s3, tp, s4
  mulw t1, a0, tp
  slli s7, tp, 61
  mulhu s8, s7, t1
  fence.i
  remw t2, t0, s8
  fence.i
  rem s4, t1, gp
  or gp, s7, s8
  srlw a0, s8, s4
  mulhsu a7, t2, gp
  addw tp, a7, s4
  remuw s11, s10, s11
  fence.i
  remu t1, a7, tp
  fence.i
  fence.i
  divu s7, t1, s7
  divw a1, a1, s11
  divuw s4, tp, s7
  divu s10, s4, s11
  fence.i
  sra s3, t1, s7
  divuw s6, a1, s8
  srlw s11, s10, a1
  srli s5, s10, 32
  divuw s7, s3, s6
  sllw a4, a4, s11
  remuw t3, a7, s11
  sll ra, s5, t1
  div a6, a6, t3
  fence.i
  remuw s4, s7, s9
  divuw a3, ra, ra
  sw s10, -740(t6)
  divuw t2, ra, t2
  divu zero, a3, ra
  xor s10, s10, t2
  lhu t3, -196(t6)
  lw a0, 140(t6)
  lw a7, 728(t6)
  addw a1, a7, t3
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
.word 0xc8065a31, 0xdb63d9e6, 0xbf67334e, 0xf53430fa, 0xb1c02fa0, 0x10ee2a59, 0x02a1f29b, 0xfe8f8848
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0xc2161f50, 0xdf263453, 0xd6293190, 0x3ec226fa, 0xe582f972, 0x7304e496, 0x6ccdd6ec, 0xcd191ba8
.word 0x4c199b6d, 0x32609d64, 0x307155c7, 0x8adc5ce8, 0xb96d53b3, 0xffa81e46, 0xda1b0e1a, 0x4607e2ab
.word 0x1a0e9c1a, 0x87d3c613, 0x86652cca, 0xddd5cfc7, 0x5e7a1057, 0x45d1f2f1, 0x247c32a3, 0x65873890
.word 0xe962acbc, 0xd50c241e, 0x8b0c8b40, 0x062b8f2e, 0x6b9eb4dd, 0x4b485946, 0xd0fc665c, 0xeb7e1627
.word 0xdbe1fdca, 0x52ae409a, 0xc276ad95, 0x760b784c, 0xe29f1c7f, 0xecf0f718, 0x23db41ae, 0x2779a51f
.word 0xb71e80d5, 0x2e302965, 0x67429c25, 0xf98ae92f, 0x531be307, 0xc23f34bd, 0x9c4a1add, 0x9a196ee1
.word 0xf19476c2, 0x67941424, 0x39b55130, 0xc397cdad, 0x3a598648, 0x43ee8e29, 0x51f9afbf, 0xfc0b3909
.word 0xf279d6d5, 0x455068e4, 0x10af32b9, 0x21598498, 0x8826c737, 0xece996b6, 0x0f7a3425, 0x7d2bcee2
.word 0x0e8c16dd, 0xf8b0eef3, 0x0e24e9eb, 0x7a944fff, 0x1495a8d4, 0xd0f3edf3, 0x74432b31, 0x8b615598
.word 0x8a31b042, 0x0d6e3909, 0xf646f506, 0x891d5d7f, 0x71c20940, 0xd3b93dc9, 0x7e8b820e, 0xa9080547
.word 0x4d18be9d, 0xf751112d, 0x09a314ce, 0xb44c6be8, 0x53350bd0, 0xcda78c88, 0xb13d3ad3, 0x91ba96bc
.word 0xda31e8bc, 0xd9e811fb, 0x0b7bb497, 0xfcf043dc, 0xec63abfe, 0x8e09975e, 0xa91d26c2, 0x786f01bc
.word 0x3599f557, 0xb14c4046, 0xa3dddae7, 0x9cbda729, 0x829a1df5, 0xb1973f1d, 0x096d231f, 0xeb2b2299
.word 0xd496e92f, 0xf427483a, 0x540d84f1, 0x61646f2e, 0xdf00be2f, 0x8ba40d7c, 0xd47a7144, 0xc196de01
.word 0x7a28c0b0, 0xd943c348, 0x0a8322e8, 0x37ab9467, 0x3b376dca, 0x9afc8e18, 0x02415f9c, 0xd614e1c2
.word 0xbe482c8d, 0x87e06e9c, 0x2163aaa4, 0x15c9bac5, 0xc77a5339, 0xb5c5428b, 0xee0346f5, 0x92daca14
.word 0xe7d59b74, 0xd4c9a8bd, 0x17783ed8, 0xddc1adcd, 0x3869fd30, 0xd7efd828, 0x3b5f61c6, 0xa1c673e1
.word 0xa9077f8e, 0xd9a93560, 0x08ec9447, 0x80202e0e, 0x17171744, 0x6d2998ee, 0x61bd2742, 0x10133ef3
.word 0xc9aed832, 0x1e606fed, 0x98e78a68, 0x13b22b5c, 0x239bab40, 0xdad2a31c, 0x72a1a450, 0xcdb48923
.word 0x8ec52efd, 0x3ad0423d, 0x03819a13, 0x8cefc4f9, 0x5bf53513, 0xf92ecd34, 0x54f38a93, 0x1cec6c6a
.word 0xa1317de2, 0xa305b77b, 0xcd68454b, 0x0464d11f, 0x1d6b33fb, 0x067ae116, 0x47e67141, 0x3935f09a
.word 0xb1509f31, 0xd039f010, 0xd5834a43, 0xc7745ed5, 0x82bf971d, 0xa8a89047, 0x48c50ae1, 0x05bd6760
.word 0x0970d917, 0x1bf5fa0d, 0x2cef1653, 0xed89059c, 0x48060645, 0x9f9e2753, 0x7f5b03e6, 0x116e6846
.word 0x0bad5502, 0x313c16ac, 0x6c082b45, 0x70d254cf, 0x4db91e75, 0x42ea335d, 0x5ad0d1d9, 0xaf6c005a
.word 0xb7ee8aa2, 0x465dfb78, 0xe02f2bb3, 0x291792ee, 0x880ba334, 0x04ba221c, 0xa9109917, 0x6f495f3b
.word 0x03678659, 0xa64da320, 0x7a329eb5, 0x88793fa1, 0x4803da77, 0x36276d34, 0x0b5530cc, 0x618ea025
.word 0xe7275a3d, 0x99377c0c, 0x6c3ef0e1, 0x3797bab7, 0x5e8edd19, 0x802bbad9, 0x13697b6c, 0xe69755df
.word 0x3eafe0e6, 0x81930f03, 0x5301ae91, 0xca777c2a, 0xaa6c04f5, 0xbaf658e3, 0x95721c19, 0x41714651
.word 0x97c7728a, 0x06fdc061, 0x43e57879, 0x6018e9c4, 0xd5344cce, 0x63179086, 0xccdd44ce, 0x223d508e
.word 0x4a5408f7, 0xbe73bd19, 0x1d8f7a0b, 0x75f4c5de, 0xb7e35630, 0x6dfc1445, 0x27e83222, 0x1ea09749
.word 0xc5f49760, 0xcb7ff75e, 0x25044171, 0x49154512, 0x8c08b758, 0x5ec4566e, 0x79ff34d0, 0xec2d7698
.word 0xcc4b270b, 0x4b384deb, 0x015f854c, 0x69e61ce3, 0xa87b444f, 0x7db17e07, 0x3b8e6441, 0x0505d7d6
.zero 7168
mem_region_end:
