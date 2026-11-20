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
  li x26, 0x0000000a000c6188
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
  li x1, 0x4716fd2c41e66fc2
  li x2, 0x3e52328cc5643fb7
  li x3, 0xd7218a78696964f1
  li x4, 0x62f9cb9976834399
  li x5, 0xd3a0b016c6936b5a
  li x6, 0xace6d00fe69561b4
  li x7, 0xcf2d1e9b7995fe5e
  li x8, 0x9174a56934bf4f2c
  li x9, 0x160b3b29e458c28d
  li x10, 0xa12c2356a7a59860
  li x11, 0x39f8154f8651e90d
  li x12, 0xd66e42828789a4cf
  li x13, 0xb5347d1bbab53ff8
  li x14, 0x9e5384d110e186db
  li x15, 0x6f509305a086dc0d
  li x16, 0xb26d04b33c2ac4ab
  li x17, 0x64fd44ae97a8dc65
  li x18, 0xe2a9e381ec4d44ad
  li x19, 0x06ee2dab2d1eb4b5
  li x20, 0x4888ca4e3bcb4834
  li x21, 0x6d981ab23ee849f8
  li x22, 0xcf625ab393c8e0ab
  li x23, 0xb1fa7d1f8cb84761
  li x24, 0x34ca63855725102f
  li x25, 0xbef65f4ab49a6c0f
  li x26, 0x3a8fdb9197ea7d74
  li x27, 0x73b4432f5fac698e
  li x28, 0xd8d10a9c1fb3dcdc
  li x29, 0xe24e7fdbf94f4766
  li x30, 0x3d89ddc6b70985fc
  li x31, 0x12c87d186455ac1d
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
  remuw s8, s1, s9
  slli t0, s8, 0
  sltiu ra, s7, -1
  mulw zero, t0, ra
  srli a1, t0, 0
  mulhsu gp, zero, a0
  fence.i
  slli a2, a1, 63
  mulw s11, a2, ra
  remuw s3, zero, s3
  srli s7, s11, 0
  andi t4, s11, 366
  fence.i
  fence.i
  remuw ra, a2, s7
  divu gp, s11, s11
  divu sp, s7, a6
  srai s5, s7, 40
  fence.i
  remu s9, sp, s5
  rem a6, s5, a4
  xori s0, s5, 858
  divuw a0, s7, a0
  fence.i
  fence.i
  mulhu s11, a0, s9
  divuw s4, s11, s11
  remuw a5, a0, s3
  fence.i
  or s10, a0, s11
  rem sp, sp, s10
  fence.i
  fence.i
  remuw s9, s4, s11
  fence.i
  remuw a3, a3, a2
  fence.i
  sltu s1, a3, s10
  slt s4, s4, a3
  fence.i
  sllw t1, t1, s9
  fence.i
  fence.i
  sub a2, t1, s9
  lui s5, 0
  divw s9, s4, s4
  lw gp, 1328(t6)
  divuw tp, s9, tp
  mulw s9, gp, t4
  mulhsu s2, s8, gp
  div t3, t3, tp
  remu a6, s2, tp
  div sp, s2, a6
  remuw a7, sp, s2
  lw zero, 1796(t6)
  sd a7, -1032(t6)
  rem t2, a2, sp
  fence.i
  div s4, a7, zero
  srli s3, t2, 0
  remw a2, s3, s3
  fence.i
  fence.i
  div a1, a1, s3
  ld s2, 376(t6)
  fence.i
  sw s2, -1020(t6)
  divu ra, ra, s9
  addiw t0, t0, 0
  addw s9, ra, ra
  divuw s11, s9, s2
  mulhsu s7, s7, ra
  divw t4, s11, t0
  divuw s6, s7, s9
  divu s5, a5, s3
  fence.i
  div s1, s7, s1
  xori s4, s5, 1
  fence
  fence.i
  xor s3, s4, tp
  divw t3, s1, s5
  sd a6, 1432(t6)
  slliw s10, s1, 0
  fence.i
  fence.i
  remu s11, a5, s4
  remu s2, s11, s11
  remw t4, s3, s11
  divw zero, t4, s10
  lb s6, -894(t6)
  fence.i
  subw a4, s2, a1
  rem ra, zero, s2
  slt s9, s9, a6
  srli s8, s6, 13
  remw a0, a4, a0
  mulhsu t2, a4, t2
  fence.i
  sllw sp, s9, s8
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
.word 0x11bdc7e1, 0xe6b7da02, 0xf9f5ecda, 0x0d6edb87, 0x8841e2f7, 0x20b0c810, 0x1cb955f7, 0x6091f7ce
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x7f260aa9, 0xcd1b31aa, 0xdc06f3d6, 0xe76c3e1b, 0x309fc18d, 0xa42b8241, 0xeeb36237, 0xf129b80e
.word 0xfb31ffc6, 0xa6b24d68, 0xdd9139af, 0xc0b43325, 0xc65534cd, 0x709c510c, 0xdaff04fd, 0x8f6be16e
.word 0xd2b94830, 0x8f672253, 0xbef43738, 0x9ae53a27, 0x65683d8c, 0xe9b57aad, 0x8d1aebf5, 0xfa31136b
.word 0x72402065, 0x13c9a378, 0xd473b6f7, 0xae3ee02f, 0x4be88bc5, 0x476f67d9, 0xf5931c35, 0xed8e71e2
.word 0x953ef498, 0x0a319256, 0xbb753e3d, 0xf25615c2, 0x4ee8f12e, 0xb7275b1f, 0xf8bdb09e, 0x93717040
.word 0x353055ca, 0x8310b127, 0x8aeb093c, 0x74ec0b7a, 0x7d7b43e0, 0x02d69fd8, 0x42db55bc, 0x1d9b40ee
.word 0xa032730d, 0xe2fe69c4, 0x51ea523c, 0xf91c7542, 0x8875be93, 0xd51f8125, 0xa0867bf3, 0x3489c52d
.word 0x80b6ccc7, 0x717c7c04, 0x096dc9f1, 0xdb739de6, 0x5c225c16, 0x562098aa, 0xaa1be7fa, 0x249fe444
.word 0xf13bd98c, 0x1b7af935, 0x3d339ec4, 0xe7e5f864, 0xbd986217, 0x9812d10e, 0xb1b167ce, 0xc80b89c6
.word 0x2f543415, 0x180245da, 0x4eb18b60, 0x7d12264c, 0x24997b77, 0x3f396dcf, 0xca135c75, 0xf5bd9a3f
.word 0x47f82e44, 0x119b1f81, 0x0055fe85, 0xdb4f809b, 0x59a7ee99, 0xa88f30a1, 0xc12654f5, 0x7aefb1f6
.word 0xc734c195, 0x32bcb874, 0xbd5c6974, 0xe4b771d3, 0x3e99a62c, 0x8e04a477, 0xe8eabfec, 0x79ddfb49
.word 0xff1c8688, 0x6b26420a, 0x79883d08, 0x97abdb25, 0x1c5e111c, 0x7dc65c33, 0xa2199890, 0x1ebd9d4f
.word 0x67af970f, 0x507b3973, 0x8c3b469e, 0x53380787, 0x67790431, 0x18fa4cac, 0xc0a86de1, 0xafbd2203
.word 0x972c5b76, 0x5383123f, 0xacf2aafd, 0x1540c200, 0x1e84a768, 0xb9a6c694, 0x4f7a6217, 0xfc1f6a7f
.word 0x8316768e, 0x57b4fea4, 0x68a9f39a, 0x83ecf46e, 0x7702d67b, 0x779ac983, 0x47f63ab2, 0x9a12931d
.word 0x56c9b772, 0x121926a2, 0x8b14abf2, 0x10d29030, 0x49edb90b, 0x63fe66b0, 0xd8d6fcba, 0x494befed
.word 0xb18cb69d, 0x0bde6c1c, 0x3ae3c592, 0xd295be4a, 0x5a6e5714, 0x26ad1df6, 0xf2f80c05, 0x430bbc28
.word 0xa93f7ed4, 0xa3968911, 0xab976c2d, 0x1c7925ce, 0xfe3a581d, 0x29930ad5, 0xdbf579c3, 0xc6274a56
.word 0xeda1018a, 0x83ecc163, 0xdfbcb8e9, 0xa70385a8, 0x4f888cd1, 0x6413c7ea, 0x35c9fbeb, 0x086b18df
.word 0xd84d6ed2, 0x2e0b9796, 0x2acea48a, 0xffffc253, 0x3734c5fa, 0x99979fd4, 0xa2e8968a, 0xd3d7b6de
.word 0x161e6a60, 0x5b424d35, 0x1e01e163, 0x4e01fa33, 0xa633c7b9, 0x0350a4ce, 0xf16a51be, 0xf0e0020b
.word 0x98ced6d8, 0x2b9c6d65, 0xc5e90063, 0x180b142d, 0xab6c34fb, 0xb99d1100, 0xe10ce1de, 0x86e9919f
.word 0x66dbd30d, 0xed0b6532, 0x8da08f50, 0x41597c06, 0x13b9eb4e, 0x7cac83bd, 0x0c88dfbd, 0xf2ea9dfb
.word 0x8f191c9f, 0x7cce0467, 0x1a43f6d0, 0x199955bf, 0xaec1d43e, 0x9dac2b44, 0x64086828, 0x3ab72509
.word 0xdd838eac, 0x4d0c17bf, 0x8368611a, 0x617f9a31, 0xe9fb4023, 0x3391976f, 0x75bc5a3c, 0xc37e758e
.word 0x83dbae7d, 0xb6596a07, 0xf114ae3f, 0x08cc18a5, 0xf58abd15, 0x26a820c8, 0x78729cf0, 0x2ca70b83
.word 0x12e47e48, 0x32c53f64, 0x3aa2f278, 0x5a1187df, 0x1f788233, 0x65ce334b, 0x60dc6cc0, 0x6fc13323
.word 0xe04a8239, 0xd8c58748, 0xeb8a3672, 0x24b93665, 0x63516840, 0xfe306e04, 0x595f8e56, 0x87df7dfc
.word 0x22aaaba9, 0x6fe860e1, 0x80b4ada2, 0x03d8eb6b, 0xa1f63a51, 0x31a29446, 0xb7bb9b1e, 0x4c4f9e8c
.word 0x6ce6a8b3, 0xfa6d6e9f, 0xfaf7feb9, 0x30731c03, 0x50479d6c, 0x82881ad6, 0x0b594d58, 0x810bcf8e
.word 0xa450459b, 0x25a7b2fb, 0x99ba1bd1, 0x78ed096e, 0x3cade09b, 0xde88b26d, 0x8714572c, 0xa5d65e7a
.zero 7168
mem_region_end:
