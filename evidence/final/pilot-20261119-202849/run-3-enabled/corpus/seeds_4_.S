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
  li x26, 0x0000000a003800a2
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
  li x1, 0xc0d1a6ff3d158691
  li x2, 0x87f7c359db939ee0
  li x3, 0x896a85bea1576875
  li x4, 0x8cc8bdcaf32e7b4f
  li x5, 0xb999400e0b0f6f63
  li x6, 0x71ce87d66a9fa3d5
  li x7, 0x7435607bd10f7fd2
  li x8, 0xcab84368317c71d6
  li x9, 0x6709ee12a4646d3f
  li x10, 0x5292631a2bec1b22
  li x11, 0x412113a342f7d2c2
  li x12, 0xc0c6d5a2dca15dbb
  li x13, 0x201a4853abca16af
  li x14, 0x482161721430e5b3
  li x15, 0xaaf727cc504ccd47
  li x16, 0x7b5bf7117025708d
  li x17, 0xf1655235d0b429dc
  li x18, 0x7815c2de88b76d09
  li x19, 0x1a86b6f082d4c1c7
  li x20, 0xa2320a119061f2ce
  li x21, 0x4fabcec64d6891a3
  li x22, 0xf70e4b02a4cd37a2
  li x23, 0x46a11819a213b994
  li x24, 0xf8dbdf2e14878286
  li x25, 0x797597969cc60e3d
  li x26, 0x923fe4df1af26d26
  li x27, 0xa7013de33a4aeeb4
  li x28, 0xb59c37d1b90f1bdd
  li x29, 0xf89054e8a4dd6aa2
  li x30, 0x289186e82d77d792
  li x31, 0xba3d6dfb58008a69
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
  remw t4, s3, t4
  divu a2, t1, t4
  sra s6, a2, t4
  sraw s3, a2, s6
  divu zero, t4, s3
  divuw s0, s5, s9
  div a5, a0, s3
  addw a6, a6, s0
  sllw s4, s10, s4
  auipc t3, 610569
  divw t4, t4, t3
  or a0, tp, a1
  srli t1, t0, 18
  sd t4, 1120(t6)
  srl s2, t4, a4
  remu ra, a0, s2
  remuw sp, s2, sp
  mulw s8, sp, sp
  divw s5, s6, sp
  mulw s4, s8, gp
  mul tp, tp, tp
  slt s10, s8, tp
  rem a7, s10, ra
  slli gp, tp, 1
  slli s8, gp, 52
  sllw a0, tp, a0
  mulw t3, t3, s10
  mul t1, a0, t1
  mulhsu a1, t4, zero
  addiw ra, a0, 1
  andi s8, t1, -2048
  addiw gp, s8, -1764
  remw a0, gp, gp
  srli s2, a0, 28
  sraiw a6, a0, 31
  sd sp, 456(t6)
  mulhu tp, a3, s10
  remu gp, t0, gp
  lui s6, 1048575
  add t3, s6, a6
  sraw s4, t3, t3
  remw t4, s9, s9
  remuw tp, s10, t3
  sraiw a5, s9, 0
  mulhu t4, s11, a5
  sllw a6, a6, t4
  mul t1, a5, s2
  auipc zero, 405953
  lui a2, 729590
  remuw a5, a2, s2
  divu a0, a2, t1
  remuw s2, a5, a2
  and s0, a5, a0
  sltiu t1, a0, -2048
  remu a1, t1, a5
  xori a6, s2, -2048
  remuw ra, s0, s4
  mulhsu t4, t4, s6
  mulhsu a6, t0, ra
  div s1, s1, t4
  div t0, s6, ra
  sllw s9, s5, t4
  subw t1, s9, s3
  sraiw s7, s5, 19
  addi a5, s0, -1136
  remuw sp, s7, a5
  sll sp, a2, s3
  divuw a7, sp, s0
  div a6, a2, s11
  div t3, a6, a2
  mulw gp, a6, sp
  divw s3, s9, t4
  slli ra, t2, 1
  divw s4, a2, a6
  slli t0, s8, 0
  addiw tp, t4, 1578
  srai s8, t0, 63
  remu a1, t0, s2
  mulw t3, s2, t0
  addiw t2, s2, -1
  sraw a7, t4, zero
  rem s0, a7, s0
  srl sp, sp, sp
  divw s4, a7, a7
  remuw s2, s2, t2
  remu s3, sp, s11
  divw t0, s3, s0
  rem s11, s4, s4
  srliw a0, t0, 16
  div sp, a0, a0
  divu a3, a0, t0
  auipc a4, 763519
  ori t0, a4, 0
  mul s3, a4, s3
  divw gp, a2, a4
  addiw a1, t0, -1
  divuw t2, s3, a1
  divw a2, t2, a1
  sllw a5, s3, s3
  rem tp, a5, sp
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
.word 0xde0019dd, 0xf90f5b8b, 0x4e16c49b, 0x741bb277, 0x08cec349, 0x629dd8f0, 0xe04e3d23, 0xbb2924b9
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x372bcb9a, 0xffe18952, 0xdb42b36d, 0xbece7d62, 0x55c74e79, 0x1ff0a23f, 0x3a11e735, 0xd3a6903b
.word 0x598a98a4, 0xe4991ac0, 0x5dba3cb4, 0x2e13154d, 0xca5a941e, 0xa071146c, 0x4fc491f8, 0x2c167910
.word 0xa862f49b, 0x9faa2ee2, 0x73a7ae36, 0x117780aa, 0x1332c808, 0xd4f46891, 0x681f6d07, 0x72fc309d
.word 0x98ef86d9, 0xbc6b4be7, 0x765abccc, 0xfc8b861c, 0x9bb0e45e, 0xb657e800, 0x02a554ad, 0x7ccba0bb
.word 0xe6f2b30b, 0x6348316c, 0xcde72a7c, 0x705f6598, 0x58221ba0, 0xdbcb7647, 0x3841f7a9, 0x460c874a
.word 0xda484b56, 0xb559ebf5, 0x1a819b9c, 0xcaba741c, 0x35432bc8, 0xee9a0d62, 0x186db7c2, 0x273f672b
.word 0x67ae816f, 0x4e232c66, 0x1f479291, 0x3cec7342, 0x7fb23167, 0xc35e6e5a, 0x796613c2, 0x1e83ce28
.word 0x36c95d23, 0x6fb471b0, 0x9fce5a72, 0x682d595a, 0x53af023b, 0xf9c5065d, 0x52062d0c, 0xe983c7a3
.word 0xf2ecbb7b, 0x696c3d9b, 0x43b62ed3, 0xb7dfbb46, 0x436c3241, 0x17b05580, 0xd7ef06dd, 0x61fab7c8
.word 0x2c0bb6bf, 0x0e634513, 0xbf88733b, 0xe63a272c, 0xcd48e24a, 0x4b5a207d, 0xcd8f856a, 0xe197a5ce
.word 0x0c82dc8f, 0x49845551, 0xa2e535ae, 0xa181a086, 0x7feaea24, 0x2204335c, 0x3b4cd654, 0x239ce1fe
.word 0xfcac223c, 0xeacf8d5d, 0xc1cfd8eb, 0x7b74e5af, 0xac632e45, 0x9e4a83a6, 0xbad4c9cf, 0xaa10ddda
.word 0xad01d5cb, 0xa6c5bce8, 0x8743b619, 0x3f72760f, 0x9a05ee0a, 0x58f3a6bb, 0xfa93bb88, 0x8a220a21
.word 0x3cfc942b, 0x2dbcb1e2, 0x3b6a1d0e, 0x1206ba47, 0xdf9e85db, 0xa2659f20, 0xe71fd0c4, 0x02bc7d47
.word 0x49ed7a40, 0x3feb5c11, 0xe80452de, 0x9ed18ad3, 0xe7e51788, 0x864bf8ac, 0x721dcb30, 0x35a26ac6
.word 0xd0662036, 0x4b06071f, 0xa1d99eaf, 0xf54b8aa2, 0x18350bb5, 0x9863365d, 0x4c396857, 0x0ce86f0a
.word 0x22c3919e, 0x180a96f9, 0xd5864175, 0x75be180a, 0xf90c4336, 0x2ec8ca18, 0x32b1edb9, 0x3c9ed478
.word 0x2f0156c4, 0x26e59eee, 0x31776ab4, 0xd46d4fb4, 0xde2fd097, 0xd0d736fb, 0x36ae14af, 0x6e44b276
.word 0xab88bc50, 0x27dda85f, 0x38fbb398, 0x7095c846, 0xcd5a1828, 0x40b4c507, 0xba17beba, 0x7fc94900
.word 0x84a0ee96, 0x31817533, 0xc63569a1, 0x225350df, 0x4267b8eb, 0x2a4aadb6, 0xac8df8d1, 0xbe9911f8
.word 0x483b2998, 0x44cdb20d, 0x5c675aa6, 0xd971ff91, 0xa6423977, 0x7de954b1, 0xd0e8e6e3, 0x2e69a2d7
.word 0x834e4f43, 0x542b6ce8, 0xf9dd5d3d, 0xdbe8efd9, 0x4aee3983, 0x13040867, 0x30a1c153, 0x596224c0
.word 0x794644c9, 0x4b0da328, 0xe2c45036, 0x487526f3, 0x15013a99, 0x8c898044, 0xb32c3136, 0xa423d2d3
.word 0xfcd909ae, 0x537028e9, 0x5c4d875e, 0x29e77624, 0xa0442a7c, 0x5223ad66, 0xfdd766f2, 0xa83dd332
.word 0x8b9351f1, 0x2c06a17a, 0xbcfa2830, 0xfc28bead, 0x166036f7, 0xa5f24eea, 0x94ef50cb, 0x7d76e71f
.word 0x055c7ff1, 0x7468f9d8, 0xa61782f7, 0x9f78950e, 0xbbb2a4cc, 0xbe42b330, 0xadd94438, 0x6b828087
.word 0x5c96d597, 0x3ca9391e, 0x875a457c, 0xfa663d90, 0x26b325e0, 0x0a86903e, 0xbef53c66, 0xcf1d3a89
.word 0x097a0eee, 0xac4c7912, 0xa7373a5c, 0x02b8f23a, 0x93a625b4, 0x2eba74d2, 0xb9f6047b, 0x36949b8a
.word 0xc43899d3, 0xade55d68, 0x46689078, 0x5935b95a, 0x91058f3c, 0x2868a51d, 0x46d14b06, 0x0860699b
.word 0x30d40c53, 0xce8ce748, 0x0418200e, 0x6a710ceb, 0xaa6cd9fc, 0xf7813299, 0x31e2b272, 0x7ac9fff6
.word 0x6d614d7d, 0x4e96bd5c, 0x2863a4e7, 0x5147211d, 0x9b9a7961, 0x8d9c56c3, 0xd6e7d365, 0x0fa3081d
.word 0x936d69ee, 0x358fcb1e, 0x6ab63cbf, 0x3d081125, 0xc5fc125d, 0xf4b24c19, 0x8f726704, 0xc170dd97
.zero 7168
mem_region_end:
