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
  li x26, 0x0000000a00640888
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
  li x1, 0x72319c3f9b3721c2
  li x2, 0x5497d70fa602c41e
  li x3, 0x35d1dd8f11de1b36
  li x4, 0x4beab57e40ca9569
  li x5, 0xc017e338bd089cb0
  li x6, 0x295fa7abadf532aa
  li x7, 0xf46435d564213bdf
  li x8, 0x532fb08d5a81d023
  li x9, 0xf213d1eea075d926
  li x10, 0xbc63d822ad4b4ea5
  li x11, 0x33a50509c82756bf
  li x12, 0xabc941911f54cd8e
  li x13, 0x6443827c25e526b9
  li x14, 0x69ea9c291a99487f
  li x15, 0xed87b6691ebc0a0a
  li x16, 0x7b489f3360acbb8c
  li x17, 0xb7431e83800a5aa6
  li x18, 0x1205833d2e20e29e
  li x19, 0xb03538b0dc3d8223
  li x20, 0xaedb5850a3300f86
  li x21, 0x51a91d7b4b71d4d3
  li x22, 0x9b925ca149d1bc6a
  li x23, 0xe03e2f4833169fe7
  li x24, 0x4863053f0610891c
  li x25, 0xab0e46d485417e00
  li x26, 0x80b50745c61ec987
  li x27, 0x7ebf4d2a5c6ec438
  li x28, 0x72480254e9f1b2d4
  li x29, 0x8689759bd0d70a18
  li x30, 0x52e3952810a08b8f
  li x31, 0x46fcc44941b0e9a4
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
  mulhsu s5, s5, a5
  fence.i
  sub a3, s5, s5
  ld s6, -576(t6)
  fence.i
  fence.i
  sltiu t0, a3, -1
  xor s2, a3, s5
  remw t1, a3, s5
  div s7, a3, t0
  divu s10, s10, s10
  ori s11, s11, 1891
  sd t1, -1360(t6)
  srlw zero, s2, s2
  remw a5, s7, s11
  rem a3, s7, t1
  fence.i
  mul s1, s1, s1
  fence.i
  fence.i
  mulhu tp, zero, s2
  rem a2, s1, a5
  srlw s3, tp, s8
  auipc a4, 103110
  remuw s10, t4, s10
  xori a3, s3, -2048
  fence.i
  fence.i
  div s2, a4, a4
  sraiw s7, s3, 8
  fence.i
  remuw s1, a4, s1
  mulhu a6, a3, s2
  sraw s3, t1, zero
  lh s8, -358(t6)
  ori s9, s3, 1
  remw s6, s8, s1
  remw a0, a3, s8
  subw s2, s6, s8
  lb a3, -189(t6)
  ori ra, a0, 0
  addw t2, s11, s6
  divu s3, a5, s2
  lbu s8, -254(t6)
  mulhsu a0, s8, sp
  remw t0, tp, s8
  div zero, t2, zero
  remw s6, s3, t0
  divuw s2, s2, a0
  fence.i
  sraw a2, s6, a0
  fence.i
  sllw s10, s6, s6
  fence.i
  add tp, s10, zero
  slli s0, t3, 63
  mulw s9, s0, s11
  addiw a7, tp, -351
  xori zero, zero, 1
  fence.i
  srliw t1, s0, 0
  remw a1, s10, a7
  fence.i
  fence.i
  li a3, -549755813888
  srliw s1, t1, 27
  fence.i
  srliw s9, a3, 15
  mul s4, s9, s4
  fence.i
  divu s5, s5, a7
  divu t1, a3, a3
  srai a3, a3, 37
  remuw s6, a3, s8
  andi s4, a3, -1049
  fence.i
  divuw s10, s10, s5
  mulhu a6, t3, sp
  mulw s5, s10, s4
  sraw s3, s6, s10
  sub s1, a6, s3
  fence.i
  subw tp, s5, s5
  lbu t4, -1305(t6)
  fence.i
  sw t4, -592(t6)
  li a2, -1
  remu s9, a2, s3
  lwu t2, 28(t6)
  sd a2, 1368(t6)
  lwu a4, -656(t6)
  sltiu s5, s9, 0
  mulhu s11, s9, a2
  sraw sp, t2, a4
  fence.i
  rem s5, a4, t2
  addw s8, a4, s11
  divuw s2, s8, s2
  remu a2, s5, s5
  sllw a1, a2, sp
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
.word 0x690b0e24, 0x7fd58d96, 0xc968561a, 0x790f28e9, 0x6f59c7eb, 0x1246da77, 0xa4dc343c, 0x4a3efefe
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x4d1495fe, 0x2a32d530, 0x52d70de3, 0x42436472, 0x200f8e9a, 0xbd324c9f, 0x5cb7c651, 0x07e6ce1a
.word 0x3c5abd15, 0x8c3819fc, 0xee7425e4, 0x6c185faa, 0x20cd06ca, 0x6ef172a4, 0x886d314d, 0x126cef57
.word 0xb13e3040, 0x2dde2cac, 0x982bfde5, 0xee576225, 0x8cb01b98, 0x557e4c89, 0x4f73c54e, 0xedab1814
.word 0x124a1065, 0x4a863f6a, 0xb0b54f5f, 0x36d00dc4, 0x3e35aaa6, 0xc12924d6, 0xa2384c2d, 0x5ee9d02e
.word 0xfd10f818, 0xae2278fd, 0xedd5fa9e, 0x4cca146e, 0xb474747a, 0x1d15a8fb, 0xee45fe35, 0x8b36fd7c
.word 0x8af9f965, 0xd87ca916, 0xa6cf1744, 0x4529d428, 0xbde9008f, 0xe255c957, 0x0bc117bc, 0xad6c1747
.word 0xa9459baa, 0xeef08268, 0x34d7b8e9, 0x3828cae3, 0xf1dd960e, 0x6f221897, 0x77625c14, 0x29f216ab
.word 0x51d8881a, 0x93e39939, 0xc080e0e3, 0x6aff53f1, 0xeeb46607, 0xa2f60f2f, 0xf6af4f78, 0x99f7eeb5
.word 0xfa304a15, 0x080394fd, 0xbd90caa9, 0xa05eebb0, 0xe1d8151d, 0x1c3bdaca, 0xa2e9afd4, 0x46d6ec06
.word 0xc8a1b507, 0xfd105202, 0x95538239, 0xd84dd21b, 0xf7eaabe2, 0xcd11f3b8, 0x3527280d, 0x19cbeaf0
.word 0x4340b4ed, 0xe0c40e7d, 0x67dd80a8, 0x4a2fba5b, 0xe9408b33, 0x8814ff06, 0x31fe763c, 0xb782fab5
.word 0x137aa03f, 0x088f4ea5, 0x39c295c3, 0xae9af44c, 0x677c901e, 0x742087df, 0xc086a9be, 0xcce2a458
.word 0xb64cd2ac, 0x0c0bbe2c, 0x394260fb, 0x28f977c5, 0x09a71173, 0x0a7864bc, 0x63bf82ea, 0x5fe2621a
.word 0xb31d8dc6, 0xc7755861, 0xeb7dc992, 0xa6998fef, 0x010cdbac, 0xdb88b276, 0xc28f0827, 0x8a09616d
.word 0x45041492, 0xb22e4461, 0x0bba3c01, 0xa26e191b, 0x9e048b68, 0x78020e79, 0xb85ce9ac, 0xff2f20d1
.word 0x72ec6ef3, 0x7b3ef4ab, 0x22b1652e, 0xc48db337, 0x4010d718, 0xaddf36f3, 0xcb49cc8e, 0x493dfb40
.word 0x5691b17f, 0x4a6b188a, 0x3cdc5c71, 0x0e4d1064, 0xc8005505, 0x1651501e, 0xbb7cbf08, 0xaebea387
.word 0x1ae207f9, 0xbe01816b, 0xb28dbfb1, 0xad3762d6, 0xc08b704c, 0x55f8cd62, 0x291f9f16, 0x73834a92
.word 0xb163af0a, 0x6b84a270, 0x95c11880, 0x82cd294e, 0xac50356b, 0x882a0072, 0x876a14a4, 0x14030cd0
.word 0x7a164efc, 0x43965004, 0xe961379f, 0xe4eb7050, 0x0dfdcfa4, 0x74bf4201, 0x2d8ad892, 0xead33aa3
.word 0x06380bab, 0x7cf8a485, 0x2506a847, 0x161bfba6, 0x76d2564e, 0xed5cede4, 0x5f370ea7, 0xd8bde191
.word 0xc4bcf9b1, 0xee238037, 0x58f66a51, 0x810850ec, 0xdb0aba37, 0x27ca5e4c, 0x016e166a, 0x433c228c
.word 0x67cc03ad, 0x2db97a3b, 0x6a07665b, 0x247b0bed, 0x2f31c957, 0xf44976ea, 0x4d73663c, 0x13415b8f
.word 0xfb69395a, 0x939e1a5d, 0x394ec748, 0xa1b0724c, 0x67b3cd54, 0xc3c8b197, 0x4b79f1e5, 0xbdebf2d8
.word 0x9847dfc2, 0x2315e19c, 0xd314ec8a, 0x86408a0a, 0xa9e1760a, 0xacb1a9b4, 0xc69ad523, 0x841ca069
.word 0x5f88555f, 0x9c5c74dd, 0xda960c5f, 0x0726f30c, 0x968e82e7, 0x8cd85eb2, 0x5d2cd400, 0xec389767
.word 0x6a50e0f0, 0x4f495c92, 0x4d8b4ef6, 0x64f97547, 0xebce4656, 0x5081530d, 0x6c6cf377, 0x0a4ce673
.word 0xf84b8046, 0x97e428c2, 0xf3a0b640, 0xbb45cd2e, 0x7b0fb1b8, 0x19280b28, 0x5a0c664f, 0x0646577f
.word 0x7bbb41df, 0x7422b088, 0xbf6fac36, 0x44c21642, 0xce88429a, 0x7cc2650a, 0xa871aaf7, 0xe01de3e4
.word 0x2179ff73, 0xe6a57594, 0xc910ac97, 0x892d524f, 0x37a26523, 0x4324c439, 0x0f341d52, 0x7f017501
.word 0xafd7b06c, 0x027147c3, 0xf8172921, 0xa8d0fdd7, 0x963a726e, 0x4f7bed95, 0x5b22b73a, 0x3d5dfe64
.word 0xa898558a, 0x3ecd4480, 0xd8d886a1, 0x910939f1, 0x2e9dc808, 0x9149ee8c, 0x0915af6b, 0x12168c06
.zero 7168
mem_region_end:
