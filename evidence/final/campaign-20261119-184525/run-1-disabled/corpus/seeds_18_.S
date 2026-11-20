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
  li x26, 0x0000000a002078aa
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
  li x1, 0x39b5abbe427bfa04
  li x2, 0x1aa812da42d3366d
  li x3, 0xa71b9d71c66ce1ca
  li x4, 0x68b159c0599e6963
  li x5, 0x2f502dfa0c7323f8
  li x6, 0x71d0a325d6e3e6da
  li x7, 0xcf40594c49d5f1b0
  li x8, 0xa746164a78f53663
  li x9, 0x794be593ec2ed66a
  li x10, 0xd5f7ffde0b3a1515
  li x11, 0x7e809fd61ee1da19
  li x12, 0x9a4d9000281c2bc7
  li x13, 0x309fdbcef84e9793
  li x14, 0x870e540bce4818cf
  li x15, 0x6620f7faad33b79a
  li x16, 0x7f3c51c168c301a4
  li x17, 0x6ff8c37e2b398a56
  li x18, 0xe29ca9a7b391570d
  li x19, 0x1a1a76b40de75ae2
  li x20, 0x4ab63fada62074d5
  li x21, 0x1a32510fe18169b3
  li x22, 0x61d50fd172d4a4bc
  li x23, 0xd40b44c593a74d25
  li x24, 0x81c7e760cd890019
  li x25, 0xaead9dc2c505431a
  li x26, 0x1b41a244eb3428b6
  li x27, 0xbfaa0218b6166d8b
  li x28, 0x2d1b00224befc98c
  li x29, 0x6b446701d20637cf
  li x30, 0x49de527c353e92a7
  li x31, 0x7708573ca4ee7a91
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
  sraiw s4, tp, 8
  fence.i
  fence.i
  addiw s9, s4, -1679
  srli s5, s2, 15
  slt s8, s9, s8
  fence.i
  mul t1, t1, s5
  mulhu s0, t2, s5
  mul tp, s9, s2
  srl a7, a7, a7
  or a4, tp, a4
  mulhu s4, s0, a2
  mulhsu s11, t1, a7
  remu s6, gp, t3
  divuw s7, a7, s11
  and t2, gp, s11
  fence
  mulw a4, a0, t2
  lbu s2, 924(t6)
  sllw tp, a4, s7
  div s10, a4, t2
  mul s5, s2, s2
  mulhsu a0, s9, a0
  fence.i
  srli a6, s5, 10
  remuw zero, zero, tp
  fence
  fence.i
  mulhsu s4, t2, zero
  mulw t1, zero, zero
  nop
  remuw s5, s6, a6
  subw s7, s7, s4
  subw s8, s5, s1
  divuw s6, a3, t1
  divu s11, s6, s11
  lwu t0, -432(t6)
  divw zero, s11, s11
  sd s8, 1776(t6)
  div s10, a2, t0
  lwu s11, -580(t6)
  divu ra, t3, s6
  fence.i
  li a5, 549755813887
  divw a4, s5, s10
  fence.i
  addw s7, s7, ra
  fence.i
  remw s1, a1, a5
  lb t0, 43(t6)
  xori s2, s7, 502
  fence.i
  mulw zero, a4, s7
  subw a3, s1, t1
  fence.i
  remuw a2, s2, a3
  div tp, a3, zero
  srliw s4, zero, 0
  li t3, 0
  sll s9, a2, tp
  addw s7, s4, s4
  remw a4, t3, s7
  srlw zero, zero, t4
  mulw a6, s9, zero
  lui s10, 0
  mulhu t0, s10, s1
  lbu s0, -1192(t6)
  lwu a1, -1512(t6)
  lw tp, -1132(t6)
  remw a4, s8, s8
  srlw s3, tp, a1
  mulhu s2, a1, a4
  remuw t1, s3, s2
  sb s3, 1673(t6)
  addw a6, a4, a4
  xor t0, s2, s2
  ori s7, a6, 1673
  ld ra, -1464(t6)
  sltu sp, ra, s7
  mulhsu s9, s9, s7
  mulw zero, ra, s7
  rem t2, s9, a1
  rem a2, sp, a5
  mulw a7, zero, a7
  mul s6, s9, t2
  sub zero, a7, a2
  remw a5, a7, a5
  subw s5, a7, a2
  remu s8, s5, a7
  mulhu a3, s11, a5
  lwu sp, -1992(t6)
  fence.i
  fence.i
  fence.i
  remw s7, sp, sp
  remw a0, a3, s5
  srai s3, s8, 8
  sw a3, 1644(t6)
  lbu s4, -982(t6)
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
.word 0x358e261e, 0x70c1d355, 0x32accabd, 0x922e4358, 0x31a025b3, 0xd9c9e409, 0x39fc63a1, 0x804d8a73
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0xf1667e17, 0x1fa6f6fd, 0x91377b21, 0xd2a059b5, 0x587f1d63, 0xc6db8000, 0x05286827, 0x264b2f1f
.word 0x1e5487fd, 0x7a2c938b, 0x9c043391, 0x0d9c0609, 0x15624e18, 0xe598d116, 0x834909d8, 0xa1e8d05e
.word 0xad914c12, 0x6f012af7, 0x08ecced6, 0x0adb8b6d, 0x63ee7ace, 0xbc201ee3, 0x6a37ac1e, 0xddf0620c
.word 0x42960844, 0xfc2301d1, 0xf408d966, 0x593b0795, 0x4b555ac2, 0x9ec6fe89, 0x7137590b, 0xaccba451
.word 0x218db790, 0x7a4b034d, 0xa3eb0788, 0xf1287cc2, 0x06155bb1, 0xced24517, 0xc83dd587, 0xa8508ca7
.word 0x7273524a, 0x6de7eadd, 0x77a9c5ac, 0x3e451a8d, 0x99a3e3cd, 0xfb0cc64c, 0xbedf8a7d, 0x400d15c3
.word 0x54703a9f, 0xc2d40bf7, 0xc2c95635, 0x7d8215d6, 0x058afaac, 0xee5bc14f, 0xfcf67166, 0x90117c85
.word 0xa949f52a, 0x999ddf20, 0x01b86193, 0x4268bbce, 0x3a0f851b, 0x79cfef85, 0x6865bfae, 0xb26870e1
.word 0x57ba8720, 0xa7e8b59b, 0x478945e4, 0x31decccd, 0xba83106b, 0x96b80023, 0x63497882, 0xf558dff5
.word 0x0c9d84cf, 0x7e75ecbe, 0x3a050519, 0xf894a200, 0xcb6b76ad, 0x1d9ff672, 0xf0fa2e3b, 0xd17fce23
.word 0x1692c8cf, 0x468fbf12, 0x2fbb8f6e, 0xbed65964, 0x8ec396c7, 0x496ae56a, 0x0e97029c, 0x5fae2093
.word 0xadc026f1, 0x27f3750c, 0x27d520a5, 0x5ba7c800, 0xcddb13ac, 0x4d899236, 0xf34dd1e6, 0xe0cb8938
.word 0xfc37aece, 0x6968332d, 0x4aced941, 0xfc8655e3, 0x3d8d13cb, 0xd9e33817, 0x91e82f4b, 0x53dc9abe
.word 0x177c4042, 0xe65ffd2c, 0x03341467, 0x7212200a, 0x4d29241b, 0x10e8b01b, 0x6bfe6af5, 0x27faad65
.word 0x4a87b249, 0xdab2a9e9, 0xedd76aa0, 0xdb233582, 0x5f86517f, 0xe5beb901, 0xeeca5cc6, 0xe317e93a
.word 0x8f1c4498, 0x46b9d273, 0xf0e1c5d2, 0x37c68674, 0x86e1367e, 0xe5d539f1, 0xbe46711f, 0x94ec5b4f
.word 0xa3a9264b, 0xbff97c3f, 0x7f8ba57f, 0xc3154615, 0x61edf649, 0x90cee861, 0xbe1f0a57, 0x53e87c9e
.word 0x2b2ac9eb, 0x85044b7e, 0x77079c02, 0x8f23a363, 0xbcddf86a, 0x1842c3ad, 0xc4879e33, 0xdab4ed2c
.word 0x90a199a5, 0xc76b6518, 0xed28b690, 0xb56a621a, 0xb95b2edd, 0x22f06112, 0x70079155, 0x6e6447ee
.word 0x00da113e, 0xe33f0a77, 0xadc4c8da, 0x8c67f714, 0x434f134b, 0x3c77b7e3, 0x696cefa7, 0xa1a1edc7
.word 0xbc935768, 0xdcf4c4d5, 0x468a146f, 0xadc22eca, 0x2a7ec317, 0x4751b10d, 0xf180ab56, 0x993e6541
.word 0xbac44982, 0xb482f86e, 0x558e13ae, 0x5def4882, 0x74a9b608, 0x0b6d0457, 0x4bb91f46, 0xbff1f156
.word 0xafa30d0c, 0xb096b12c, 0x20cff67a, 0x5789d334, 0x22da55b3, 0xfc539cda, 0xc27cf542, 0xbd47ba53
.word 0x4436fa4a, 0xcfccda58, 0x681c13eb, 0xd1a0b1a4, 0xa96e86c2, 0xa46c2a81, 0xeae3753b, 0xf7d8823e
.word 0x297b6943, 0x8d5d3060, 0xf389ed32, 0x07909a95, 0xe104a5c4, 0xa28484e6, 0x5c139b40, 0x9e8b2682
.word 0x634a7f5a, 0xdf7ed139, 0xa1969eb2, 0x41884fec, 0xebeadf7c, 0x26068857, 0xc97e4af8, 0xfe7bbd63
.word 0x66498b81, 0x1eb1cc34, 0x02f3caae, 0x293a3091, 0x161e53e6, 0x07a68188, 0x255bdddb, 0x05260c29
.word 0x76c4c9d1, 0x81680911, 0xa41462a8, 0x0320715d, 0x9a4fb0a6, 0x38ec0734, 0x26312eca, 0x7f89ca9d
.word 0xd8bd7383, 0x2b847bb8, 0x00b93d4c, 0x651caebe, 0xcd05a31a, 0xff51d9bb, 0xe32984ce, 0x0c644ba7
.word 0x47288ed4, 0x1599c76a, 0xb808d068, 0x66093b3a, 0xc048ba3f, 0x2324a217, 0x6bb8c359, 0x8f24a627
.word 0xdf7255c2, 0xc062a3ec, 0xb07e69f5, 0x3a013fb0, 0x1af151b2, 0x75dc3f6f, 0xa1e2012f, 0x79a47fc4
.word 0x3378e3fb, 0x9f31cf3a, 0xc85e009d, 0xa5217094, 0x3becbc89, 0x2ea9babe, 0xb6e1cbc7, 0x019ab317
.zero 7168
mem_region_end:
