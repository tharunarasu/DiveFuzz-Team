.globl _start
.section .text.init
_start:
trap_vec_init:
  la x13, other_exp
  csrw 0x305, x13 # MTVEC
  la x13, other_exp_s
  csrw 0x105, x13 # STVEC
mepc_setup:
  la x13, init
  csrw 0x341, x13
init_env:
  li x26, 0x0000000a007ba182
  csrw 0x300, x26 # MSTATUS (MPP=0)
  li x16, -0x1
  csrw 0x3b0, x16 # pmpaddr0 = all 1s (NAPOT full coverage)
  li x16, 0x1f
  csrw 0x3a0, x16 # pmpcfg0: entry 0 = NAPOT+RWX
  li x16, 0x0
  csrw 0x3a2, x16 # pmpcfg2 = 0 (disable entries 8-15)
  sfence.vma x0, x0
  li x26, 0x0
  csrw 0x302, x26 # MEDELEG - no delegation to S-mode
  csrw 0x303, x26 # MIDELEG - no delegation to S-mode
  csrw 0x304, x26 # MIE
  csrw 0x340, x26 # MSCRATCH - init to 0 for cosim sync
  csrw 0x343, x26 # MTVAL - init to 0 for cosim sync
  csrw 0x342, x26 # MCAUSE - init to 0 for cosim sync
  csrw 0x140, x26 # SSCRATCH - init to 0 for cosim sync
  csrw 0x143, x26 # STVAL - init to 0 for cosim sync
  csrw 0x142, x26 # SCAUSE - init to 0 for cosim sync
  csrw 0x141, x26 # SEPC - init to 0 for cosim sync
  mret
init:
  fsrmi 2
  csrwi fflags, 0
  li x1, 0x273b9087c74ebee1
  li x2, 0x4735f73d0e0db0bf
  li x3, 0xb49ff88329487579
  li x4, 0xe1a1b11ee7fa5259
  li x5, 0x369ae14acfeda0a7
  li x6, 0x7c27175dd51c60b5
  li x7, 0x22ffbc04cb36c537
  li x8, 0xd0a912f254f2467c
  li x9, 0x72c26f2ad1f7f2ea
  li x10, 0x388d970328eea1e2
  li x11, 0xf9d838530efbd0e3
  li x12, 0x226d1fc6df2b82fa
  li x13, 0x196a49ba2b3df0c8
  li x14, 0xec102723d20737c1
  li x15, 0xb5b696181d82a3e0
  li x16, 0xb6d5a27ab52e978e
  li x17, 0x006022dfe49a5cbc
  li x18, 0x3734f2d35e49069b
  li x19, 0x8b34aa34b49645ea
  li x20, 0x726ff369888bd2de
  li x21, 0xfd1b35ef7636346e
  li x22, 0xb1884610829597a5
  li x23, 0x385d0f9745cf74d6
  li x24, 0xa71f835dba3f944c
  li x25, 0x96705f3f8cad713e
  li x26, 0x51a1dafa06d483f7
  li x27, 0x2a4b8c13ebe7538f
  li x28, 0xdca12b88b71bcaef
  li x29, 0xacbcf36cac929092
  li x30, 0x38fea1fc20689c88
  li x31, 0x2ce21b96630bb63a
  li x5, 0x737e5c18e9d9b236
  fmv.w.x f0, x5
  li x5, 0xf3f68b17795e37b6
  fmv.w.x f1, x5
  li x5, 0xde72e8452632ad83
  fmv.d.x f2, x5
  li x5, 0x878674c90642ad1b
  fmv.d.x f3, x5
  li x5, 0xd02e2e8e9a131c8e
  fmv.w.x f4, x5
  li x5, 0xf8ff09dfc984229c
  fmv.d.x f5, x5
  li x5, 0x44ca70242f78996f
  fmv.w.x f6, x5
  li x5, 0xd2b432260fd69205
  fmv.d.x f7, x5
  li x5, 0x60aa4b23341452a1
  fmv.d.x f8, x5
  li x5, 0xf5122bb57bba217a
  fmv.d.x f9, x5
  li x5, 0xa09eb2a4f43f87cb
  fmv.w.x f10, x5
  li x5, 0x8d62205de7c828bd
  fmv.w.x f11, x5
  li x5, 0x787c08065afc5ed6
  fmv.w.x f12, x5
  li x5, 0xc44346fd9456aec2
  fmv.d.x f13, x5
  li x5, 0x43898fb5f171e69d
  fmv.w.x f14, x5
  li x5, 0x570846770fa19178
  fmv.d.x f15, x5
  li x5, 0xe9c6e88e8e99f14f
  fmv.w.x f16, x5
  li x5, 0xe5cb60c763788dea
  fmv.d.x f17, x5
  li x5, 0x2e4276ef89bfa1a0
  fmv.d.x f18, x5
  li x5, 0x4a90a74a6180e746
  fmv.d.x f19, x5
  li x5, 0x6314d50f83a8d9a9
  fmv.w.x f20, x5
  li x5, 0x5cf5ef3b9652f148
  fmv.d.x f21, x5
  li x5, 0xdb6763f8a782b90b
  fmv.d.x f22, x5
  li x5, 0x8ee41b258e0b2bb8
  fmv.w.x f23, x5
  li x5, 0xe2bbdbb9656b419f
  fmv.w.x f24, x5
  li x5, 0x3b3f8361acee3d94
  fmv.w.x f25, x5
  li x5, 0x80f00077a832e3ac
  fmv.d.x f26, x5
  li x5, 0xdb8b6839aec56d74
  fmv.w.x f27, x5
  li x5, 0x1b37acad85ea4de8
  fmv.w.x f28, x5
  li x5, 0x352b3370c4c215de
  fmv.w.x f29, x5
  li x5, 0xea6477443ac20eeb
  fmv.w.x f30, x5
  li x5, 0x127d7029f2fc6fef
  fmv.w.x f31, x5
  la t6, mem_region
  li t5, 4096
  add t6, t6, t5
  j main
.align 12
other_exp:
.option norvc
  csrr x14, 0x342
  blt x14, x0, m_handle_interrupt
  csrr x13, 0x341
  addi x13, x13, 4
  csrw 0x341, x13
  mret
m_handle_interrupt:
  li x15, 0
  csrw 0x304, x15
  csrr x13, 0x300
  li x15, -9
  and x13, x13, x15
  csrw 0x300, x13
  mret
.option rvc
other_exp_s:
.option norvc
  csrr x14, 0x142
  blt x14, x0, s_handle_interrupt
  csrr x13, 0x141
  addi x13, x13, 4
  csrw 0x141, x13
  sret
s_handle_interrupt:
  li x15, 0
  csrw 0x104, x15
  csrr x13, 0x100
  li x15, -3
  and x13, x13, x15
  csrw 0x100, x13
  sret
.option rvc
.align 2
.option norvc
main:
  aes64esm ra, ra, ra
  sc.d.aqrl t3, t3, (t6)
  lr.w s8, (t6)
  rorw t1, s8, ra
  aes64im t3, s8
  feq.d s2, fa5, fa7
  aes64esm a5, t1, t3
  orn t4, s2, t1
  ori s3, t4, -1
  xperm4 s11, s2, s11
  fsd fa3, 880(t6)
  rem sp, sp, s2
  addiw s1, s1, 0
  sraiw a1, sp, 3
  fcvt.d.lu ft4, sp, dyn
  xor t2, s8, s3
  pack s7, t2, a1
  rolw a0, ra, a0
  fadd.d fa7, fa7, ft4, dyn
  fsgnjx.d fs8, ft4, ft4
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
.word 0x00bf0590, 0xfd0381ce, 0xcef891ff, 0x2c11e059, 0x2f455778, 0xe4e91741, 0x09d5903b, 0x54755b9b
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x5e899b39, 0x64be6edd, 0x348f4473, 0x97c5cf50, 0xa6e326ce, 0xeb81d6cf, 0x7f93849b, 0xd758f2df
.word 0xf9c74cba, 0x2e071a76, 0x12a39502, 0x015e2013, 0xf9654a9c, 0x89895927, 0xb86cf6bd, 0xa3b8550a
.word 0xe7f8e44d, 0xf70c9775, 0xd0d795ff, 0x660e5bf4, 0x3dd6a9d5, 0x96e4c34d, 0x6d7c1164, 0xcb0de29f
.word 0xb2a14782, 0xd084f6bf, 0xc0c596f3, 0x0730b027, 0x475cf740, 0xf00b7ee1, 0x0706f509, 0x3764ec99
.word 0x86184c57, 0x373ba84a, 0xa0c3031e, 0xd1738be3, 0x1069972d, 0x1aed66df, 0x46c86c32, 0xe92d4da1
.word 0x77842f17, 0x2ab4f319, 0x02381b4b, 0x14c85be8, 0x883afea0, 0xadfbc87d, 0x68a8d69d, 0x2ad8edec
.word 0x53471c94, 0x4dd57c2b, 0x1c7508ac, 0xac76e665, 0xe1850cb8, 0xd691db62, 0xfa724e26, 0x8c5edfd5
.word 0xdd42fbb1, 0xaa1e0b01, 0x357b72d2, 0x5efee3aa, 0x85528414, 0x6445683e, 0x86a0d946, 0x30e69ebe
.word 0xc3b53d64, 0x1cec17c6, 0x8aa8f6c6, 0x7b1a667b, 0x044414a2, 0x928e9219, 0x80a17a95, 0x1f2d3d86
.word 0x2d958330, 0xae91e28c, 0xcc7eb2b8, 0x8106ef5b, 0x2c702966, 0xc9006ec6, 0xdb68def6, 0x709da663
.word 0x872476b8, 0x791dc1d1, 0x190ad47b, 0x90e7dc6c, 0x3be526b0, 0x25dee5df, 0xfeaa16c8, 0xb3d031e7
.word 0x6193fae0, 0xf04f3cc8, 0x40beb57f, 0x8b7c971e, 0xd62c8ec6, 0xf5b1ce88, 0x49878a76, 0x2e5012bb
.word 0xad3d27f4, 0x6cf53378, 0x58f518d8, 0x47a1a91f, 0xbcb052b0, 0x966877ba, 0x0fd39280, 0xc6281b0d
.word 0x92915183, 0x51d3f1df, 0x55147117, 0x56be4bac, 0x8eeb06f6, 0x650523f3, 0xad926842, 0x6a8aa04f
.word 0xfc9e15f8, 0x55118ee1, 0x119c542f, 0x9f330ff8, 0xd631a505, 0x55f384d8, 0xc0001e06, 0xaeadfc84
.word 0x46911a36, 0xeda7978d, 0xfd2e574d, 0xd2a284e1, 0x4c308591, 0xa134ffac, 0x906ed20b, 0x7f11904a
.word 0xdae779ae, 0xfe39a9ef, 0x9632220d, 0x5dd11adf, 0xdfbad7c8, 0xb88bc51a, 0xe6b62ad2, 0xeb4a0516
.word 0x52446155, 0x2fea08af, 0xf27133c5, 0xf883bb4a, 0xbc54ea4a, 0x3dc31de5, 0xf2de2d21, 0x61417831
.word 0x4466dfa1, 0x52cfb827, 0x07780f53, 0xddd52328, 0x547d0dd0, 0xafcfc24c, 0xbfa4d205, 0xd3c5ae08
.word 0xbd9981c2, 0x28f8fb06, 0xc0747cd1, 0x9c15054f, 0x90daa85a, 0x3630aa37, 0xd5d90230, 0xbac4433c
.word 0x6986ab5e, 0x7f180399, 0xde91ed8a, 0x69169442, 0xee32906a, 0xb0f056f9, 0x55ce2330, 0xedad668e
.word 0x91dcbe6a, 0x0fb4f48b, 0x014029ef, 0x326a2a8e, 0x1cc743a5, 0xbe50dc07, 0xc21f84b4, 0x90d83bbe
.word 0x23438b91, 0x777325dc, 0x3d9b78aa, 0xe28c70ff, 0x0c79ad38, 0x4b116903, 0xe05f5786, 0x5b9e05e1
.word 0x16c9e28f, 0x1b789907, 0x23229e9a, 0xb1ee2681, 0x1877a7ac, 0xb6667861, 0xc4f90e83, 0x7e3343ff
.word 0x43d5f24c, 0x933a7002, 0x189ddc57, 0xb8374e5f, 0xacf57b42, 0x8f0d6e10, 0xeb3001ef, 0x07637621
.word 0x58f470f1, 0x0774eb74, 0xa0c3f827, 0x3301db55, 0x3ea4fa3f, 0x17ff8c97, 0x3dd0840f, 0xd39691ad
.word 0x077b8624, 0x2f42e892, 0x865d0a7c, 0xe37b880a, 0xff5a46a0, 0xffbd37e3, 0x7b56cd9d, 0x2b6c78ce
.word 0xcf005611, 0x427084c7, 0x5f9ecef4, 0x4f448a16, 0xd71963b5, 0xa1b875c4, 0x15e17f67, 0x2e1474fb
.word 0x8d6f0501, 0x5b8271c4, 0xa4652eaa, 0xa97248cd, 0xa43b0343, 0xc4de6c39, 0x0bf4123b, 0x0825b048
.word 0xc9bfbd5c, 0xd156de50, 0xb6a10a04, 0x8a4f27b3, 0x3314962d, 0xe451b8af, 0x557c2dfa, 0x63198557
.word 0x9386867c, 0x43b617cf, 0xafe496f0, 0x52c4d641, 0xa21a1d7e, 0xccbbd019, 0x7aee6239, 0x39bf9875
.word 0xf7805a09, 0x7e2983f3, 0xac9cfb17, 0xba8804c1, 0x6197e9f4, 0x7d98a78a, 0x93d1863c, 0x3ea439bc
.zero 7168
mem_region_end:
