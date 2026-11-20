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
  li x26, 0x0000000a0060010a
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
  li x1, 0xd83d5fcdb04e6cc9
  li x2, 0x1f06da4791f69027
  li x3, 0xd99815edaa1c0e6a
  li x4, 0xa500913a5708757c
  li x5, 0x9c432c8ac9920e70
  li x6, 0xa86db27803ee4154
  li x7, 0xbd6936bced8758df
  li x8, 0x099c6a0a59653951
  li x9, 0xbe1fa0e9bf602adc
  li x10, 0xb3f18e5d45278cfa
  li x11, 0xbc9b2b585dd4fc37
  li x12, 0x56ba8760bd797449
  li x13, 0x18cd0e15de2af094
  li x14, 0xc26b8c40d5956ea8
  li x15, 0x97cf7bc9479cf2c1
  li x16, 0x5f60c7cb2d184f49
  li x17, 0x2423abfe57c9e964
  li x18, 0x09552c3ab25dcf49
  li x19, 0xbee5b50ea6a1d89d
  li x20, 0xbe2be7e679b5ec75
  li x21, 0xc736f2e50080a04b
  li x22, 0xb693130a13607008
  li x23, 0x9f86540c49554924
  li x24, 0x7759a9b1ef8bd237
  li x25, 0xde5f69f518e34353
  li x26, 0x9a7ef7db1afeaad7
  li x27, 0x594125ae629da2d1
  li x28, 0x5f77d19b30399a5f
  li x29, 0xd44b51c0a8a51081
  li x30, 0xfe4ec847b39f02a8
  li x31, 0x8722fd5ad5b6b9a8
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
  remu s2, s2, s2
  ld gp, 1728(t6)
  remw tp, gp, s3
  sraw a3, s2, s6
  auipc a0, 640090
  sllw s8, sp, tp
  remw s5, a0, zero
  mul zero, ra, a6
  slt s5, tp, s3
  slli a7, s11, 3
  remw s3, s5, a0
  lwu t1, 404(t6)
  ori tp, zero, -1
  mulw s0, s3, a7
  srlw t4, s3, t4
  mulw s4, tp, s0
  remw a0, s4, t2
  and a1, t4, s4
  remw s11, a4, s9
  addw ra, s4, a7
  lh s0, -1918(t6)
  srlw ra, ra, a0
  sraiw gp, a2, 1
  remu s3, s4, ra
  srli s1, s1, 40
  or t2, ra, sp
  div a3, s4, a5
  srli t1, t1, 6
  sltiu t4, zero, -1950
  sll tp, tp, a3
  mulw t2, tp, t4
  sllw t0, sp, s1
  remw s3, gp, tp
  mulhsu s10, t4, s10
  ori a0, s10, 0
  remu s7, s7, s4
  ori s8, a0, 936
  sllw s5, s8, a0
  sllw sp, s8, ra
  divu tp, s8, a0
  mulhsu s11, tp, s8
  sd s7, 800(t6)
  divw a2, tp, sp
  sllw a7, s11, s5
  div a5, a5, a6
  divuw zero, s0, a7
  sd a0, 1744(t6)
  mulhu s7, zero, t2
  mulw a7, a6, zero
  div a5, t1, t1
  lui t0, 948532
  srli sp, sp, 0
  div s0, t0, t0
  remuw ra, a5, a5
  addw s3, s3, s0
  remuw tp, s8, gp
  srliw s4, gp, 0
  remu s2, tp, tp
  mulhsu s3, s2, t2
  mul a7, s4, s4
  add a2, s4, tp
  divw sp, a7, s2
  auipc t2, 1
  divuw a3, sp, a7
  mulw t3, t3, a3
  srlw s2, a1, t3
  mulw t3, a1, t2
  mulhsu s2, t2, a3
  addw a5, t3, a4
  divw s3, s5, a4
  li s7, 403051533270
  lbu s9, -436(t6)
  div tp, s9, a6
  remu a0, s3, a7
  sb a0, -1363(t6)
  lui t2, 0
  srlw s7, a7, t2
  srliw a5, s7, 4
  divw gp, a5, t1
  li a2, 479132769309
  srli s0, gp, 63
  sub s3, a2, s8
  li t4, -181818557942
  remuw s11, s7, a3
  remuw s9, s11, s3
  divw t1, sp, sp
  sraiw tp, t1, 11
  sh s11, 1888(t6)
  lui ra, 1
  slli s5, t3, 0
  divuw s1, s1, s1
  divuw a1, ra, s5
  srli s4, s4, 1
  mulw a2, s5, a5
  sd s4, 1640(t6)
  sraw s3, s4, s5
  remuw s7, a2, a5
  divuw s0, s7, s3
  remu a1, a1, t0
  divuw s2, s2, a6
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
.word 0xdcba4d06, 0x2d657bf3, 0x718aaef7, 0xd04b8763, 0xa4cf2841, 0x49e6403b, 0xe2a4f5f3, 0x4478d95c
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x1494fcec, 0x0e70b364, 0x17e6dc3c, 0x6c742044, 0xaf72e9a3, 0x4d337d51, 0x7afffe7d, 0xe2672cfb
.word 0xc89f7cc9, 0x669a6640, 0x12e0c0a0, 0xb61dad5f, 0x8ffa9d2a, 0xe8a71e60, 0xc73dabe0, 0x73f953e0
.word 0x48618faa, 0x0e9b5b5c, 0x14bcc5a4, 0xd1ba210b, 0x96bcfad0, 0xe7c49e27, 0x091a22fe, 0xd14c6748
.word 0xd8afa85f, 0x892a2580, 0xe44d0ce6, 0xfefed1b2, 0x43408152, 0xd7f29954, 0x3962f555, 0x4e07f06f
.word 0xe1aca140, 0x79f310de, 0x4a67ef8f, 0xfea7d719, 0x6a691aa3, 0xf3b8bd6e, 0x965240d2, 0x191f0ae0
.word 0xc88b2140, 0x751f2ee4, 0xcdeb9d57, 0x8a6ce61e, 0xec8426ad, 0xfe0d857b, 0x5ea6984e, 0x776be8b2
.word 0x6bc7f0ea, 0xc6373556, 0xca5ec8ff, 0xef728c3d, 0xf30328e2, 0x607bf7a0, 0xa5d542ea, 0x5087078a
.word 0xc78d107d, 0x3f5f985c, 0x91b6c819, 0x565d72fb, 0xd8def0fe, 0x1e59711b, 0x5feb643b, 0xb61c6cdb
.word 0x67cdcb63, 0xb5420d9c, 0x7ba35207, 0xf37202c7, 0x691ddbb2, 0xf735d56a, 0x0734eaaf, 0xdd78dcaa
.word 0x0cedc449, 0xdaca0fad, 0x8c06fea0, 0x852e121e, 0x4198c474, 0x1230901d, 0x112a8bdd, 0x5c96daf5
.word 0x36e470f9, 0x6eabfefc, 0x3136e785, 0xa2f79e41, 0xc0655c17, 0x9e88d6c0, 0x43c1ee7d, 0x6e95b509
.word 0xdc6b05a3, 0x7b2c4723, 0x142352cb, 0x64fe2829, 0xb141f7fa, 0x47f8a17e, 0x8b8f734a, 0xa5b0c4f0
.word 0xe26d0743, 0x24af1fa6, 0xf5de9709, 0xa841f436, 0x5baa5d92, 0x3c9604be, 0xe098724c, 0x57739b35
.word 0xfeb67fed, 0x4ca42895, 0xd6a5a636, 0x3377ea93, 0x7ce08c51, 0xf6cc81ad, 0x5d7ed179, 0xcfdfee1c
.word 0xd46f98bb, 0x9d94f30f, 0x2e2ae558, 0x5a1d97f6, 0xeec8fcb3, 0x47adf7a2, 0xe6a9f99b, 0x0dd50a5d
.word 0x3d4c4272, 0xe6d2c2b2, 0xe6df55cb, 0x195feb2b, 0x8ed1b8bf, 0x379059cc, 0xecbab06f, 0xe169a33a
.word 0x4bfa1fe6, 0x8662ebea, 0xf3383209, 0x1f538b93, 0xd8175876, 0x3e6f8048, 0x5f37b731, 0x91a9f2aa
.word 0xa6d5cf2f, 0x149948e5, 0x2bf2dd97, 0x0458043f, 0xcba43135, 0x9875b42c, 0x96f42bd3, 0x70d575d3
.word 0xf9f4b355, 0xfca02d10, 0xaa5ed398, 0x322e825a, 0x8d70c65e, 0xce07a7a4, 0x0931efdd, 0x91a182d3
.word 0x5922d9cb, 0x7517c70f, 0x9cd3a7a4, 0x9ec5e349, 0x4a0582f3, 0x32eb0746, 0x6332433a, 0x65bd7c78
.word 0xffa261a8, 0xc57a94c0, 0x5d76bd24, 0x649c00ee, 0xe1c85635, 0x1eafcbda, 0x1fa4902a, 0xf192a753
.word 0x82cce8ac, 0xdf7a383b, 0x673e67d2, 0x4723d071, 0xec682377, 0x3941fa3a, 0xedcef891, 0xc92eabc7
.word 0xb36aa7e3, 0x7092b9bf, 0x28a8d149, 0x56b70161, 0x3814d34d, 0x031d3541, 0x66bbd73d, 0x5c00df54
.word 0x3832216e, 0x9b21f777, 0xb0a925c2, 0x971618c0, 0x3a475aa5, 0x08d49aa3, 0xdb3fa8c5, 0x41a74f3d
.word 0x8c945ad1, 0xf60ddb6e, 0xa0b27cbd, 0x76d76df6, 0xabcf16d0, 0xb9ec8c9b, 0x5e6f8f3d, 0xce382ea1
.word 0xc364f666, 0x638960f4, 0xf687a418, 0xbacd5505, 0x564b16cb, 0x6b03e369, 0x4624bc01, 0x744ae4eb
.word 0x5d381c33, 0x4cd64682, 0x58ad8aee, 0x70ba4e02, 0x103ed30e, 0xef0aed8e, 0x4174f6d7, 0xa4aa6a3b
.word 0x9015b035, 0x3a7149d1, 0x46d8d225, 0xd758178a, 0xf7be60b7, 0xcb0716a5, 0xb134bd02, 0x2f993e3b
.word 0x3ef1ed1e, 0x89bc582f, 0xad85e29d, 0x1c2ba6cc, 0xe8ccb963, 0x77cfd4d4, 0x4fe983c2, 0x908c755f
.word 0x9ff8cc63, 0xd033313d, 0x40233e0d, 0x47d14b73, 0x290c642c, 0x990aab38, 0x81e2bc72, 0x31fb2634
.word 0x8669401f, 0x834f903e, 0x697b91c6, 0xb9e4a587, 0x8ee5dcac, 0xcd5c3b38, 0x4b46b455, 0x4a21d2df
.word 0xea11543b, 0xf4466e94, 0x50ea8fc8, 0xa11cbb6a, 0x2a4dd9ef, 0x5b4ad9e0, 0x8ac438e1, 0xfc53468e
.zero 7168
mem_region_end:
