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
  li x26, 0x0000000a003461a2
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
  li x1, 0x478ef5d9658385d4
  li x2, 0xa32344dbe37e9d50
  li x3, 0xda7d9f0d9dc5213b
  li x4, 0xc7deb6eec2ee6c21
  li x5, 0x550f5a2dea1f93a7
  li x6, 0xff8aa9ecd38f5875
  li x7, 0x2124c60ad5bb339c
  li x8, 0xb6e9054ecc50993c
  li x9, 0x5e7698f9fa0802ee
  li x10, 0xd0d02b8e21342c51
  li x11, 0x0c104850ef9ef32d
  li x12, 0x04f072dafa252c26
  li x13, 0x72c9ebace265ace6
  li x14, 0xa93143cee19cbe16
  li x15, 0xddb60a1afc8df355
  li x16, 0x84c4cb74596913be
  li x17, 0xfa59f65fdf252fb6
  li x18, 0x1e995fd670fbbfe3
  li x19, 0x3df2b5b7c466640b
  li x20, 0xcd2b969bb0d21755
  li x21, 0x9b5960c80188bb9c
  li x22, 0x78379eb3e76fa7a4
  li x23, 0x23184b394222e70c
  li x24, 0x41fde5b4660a873c
  li x25, 0x852fe907dc9ac224
  li x26, 0x1f7d7cbcf543c250
  li x27, 0x7a65717349e9fb54
  li x28, 0xeef9cab0e5350e12
  li x29, 0xd4ffac09bfd6a329
  li x30, 0x2a7317bcc84b8aa8
  li x31, 0x10f43d4913b827dc
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
  addi s7, s7, -36
  and t3, s6, t3
  mulw sp, s7, sp
  sw sp, -1652(t6)
  divuw t2, sp, sp
  mulhsu s9, s9, s9
  divuw a6, s6, t2
  sllw s5, a6, s5
  mulhu s3, t2, s5
  divw a4, s9, s9
  divuw t2, s8, t2
  remuw t0, s8, s9
  srli t4, s5, 59
  sd t2, 1760(t6)
  srli a7, t2, 45
  sub a1, a7, t2
  rem zero, a1, a1
  mulhu ra, a1, a1
  remuw s10, ra, zero
  remu s11, s11, gp
  addw s2, s11, ra
  and t3, s9, gp
  srai tp, s2, 0
  divu s1, gp, a7
  divuw s6, s2, s11
  sllw zero, zero, zero
  slli a5, s1, 1
  slliw a3, a3, 6
  srli a7, zero, 0
  mulw s2, s10, s2
  remu s0, zero, a5
  srli a1, s0, 9
  sraw sp, sp, sp
  slt s10, s11, s10
  lhu t0, -660(t6)
  mulhsu t3, s8, t0
  divw a1, ra, t1
  srlw t4, t3, s10
  andi a4, s10, -1647
  div a3, zero, s2
  mulhu s8, s4, s8
  mulhu a7, s1, tp
  mulhu t2, a7, t2
  remuw tp, s8, a3
  remuw s6, s6, tp
  add s7, a7, s7
  sh s6, -1062(t6)
  mulhu zero, a4, s6
  remw ra, s6, a4
  srli a2, ra, 51
  mulhsu s1, gp, ra
  slti s10, a3, -1811
  rem a5, s11, s10
  mulhu t1, s11, t1
  addi s9, s10, -2048
  remw s6, s11, s11
  mulhu t2, s9, t2
  add s1, s6, s1
  divu s3, s1, s9
  mulhu a6, a0, t3
  remuw a7, a6, a0
  divu s9, s9, s8
  addw a5, s8, a7
  subw s11, s8, a5
  xor s4, s8, a5
  sb s9, -1143(t6)
  lui s1, 705125
  divu tp, s1, s11
  sltiu t2, t3, -187
  sd s1, 264(t6)
  mulw s4, s9, ra
  mulhsu t3, s3, sp
  remw a2, a2, gp
  mulw s6, s7, s7
  ori s8, t3, -1829
  srai a3, t1, 42
  remu a5, s5, a6
  mulw s10, a3, s7
  mul ra, s7, a7
  mulw a3, ra, a5
  mulw s9, a5, s9
  srli t0, s9, 38
  sltiu t3, t3, 0
  div a1, tp, a1
  srl a6, a6, a3
  sraiw t4, s9, 1
  sd a1, -360(t6)
  remw a1, s7, a6
  remu t1, t4, tp
  remu s2, s10, s9
  div a3, s2, s8
  ori zero, zero, 2047
  remuw t4, s4, zero
  andi a3, s3, 1041
  mul s1, zero, s1
  sub t1, t1, s4
  sraw s0, tp, gp
  subw a7, s0, a1
  divu s3, a3, a7
  divuw ra, ra, t1
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
.word 0x4cd015fa, 0xb7bc74f3, 0xdb6db356, 0x2fd2daea, 0x120bc39b, 0x63f39eae, 0x2c56173c, 0x951996c9
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0xf10086a8, 0x09e12669, 0x571117c7, 0xfa71bfc3, 0xf03801d4, 0x6847b1fa, 0xca512a32, 0x67410210
.word 0xbe5f98be, 0xc54b9ffc, 0x53dfed83, 0x8e5cc5b8, 0x9046bde2, 0x5a476169, 0x1ed0029f, 0x2f2034b6
.word 0x40f0c8f5, 0x64b0877c, 0xa6ff4a0f, 0xc6809ca3, 0x854d36ea, 0xed3f21b4, 0x34bd6ce2, 0xda0705b8
.word 0x8d962a84, 0x9aa93881, 0xb0c74587, 0x941c2e75, 0x6be13f12, 0xf9812467, 0xa3e9ee23, 0xb18fdb02
.word 0xff4c1d5b, 0x278f8f34, 0xd15f6585, 0x0f05c815, 0x974fd057, 0x6d75ef8c, 0x61bdecf6, 0x8a418aed
.word 0x015cc78d, 0x5a280c37, 0xeea53cb1, 0x3a1db41b, 0x8b370087, 0xa86e39c0, 0xd6b27e56, 0xd3c2aa9d
.word 0x1ed97049, 0x4ffefcac, 0x8877b89d, 0xecf71908, 0xea3cbe43, 0xe7bedfc3, 0x0a26a313, 0x841cc597
.word 0x590fc8fa, 0x802f5e40, 0xa7ab7e33, 0xb18e6372, 0xe6474e91, 0x5071ec4f, 0xa5d5ccbf, 0x77da766f
.word 0x923566ae, 0xe06728c8, 0x722699e7, 0xf631c847, 0x89429d7a, 0x987b1e90, 0xa5619d6b, 0xd8768b7e
.word 0x8a3c4b24, 0x82c96bf8, 0x22fafb07, 0xea3712cc, 0x6afaebba, 0x557ae61e, 0x30d9e975, 0xeb5c3e1b
.word 0x8f089c05, 0x052a07a4, 0x7e42cfe5, 0x130d3588, 0x74267b37, 0x132eb964, 0xe65d2c4c, 0xc92190f5
.word 0xcec4753d, 0x36834738, 0x77ee9db1, 0xc19d0533, 0x096ff0a7, 0xbad6d6c7, 0x02f3dbd9, 0x2cde8e3d
.word 0x8c36b7fa, 0x94cdc495, 0x34ad5b95, 0x191b1624, 0x93aeb17c, 0x9d0f7710, 0xacbb5cca, 0x6e159792
.word 0x43ac1a06, 0xd7f7be0b, 0xe3fec552, 0x929bf485, 0xa135a816, 0x6d511511, 0xc2b8d50b, 0xc582de56
.word 0xc546b0fb, 0x4f32cae9, 0x9bb189f1, 0x275d085f, 0x8792b82c, 0x771cba76, 0x43a48241, 0x64a9ff80
.word 0xb0406115, 0x80c4f5c3, 0xa495467b, 0xd09b2071, 0x4ac08303, 0xc9b603ab, 0x87fd1df8, 0x99807095
.word 0xb420f4a4, 0xbe601875, 0x7cb54e30, 0x3a82d41b, 0x89648504, 0xa7e260ab, 0x97e618f4, 0xe9bd4d30
.word 0x2c66f8f7, 0x1081b94b, 0x572b751e, 0x9cfed47a, 0xcedd6b88, 0x2c0b9f5e, 0xda1fc7a4, 0x53f06922
.word 0x228cb102, 0xd1187b52, 0xb8f9367b, 0x53309de2, 0xa7804f79, 0x963907b7, 0xab5bacc9, 0x3bf14cce
.word 0x473afa29, 0x0d660b07, 0x42d39678, 0x866cb445, 0xba7cfff3, 0xc88b8e4a, 0x79b159cd, 0x06ff3c85
.word 0xeed3954a, 0xd7eae3e9, 0x391a6d4c, 0xd85d4e74, 0x6af3a060, 0xee8de30c, 0xde57f33d, 0xb14f9dc7
.word 0x82a9af58, 0x1e1c882a, 0x6ce87405, 0xfb9ad621, 0xeb45300f, 0x2af5a46b, 0x42683263, 0x8e26cbdd
.word 0x7d330eb9, 0x45c0ddc5, 0x576eb063, 0x834eb53b, 0x2fddafb6, 0xddb55923, 0xfcd3430e, 0x15d0b061
.word 0xe6fd1abd, 0x077242f9, 0x0832a6a8, 0xf53e9b39, 0xbaa822cf, 0x56fb8a18, 0x34cf62b7, 0xa8bee7ff
.word 0xbc04f547, 0x9145a019, 0x984cef99, 0xddc055a9, 0x1e288f40, 0xcb1f5c63, 0x930ff423, 0x3919675d
.word 0x0e03638c, 0x6ef2eced, 0x6bdde1b1, 0xd19f2c30, 0x9ffdf282, 0x375afae5, 0xb3e8c239, 0x5b9154dd
.word 0xef6da76d, 0xad0dc2d4, 0x14741075, 0xe294b947, 0x46b1250f, 0xe8f8f914, 0xb06cbcb4, 0xd602e0b0
.word 0x1d25a228, 0x93414264, 0xe5b18d76, 0x8d71e2e5, 0x3b9c9b04, 0x8a0d7ada, 0x576071ca, 0x67539cfb
.word 0x437cf752, 0xefeab65e, 0x181c70a9, 0x1c51da95, 0x0ee21383, 0xcf6d6674, 0xf936502b, 0x9f0efa00
.word 0xf8c92f61, 0x8bbb3ab4, 0x6a0c35bf, 0xdcaec5a7, 0xcdf734d1, 0xaee21668, 0x8a10a756, 0xbc5fd301
.word 0xc020cdef, 0xb89263f6, 0x2008a96a, 0x1dad503e, 0xc4c39d98, 0xdd125903, 0xca95167c, 0xa5399052
.word 0x144d8de4, 0x25cd935d, 0x1418b738, 0xc074c611, 0xb75e965b, 0x2211da85, 0x395dfa09, 0x6f813159
.zero 7168
mem_region_end:
