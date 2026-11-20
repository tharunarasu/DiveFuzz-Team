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
  li x26, 0x0000000a00540902
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
  li x1, 0x4cd2bb3aedd63775
  li x2, 0xd788c19d75962a09
  li x3, 0x9bcd6cf366ff2bc9
  li x4, 0x8dc57ccb97a647c5
  li x5, 0x75f7f7e8dc20f9e6
  li x6, 0xff3d77c9dee57e50
  li x7, 0xafca4db8ac9e3971
  li x8, 0x5e937f857b2fb8ae
  li x9, 0x9c60803951744423
  li x10, 0x68e3ba78baa93735
  li x11, 0xdbc54071c04f3111
  li x12, 0xe3aaaaf1fe17d919
  li x13, 0x656ae5ca77667ea9
  li x14, 0xf4f3589144f2392a
  li x15, 0x16bbb402245a08bb
  li x16, 0x4694263d2cbdd3ac
  li x17, 0xe30617dbce76b6b2
  li x18, 0x5818cb4c8c68aba1
  li x19, 0x2ab0c016ed2f6c44
  li x20, 0x0819e6b7f892c821
  li x21, 0x8f49afff643c3165
  li x22, 0x48b812dd6e43bcd8
  li x23, 0x221e21c25d8ec089
  li x24, 0xee458569c7fdfd96
  li x25, 0xd51e6a7d46c60636
  li x26, 0x16d91141c8927942
  li x27, 0x1339bef2da837a45
  li x28, 0xe0bbb7186ca90d96
  li x29, 0xd476bf11f11ee240
  li x30, 0xa1f3e84a44a5808c
  li x31, 0xf90aacb71d30a53b
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
  srlw a4, a0, a4
  divu t1, t1, a4
  mul s10, s3, a4
  divuw sp, a4, s10
  mulhu a6, t1, a4
  fence.i
  srai s8, a0, 0
  mul gp, s5, gp
  fence.i
  fence.i
  ori s5, a6, 1363
  sll s6, a6, s5
  slli s0, gp, 0
  fence.i
  fence.i
  lw tp, -1820(t6)
  remuw tp, tp, s5
  lbu t2, 190(t6)
  lbu s3, -751(t6)
  addw ra, s0, t2
  mulhsu a5, s0, ra
  mulw a1, ra, tp
  sraiw zero, ra, 28
  remw a6, t1, s1
  divuw t3, tp, s1
  srliw s8, t4, 3
  mul s0, s0, t3
  mulw t2, t3, t2
  remuw s6, s6, s0
  remw s10, t2, s8
  sraw a3, tp, a6
  divw s7, s7, s6
  remuw tp, s9, s6
  remw s3, s3, s3
  rem a0, a3, zero
  slli a7, tp, 1
  lh a7, -1684(t6)
  addw s9, a1, tp
  divuw t0, s3, tp
  fence.i
  divw t1, s9, a7
  divw s11, a7, s11
  sh t1, -1196(t6)
  fence.i
  rem a6, a3, t1
  or s0, a3, s0
  srai s6, t1, 63
  slliw t3, s10, 14
  mul s2, s11, s6
  mulw s0, a6, s6
  mul t0, a6, s2
  fence.i
  srliw gp, t3, 25
  sraw zero, t0, a6
  divw s3, s2, a6
  lwu a3, 1956(t6)
  srl s8, s8, gp
  xor s9, s8, s8
  fence.i
  ld t0, 1216(t6)
  subw tp, t0, s9
  srli t3, a3, 5
  divu a6, t3, t0
  div sp, s9, a6
  lhu s1, -258(t6)
  mulhsu t1, tp, a7
  lwu s0, 68(t6)
  nop
  sll s8, s0, gp
  fence.i
  divu a0, a0, s0
  sll s10, t1, s1
  srlw s2, t1, t1
  fence.i
  divu a0, s0, s0
  mulhsu s6, s8, s10
  mul a2, s10, a0
  divw t4, s6, a7
  rem s7, t4, a6
  divu gp, t0, a0
  remw a7, gp, gp
  sllw s8, s8, s7
  srli s10, s10, 60
  nop
  sraw s11, s7, s10
  sraw a6, a7, gp
  sh a6, -1656(t6)
  fence.i
  sraiw zero, a6, 9
  mul s0, s6, s11
  sraw s6, s11, a6
  mulhsu a1, gp, zero
  divu a3, a6, a1
  fence.i
  sllw t1, zero, a1
  fence
  addw a7, a7, t1
  remu s3, gp, a3
  fence.i
  sllw s4, tp, a7
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
.word 0x312a003b, 0xfac24a95, 0xbf8f7f1c, 0xd3755b7d, 0x3cf526eb, 0x254e52c3, 0x1bc6d46a, 0xb6ff1948
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x456b4b29, 0xdc783ea0, 0xf5346ce4, 0x45536c58, 0xcfbcb414, 0x20f75a42, 0x825e39fd, 0x7bc7e0c2
.word 0x3492d3f5, 0xeef80dee, 0xc1584ed9, 0x8ec5bbf0, 0xb5f004c8, 0x55f038c7, 0xae7f0e00, 0x541660f0
.word 0x9e1e90ea, 0x9304a573, 0x9850930a, 0x5d70b298, 0xcb7dda59, 0x9a10d26c, 0x9e70f222, 0xb08eb962
.word 0xf1e6525e, 0x337948f9, 0xfc14cf35, 0x06fab60a, 0xfc0ce08d, 0x0c206260, 0x39766450, 0x4007729b
.word 0x67aef061, 0x6f8df9d3, 0x96a1da47, 0xe8b144ca, 0xa08deeca, 0xcfc92348, 0x66b93ca1, 0x8e0f7446
.word 0x431d1332, 0xddfd1721, 0xa6fac156, 0x21c2fa77, 0xb6665e8a, 0xf2789ef7, 0xf6beb182, 0x1a1af4b2
.word 0x376f32b1, 0xd0489038, 0x18a9ef3c, 0xa37cbaae, 0xca662f29, 0x3bb56581, 0x7e0cf871, 0xc8be4ff8
.word 0x4740e82a, 0x207b4155, 0x75c00327, 0x77a5cb81, 0x14a83d63, 0x35446094, 0x67323e73, 0x633c32d6
.word 0x1f583a4f, 0xdf190046, 0x1e2c72cc, 0x63ccad62, 0xa6f021be, 0x80f5e0d0, 0x31d9a748, 0xde81b1dd
.word 0xf4ccad35, 0x0b9f6d2e, 0xc84b5c3c, 0xcd3d77d1, 0x0ee55f1c, 0xfb3b5b1f, 0x360d5278, 0x72fa60da
.word 0x68220afe, 0xcb71d5e2, 0x03a00465, 0x93fc9103, 0xc7c26b61, 0x15856809, 0x572400bc, 0x2304cefd
.word 0x8a5c8ac3, 0xb2824ebe, 0xf03f4c95, 0x9f672c9e, 0x3b494657, 0x50fbdc33, 0xeaae8e1b, 0x1e17b608
.word 0xd06c80ab, 0xf9742d4a, 0xb0269a3e, 0x96dcf118, 0x17ea3dee, 0x2ae27bd7, 0xb5396750, 0xa3f98964
.word 0x965a2faa, 0xe0dd2b77, 0xaa9baeca, 0x12f8504d, 0xe264f0a9, 0xf7c6b6fb, 0xb4c89758, 0x2b3ebb97
.word 0x4e7ab144, 0x6c6742b1, 0xebe96260, 0x774c0e08, 0x074df8a9, 0x01202004, 0x30636569, 0xe52f2dd0
.word 0x054a7345, 0x82d479b7, 0xd7b05544, 0xd19ee815, 0xd66391ef, 0x9b0fbe9a, 0x5bc521d7, 0xf4519a89
.word 0x2b54bd64, 0x2e14a649, 0x45143c01, 0x333f56ec, 0xd1ee1234, 0xdbd9a84b, 0x835d8906, 0x5540edc8
.word 0x6e8db760, 0x225963af, 0xf2fe7a6d, 0x36dc879d, 0xb7ce9e8a, 0x2def0fab, 0x9d14474b, 0x69e73f59
.word 0xa0323b97, 0x92c7df8f, 0xd7bb94ee, 0x40bef5d9, 0x7c6be37e, 0x95abb5db, 0x93ce7926, 0xee5f1983
.word 0xdaf6ead6, 0x50646be1, 0xf1ce2989, 0x8b84d2d9, 0x107522a2, 0x34d06b26, 0x26bb8248, 0x5f1a47dc
.word 0x4b0ed521, 0x3e28fe10, 0xc6e79027, 0x4ce95e5c, 0x2fc3c39d, 0x18be7af2, 0xde0e4097, 0x135d92c9
.word 0xc8182cc8, 0x12da6933, 0x03ba3ca9, 0x0f4be4ce, 0x3ac492f8, 0x19543624, 0x4578eb82, 0xf39aec50
.word 0x9b8ea0f5, 0x05d9e0b3, 0xe78c0312, 0x1c88c319, 0x03dccd9e, 0x496d292b, 0x3030136b, 0xd86b2e1c
.word 0x6ec98120, 0xd6a39956, 0x201bb79a, 0xaea78270, 0xb170971f, 0xfb217c8e, 0x5cdb63c1, 0x6f32152f
.word 0x7f5d2f3d, 0x5ccebab9, 0x239163a7, 0x5f1d03ee, 0xb443abed, 0x49171bb4, 0x97154f65, 0xa34bbc37
.word 0x41adfafc, 0x7fa63c8a, 0x5423d3c0, 0xd86b09f9, 0xa98e095c, 0x27107df2, 0x803efd97, 0x472a480a
.word 0xa6968fe6, 0x24ae26c7, 0x9c8dcc68, 0x5b41d2d8, 0x29400b06, 0x1413ba11, 0xca0ef8d5, 0xc2925ee0
.word 0x67a260a1, 0xabdbaf5b, 0x8ced7a0b, 0xd199643f, 0x8c522efe, 0x06df23a2, 0x8f8cd0be, 0xbf710776
.word 0x09f036a9, 0xe6cb2053, 0x4cfcdeab, 0xbb61d0e6, 0x1faf7ae9, 0x93e1a42e, 0x9c0bd7cf, 0xb73ab61c
.word 0xdecdb26b, 0x5a4dd4fd, 0x325b7fdb, 0xea01e99d, 0x8f3c74e7, 0xc8a4a2e3, 0x99b56b72, 0x88cea4eb
.word 0xa8bfe3fe, 0x0d7e31b7, 0x68758d67, 0x07fae9e2, 0xcc033a1a, 0xf518a37c, 0x5f231404, 0x30499f5d
.word 0xf3eb420f, 0x812bc4d6, 0xc7a5f600, 0xe3e2645e, 0x984d86c4, 0xa0c622d1, 0x0aeb01a6, 0x305085ca
.zero 7168
mem_region_end:
