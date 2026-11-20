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
  li x26, 0x0000000a003419a2
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
  li x1, 0x6a272fdafb833f78
  li x2, 0x354603b8ec051b2a
  li x3, 0x7fa5815fef3a71dc
  li x4, 0xdc250fc64b2ce896
  li x5, 0x687355f22a358088
  li x6, 0x92874f5fa47ad7fd
  li x7, 0xdc99227b96ec98c2
  li x8, 0xe834806e91439b2c
  li x9, 0x8e6b421c4de75e95
  li x10, 0x9173de215d2b6d3b
  li x11, 0xd648bd844acc805b
  li x12, 0x000345df9fe1e23c
  li x13, 0x3466e783db6d8d39
  li x14, 0xc537f879c59f4d17
  li x15, 0x07ca66f86da3d259
  li x16, 0x6b29e09d084562fe
  li x17, 0x5c7fb65b2c389d13
  li x18, 0x33d26dd1612c4a45
  li x19, 0x253afde45aae3043
  li x20, 0xd4583b796a1d716e
  li x21, 0x1cb0c02a7e7dac9c
  li x22, 0x95b444d1f8e4cdfd
  li x23, 0x8d30fec0418e2ba0
  li x24, 0xfe035159a82de033
  li x25, 0x6ceadc5b23ad6b1b
  li x26, 0x826f5a9682f58f85
  li x27, 0xb348f71052ea82ae
  li x28, 0xdf1e8df270b3d3d8
  li x29, 0xd17b4d9e25e2f7d4
  li x30, 0xec08fb7897b4a764
  li x31, 0xd82ae9a169652b56
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
  fence.i
  addiw s4, s4, -115
  lui sp, 134892
  mulhu s7, s6, s7
  remuw a7, sp, s7
  sd sp, 1688(t6)
  mulhu a4, sp, a7
  mulw s5, s7, s3
  fence.i
  divuw s9, a4, s7
  remw s6, a7, s5
  sw a4, -1188(t6)
  addiw a3, s6, 1565
  fence.i
  sd a7, 1696(t6)
  srlw t0, s6, s4
  add a1, a3, a3
  mulhsu t2, t2, s6
  srlw a4, t0, s6
  mulhu t0, s6, t2
  divuw s7, t2, a4
  divuw t3, gp, s7
  mulw s2, a5, t0
  fence.i
  divu t4, t3, s5
  fence.i
  divw a1, s2, t4
  lw a0, -920(t6)
  remw ra, t4, t4
  remw a7, a7, a0
  addiw a3, ra, -1
  div s8, a0, a1
  mul a4, a3, s8
  mulhsu s6, s6, s6
  slli sp, sp, 41
  addi sp, t4, -1
  remw zero, zero, s8
  div s4, s8, s8
  div t0, a4, s6
  fence.i
  fence.i
  lwu t2, 1260(t6)
  subw s0, zero, sp
  mulw t3, s0, t3
  addiw s3, zero, 2047
  srlw ra, t3, a7
  divuw s5, s0, t3
  fence.i
  mulw s4, ra, t3
  lh s6, -880(t6)
  sll a5, ra, s3
  addw gp, s6, s5
  remuw a4, a5, s6
  divw zero, a4, a5
  fence.i
  ld t0, 1424(t6)
  fence.i
  fence.i
  auipc s2, 342657
  lb s10, -1437(t6)
  sub s8, a4, a2
  fence
  divu a2, s1, s2
  srliw t4, t4, 0
  lwu t2, -456(t6)
  lb a4, -453(t6)
  sraw a7, a7, t2
  fence.i
  fence.i
  mul s0, ra, a7
  fence.i
  remw s11, s11, t2
  divw gp, s0, t2
  mulhsu t1, a4, a5
  divu a5, s0, a5
  remuw s2, a5, s0
  sllw s10, t1, t1
  li a5, -256128839334
  addw a2, a2, a5
  slli s11, s2, 50
  remu s0, t2, a2
  mulhsu t4, s0, s0
  remuw t3, s9, s0
  srliw s10, t3, 25
  sd s11, 280(t6)
  divw tp, t3, t3
  fence.i
  fence
  sb s10, 1670(t6)
  auipc s2, 186278
  fence.i
  fence.i
  sraw ra, s6, s2
  fence.i
  remu s8, s8, s6
  divu s3, ra, s2
  fence.i
  fence.i
  divu t1, s3, s6
  srliw t0, s3, 0
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
.word 0xd74f9669, 0x59872aa8, 0xc02435c1, 0x0d9c10d0, 0x745b93e6, 0xd04d78e6, 0xfd6cea7c, 0xdde5c21a
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0xeb18b59a, 0x76e9450d, 0xb00deb43, 0xdbc0f6aa, 0xb3002dec, 0xc73b0b2a, 0x403d602e, 0x933fc2e9
.word 0x27160628, 0x2197cd52, 0x71e45f30, 0x119c8c84, 0x2656ad72, 0xe4e4ff44, 0x7817eb5c, 0x7b2b9839
.word 0x010849a7, 0x21efb32d, 0x0f8e3cc0, 0x1c082cca, 0x857cb82d, 0xf5b50228, 0x5545f26d, 0xeb50ca99
.word 0xcb201ace, 0x01306f0a, 0x254dd830, 0x031fba99, 0x884f018e, 0xf37f7db5, 0xc51a1fe4, 0x08a3763a
.word 0x92ab8d97, 0xdc28913b, 0xa085fedd, 0xba3866a0, 0x1e12a107, 0xb521784d, 0x80a06ab0, 0xf4334073
.word 0xdcfe8b1d, 0xe40818d1, 0xb01854ee, 0x68cc2032, 0x1c5ce6e6, 0x809660ee, 0xe6691d6a, 0xa37427c9
.word 0x8f46787c, 0xb299225d, 0x05708668, 0x3d4954ef, 0xc5800350, 0xa14e2c8a, 0x5a82c68e, 0xad1ff5e3
.word 0x3fac2a28, 0x6850cb32, 0x86cb2472, 0x82a2b6a4, 0x390031ea, 0x4dcdda02, 0xa8353cac, 0x46be04c8
.word 0x9503426a, 0xb3e32d59, 0xf454084a, 0x245aac91, 0xb75635dc, 0x8a07227e, 0x06220dc9, 0x50b1e6cd
.word 0xe84d4013, 0x67e6642f, 0xc9273471, 0xc8e48c1a, 0xbbfa1fbf, 0xb47183e9, 0x110f8b96, 0xf3420cb0
.word 0x6607f278, 0x0cc3526d, 0x9e2e8caf, 0x1fe300e7, 0xeaa4743e, 0x4b1f3bb6, 0xe8f74d51, 0x8b0e0cd5
.word 0xb0d2f162, 0x0634766f, 0x208ef853, 0xd29ed564, 0xd25cec9f, 0x000c01d9, 0x44ff772a, 0xb47983de
.word 0x6eb47b0f, 0xae65f342, 0xcee661e0, 0x1755761d, 0x08fd6de3, 0x707c1845, 0x4724c67b, 0x76e11d18
.word 0xb1c5cec6, 0xad96f0c8, 0x0e0882b7, 0x9fa045c0, 0xb8de00bd, 0x39befa7c, 0x20325756, 0x662b0c04
.word 0xcc37c20b, 0xb44cc9f6, 0x224cd5d3, 0x6738de08, 0x2f3150da, 0xa0a8af7d, 0xe33124fb, 0xb50711dc
.word 0xdb6bbde0, 0x2fa0a964, 0x82ed5dd5, 0x62520b00, 0x921f9718, 0xc095e7f6, 0xdb856e1d, 0x8a30e855
.word 0xd0d50859, 0x7303389f, 0xb46a42d5, 0x3052ace3, 0x8d397db0, 0x3f4015b6, 0x658a674d, 0x95afe226
.word 0x29289b26, 0x790e9a62, 0x96d2ab0d, 0x9a074112, 0x026407dc, 0x6dee1242, 0xd890f011, 0x8deacc83
.word 0x96e0bac0, 0x2f72cdac, 0x6a89a819, 0x2f5dec37, 0x5ad18c81, 0x34a5466a, 0x58f412dd, 0x741f89eb
.word 0xbc92d303, 0x3aeb06e2, 0xf7476d94, 0x4a7ab78b, 0xa365ea26, 0xebc4bebd, 0xe3f8c717, 0x5622344a
.word 0xcb684b10, 0xc61908d7, 0x73799546, 0xf37b9be7, 0xd7137f02, 0x9a74472d, 0xe479f817, 0x7b4d8898
.word 0x84d9b79b, 0x16c4144c, 0xf2e67f9a, 0x314de720, 0x1023da2e, 0x0ec2298c, 0x856861c0, 0xf0b8a131
.word 0x4e87eeec, 0x21688e98, 0xac19f713, 0xb4312122, 0x5c975d59, 0xfdbfb01d, 0x34729adb, 0x2177bc32
.word 0x04357aec, 0x91d0ec5a, 0x2f65f551, 0x2840d152, 0xec8a777f, 0x995faad0, 0xf96240ed, 0xe23c9425
.word 0x33ba1302, 0x683768b3, 0xb6b0aa25, 0xaab433c2, 0xbea8473a, 0x5934cfee, 0x25986d8a, 0x06598bc4
.word 0xa4e088aa, 0x77808407, 0x3f63cf02, 0x0b0e7234, 0x05281c17, 0x7e6816f9, 0x9e094418, 0x0eda65fc
.word 0x19750e0f, 0xa694a247, 0xa92d8aeb, 0x8ef4631e, 0x2bbe5439, 0x063acfdb, 0xed671978, 0xad8662a0
.word 0x7d20acd6, 0x020513d6, 0x2eae7f4d, 0x0ce196f5, 0x08006c20, 0x941d49ae, 0x0db52364, 0x31ad595d
.word 0x46ff16a8, 0x5f023eb6, 0x0b5a195b, 0x7a320b47, 0xc2d7d1fa, 0x49902ffc, 0xbab4e284, 0xca5d223e
.word 0x41bf9d51, 0xbbe6c4f0, 0xe2b6a712, 0xc83ac600, 0xa142643a, 0xe16041ab, 0xf6058bed, 0xdbb8d81a
.word 0x76f3578e, 0xe24fd63b, 0xbbabd83e, 0xb43d86fb, 0x9ef394a7, 0xcbf32a8b, 0x7b4a206e, 0x22a4404c
.word 0xb9520a97, 0x7f32b39d, 0x65747fab, 0x4c058ea4, 0xdd263a1b, 0x7eafc067, 0xd2e66a8d, 0xf3bb0c35
.zero 7168
mem_region_end:
