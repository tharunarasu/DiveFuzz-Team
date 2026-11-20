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
  li x26, 0x0000000a001841aa
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
  li x1, 0x68d4cff9ff9ae0bc
  li x2, 0x72db65d60c7ffc01
  li x3, 0x0b973afe2092af5e
  li x4, 0xbe98df8a9af0d804
  li x5, 0x2f25a6d87efbbd9f
  li x6, 0x9609be066bbcdbd7
  li x7, 0x1feadd1aa7b3679c
  li x8, 0x273d5da117c1eee1
  li x9, 0xc7ff213863a7b34f
  li x10, 0x864613f1677c2e7e
  li x11, 0xa06d17e3174a1a94
  li x12, 0x0001186b7c104c02
  li x13, 0x65aa1a5a63fbf9d3
  li x14, 0x2cf5e05539902c81
  li x15, 0x1c4961e749903a5c
  li x16, 0xe332fe84cb13f9b4
  li x17, 0xcf6e273f202715e6
  li x18, 0xeb8d06ba2f191049
  li x19, 0x3b580037558a3657
  li x20, 0x5f609e6b419ea08b
  li x21, 0xdfa4900df65b5577
  li x22, 0x8b371d130ccec164
  li x23, 0x319fd124514cb327
  li x24, 0x16cd17dcc0993c89
  li x25, 0x859cda2857f03636
  li x26, 0x98f34b50232fb232
  li x27, 0x2dd4d2aa64fde0c6
  li x28, 0xfcec0844af35cee0
  li x29, 0xf2f3ce8c16ce09d7
  li x30, 0xe64ca6c53330986d
  li x31, 0x44598f1383bcb437
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
  divw a5, s11, s7
  ld zero, -1928(t6)
  fence.i
  addi a3, a5, -1765
  mulhu s6, zero, a3
  div s8, a3, s8
  remw t2, t2, s0
  slliw sp, s4, 31
  lb s7, -447(t6)
  sraw s1, s6, a0
  mul t4, sp, s8
  srai sp, t4, 0
  fence.i
  mulhsu t1, s7, t1
  divw s11, sp, s1
  remw a7, sp, s11
  divw s10, sp, t4
  fence.i
  mulhsu t2, t1, s11
  remuw s8, s0, t2
  remuw zero, s8, s10
  mulhsu a6, s10, a6
  srli s7, zero, 50
  fence.i
  divuw a5, zero, t2
  mul tp, s7, tp
  fence.i
  fence.i
  mulhsu s4, zero, zero
  mul s10, a6, s10
  sraw ra, s10, ra
  remuw a3, t1, t2
  fence.i
  subw a7, s10, s4
  remuw s8, ra, s4
  fence.i
  remuw s5, s5, s5
  lbu tp, 216(t6)
  rem s1, a7, tp
  fence.i
  fence.i
  fence.i
  mul t4, s8, s1
  srliw a3, t4, 23
  fence
  lwu t1, -1920(t6)
  fence.i
  mulw s9, s1, s9
  remuw s10, t4, s9
  xori a1, a4, -2048
  mulw s5, t1, a0
  mulw a2, s5, s10
  fence.i
  slti t3, a2, -1
  lb s2, 495(t6)
  fence.i
  mulw a4, s5, a1
  sw a1, 1100(t6)
  slt gp, a3, s4
  remw tp, s2, a2
  fence
  mulhu sp, ra, a4
  mulw a2, a2, s10
  mulw s6, sp, sp
  sw s8, 1360(t6)
  fence.i
  divw s10, ra, s6
  mulhsu s11, sp, s6
  divu s5, s5, s11
  fence.i
  fence.i
  srliw ra, s10, 0
  rem a3, a1, s10
  divu s9, a1, s5
  fence.i
  remuw s0, s11, s0
  fence.i
  div t2, s0, s0
  lh s1, 1284(t6)
  fence.i
  srliw t4, t3, 31
  fence.i
  addw a6, s1, s0
  remuw zero, s0, s7
  fence.i
  remu s3, t2, a7
  xor a2, a6, zero
  fence.i
  divuw a4, zero, a4
  sh a4, -1108(t6)
  remw gp, a2, a6
  remuw s4, s3, s8
  remuw a6, gp, a6
  fence.i
  div a1, a1, a6
  lhu a3, 648(t6)
  fence.i
  fence.i
  subw t4, s4, t4
  divw t0, a1, a6
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
.word 0xf1247174, 0x69da9adc, 0x8ca2320c, 0xc4caecd4, 0x017bb78c, 0x283a0f47, 0x4bb46b1b, 0x4ca7ed85
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0xc21f7783, 0x1c88f37f, 0xfcc14c55, 0x5a93ad68, 0xa43d07bc, 0x540e5d39, 0x33baa2d3, 0x1c6468ac
.word 0x9d42b361, 0x1cdbabc1, 0xbbd87051, 0xf9b8d5e0, 0xc8d53576, 0x8eb8e19f, 0xcc96bea1, 0x29a11f8b
.word 0xb2fb6515, 0x541bd4b9, 0x43fbf9d8, 0x9cd560ca, 0x4694f4c6, 0xe5aeab77, 0x2bd058af, 0xbeb78f85
.word 0xa1592f78, 0xcaf8ee6d, 0x5982be74, 0x8076db88, 0x2d89469c, 0xc6c9b9dd, 0xb8c3b561, 0x84eac844
.word 0x2221c37e, 0xa79ebbf5, 0xda08e353, 0x75a77d0e, 0xbbdcefed, 0xe02e72de, 0x92d73dfe, 0x81a8ae27
.word 0xcfe19ccb, 0x05d88064, 0xe0bbed0b, 0x7f045282, 0x40a29559, 0xf872d9c0, 0x9690fe3b, 0xd58965d1
.word 0x22f84e70, 0xe5b73e20, 0x344076fd, 0x5d7239f6, 0xfae233ca, 0x70b802d5, 0x050e5dbe, 0x259764a4
.word 0xc1d6140e, 0x7c76f2bf, 0x16b8ad63, 0x67dd7bd5, 0x177ec119, 0x9956d482, 0x6fba6cb6, 0x3930d59f
.word 0x2eb7eb9d, 0xbcf6a925, 0x2b9e61d7, 0xe4dc3882, 0x0e7a9096, 0x40329a27, 0x1c695ccd, 0x88ed1fa5
.word 0x9a2117a5, 0x68059b4c, 0x8b7e52ae, 0xbf866ef8, 0xd0b5bf72, 0xe853357d, 0xbb054442, 0x44f5d3ab
.word 0xfc745f7b, 0x7c952809, 0x5958595a, 0x0bf9c76e, 0x372538c3, 0x03aa9ef9, 0xb38ed492, 0x43e8263c
.word 0x92e5cfdf, 0xd044c46d, 0x6e99ea28, 0x345b32ee, 0xa1d3e540, 0x9671213f, 0xf345ba57, 0x6b54fd1d
.word 0xbf3dc309, 0xb4e160f9, 0xca7bde69, 0x7cc06c0a, 0x411f2cd6, 0x03da3ba7, 0x0d6e3170, 0x8020e3f1
.word 0xe12ad288, 0xf34c3f4a, 0x69b644b2, 0x3ec4ec63, 0xd25d35ff, 0x6be8c06d, 0x49027ed4, 0x833bdf72
.word 0x7ec87083, 0x0e2a00c1, 0x9cee5e7d, 0x6cbdd422, 0x672a856e, 0xab1935dd, 0x180ce25a, 0x99c03ca5
.word 0x070f9ba5, 0x61bcbf86, 0x8c92e112, 0xe0ffba71, 0xc7087be9, 0x08717650, 0xb9ec9cfa, 0xc159699d
.word 0xe99e02c7, 0x95288a63, 0x5a00e189, 0xbb586839, 0x088fa541, 0x54777309, 0x727caec2, 0xce54fb1b
.word 0xe18a729d, 0x134554d4, 0x38bc3174, 0xfb6af106, 0xa673cd8b, 0xe5d385d2, 0x89dc1641, 0x4d26ba6a
.word 0xedbee168, 0x269949cb, 0xa6d5f431, 0xb697a4b4, 0xdc5eed70, 0x7c5dea73, 0x1d18d1b1, 0x3c475a32
.word 0xf75fba39, 0x8c3b3b0e, 0x22123986, 0x5b66593c, 0x45c187eb, 0x3312a27b, 0x1a241cf2, 0x633863f0
.word 0x8e3473c1, 0x0d802a74, 0xbdd99196, 0xaf520794, 0xf74285e8, 0xe3dbdc25, 0xb82cd6ef, 0x83e31c5b
.word 0x8f2f8c35, 0xd888b8db, 0x04739ded, 0x566989dd, 0x7d3610b1, 0x1f2ce4cc, 0x028fa064, 0xd9476ad9
.word 0x3041561a, 0xbafa84f6, 0x61c9f7b7, 0x635d80ae, 0x25abcee2, 0xc62ffcc9, 0x5715b09d, 0x1c0ffd2e
.word 0x8c6f70c5, 0x3992382e, 0xfdcbb2c3, 0x5a660731, 0xae9cac69, 0xaf5106ef, 0xf188b0ce, 0xe7cc90bd
.word 0x8109a669, 0x3f0008c1, 0x9aed1fc4, 0x0fe83690, 0x6065d78c, 0x42977ab0, 0x94f0f386, 0x059d7a5c
.word 0x6f60e67e, 0x776e292e, 0x07cfb0c1, 0x6047e24f, 0x53c733f5, 0xc59bf0e0, 0x6e1ce5a7, 0x48f3ac07
.word 0xea28432b, 0x58906215, 0xe792f045, 0x1e2110c6, 0x5ba0693c, 0xb60b0cc4, 0x0c539e78, 0xef23f512
.word 0x6e95fece, 0xb9cbe216, 0x72d22715, 0xdc07d75f, 0xff679054, 0x391426bc, 0x6ab198cd, 0x55e1c5b8
.word 0xd042ce77, 0x2eef289b, 0x6aa9b8c7, 0x46215924, 0xb4c1c473, 0xe6f29cb6, 0x307e9e28, 0xc80a89fb
.word 0x2eb2869b, 0x645b3067, 0xad8585bf, 0xf83476fc, 0x39b8648b, 0x4dc931a7, 0x08a126b3, 0xa2053dfc
.word 0x96df87f5, 0x3bc1e240, 0x3004c788, 0x1962dee3, 0xe96537df, 0x913af138, 0x31945952, 0xa89fac5f
.word 0x5a180629, 0xe07455ec, 0x5bfe07dd, 0x7912255e, 0x0d67767f, 0x2cb1bb2e, 0x82c0f097, 0xb004368a
.zero 7168
mem_region_end:
