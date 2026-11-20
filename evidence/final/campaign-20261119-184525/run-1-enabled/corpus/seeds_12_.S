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
  sub a3, s5, s5
  ori s11, s11, 1891
  sll s5, s2, s5
  divw sp, s11, sp
  div a5, s2, s11
  rem a3, s2, t1
  slliw t1, t1, 31
  sraiw s0, sp, 10
  sll t2, sp, s2
  mulw s5, t2, a0
  mul s8, a3, t0
  mul ra, s5, t1
  divu sp, sp, ra
  divu t4, s10, s5
  srai s0, s0, 57
  or a0, sp, a0
  remw a1, a0, tp
  and s7, s0, a1
  rem a5, s7, tp
  sraw t3, a1, s9
  remw t4, s3, s7
  div s9, s9, a5
  sra s8, s7, s9
  slliw tp, s9, 23
  slt t2, s8, t4
  remw zero, a5, s6
  remuw s4, ra, a2
  sraiw ra, a5, 0
  andi a2, s4, -2048
  sraiw zero, a6, 31
  divu a5, a4, zero
  sltiu s1, sp, 1445
  div s3, a7, ra
  mulw a3, a3, s0
  divu s6, a7, a3
  remw s5, s6, a3
  divw a7, a7, a7
  subw a7, a4, a7
  slli t2, sp, 61
  srl s1, t3, t2
  addw s9, t3, t2
  remuw s11, s9, a7
  srlw s3, s1, s11
  andi s2, s2, 403
  srli s6, s11, 63
  divuw a7, a7, a0
  sltu s8, s2, s8
  sd s0, -1344(t6)
  srliw ra, t0, 1
  mulhsu gp, s8, gp
  divu t3, t0, s8
  rem a2, gp, s2
  mulw a6, t4, a6
  remuw s2, s0, s2
  divu s3, s8, s8
  remuw a0, a1, t1
  sraiw s8, s4, 17
  sb a0, -1724(t6)
  mulhsu s1, s1, ra
  sraiw t0, s8, 24
  srlw s0, tp, a4
  sraiw s2, t0, 27
  sw s1, 996(t6)
  remu t4, sp, s10
  srli a0, s4, 49
  rem a0, a4, a2
  srlw s10, zero, s3
  remuw zero, a5, a0
  mul ra, s10, a5
  remu zero, s1, a6
  srliw zero, t1, 12
  divuw t3, t3, zero
  mulhu s6, s11, zero
  mulw t1, s1, gp
  mulhsu s4, t3, a3
  auipc t4, 544461
  divw a1, a1, a3
  divw t3, s4, a1
  mulhsu t4, a3, t4
  mulw s0, a4, a3
  mulw a6, a4, s8
  sll s6, a4, a3
  slli sp, t1, 63
  mulw t2, sp, a3
  remw s11, s11, sp
  divw s4, s11, s1
  lui a6, 566782
  rem ra, s5, s11
  slli s7, a1, 51
  mul a0, s0, s7
  mulhu a3, a3, t4
  divw a5, s2, a4
  remw s3, s9, a4
  srliw s3, s10, 25
  divuw a4, sp, a4
  remw t2, a2, a6
  subw s6, a6, a5
  remu s11, s8, s6
  divw s4, s6, a5
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
