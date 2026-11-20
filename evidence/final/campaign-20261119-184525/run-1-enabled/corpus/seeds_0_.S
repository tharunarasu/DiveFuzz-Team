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
  li x26, 0x0000000a00087980
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
  li x1, 0xf30765a8bcb1ccbe
  li x2, 0xbf30555ab55f5d1f
  li x3, 0x7e3c1131ec137e65
  li x4, 0xb3d8c88ab7063e8d
  li x5, 0x9ce26b09a7e0b4cd
  li x6, 0xefe90ebcbcb30e03
  li x7, 0xe8bc71f23002c45a
  li x8, 0xbbcbcddc80819e8d
  li x9, 0x9c8d81a9e520ad2a
  li x10, 0x260db342ed25d198
  li x11, 0x905949f304dca1ab
  li x12, 0x19dadcefe0b3027f
  li x13, 0xe726fffca2e41039
  li x14, 0xafdd271c68193578
  li x15, 0x19832774212c0fea
  li x16, 0xe1c29267dcd91c8f
  li x17, 0x6f3f382d40f8ce02
  li x18, 0xe9c2b43197c59b7a
  li x19, 0x8b04a73b1345b082
  li x20, 0xcac361348e75d3e3
  li x21, 0x16da4b9d645b030a
  li x22, 0x593cf5194e7e1fa9
  li x23, 0x665728e02a8868fa
  li x24, 0x262acbf609155a50
  li x25, 0x18450a72df97ac97
  li x26, 0x361730879b985939
  li x27, 0x6edfcd5601731625
  li x28, 0xd478af0f9451edd7
  li x29, 0x565c8e68c43942c2
  li x30, 0xd8148ea5335972c9
  li x31, 0xc659f3cbede815c3
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
  addiw a1, a1, -363
  add a6, s6, a1
  nop
  div s4, a1, a1
  fence.i
  subw s7, a6, s4
  mulw sp, a6, a6
  remuw gp, s4, s4
  div s0, sp, s4
  ld t4, 1744(t6)
  divu zero, t4, zero
  remuw s2, s0, s3
  sd zero, -1168(t6)
  remuw a4, s0, s2
  sh s2, 1126(t6)
  divuw s1, s1, s0
  divuw tp, zero, s2
  xor s7, zero, s7
  remw s10, s2, s7
  sraiw t2, a2, 18
  divu s11, s5, s1
  divu a6, s10, s7
  srli a1, ra, 49
  mul sp, t2, ra
  slti tp, sp, 1474
  mulhu zero, zero, a6
  remu t4, a1, a6
  srai gp, gp, 24
  sraiw tp, sp, 31
  sub s6, tp, zero
  rem a3, s6, s6
  divw s10, tp, t4
  div a6, s6, tp
  add s1, s6, s11
  sraw s8, a3, s6
  addi gp, s1, -1334
  fence
  mulhsu tp, s2, tp
  remw ra, a7, s8
  lb s10, 216(t6)
  mulw s9, tp, s10
  remuw t0, s9, s8
  divuw s5, a6, s9
  divuw zero, s9, t0
  sd t2, 1432(t6)
  sraw s3, s3, zero
  srliw s7, s9, 1
  sllw a3, zero, t0
  srliw t3, tp, 28
  div a7, a3, s7
  srliw a6, a7, 1
  sd s3, -1656(t6)
  remw t4, t3, t3
  xori zero, a3, -2048
  srli a5, t3, 13
  div a4, a4, zero
  remu s0, a3, gp
  slti a0, gp, 1
  lbu t0, -1657(t6)
  remw t3, t3, a4
  srl s2, t0, t3
  mul gp, s0, s8
  mulhsu s5, t0, t0
  mulhu s2, a0, s6
  div a6, zero, a6
  remw s2, s6, s2
  mul s3, a6, sp
  div a6, s3, s1
  lw t0, 224(t6)
  sd sp, 112(t6)
  mulw s5, s3, s3
  lwu s10, -1024(t6)
  mulw a4, t1, s5
  srai sp, a4, 0
  srliw t1, tp, 13
  sd tp, -776(t6)
  remw a6, sp, t1
  ori s3, sp, 17
  remw a6, a6, t2
  sllw s5, ra, t4
  and s9, s9, s5
  mul s7, s3, s3
  addi t3, a6, -1
  sll tp, t3, tp
  addw a7, t2, t0
  addi s6, s7, 2047
  xori zero, s7, -2048
  divu a3, zero, s7
  rem s3, s7, zero
  divuw t4, a7, s6
  subw ra, zero, zero
  sraiw a1, t4, 22
  rem tp, ra, a3
  remw s1, ra, s1
  remuw s10, t4, s10
  and a2, tp, a1
  srai a7, tp, 21
  srliw s10, s6, 0
  slti tp, a2, 2047
  addi s4, tp, -1
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
.word 0xd79e96a2, 0x2346fec6, 0x89e88400, 0x71930d8d, 0xfd03c973, 0xe19b04c4, 0x37d09e91, 0x92fd447a
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x09dab435, 0x0f201baf, 0x5ecd5da2, 0x6f0ed956, 0x2ea66e67, 0xd50b70b9, 0xf23c85db, 0xfde2a5a6
.word 0x1d76abfd, 0xb024ff15, 0x5a594780, 0x8722e35b, 0xdcfa5b1d, 0x37a46186, 0x0a8df9ea, 0x9d3e1fac
.word 0x16d6716e, 0x3be54df3, 0x84d5ecab, 0x9745f74e, 0x5c000284, 0x782c18b0, 0x05790fa7, 0xba840b9e
.word 0xabaa03fd, 0xc0d50567, 0xd76caac0, 0x73b83780, 0x0e123798, 0xa40498ad, 0x20e3ae4f, 0x25bb630e
.word 0x1f0fe920, 0xb8603b8b, 0x799717f6, 0xe6a8086e, 0xa66fd6ba, 0xd2367c78, 0x43c1909f, 0x42327527
.word 0xd411b93c, 0xfeadb7d7, 0x18a8c207, 0xdb09b994, 0xe6702e8c, 0x07a23459, 0x3965805b, 0xc7830b74
.word 0x1db2eebe, 0x7c36a060, 0x338e3fd0, 0xd4d9c781, 0x8ea2b8fa, 0x851449e3, 0xe53af548, 0x5f2848f6
.word 0x1b9b2181, 0x116d75db, 0x9c6bc945, 0x5401572b, 0x8750aae1, 0x50599941, 0x79a1b8cb, 0x073831e5
.word 0xc8dfe3ea, 0x776896ef, 0x40812efb, 0xcd6c2d95, 0xe6b22d26, 0xce1b0782, 0x54850024, 0x7d52720c
.word 0x64057d49, 0x4d428295, 0x809f3f1b, 0xddcdede0, 0x8a993fa6, 0x55356e2d, 0xb4c7c55b, 0x37bdb3c8
.word 0xd116ece4, 0x19578a71, 0xe89c3b65, 0x4f0d69bd, 0x204dbe4e, 0x80d9c8b2, 0x2f1e4718, 0x12ba5785
.word 0xc4be8c88, 0x36f84455, 0xc8b92bb3, 0xf350023e, 0x40e8ee18, 0x8e884c79, 0xe209471f, 0xfc8c9dcb
.word 0xde558283, 0x4dede9b5, 0x100e70b5, 0x1c7d8a9d, 0x1d4ef33a, 0xe7a8837b, 0x186a9fa5, 0xedae0001
.word 0xdd9af117, 0x15beecc8, 0xde84b548, 0xb94619c2, 0x3f7a7f7a, 0xaa519575, 0xe3e80354, 0x10756b5a
.word 0x3377b50f, 0x8338e0aa, 0x778aa664, 0x6761fe0d, 0x87872c57, 0xee1fe518, 0x936bb377, 0xdff07002
.word 0x1f51d99d, 0x75ee3173, 0x0f4fa5c2, 0x35c10bab, 0xe3dc526a, 0x5535bc76, 0xc828de0c, 0x8754da17
.word 0x802e6f0d, 0x0904787a, 0xa95ad88b, 0xdece5237, 0xcc2010ba, 0x10883948, 0x103f7e62, 0x73da90f4
.word 0x3da97c9c, 0x33ec9997, 0xb7a5c22a, 0xbfc9ecbb, 0xa5f785b7, 0xa80defc1, 0x71631107, 0x26339c3d
.word 0x23eb006c, 0x98ac952b, 0x1013da93, 0x55134dfa, 0x47bcb720, 0xbd2e589a, 0x9de6ea8c, 0x4ce19654
.word 0x72b2e643, 0xecd30d1f, 0xa216438f, 0x136e14eb, 0xed20108d, 0xc9b0e7fb, 0x7be8457b, 0x1e078a8a
.word 0x41cba8df, 0x49b5be95, 0xe4a4809d, 0x69401cf2, 0xf6c8b8ec, 0xb8b1a4f8, 0x77619ce1, 0x079a092f
.word 0xe8031146, 0x2b20065e, 0x6fb70779, 0xf63dada1, 0x2021be5c, 0x78feaab4, 0x863e582c, 0x44cddbaf
.word 0xebfd54cd, 0xff12478e, 0xb0715233, 0xde8110dc, 0x3699fd75, 0xe3c08982, 0x18f19d1c, 0xe11f4034
.word 0xf629c027, 0xeef622bc, 0xa51bd4e8, 0x83e40799, 0x999232e4, 0x5dc0edcd, 0xb8b45d45, 0xf56decb2
.word 0xe51ba042, 0x8c9c3651, 0xc5879133, 0x86cebb28, 0x7b8a61af, 0x78038ce4, 0x2acaf448, 0x83930a26
.word 0x2858eae7, 0x3189e9e5, 0x8ad80d18, 0x26be0d08, 0x47967c75, 0x04425e16, 0xe690fd8e, 0x43c29498
.word 0x63e9dee3, 0xb5bb97b7, 0xd85af456, 0xdc36a1d7, 0x00912c51, 0xe2cbe03d, 0x1e55758d, 0x9d022e27
.word 0xde7093a5, 0xaddb93fd, 0x8b59ce2b, 0x73e710a3, 0x4da40a3b, 0xeba63281, 0x9a29fd2f, 0x40c08d59
.word 0x5f0caa8c, 0x149301fb, 0x8fb99c94, 0x01f4b7ef, 0xe36833a4, 0x4fca9853, 0x811eb6bf, 0xbb0c9a43
.word 0xb5f08672, 0xeb04e406, 0x725fe233, 0x2ef34149, 0x6637ceeb, 0x4979e083, 0x98247f17, 0x2b726ba4
.word 0x381e15ca, 0x048dee8c, 0x87c4d4ce, 0x449a4e1b, 0xe401f7ca, 0xb99273e8, 0xbcafe6e4, 0x649b4e7c
.word 0x5a5058f0, 0x77af4e9d, 0x1fc3d6ce, 0x9efe9907, 0x0c4c0714, 0x9ee4f1f1, 0x6bb27c13, 0xf5844910
.zero 7168
mem_region_end:
