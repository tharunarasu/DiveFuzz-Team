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
  li x26, 0x0000000a00686982
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
  li x1, 0x4beeabc8a9ff9818
  li x2, 0xcbd22080d129b552
  li x3, 0x613e5111be7cd575
  li x4, 0x9e12e041ebb6b785
  li x5, 0x1ce8999cff19d85a
  li x6, 0x3640f1e259c55c02
  li x7, 0x6e19205414b17c8f
  li x8, 0x91b01cf5d2822135
  li x9, 0x7a3cccc7599a3d67
  li x10, 0x04fb5e44fdd1fc0b
  li x11, 0xd6d7e34879f9ffcd
  li x12, 0xd3f4de8fd7d4ac31
  li x13, 0x8907755b280be711
  li x14, 0xaf12a66201a497fd
  li x15, 0x87b8a8fc44725671
  li x16, 0x2a55c1438a2e5742
  li x17, 0xb7707cbeecfd6142
  li x18, 0x18b53a5ebcf3b397
  li x19, 0xef565c1b436863df
  li x20, 0x3be2f2e972197e41
  li x21, 0xde1ab5b3413fd279
  li x22, 0xf65c26917948611a
  li x23, 0x217f5908c4d68c00
  li x24, 0xb62e3ae57f33d025
  li x25, 0x174d70bcb8b182c1
  li x26, 0x6935f074262c6fb5
  li x27, 0x4109505a330761e4
  li x28, 0x2fed8ac54fba7897
  li x29, 0x832f097e19288aad
  li x30, 0xda7c7041c385756d
  li x31, 0x785fcfa8aa4a980f
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
  mulw sp, sp, sp
  addw s2, sp, sp
  divuw t3, s2, sp
  fence.i
  remw s8, s2, t0
  divuw t2, t3, a6
  fence.i
  lwu gp, 836(t6)
  fence.i
  mulw a2, t3, s2
  mulhu s7, a5, t3
  fence.i
  slt s6, s6, t2
  mul a5, s7, gp
  li s9, 1
  lbu s4, 580(t6)
  fence.i
  fence.i
  fence.i
  fence.i
  remw t0, s9, s9
  slti t2, a5, 117
  addw s2, a7, a5
  fence.i
  lwu s0, -1588(t6)
  divw zero, zero, t2
  sd s0, 280(t6)
  fence.i
  add ra, t0, zero
  mulw gp, t2, gp
  slli s10, ra, 0
  ld a0, -1400(t6)
  fence.i
  slt a6, ra, ra
  fence.i
  fence.i
  mulhu a7, a6, ra
  divw s0, a6, s5
  sra tp, a0, a7
  fence.i
  lb sp, -1828(t6)
  divw a2, tp, a5
  fence.i
  fence.i
  fence.i
  mulw gp, t2, gp
  fence.i
  fence.i
  mulw s10, s4, s10
  mulhsu t1, t1, s3
  fence.i
  mulhsu s3, s3, s10
  sltiu a5, s3, 2047
  mul tp, tp, s10
  remu s8, a7, t1
  divu a0, a5, tp
  fence.i
  divuw a7, t1, a5
  remw t2, a0, a7
  divw gp, t2, t2
  rem a5, a5, a0
  divw a6, t2, a7
  slti t2, a7, -546
  slliw s4, s4, 30
  lbu s8, 1621(t6)
  lwu s3, -1760(t6)
  fence.i
  fence.i
  srli s10, s3, 0
  slliw a0, s3, 5
  sltiu ra, s10, -359
  rem t0, s8, s8
  fence.i
  lwu s6, -144(t6)
  fence.i
  fence.i
  xor a3, s10, a0
  remw s5, a3, ra
  remuw a6, s6, t2
  rem s7, a3, s6
  remuw t4, s6, t2
  fence.i
  subw t2, t2, a6
  sraiw s6, t4, 30
  srliw s2, t2, 24
  remuw a3, s4, a3
  div s3, s2, t4
  srliw tp, s3, 1
  mul s4, s6, s0
  and a4, s4, a3
  mulw s1, s4, a3
  fence.i
  subw s2, s3, s3
  lbu t0, 1368(t6)
  lhu s0, -1310(t6)
  fence.i
  fence.i
  remw gp, t0, s0
  srlw t2, t2, gp
  fence.i
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
.word 0x6d93331c, 0x0e2cd1c1, 0x2d67a515, 0x2a7138fb, 0x5d9b77a0, 0x2225fb76, 0x202ce834, 0x251e5daf
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x5d63a6bb, 0x26c5a7ee, 0x0b642c3d, 0x308b83f2, 0x4698d065, 0x879a8862, 0xe3849ac3, 0x422ec161
.word 0x90d4d516, 0x3082a702, 0x43c53595, 0xe46d54fd, 0xb812e669, 0x09860036, 0x4221530c, 0x73478bcf
.word 0xef5eb44e, 0x1177ac34, 0x3b098f91, 0x33753b72, 0xc12ea7ac, 0x4f07cd35, 0x2bbaf9b9, 0x22cf3d28
.word 0x2d749203, 0x7c585860, 0xe7c3ae55, 0x7165be44, 0xbfe647e3, 0x4d47ddd0, 0x73626328, 0x576b6194
.word 0x24e0e164, 0x55eb7243, 0xe9058efd, 0x72781f0e, 0x0796226d, 0xc3c7e921, 0x7e6a4aaf, 0x1a2fecf1
.word 0xb7571c25, 0xfa69d0c8, 0x17845e2d, 0xc5af96bc, 0xb8a5bd1d, 0xa1316f4d, 0xe4fd9694, 0x141a1447
.word 0x9f348408, 0x27703ccd, 0x45c01865, 0x340f09c7, 0xba60b46f, 0x09e643ed, 0x83e1f850, 0xfd6c87ca
.word 0x9305413e, 0x9214fd82, 0x898ddd6a, 0x693f5593, 0x50efae69, 0x86f2eb90, 0x8e57ca7a, 0xca73f920
.word 0x375256b4, 0x3b34cffb, 0x2b53c177, 0x50082da1, 0xbbd435c7, 0x5119ea6a, 0xef931033, 0x720df189
.word 0xa638d804, 0x23e91a48, 0xd30cde7b, 0x7283de39, 0x852a38c3, 0xd65a1148, 0x2cba59e7, 0xc3494081
.word 0x755891fd, 0x7b463b80, 0xcce2ece3, 0x2a685c4c, 0x0a40bfd8, 0x26f331b1, 0xa98e6fe8, 0xe3731336
.word 0xdeee982f, 0x523c69e0, 0x2bb9552a, 0xf6be03e3, 0x6b155629, 0x3ea4d7b1, 0x14138967, 0x5c2b35fe
.word 0x97de91fa, 0xf38485c2, 0xf8139628, 0x486cea70, 0x505ededc, 0x1c0e2cbe, 0x1c3f60b0, 0x9ec4cac2
.word 0x8b005f31, 0x64d45848, 0x90fbcb99, 0x94c6202a, 0x844f1da1, 0x51a4b91f, 0xd54433b7, 0x0cab3843
.word 0x1130beff, 0xccfad262, 0x2fc3ecda, 0xb5598608, 0x51276f56, 0x4bc7240e, 0x21f39af1, 0xa521f803
.word 0x78570e18, 0x05a380d1, 0x6dccc16c, 0x97e39592, 0x1e32d6fc, 0x842bfde9, 0xf1c17aad, 0x69ff5312
.word 0xbca6e56a, 0xe9a194d9, 0x0bcc4624, 0xfb2df70c, 0xe37681d8, 0xb66b6617, 0x92b45ef0, 0x2ed4ba6e
.word 0xb1e0576e, 0x4036c1ad, 0x4e93173b, 0xbbe89f0d, 0x81577a25, 0x5f203695, 0x255a454c, 0x9834097e
.word 0x9dcef8eb, 0x523558ef, 0x43c1fa1a, 0xcfc220b8, 0xa4313151, 0x3f5cf1d3, 0xcf36167e, 0x20c4c153
.word 0xa2ea45ff, 0x994b39c5, 0x6755a4a8, 0xd1f46f44, 0x00ef86f4, 0xbc17de91, 0xacbbfc81, 0x131eea6f
.word 0x8b134252, 0xc39683c2, 0x3936f41e, 0xe0b31a1a, 0x6e44e2c9, 0xc56f48a5, 0xc8143fa2, 0x7f8abaaa
.word 0x4586e1e1, 0x8a5a5eaf, 0x4f3c42c0, 0xd6f0b17c, 0xcd55bb97, 0xa0f9940c, 0xb2d660db, 0x978032e7
.word 0xebe93701, 0x5f82eaf3, 0x18324f62, 0x0d80672a, 0xb7ec1063, 0x4749e6c8, 0xf0029076, 0xd48503ad
.word 0x6dad4493, 0xab927c9b, 0x773e6674, 0xe24e4dab, 0xc1e5c667, 0x598e6e44, 0x6356ee44, 0x6e816eb5
.word 0x2d61d598, 0xdd12b667, 0xe58204e9, 0x5f7aa08e, 0x25a1b150, 0x818738e7, 0xaf7bea7d, 0xbcad89f2
.word 0xb4afd597, 0xde8d919d, 0x862dc4fc, 0x027fa25d, 0x0f711553, 0x1f72a1e6, 0x958e834e, 0x5e78e06d
.word 0xc542a2c8, 0x3efdc2ac, 0xffa6fa31, 0x090cb675, 0x47bb2002, 0xc50b92d3, 0x1ee16870, 0x7d50e145
.word 0x1fb863f3, 0xf171d889, 0x611e5c16, 0xf48687e4, 0xc3b2bb11, 0x453e9c3e, 0x520b6d22, 0xf9197c3f
.word 0x012f2c59, 0x18a55ef8, 0x0226e461, 0x42e38575, 0xae3397a3, 0x51944ac7, 0xfe932c19, 0xd034ba15
.word 0x4c8ca3fc, 0x7188d9d2, 0xce223659, 0xd31c0127, 0xb006220e, 0x16cf8d42, 0x746be072, 0x7058382c
.word 0x4a885eea, 0xd850c375, 0xf646a0d6, 0x8b256f84, 0x6e13edfa, 0xb7b7dced, 0xe659b16c, 0xd378c4a2
.word 0xbd1930a4, 0x109bb40c, 0x6f6adbb3, 0x47069552, 0xbbc54415, 0xaf52e68f, 0x18fc6cac, 0x24dd2c6d
.zero 7168
mem_region_end:
