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
  li x26, 0x0000000a004020a0
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
  li x1, 0xda5fa06a56831b80
  li x2, 0xdc3035b0535c4fae
  li x3, 0x667ffb5afd8a7929
  li x4, 0xf5a0c4ead00360bf
  li x5, 0x072561f1f8f97e65
  li x6, 0xd0ba445b0064d80a
  li x7, 0x37248e39537cfc6c
  li x8, 0xe32349036f262034
  li x9, 0x432599d451713c0f
  li x10, 0x682a009727f34a90
  li x11, 0xac9209ba5a6215e6
  li x12, 0xf58e2d674ca5e5ce
  li x13, 0xe7315e3d182e4789
  li x14, 0x713af784f8a9a310
  li x15, 0x84abf174ffd4a976
  li x16, 0xe17c3aea129d70f8
  li x17, 0xb02af02ec16419a0
  li x18, 0xdbe3bd2c273e276e
  li x19, 0x48d37ae2660068bf
  li x20, 0x903c377df834a218
  li x21, 0xfc63915a002e02a7
  li x22, 0x342fbd685b4ec54a
  li x23, 0x85e8892ef6d83dfb
  li x24, 0xabe9c363c28ee2d3
  li x25, 0xd7530acbab08d8bc
  li x26, 0x54226fa92c9ce401
  li x27, 0xb9852c6322d14382
  li x28, 0xc44357bd15bd6667
  li x29, 0x3d6c5d4ffd28b534
  li x30, 0x0aa9fc21ca88e984
  li x31, 0x3ce3d965c3078db0
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
  mulhu t2, a7, t2
  sll s2, s2, s2
  ld s10, 600(t6)
  sllw s1, s4, t2
  sd t2, 680(t6)
  sd s4, 1352(t6)
  remu a2, s2, t2
  divu s7, gp, t2
  remu a6, a6, a6
  fence.i
  mulhsu t4, s10, s10
  remuw s2, t4, s2
  slti ra, ra, -274
  fence.i
  fence.i
  addiw t0, s2, -620
  mulhu a7, s2, s2
  sb t4, 1802(t6)
  fence.i
  remuw a1, s2, s2
  mul s5, a7, ra
  mul s8, a5, s10
  fence.i
  remw a4, a4, s5
  subw s2, a4, a1
  rem sp, s5, sp
  divuw s9, sp, a4
  sraiw a3, s2, 12
  sraiw a7, sp, 4
  mul s8, s8, s9
  fence.i
  fence.i
  remuw a4, s5, a2
  remw s4, s4, a1
  mulhsu s10, s10, a3
  addw a0, s4, a7
  div s6, s5, s4
  remw tp, s10, s3
  sltiu s3, s6, 758
  rem s9, a6, a0
  div a4, s7, s9
  mul s11, a4, a4
  sltu t0, s9, s11
  fence.i
  mulw t4, s3, t0
  mulhu a6, a6, s5
  remuw s6, t0, t0
  mulhsu a0, s6, s11
  fence.i
  remuw t1, s6, s6
  fence.i
  remu s8, a6, a6
  srli s1, s1, 1
  srai s9, s8, 34
  fence.i
  sraw a1, s9, s1
  fence.i
  mulw zero, s1, t1
  divw s6, s1, s8
  xor t1, t1, a7
  mul t2, t1, t1
  fence.i
  fence.i
  remu s3, a1, s3
  rem a4, t2, s3
  remuw a6, a1, t2
  fence.i
  fence.i
  divw a5, a4, t2
  mulw a0, a4, t2
  sllw s8, s3, s6
  fence.i
  remuw s6, a0, s8
  fence.i
  remu a2, a0, a0
  rem t1, a5, s8
  lwu s0, 1300(t6)
  fence.i
  fence.i
  srai tp, s5, 55
  divw a0, a0, t1
  sra t0, tp, t0
  mulhu s7, s7, a0
  srliw ra, a0, 0
  fence.i
  mul a4, t0, s7
  sw tp, -348(t6)
  remw s5, t0, ra
  fence.i
  fence.i
  slti s2, s2, -1189
  add t0, a4, s5
  sw s7, -1588(t6)
  add a2, tp, a2
  divu s7, s2, s5
  addw s10, s7, a4
  slti a0, a0, -143
  sd t0, -344(t6)
  sll s1, t0, a1
  fence.i
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
.word 0xc249dfd6, 0xd184c18f, 0x7fa857bf, 0x9be6b00e, 0x87433866, 0x0bcb19ec, 0x655889cf, 0x883b8bd5
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x382fd1c3, 0xcd057cb4, 0x45610bd7, 0xfcee62ee, 0x5707f1ec, 0xd8f824b0, 0x2b88af88, 0x51337401
.word 0x619dae2a, 0xe0e7e38a, 0x0729fe8a, 0xb6971569, 0x89943e37, 0x0c5acd84, 0x2157d932, 0xc8322a43
.word 0x2cc344e6, 0x2597ee14, 0x7686b15b, 0x6f245df5, 0x08607a01, 0xe2d3177b, 0x55b7e629, 0x129665c1
.word 0x8c2f4b30, 0x3fd88b2d, 0xf3752723, 0x0f939e44, 0x420392b6, 0x0555c394, 0x91b2538c, 0x54152e8f
.word 0x5103ea21, 0x960a87d2, 0x324ce077, 0xead00f03, 0x2324ac10, 0xc30beb95, 0xe242a357, 0xcc9b8b3c
.word 0x4905a796, 0x3460f25b, 0x9fd8bb40, 0xe5ac38a9, 0x70605b40, 0x4b30027d, 0xcbb9522f, 0xf8099fa8
.word 0xcf8ea0e4, 0x3d7af54d, 0x0178a0fb, 0x5ad0f159, 0x99051e51, 0xa6a5ef5f, 0x1947207c, 0x7d6fc3ab
.word 0xe9eeb20e, 0xb4dea50d, 0x00a5bfe7, 0x96e1c404, 0xd414a9b4, 0x1e5ded45, 0x6b9416c8, 0x7f004220
.word 0x2bc61cdb, 0x09878559, 0x70dde0ed, 0x9e2b2b91, 0x071abcf8, 0xa6d3ee6f, 0xfb274893, 0xe6c912fd
.word 0x3a8008e7, 0xff901bcd, 0xd68c339c, 0x4fa87027, 0x0f6a3a81, 0x4cd0a28b, 0x8e8339a0, 0xf4e9dcf7
.word 0xa30c3694, 0x17f7ba53, 0xfa53b16b, 0xfff68bd2, 0xe3e69781, 0x26d064da, 0x7ea0e96d, 0xca1a0875
.word 0x83456254, 0x18d62860, 0x9fc1bf81, 0x5a99fc12, 0x08365c41, 0x4c11eeef, 0x20c20dae, 0xa759c94d
.word 0xe4a6cfac, 0x863cc7eb, 0x2aa3edd4, 0x08ff3c67, 0xbd706e86, 0xbcbdeef5, 0x02f07b57, 0xb014ae64
.word 0xc7625220, 0xe2f52784, 0xfdb3c2b6, 0x081b3b2d, 0xd78b8bdf, 0x75a99a56, 0xdccc4223, 0x29449991
.word 0x3a2f88e5, 0xf953eec3, 0x6983f7d9, 0x89a53e52, 0x61a73376, 0x56af4541, 0xf80aa7ba, 0xad464b3a
.word 0xc0a8c3a6, 0x1a323514, 0x87d1e1c1, 0xf1171e67, 0x6c63363a, 0xf8ad3b08, 0xaa3102fb, 0x13cd9889
.word 0x3bc25cfe, 0x25464a33, 0x0a7077a3, 0x4ff3da78, 0x709ea8fc, 0xe8c73f68, 0xef125873, 0x364f03da
.word 0xc9a1281e, 0x293d7ef0, 0xcad459dd, 0xc17623c7, 0x200e4eac, 0xcc72d63d, 0x9098b956, 0xef5355ad
.word 0x65b2e6bd, 0xb9db910a, 0xedee3d55, 0xb68af743, 0xbb89c56d, 0x0da7af38, 0xd36b61b7, 0xdf909617
.word 0xe3510dd9, 0x66a7026e, 0x5e89f576, 0x49e121d6, 0xd7a5bcac, 0x3249add5, 0x57da639e, 0x02edcc67
.word 0xca4db7d4, 0xafaf75eb, 0xb3fca7bf, 0x36cce774, 0x41af39c0, 0xfb09bdf9, 0xead4286f, 0x3c00fe3d
.word 0x092ad1fe, 0x48e52b6d, 0x3793c10c, 0x937f4a7c, 0xa1346003, 0x00fa8ae4, 0x4190e69f, 0x1e70ec02
.word 0x50366855, 0xae04d927, 0x8efa6fd0, 0x16a92128, 0x221a1480, 0x2866aafb, 0x03d30159, 0x3ce56f24
.word 0x6a591a6e, 0x621182cd, 0x903abc82, 0x2909b316, 0x9849d197, 0xa78294c0, 0x6a5a61e2, 0xe05e8ea5
.word 0xdd702bc7, 0xa879bd5f, 0xd4f831dd, 0x45ff2180, 0x8c990a2a, 0x833c267e, 0x9fe3536d, 0x0646750f
.word 0x5224457b, 0x1c58ecb2, 0x45a4d308, 0x48f28b39, 0x2099b70f, 0xcbb72ac6, 0xfa024bf8, 0x5a862534
.word 0xbf096763, 0x69fd90f1, 0x23bf079e, 0x7cb920d8, 0x98354e3f, 0x99adba98, 0x274e498c, 0x636dba5a
.word 0xdbe8e18c, 0x5a7e7453, 0xa4e773e0, 0x627b8d4d, 0x922005d2, 0x75234d77, 0xa831af1d, 0xe3a4158b
.word 0x36a3678a, 0xac7ff6d2, 0x3230689a, 0x7ff08b39, 0x783646f0, 0x175beebb, 0x9fa06a6f, 0xe9f902d3
.word 0x07d0dfd9, 0x58c49d0b, 0x2b40487a, 0x628878d1, 0x5b45c0f1, 0xb0ed22da, 0x83aa6b50, 0x9566b512
.word 0x27f5fd89, 0x3fc421b6, 0x8baf0393, 0x4566f989, 0xa17dd440, 0x187cbd50, 0xac6cab2b, 0x2a722415
.word 0x75cc16e2, 0xbb194ec6, 0x099ee749, 0x872c004c, 0x51b3cacf, 0x3dea081a, 0xbd2f6cca, 0xa84d0d96
.zero 7168
mem_region_end:
