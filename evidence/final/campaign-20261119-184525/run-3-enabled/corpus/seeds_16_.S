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
  li x26, 0x0000000a004c4982
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
  li x1, 0x6a05701d518aa80f
  li x2, 0x0f7bc4f51802b153
  li x3, 0xad4a11ec02fba036
  li x4, 0x8944eebb43345acd
  li x5, 0x9d696fee2f060718
  li x6, 0xf88ee94a4270048b
  li x7, 0xe5d4158e706bfd8d
  li x8, 0x43f1bb8fedcbb7f2
  li x9, 0x1bab06ba2fcb2cc2
  li x10, 0x0f548cca93e2d2ea
  li x11, 0x751d17855a2df3f5
  li x12, 0xef5533159c46a406
  li x13, 0xec191f7e7644ed46
  li x14, 0xbcf16974999cd5e0
  li x15, 0xbd6b50e1a7ab7769
  li x16, 0x1c006f9f6c3326e7
  li x17, 0x38d7bce52eb39650
  li x18, 0x8fd8825360244d9b
  li x19, 0x20f528b19423f803
  li x20, 0xe2a5d660dcc2130a
  li x21, 0x44cabb5229039af3
  li x22, 0xac9da0b9cd0ef2fe
  li x23, 0xcd7a33fb1a6d3d20
  li x24, 0xf35b99d025fe2395
  li x25, 0x9d8423c523418422
  li x26, 0x85a9d62bf96f52a2
  li x27, 0x672ffaaea938c58e
  li x28, 0xef5eb0542dd76590
  li x29, 0xd8dc8e1fe3bd6131
  li x30, 0xe484208e0ab933a7
  li x31, 0xfe88e8c97e289359
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
  srli sp, sp, 58
  divuw zero, s5, sp
  div a6, zero, sp
  srli sp, s8, 0
  divu s9, s7, sp
  mulw t2, t0, gp
  remu s4, t0, sp
  addw sp, t4, ra
  remuw s5, a3, s5
  sraw s1, tp, a3
  mulhsu s0, s0, s9
  mulhu a0, s5, a7
  sd sp, -1576(t6)
  mul a3, sp, s0
  divw a7, a0, s11
  xor s1, s0, s4
  divuw t3, s4, s0
  remu t0, t0, s0
  srliw a5, t3, 31
  mul s3, s1, a7
  remu t4, s3, t0
  srliw a6, s3, 16
  sraw s11, s11, t0
  slli t0, s11, 47
  divu sp, s7, a6
  mul s7, tp, tp
  slt s6, s7, s11
  add a2, tp, t4
  divu s3, sp, t3
  div t1, t4, s7
  divu a0, s7, a2
  divw s8, s8, a0
  mulw s11, s8, s4
  sh s8, 924(t6)
  srliw zero, s11, 11
  mul t0, s11, s8
  remw s2, zero, t0
  mul a0, s11, a2
  sltu a5, s8, s6
  srlw s1, s2, a1
  mulw gp, gp, s2
  sltu t1, a1, a0
  divu a1, t1, a1
  auipc gp, 1451
  remw tp, sp, s11
  divuw s1, s11, gp
  rem s6, t0, t1
  or s10, gp, gp
  slliw zero, s1, 1
  addw s11, s11, zero
  divu s2, s11, a1
  remw s0, zero, s10
  addi s8, s0, -1208
  mulw t0, t0, s11
  divu tp, s2, s8
  sd s8, -1752(t6)
  sd t2, 1248(t6)
  sllw s3, tp, s3
  remuw a5, s3, s0
  slliw s3, t0, 25
  divuw sp, s11, s3
  mul s7, s7, a2
  srlw t0, s11, t4
  mulhu s0, a3, t0
  sraw a7, a1, s7
  slliw a0, s7, 6
  div s9, s9, a0
  remw a5, s7, s3
  remu ra, s4, a5
  mul t4, a5, s6
  srlw a7, a7, ra
  div s0, s3, a5
  mulhsu a1, a1, a5
  sll s4, ra, ra
  div sp, s0, t0
  remuw gp, s4, a1
  sltu s9, t1, gp
  divu s6, s6, a3
  divw a2, s9, a4
  divw s7, a4, a2
  divw s4, gp, s4
  auipc a1, 498647
  srliw s11, s4, 1
  srli s2, a1, 63
  remuw t3, a1, s8
  mulhsu t4, s11, t3
  remuw t0, t3, s3
  mulhsu a4, t4, a4
  mulhsu s5, a2, s5
  xori t1, s0, -1383
  srliw s10, s11, 4
  srai s3, a4, 11
  slli s6, s6, 45
  divuw t0, s0, t0
  mulhsu s10, sp, ra
  srli ra, s8, 0
  remw t1, a3, a0
  divu t3, t1, t3
  remuw a7, s10, a1
  and t0, a6, ra
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
.word 0xb586d68a, 0x4ac03cf7, 0xe8db8e21, 0xa03256d7, 0xa8109958, 0x850131c8, 0x53403ab3, 0x7b8d3472
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x24f0922b, 0xac422176, 0xce835365, 0xd9870c17, 0x1b5b5d1b, 0x156ca920, 0xba6b8e6e, 0x066b3d00
.word 0x04383f5b, 0x105fca5c, 0x8fae19d0, 0x9fa55b3f, 0x7b86bbaa, 0xb5b82021, 0x3ee19d01, 0x58b24d57
.word 0xe5edc8f0, 0xcd7d5b9d, 0x8d21c6f0, 0x167a0846, 0x90c32e2a, 0x341c7cd1, 0x38b01474, 0xb7ac4aca
.word 0xdf7ad62d, 0x6203c8ae, 0x0b4256b3, 0xa613eddf, 0x62d90a0b, 0xbb5bb435, 0x75191f62, 0xdd6b25df
.word 0x27b8cb9b, 0x32e5c8f3, 0x4ee63c73, 0xb7b0131b, 0x213a8c6d, 0x1af31758, 0x9e0d5e8d, 0x68f0cc00
.word 0x78a7a20f, 0x2ef7d0e6, 0xf05ca605, 0x9bfb4c8c, 0x2d93d7f7, 0x40b46136, 0x52f6fad3, 0xad8cfc8a
.word 0x8f279d34, 0xdaf9a82e, 0x7a0e955f, 0x6c93800b, 0x4660ebb7, 0xd13de31c, 0x90b8a24a, 0xf2a78d99
.word 0x9279baa5, 0x922665da, 0x00afc2a4, 0x67da4b5d, 0xbd6822e6, 0x5ce245d2, 0xa77c6938, 0xfb7f1b6b
.word 0x90b4414b, 0x5fcc9e76, 0x73383c76, 0x431b9665, 0x0484e7fd, 0xc26ed294, 0xe5979752, 0x02a88fa1
.word 0x2be51330, 0x23b31776, 0xa181761f, 0x46b5fc93, 0xd0c65894, 0x73f40c9a, 0x67ec2831, 0x07e7027b
.word 0x395c69ac, 0x3a8b1a81, 0x7b0116b9, 0x42881064, 0xc1c95007, 0x9492058b, 0x0d48c6c8, 0xd934d6eb
.word 0x0c1603e5, 0x367b692f, 0xf01fba9b, 0xd70eab1c, 0x16c76ffa, 0xde787a96, 0xec64bf06, 0x7a92548b
.word 0xefae3251, 0x81a136e7, 0xdbf28d66, 0x7e85a74c, 0xb64c4423, 0x1714711d, 0x45e26058, 0xf57e86e5
.word 0x148fe126, 0x7e47c4e7, 0xd4a0bb03, 0x4043f5d8, 0xc84e9e40, 0xaa8b6c02, 0x7f75ec07, 0xa2e0f055
.word 0xeceaaec2, 0x21476bd2, 0x33ffaec5, 0xee0a7fe6, 0xa32da8e9, 0x5ba6695a, 0x1705ae48, 0x00f1434f
.word 0xdab84120, 0x9e4ceaea, 0x4f37906a, 0x5eec87c5, 0x2e2cef4b, 0xf58866fd, 0xcf657997, 0x0603ead4
.word 0x180de23a, 0x4baa5aea, 0x6a92d43d, 0xd3d2d272, 0xd5d71de2, 0x7fcd4e18, 0x47d52fa6, 0x14aab222
.word 0xe85bab83, 0x16bc6658, 0xbf5b8d59, 0x5f87b543, 0x17baf9b2, 0xf510c882, 0x0c02a896, 0x08395579
.word 0x6d8a50c9, 0xedee18b4, 0x1434245d, 0x8c42d394, 0x23c6973a, 0x918656c3, 0x28e71cea, 0x72b9b5f5
.word 0xe743ffe4, 0x7ca4c45f, 0x956f5a21, 0xa9795a01, 0x00b07eb7, 0xbd49544f, 0xf7802411, 0xa14e9f6a
.word 0xef8458db, 0x99fbb7b0, 0x0c707ef3, 0x2df40956, 0xbd241204, 0x96caf291, 0x076e0593, 0x0fb37434
.word 0xccd4c0d3, 0x37bb50fd, 0x63a6c96b, 0xde0bdfb7, 0x67742a95, 0xc41c76fe, 0x2b8efb6a, 0xc6fdba6f
.word 0xaf55d7d4, 0x479db44a, 0x5961083a, 0xba28726e, 0x951a1ceb, 0xcf78334a, 0x2ab50bb9, 0xc277a807
.word 0xd1e3924c, 0x28cad22b, 0xdb6d6867, 0x2bb3ee90, 0xf64df641, 0x0c174cf5, 0xf7f1e8a7, 0xe5848526
.word 0x85ffc5a5, 0xe3b041b1, 0x72e20639, 0x1228c8e8, 0xf198fdea, 0x5264602d, 0x877e3a75, 0xde7357af
.word 0x1bef91d6, 0x9322f6d7, 0xd73550b5, 0x85e8c052, 0x809eeefe, 0x8678af34, 0xf5fc6c58, 0x3c75f664
.word 0x5effd8cd, 0x788bff99, 0x55317a33, 0x7596f7bb, 0x9810b2b6, 0x469974a2, 0x7267316f, 0x7f15c1e9
.word 0xd00cba27, 0x05bb5a7c, 0x571e05ef, 0x94d72df9, 0x6ed0a362, 0xc4933c0c, 0x702b62be, 0xa6deb8f2
.word 0x28a8cb2b, 0x45345578, 0xd2d55494, 0x58725b29, 0x7864fdb4, 0xeb855ffb, 0x1d1967e1, 0xcf0d1a5a
.word 0xb78fac52, 0x91071bc3, 0x9750e645, 0xd43747b1, 0xf9cf34af, 0xb205b5ff, 0xe4ca68c2, 0x8a1950ef
.word 0x28e255ba, 0x4deec8ef, 0x8f932de9, 0x1a193b2a, 0xd8a7367b, 0xa7de0afd, 0xb4cfb79e, 0x7198db5b
.word 0x90ea8a79, 0x0b224dbe, 0xa49601f9, 0x14f3d809, 0x4dbc33da, 0x78b40669, 0x4e822e4f, 0x3a6eca40
.zero 7168
mem_region_end:
