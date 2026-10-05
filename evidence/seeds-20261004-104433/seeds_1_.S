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
  li x26, 0x0000000a002348aa
  csrw 0x300, x26 # MSTATUS (MPP=1)
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
  li x1, 0xdc65fa1ed53de6fa
  li x2, 0x9a6e8c8f9f90d477
  li x3, 0xb396b79f6be1ccff
  li x4, 0xa4f254b4f49293b0
  li x5, 0xcf56a49c46bfb64a
  li x6, 0x2715e060578db905
  li x7, 0x2804a0270435640d
  li x8, 0x2a51ea19e389df89
  li x9, 0x67628cf573d89c52
  li x10, 0xfe10675318494a40
  li x11, 0x7b1a01604550aecf
  li x12, 0x7bec1c41257ce5d1
  li x13, 0xb9fc16ff712e37e5
  li x14, 0x78b9a723894970f6
  li x15, 0xcd31620b33c2ced1
  li x16, 0x438f19c02b8e07de
  li x17, 0xd16369ab26e83a24
  li x18, 0xafef6ab5fb8afec2
  li x19, 0xf8f9f4832bb381e2
  li x20, 0x8753f5a91f43fd64
  li x21, 0x77980d63f7c08f3e
  li x22, 0x8d7b002ba8f9d67e
  li x23, 0x725b97308b529106
  li x24, 0xd5475b3283d93f42
  li x25, 0xe7cc7ca2d30f67da
  li x26, 0x6bdb1b818147c246
  li x27, 0xab1745a20d5f264d
  li x28, 0x8c8711272d9ebd21
  li x29, 0x0901112c9bf1a6a1
  li x30, 0xf2d77d4b951e72e6
  li x31, 0xe695396439a91c44
  li x5, 0x25c2f8863ac83d6a
  fmv.w.x f0, x5
  li x5, 0x3fdf3c9d0cde2f34
  fmv.w.x f1, x5
  li x5, 0x70e537cfd617e370
  fmv.d.x f2, x5
  li x5, 0x131f4f4c1f7fb2a4
  fmv.d.x f3, x5
  li x5, 0x2c2feb1ed42545b8
  fmv.w.x f4, x5
  li x5, 0xd4859f32e3ea0fe2
  fmv.w.x f5, x5
  li x5, 0x86472123bb7eac31
  fmv.d.x f6, x5
  li x5, 0x395e7e9239cd917b
  fmv.d.x f7, x5
  li x5, 0xdbe6474ab2e7c79e
  fmv.d.x f8, x5
  li x5, 0xfc3421138aa0abc2
  fmv.w.x f9, x5
  li x5, 0x2166cfad1ca1d3c7
  fmv.w.x f10, x5
  li x5, 0x3b9f8e812100c86f
  fmv.d.x f11, x5
  li x5, 0xd1600584811714ed
  fmv.d.x f12, x5
  li x5, 0xe102a7c431c692cf
  fmv.d.x f13, x5
  li x5, 0xe7bf4993fea7ed4d
  fmv.d.x f14, x5
  li x5, 0xaeab0aede2f9bdbd
  fmv.d.x f15, x5
  li x5, 0x3ddb86936ec66c93
  fmv.d.x f16, x5
  li x5, 0xd5ea507768c07655
  fmv.w.x f17, x5
  li x5, 0xd1403f1fc3a276ad
  fmv.d.x f18, x5
  li x5, 0xb9ac087371766a64
  fmv.d.x f19, x5
  li x5, 0x994cda9461384f3c
  fmv.w.x f20, x5
  li x5, 0xb4bd3f3ba5b013cb
  fmv.d.x f21, x5
  li x5, 0x1bce21e2ef67247e
  fmv.w.x f22, x5
  li x5, 0xe79b5370eacf9c96
  fmv.d.x f23, x5
  li x5, 0x75e621950b049f76
  fmv.w.x f24, x5
  li x5, 0x7b775c4ddadea9b4
  fmv.d.x f25, x5
  li x5, 0xe57ccb9287c30830
  fmv.d.x f26, x5
  li x5, 0xa76d7bd631e18cef
  fmv.w.x f27, x5
  li x5, 0x58b01ca8ecf6f9ac
  fmv.w.x f28, x5
  li x5, 0x056c5e96f80ad156
  fmv.w.x f29, x5
  li x5, 0x44ad2d5683fa5906
  fmv.w.x f30, x5
  li x5, 0x76b3ae497f14afcc
  fmv.d.x f31, x5
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
  csrrs zero, senvcfg, a2
  rolw a4, a3, a3
  frrm t4
  fsrm s4, t4
  slti s1, s0, 2047
  fcvt.l.d zero, fa2, dyn
  amoand.w a7, s1, (t6)
  amoxor.d.aq tp, s1, (t6)
  sha256sig0 s7, s4
  packw a2, tp, a7
  rorw a4, tp, s7
  sll a7, a7, a4
  srl a6, a6, a7
  ori a3, a2, 1
  roriw a5, a6, 26
  fsub.d fa0, fa0, fa0, dyn
  sha512sig0 t2, a4
  roriw t3, t3, 31
  ecall
  clmulh sp, a3, t3
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
.word 0xe0121bf7, 0xec7fd2b5, 0xa882d09e, 0xe3a92d6d, 0xfd80ba20, 0xb9459fe3, 0xb5f967b1, 0x01e4895f
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x7b2a27c0, 0xb3756778, 0xb1e94486, 0x8cc5705a, 0x47696b7d, 0x0617e635, 0x185db750, 0x700c223d
.word 0xb8792d60, 0x72a5cdb8, 0x55d07acf, 0xdbcceb0b, 0xf0fd0c84, 0x18d73bba, 0x35b6ea47, 0x9d52160d
.word 0x2b5a4feb, 0x44d431d4, 0x8d4e0233, 0x7751e149, 0x5394a013, 0x06a582e9, 0x5baa2530, 0xaa44af72
.word 0x3741cc8d, 0xe64c88c3, 0xe86874f3, 0x60460d3f, 0xe91d2eb8, 0xe7caaa50, 0xb664ca4c, 0x14306abd
.word 0x91af6c52, 0xd7ccd7e3, 0x3cd4eaf2, 0x00407397, 0x293a80d9, 0xe29b3326, 0xfeda6687, 0xf5557eab
.word 0xb4d68a71, 0x67084293, 0xc73f37fb, 0xad65dd25, 0xfee756ae, 0x1ec34885, 0x9e9c236b, 0xce67d207
.word 0x400a350a, 0x552265f2, 0x80356aef, 0x6499623c, 0xddf342eb, 0x64f451bb, 0xed533d0e, 0x0e2d4a52
.word 0x8bb220be, 0x13f293f6, 0x59844dc8, 0x2d463908, 0x365e85b4, 0xd7709193, 0xc5b1655e, 0x88520e80
.word 0xdf80462e, 0x986b8ac2, 0x60948914, 0x137c0596, 0x7b930cb4, 0xac88f9f7, 0x9ba113e4, 0xd744e562
.word 0x152a08af, 0xb7e60de9, 0x480f1e42, 0x8bea7af9, 0xe05a5a81, 0x397f3c7d, 0x920700c0, 0xf87f08d7
.word 0x85eedd93, 0x04fa98c7, 0x6fda17df, 0x5fe1580f, 0x11a2c18d, 0x74dc74c6, 0x048b9bff, 0x896772c7
.word 0xce93a773, 0x7e94d3ce, 0x6525edfc, 0xc4f9a021, 0x1ad611cc, 0x5a07da1c, 0xffd943a9, 0x6fa3f547
.word 0xcdf015bb, 0xa2e54283, 0x0b640b9b, 0x8b6a48a6, 0x42f68e1f, 0x29b9b5ab, 0x5f19bcfb, 0xb8f8c862
.word 0x131e138b, 0x505e28a6, 0xe1ddeea6, 0x28430cd6, 0x6e7bddb9, 0xffb41acb, 0xf97e3405, 0x5c9538a3
.word 0x0cd00d84, 0x5ee3f2ea, 0x5bcfc010, 0x76588a0b, 0x6010110f, 0x010a6658, 0xc3bdd3c9, 0x12dc17b0
.word 0x1f43e9ab, 0x0e2f9b8e, 0x04fdd50e, 0x3b007d33, 0xaff20fc3, 0x17e0b09e, 0x8b04d8c4, 0xcb28aec4
.word 0xa2b64aeb, 0x553685ad, 0x1e85a7c6, 0x1a2c8577, 0xc2d62c4d, 0x85c488da, 0xe36c5a4d, 0x98f2d10f
.word 0x6216dfd2, 0x58af7f49, 0xd13eda29, 0x85c107d5, 0xc9d23a12, 0x09028f7c, 0x1becec09, 0x63d49ade
.word 0x0d822441, 0xe632b43b, 0xa09a964c, 0x8d966b6d, 0xd53ff318, 0x31e885df, 0xc1fca672, 0x5a876bfe
.word 0x52d64f95, 0xe0303a96, 0x0fe6d118, 0x722b6488, 0xf23562d1, 0x7a70d1d3, 0x8f8348c0, 0x00676ec6
.word 0x157584a0, 0xb8a3942a, 0xa7dbca51, 0xb63a9528, 0x3a0de8f7, 0xf4a4f580, 0xcda134fc, 0xff122967
.word 0xbe8bfa6f, 0x7b740380, 0x4715fc00, 0x1308fa5d, 0xcfcdb993, 0xc355c639, 0xb18a084d, 0xfca7167c
.word 0xef848509, 0xf207e0bb, 0xb71f347d, 0xdc91bbec, 0xe54384ee, 0x8927950d, 0xd62ab5ab, 0xbfa6f7c3
.word 0xf386f2ed, 0xd2a366c7, 0x420ec404, 0x7d807961, 0x0c90f395, 0x7c3f601a, 0x97dbc329, 0xac156b05
.word 0xe40e3707, 0x38641a6b, 0x6d373c51, 0xb94a8cc6, 0x9eb39719, 0x80d608fa, 0x822962c3, 0x9b5c7652
.word 0x67191c53, 0x2c8abed7, 0x495cc3ad, 0xc7672ef5, 0xc4a162c8, 0x770f5fbb, 0x700644b9, 0xf6dfc0e3
.word 0x81c78016, 0x96ca4b7f, 0x5066d49a, 0xf8823439, 0x4703876a, 0x78b49e60, 0x44ee8ff6, 0x512b8a0e
.word 0xd96a7d20, 0x7a9cdc09, 0xa67e4b53, 0x56549001, 0xc3bf6fc8, 0xa2d2465b, 0x4a517b40, 0xedc4259b
.word 0x05d649bb, 0x17d46edc, 0xf7a0b903, 0xb8f697f2, 0x5a7d7c03, 0xd3d9de1d, 0x5ed1d3ce, 0x28d4a25a
.word 0xd8aca192, 0x57e1dafb, 0xbdf763e2, 0x630fe3cd, 0x12a3d653, 0x1a395d95, 0x7c524447, 0xb2f2baf7
.word 0x6126d019, 0xd005f8d6, 0x325ddc73, 0x78df804a, 0x45624f0d, 0xe8fdbe58, 0xfdb8a666, 0xe9959493
.word 0x60ed411e, 0x6937432d, 0xdcc4f422, 0xf166d07f, 0x29c70bcd, 0xc4fbb382, 0x2ad97697, 0xb24ffa55
.zero 7168
mem_region_end:
