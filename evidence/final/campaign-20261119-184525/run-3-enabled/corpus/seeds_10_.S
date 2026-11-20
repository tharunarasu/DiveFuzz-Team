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
  li x26, 0x0000000a0004790a
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
  li x1, 0x75530c7ee3fb8cd2
  li x2, 0x334fdb803839fd45
  li x3, 0x888f5a0f1c3ec3c5
  li x4, 0x8f22825ef79a9f3d
  li x5, 0xd2bcd9e5b6cdb593
  li x6, 0x992132af8b72d5d2
  li x7, 0x43a8c74450257a4d
  li x8, 0x9388dfe5b0307c1f
  li x9, 0xee5c2ae16aa52a83
  li x10, 0xa3927ea2cf9fff5b
  li x11, 0xd2b941d3bca36705
  li x12, 0xb3520d516a2dcdfa
  li x13, 0x734949b67933ec88
  li x14, 0xa1fdb7d2c506a65b
  li x15, 0x05a8a494c03f7b6e
  li x16, 0xd799dbf22abc7061
  li x17, 0x97e7dc39b6a22da5
  li x18, 0x02bbcb643e60b105
  li x19, 0xd13406cb8829a2d6
  li x20, 0x26719ccaabaafc42
  li x21, 0x2c73d59e40e7534d
  li x22, 0xbf2990322883016e
  li x23, 0x6977e1f879c2a4fb
  li x24, 0xf357a8bd2a9f2c6b
  li x25, 0xf07f48f3e74d85d1
  li x26, 0x372b80334df2862f
  li x27, 0xbb8a50fa6db7a8e8
  li x28, 0xd1f718a3f3f21be7
  li x29, 0xdae40227ac109872
  li x30, 0x3cf11b2ceba3576e
  li x31, 0x421533c7dab3442b
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
  mulw s11, s11, s11
  remw a5, s11, s11
  slt s9, a5, s7
  sllw s2, s2, s11
  mulw t4, t4, s11
  divw tp, s2, a5
  rem s10, a5, t4
  remu a3, a3, s9
  div t1, s10, s2
  mulw ra, s10, a1
  srli a5, t1, 11
  sd s8, 176(t6)
  remw a2, s9, s6
  remuw s8, a7, s6
  mulhsu a4, a3, s8
  remu a6, t2, t2
  srliw tp, t4, 29
  div ra, ra, s0
  sd sp, -1592(t6)
  mulhsu s0, tp, a6
  xori zero, zero, -1
  divw s1, ra, s8
  divw s11, s6, s11
  srliw sp, s8, 31
  divuw a7, t0, t0
  addw t2, gp, s1
  remu a5, tp, tp
  mulw s3, a6, s4
  mul a3, tp, a3
  sraw a7, s3, s5
  sd a2, 1752(t6)
  mulw s6, gp, t3
  slliw a7, sp, 19
  sraw a1, a1, s2
  srli s1, a1, 3
  srl t0, s2, sp
  div s9, t4, s7
  remuw s8, zero, s8
  sd t0, 232(t6)
  remu s9, t0, a7
  remuw s6, t0, zero
  srlw a1, s8, a2
  or s5, s6, t1
  mulhu t1, s1, t1
  remuw t3, t1, t0
  divuw s11, a1, s2
  sb a3, -1406(t6)
  sllw a7, s7, a5
  addw s4, s4, ra
  li s3, -385346465787
  divw s8, s3, s10
  div s0, s3, s0
  sd s8, -392(t6)
  remuw gp, s3, s0
  srlw tp, s3, t3
  srli s6, s0, 3
  mulhsu s2, gp, gp
  slliw a3, s2, 28
  mulhu zero, zero, s9
  sd s1, -1256(t6)
  mulw a0, gp, a0
  divuw t2, a3, a0
  remu gp, a4, gp
  mul s4, s8, s7
  auipc t3, 722763
  slliw t0, s8, 0
  sd s4, 1432(t6)
  and ra, gp, t0
  sh t3, -480(t6)
  mulw s11, s8, s4
  mulhsu a6, t0, t3
  sd t3, -1368(t6)
  srliw zero, s0, 15
  sd s11, -1232(t6)
  xor s10, a2, a3
  srliw t4, s1, 0
  remw t4, t4, a0
  sraw a7, a7, a2
  divuw gp, a2, t4
  sw a2, -1384(t6)
  sb t4, 404(t6)
  or t1, a2, a2
  mulw s7, a7, a7
  rem zero, zero, a6
  add s9, s9, zero
  lui s5, 655907
  remu s10, zero, s9
  mulhu s6, t3, t2
  slli a5, a5, 18
  div zero, a7, a7
  remuw t0, gp, s7
  divw t1, t4, gp
  remw s10, s9, t1
  mulw a3, t0, t4
  div a0, a0, a3
  mulw s8, zero, s11
  mulhsu gp, t4, gp
  sllw sp, gp, s7
  remuw a2, zero, t3
  subw s5, tp, zero
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
.word 0xe41835f7, 0xa97eee1d, 0xb3e51061, 0x542aadb6, 0xcd289373, 0x38ae277a, 0xf35556a7, 0x8c796338
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x4d2d68be, 0xa0be5b7e, 0x8d038cee, 0x0886a273, 0x448feb06, 0x9814eaa9, 0xcb3b4e14, 0x62c7dabb
.word 0xf5ffa8ab, 0xb38f5730, 0x8414be65, 0x16bb6903, 0x1432b17e, 0x66e3fc8c, 0x3992606d, 0x3e9ba9f7
.word 0x51322a2a, 0xd6da13ba, 0x7dfd2230, 0x64bff5bc, 0x0490e15f, 0x94274a8a, 0xede3a3fd, 0x0d243b79
.word 0xaedddfd2, 0xa3cdb4ab, 0xdd22c155, 0x1a8b0e1b, 0xe57014ac, 0x5c3edb70, 0xd7b7cd30, 0xdc372665
.word 0x1e10b1c1, 0x8d24fc38, 0x6241591c, 0xf41ceefa, 0x4bd77fcd, 0xa37159ab, 0x67ff5790, 0x45dd9dbf
.word 0xcc6d487f, 0xdf21d30a, 0x389d923e, 0x6400374b, 0x20aa0d9a, 0x2c2ba68e, 0x3c0f98fe, 0x17039484
.word 0x4b9d42c6, 0x7b05abb0, 0xf402a4a1, 0x0f793f81, 0x864e8a32, 0x79a7e381, 0xa4ed780b, 0xf1454d6a
.word 0xbb8414f1, 0x5d75522f, 0x9d6375a2, 0x6bbe51fa, 0xa3d43eb2, 0xada67463, 0xa5789d3f, 0x6bed32b7
.word 0xc4f9bb24, 0x88939934, 0x6aec4763, 0x5842b058, 0x6c5fcc9a, 0xe847ae05, 0x1f382d93, 0xc27cf2a9
.word 0x90357701, 0x3fe19082, 0xc0dd31f1, 0xaa76daf3, 0x17d0398f, 0x494ca234, 0x06abf05d, 0xbdf5c18a
.word 0x8108ab82, 0x9c542631, 0x870dd5c5, 0x0ca0858b, 0xb8413223, 0xd4061bba, 0x3e5b0be5, 0x956f331b
.word 0xd1442f43, 0x16514d15, 0x55484504, 0x87be747e, 0x2a824b70, 0x1f777ea7, 0x18f6f086, 0x69e9b746
.word 0xa4ec9185, 0xfa3361b2, 0xb16ebd6e, 0x853f2c14, 0xed8139b3, 0xecb408b8, 0x4a332abe, 0x75edc492
.word 0x6f448b89, 0x59d415d2, 0x8e4216d5, 0x059838d3, 0xd52ca8e8, 0x667728c1, 0x1491ba90, 0x7a029b07
.word 0xb3af0434, 0x87fe8595, 0xf7c0a703, 0xa9c5556e, 0x1973c4c8, 0xe64f3b09, 0x149ef587, 0x7265c5c2
.word 0x3d4b9d2c, 0x5b4f38b7, 0x4a55d6c3, 0x52f19b25, 0x1be0c809, 0xe848440d, 0x11174328, 0x4ecb6853
.word 0xaaad4af8, 0x20238394, 0x7df217d0, 0x2a0740dc, 0xde704b25, 0x03cce653, 0x8a8437f5, 0x027010bb
.word 0x537f5061, 0xe62032db, 0x0b8c66aa, 0x253399a7, 0x42ee5af5, 0x4863e35c, 0x0ad9c084, 0x57566ee5
.word 0x5e70bc61, 0xa1d5465e, 0xb7ebbdc2, 0x660729f0, 0x3bbd828b, 0x7da79ceb, 0x37821a50, 0x9722847e
.word 0x79764101, 0xdd0d491d, 0xa96462e1, 0xff6f61ea, 0x0a0eb52a, 0x10f9b73e, 0xf5dbfa60, 0x04c3d34f
.word 0x90db04d6, 0x56776cb6, 0xe0389134, 0x50cd9235, 0xd51b1f49, 0x8977dda9, 0x91cf2f60, 0x6f5ab067
.word 0x70d2a88d, 0xa4d3b450, 0x1d280586, 0x959640d1, 0xf95349b9, 0x03de80ed, 0x9b660956, 0xee465cea
.word 0xee00c1ac, 0xa77ae060, 0x4c779743, 0xbb6ac124, 0xea37f9ae, 0xb177a77e, 0xdeaa10eb, 0x22383a1a
.word 0xb79dd0c9, 0x1d9a4246, 0x348a3165, 0x0a1344b5, 0x8d60105a, 0x5d90b641, 0xcaf0e639, 0x2b3f9f67
.word 0xc4ee2e2a, 0x7e7d1ee3, 0x041f335d, 0x8ad53394, 0x13b87916, 0x9c4d3d50, 0x9ffc00bc, 0xe425b590
.word 0x8d3dbcbc, 0xc3ab8c53, 0x07d53b06, 0x95499a3e, 0x220f614a, 0x10c63fe9, 0x5db66115, 0x1603ea34
.word 0x7be2e135, 0x52397b7c, 0xfa6254e8, 0x86cb2108, 0x9e5e815f, 0x965d899d, 0xe2b18b7f, 0xae5b67a0
.word 0x52d85158, 0x92918e82, 0xef0ba508, 0x242cfc3d, 0x4c7c8271, 0x541526f1, 0xb769787e, 0x85e4e4eb
.word 0xc71332e8, 0x42df8a69, 0x133a6fb7, 0x70927611, 0xf3212262, 0x9afbe89d, 0x6a33ebda, 0x1d325be2
.word 0x83b86333, 0xf211840b, 0x1a48deb9, 0x3f7dadda, 0x7649d6f0, 0x27edeb5c, 0x1b95b21a, 0x6ad381e1
.word 0x91053434, 0xe779c542, 0xd017757e, 0xd62b4fc6, 0xe70107b8, 0x9bac9d8f, 0x504b99e0, 0xb8e57950
.word 0x594d3794, 0x92ed4b70, 0xec42cd0d, 0x544a37f6, 0x9e9b827a, 0x63f7ab74, 0xd1f6fac0, 0x29a77c5a
.zero 7168
mem_region_end:
