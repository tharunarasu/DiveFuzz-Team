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
  divuw ra, t3, sp
  divuw t1, s2, t1
  mulw s6, t3, ra
  sllw zero, zero, t3
  divw s11, s2, t3
  mulhsu s2, s2, s2
  mulhsu s9, t4, a6
  lui t4, 1
  divuw t3, s1, a0
  addw s7, s3, gp
  srlw a6, a6, s9
  divuw a7, a6, t3
  sraiw t1, a6, 1
  slt s0, s0, a6
  remuw a5, t1, s0
  andi s10, t2, -1023
  srliw t0, a7, 15
  srli a2, tp, 63
  sh a2, 166(t6)
  mulhu sp, t2, t0
  remw gp, s10, a5
  sra s5, sp, a2
  lh t2, 392(t6)
  remuw s9, s9, gp
  remuw t0, gp, s9
  remuw a0, a0, gp
  divu s11, t0, t2
  div s8, t2, a0
  div a7, s0, t1
  divu s10, a7, s3
  mulhu a0, a0, t2
  auipc s5, 732092
  divuw t2, s9, s9
  sltiu s8, t4, 0
  remw a2, s5, s8
  remuw a5, a6, a6
  mulhsu t3, s8, a2
  remuw ra, ra, s7
  sra s0, tp, zero
  srli a4, tp, 59
  sub t0, t0, s1
  srli a5, a5, 47
  srlw t2, s0, t2
  sltu s9, t0, s10
  mul s11, t2, t2
  srlw s7, s8, a6
  li s8, 83014832406
  divuw s7, s6, s4
  divw t4, s8, s10
  mulhsu t3, gp, s7
  remuw a1, gp, a7
  sd s6, 1280(t6)
  sraw sp, t4, a7
  remuw a2, sp, s8
  mul s10, sp, gp
  div a2, s2, a2
  remuw s6, a2, s11
  srliw s3, s6, 0
  sw tp, -1208(t6)
  mulw tp, s3, a3
  sraw ra, a3, s8
  mulw t4, t4, a1
  rem a5, a3, a5
  rem a1, s0, a1
  mul a1, a1, a4
  rem a0, s6, a4
  rem zero, a4, a1
  subw s8, a1, sp
  sw s6, -1464(t6)
  srli t4, a0, 0
  mulhsu s9, s9, t4
  xori t1, s8, 1
  mulw s4, s4, s9
  remu a4, s10, s6
  remw s3, s6, s8
  divu s10, s3, s6
  remu s9, a2, s6
  remw t0, s10, a4
  remuw a7, s3, a2
  slli sp, s11, 2
  xor t1, s2, a3
  sb t4, 225(t6)
  remuw s11, t2, t2
  divw a0, ra, a0
  remw s4, t3, a0
  sraw a0, a2, a1
  remuw t4, a2, a4
  sd t4, 1376(t6)
  addw t0, t4, t0
  slli s4, t0, 0
  div a2, a6, a4
  remu tp, a3, a3
  remw a0, a0, a6
  rem t3, a3, a4
  div s5, a4, s5
  andi sp, a0, -102
  mulhu gp, s3, s11
  divw ra, ra, t1
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
