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
  li x26, 0x0000000a00504800
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
  li x1, 0xc3d7dc8a198a933a
  li x2, 0xb579205ecda4d5da
  li x3, 0x0f392faa2242073b
  li x4, 0xe16d7f130bc8ac79
  li x5, 0x5b9cb43400d03e5c
  li x6, 0xbab2c2cff8da5625
  li x7, 0x77b04384ded89aa4
  li x8, 0xf0ace7999b18a903
  li x9, 0x02ac97d8947b284d
  li x10, 0xbd3269b2cf7951af
  li x11, 0xdc6a935363142c9f
  li x12, 0x0b865c30a2032ccf
  li x13, 0xce1b85ba1f015440
  li x14, 0xf036a99036bb34c1
  li x15, 0x8af235ac7b9bfe7f
  li x16, 0xb486de21821b8ee8
  li x17, 0x23360ddc4b9ec2b9
  li x18, 0x37363ab821c43f2b
  li x19, 0x90aa1c0670852696
  li x20, 0x0670279a3c0e50b5
  li x21, 0x9f391cb550b1b968
  li x22, 0x91a43f1cd8c293c4
  li x23, 0x4c941fa6e545719e
  li x24, 0x86cc384020c72d75
  li x25, 0x1e2411ab0dfb0adc
  li x26, 0xa667fd33ccfd2505
  li x27, 0xb1d60b211f98c7b4
  li x28, 0xa1c508780ee31445
  li x29, 0xdc81198a710afc50
  li x30, 0x73459002ced9564e
  li x31, 0x1e16743256055d05
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
  addw s10, s10, s10
  mulw s2, s10, s10
  fence
  divu s0, s6, s4
  addiw a5, t0, 1435
  srai a6, s10, 0
  or t1, a7, s0
  slt t4, t1, t1
  mulhu s7, t1, t4
  mulw a1, a6, t4
  remuw a3, a3, t1
  rem gp, t1, t4
  mul s5, a3, a3
  mulhu tp, gp, a2
  divw s1, gp, a1
  divu sp, s6, a5
  auipc t3, 820816
  mulhsu s8, s8, s10
  srli a5, s10, 30
  div a4, s10, s10
  sw s10, 384(t6)
  sltiu s1, s8, 2047
  sll t4, t4, s4
  slli s3, s1, 0
  sllw s11, s5, s1
  srai sp, a4, 17
  remu gp, a3, s8
  srli a1, s3, 0
  div s6, s8, s10
  sraiw zero, s6, 21
  mulhu a4, s8, a1
  addw a2, t2, s6
  sraiw t4, a1, 6
  ld a0, -552(t6)
  addiw s10, s10, -2048
  rem s3, a0, s10
  divw s0, t4, s4
  mul s1, t3, s0
  mulhsu t2, s10, tp
  divuw a2, a2, t3
  sraiw a7, a7, 31
  ori tp, ra, 53
  li s6, -401914283534
  sw sp, -1200(t6)
  remw t0, t0, s7
  remuw sp, sp, t0
  remu s0, s6, a7
  divuw s1, t0, s1
  divw t3, s1, s7
  mulhsu t3, a6, tp
  auipc s10, 980668
  auipc s6, 1048575
  remu s5, a6, s6
  divw t4, s5, s10
  mul s0, s11, s10
  divw t2, t2, s0
  and gp, s11, s11
  divu a7, t2, s0
  srai s1, t2, 15
  div tp, gp, gp
  sraiw a4, s7, 0
  sub s8, a4, s3
  mul s4, s3, s4
  slliw a2, s8, 4
  divuw s0, s0, s4
  remuw a0, s10, a2
  mulw a0, s5, s3
  mulhsu s1, s5, s1
  sraiw s3, tp, 1
  sb tp, -1598(t6)
  divw s6, s2, s1
  remw a2, s1, gp
  rem a6, a6, a6
  sd s1, -1072(t6)
  divu s3, s3, s5
  slt a1, s9, s0
  divu sp, sp, s0
  sd s5, -1104(t6)
  addiw a4, a1, -1457
  mulhsu a5, a1, sp
  remuw gp, sp, gp
  add s1, s0, s1
  addi zero, s2, 0
  remw tp, tp, zero
  divu zero, a6, a3
  addiw s1, s3, 1396
  remuw a7, a7, s1
  remu s4, s1, gp
  mulw s2, s4, a7
  mulhsu s11, s4, s2
  remuw t3, t3, s7
  sraw s3, s5, s2
  mulhu s10, s10, s3
  mulhsu ra, t3, s10
  divu t4, s3, s3
  divw s5, a2, s3
  mulw s3, a3, a4
  auipc s0, 0
  divuw a1, a1, a1
  mulw t0, t0, a1
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
.word 0xf2c2cda2, 0x24cd6512, 0x20b521b8, 0x5382ecab, 0x0c998403, 0xe0e040ef, 0x5244313d, 0x068302c4
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x58e41b02, 0xc3b50037, 0x7c5c5fe1, 0x03138eaa, 0x7b12d392, 0x96bfb78c, 0xef51fce6, 0x7ddc25c7
.word 0xe7d81e0a, 0x21c59672, 0x861a9706, 0xab315b4c, 0x17a15499, 0x603157a6, 0x82a5ad5c, 0x78444447
.word 0x929cba5b, 0xf7c93b02, 0x10c89135, 0xb15973f8, 0x239da47a, 0x08e82606, 0xba50d78c, 0xf0b8cc87
.word 0x82712152, 0xb397f6f2, 0xcd114c63, 0xc7296fbb, 0x24d759a8, 0x81a4a36f, 0xf69d2802, 0xa15b5396
.word 0xf68d9992, 0x3ca7bc76, 0xf9022a6b, 0xda38cee3, 0x5e4f62bc, 0x70f52f35, 0xe37f69e0, 0xa6eb76f7
.word 0x0cd14d5f, 0xafcdd5e9, 0xe91f6389, 0x96abae59, 0xe6776a00, 0x61d34498, 0x4e27ab4e, 0xabf3d5a1
.word 0xbfe96f8e, 0xa61efe6d, 0x12357652, 0x92234110, 0x42ac5bc5, 0xd4dabaf4, 0x9ca1a311, 0xb73c6f64
.word 0x90b2d754, 0x3103b991, 0xb48640df, 0x8c71e9c0, 0xc1b5c89e, 0x50558813, 0x3246880d, 0x43ed8a52
.word 0xbe1f36f2, 0x3e86de8e, 0x1e50e9ea, 0xd5955f05, 0x3119804c, 0xf59b371e, 0x9ca1e55e, 0xd45b12da
.word 0x7ddef582, 0xd7aa9143, 0x3e8410e4, 0x5e92b9cb, 0xc7223543, 0x143281e5, 0xd4fd57f1, 0x71cdee16
.word 0x80a11846, 0x1ca00fc8, 0x997a64b3, 0x644061a8, 0xc330528e, 0x7770327f, 0xf6aec2f7, 0x26796e17
.word 0x71442e27, 0xf0a0b95b, 0xf3c7be07, 0xbc05e0eb, 0x2a0c0edc, 0x179f4bd7, 0x79a278f5, 0x08890db2
.word 0xefdff99a, 0x4451f2b6, 0xd78cb4c0, 0x7411040d, 0xcdce3aff, 0xe7a2f1f1, 0xffad1e22, 0x71c715ab
.word 0xf482f007, 0xd93375e1, 0x535f187e, 0x6b3905d4, 0x63b2aade, 0xbcdaf39c, 0xd952da70, 0x1ec02f0d
.word 0xd50bf827, 0x64d0d59a, 0xd2531b84, 0x4641c7ab, 0x06f5c2f4, 0xb7ad3272, 0xd779535d, 0x09053ae4
.word 0xf3101afd, 0x6af5d98a, 0x56ba6668, 0x396ac792, 0x332065b5, 0x26b5e050, 0x9c8b9e13, 0x06f3423c
.word 0xdab803ee, 0x798ecb7a, 0x04a28e5a, 0x18335e52, 0x938bdac8, 0xafd312f5, 0x10887e75, 0xcb654c61
.word 0x1c421056, 0x40d68de1, 0x807bb082, 0xde2d36d4, 0x4e89f8d9, 0x57babd6a, 0x31e4aeb5, 0x8a5a0aa6
.word 0xfe0c3dd3, 0x57dbba56, 0x80375f39, 0xdb6da190, 0x7daab41b, 0x209e4129, 0x914e93f3, 0xeef14fea
.word 0xf8454be1, 0x961cc48d, 0x22dfe54f, 0x9e90d727, 0xe65f3025, 0xf4cfb476, 0x4ebb51f0, 0x84f67da6
.word 0xdf944571, 0x02e516c7, 0x86752f81, 0x56453d02, 0x05c301bd, 0x597bb80f, 0xdf79cce7, 0x034a9221
.word 0xcee21c08, 0xfad44472, 0xe08d9ca8, 0x8e24a094, 0xeb842f0a, 0xfd1a86f6, 0x964ce15f, 0xd2f74e8c
.word 0x4125aabc, 0x1c4ec691, 0x8b6a1447, 0xabaa300f, 0x1fc8ef31, 0x31c1485a, 0xf6ad92e3, 0x966eee25
.word 0x3afc2b81, 0x88c0a8a0, 0x7ba1148a, 0xfa73686b, 0x13454771, 0x4ab8123c, 0x7c420cba, 0xa67d300d
.word 0xaad12359, 0xd6b2f8fc, 0x9c5b4f40, 0xb1999f90, 0x8bc46e2f, 0x1aeefce5, 0x38225ca0, 0xc0c3e210
.word 0xd167389d, 0xe1ea09cd, 0xed45b1fa, 0x4203ac2e, 0xdbe381b4, 0xa7057341, 0xdca9b393, 0x45293399
.word 0x8f20c4a4, 0x9398dc5a, 0xec154632, 0xb5e1f999, 0x714062a0, 0x21bf910d, 0xbd7aa084, 0xe6c0b4a9
.word 0xf7134d0f, 0xe3dc310f, 0x5f1e1432, 0xefc384c0, 0xac031e30, 0x0f21b45f, 0xf1ae41e0, 0xa4b4cdaf
.word 0x03f158e1, 0xb0cd1687, 0x31c9baa1, 0x76ca613d, 0x6418764a, 0x278f1865, 0x3736da4f, 0x67beda71
.word 0xa3d6ffee, 0x6a16a7db, 0xc8f25b2d, 0x5f606929, 0xb0cb6494, 0x02c0de41, 0x33df07c7, 0x293561af
.word 0x4d96de43, 0xf66ea02b, 0x3e88d047, 0xcc3ea489, 0xa62fa9d4, 0x67e861ff, 0xab2081a7, 0xe86ef18b
.word 0xbd04c68d, 0xa14e662a, 0x87910330, 0xb93458d5, 0x0f02912c, 0x754b9074, 0xae2125b7, 0x31d40dca
.zero 7168
mem_region_end:
