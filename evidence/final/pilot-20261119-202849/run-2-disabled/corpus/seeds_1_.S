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
  li x26, 0x0000000a002c0182
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
  li x1, 0x5cec48b5c602dc85
  li x2, 0x5b0e4ca9e095bf8c
  li x3, 0x78b1155406d50c90
  li x4, 0xf2247d3903e88267
  li x5, 0x98f75e5a2cc54b4f
  li x6, 0xc793844d6594f521
  li x7, 0x9b793d5b5da3dae5
  li x8, 0x84c56d0f83e197dd
  li x9, 0x9ecefb7793008474
  li x10, 0xb6fc3bd965af6eed
  li x11, 0x70ce87300aa81919
  li x12, 0xff869e7189f6913a
  li x13, 0x4166b89603b28baf
  li x14, 0xbae6b83b59bdd460
  li x15, 0x8d26823ffc4bc6e4
  li x16, 0xe17a82e8d908ea00
  li x17, 0x749a00b5ec04ab65
  li x18, 0x057e5ef098a1be53
  li x19, 0xf01c3cd7fed8420e
  li x20, 0x94c76513c98a289a
  li x21, 0xfc76fb40538f6a06
  li x22, 0xe96f1bab42fb3ebf
  li x23, 0x5b78b8e4626c0c54
  li x24, 0x9fda6d087105bcd7
  li x25, 0x1d7849de0a08b663
  li x26, 0xb4deff2b4a101914
  li x27, 0x6975d35e63a9bb71
  li x28, 0x6f6957cf79f48b8d
  li x29, 0xf177b9f4cfb28771
  li x30, 0x81cfbc5b1555f25e
  li x31, 0x321cfad82191e363
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
  divw s0, s0, s0
  srai s7, s0, 47
  mulhsu t1, s7, s0
  remu a5, s0, a5
  mulw a3, s11, t1
  fence.i
  fence.i
  fence.i
  subw sp, s0, sp
  lh s11, -1384(t6)
  mul t0, a3, a1
  sraiw s0, s0, 31
  divu s7, a3, s0
  srliw s5, ra, 0
  mulw s9, s7, s10
  mulhu s4, a2, s5
  mul s11, s0, s4
  srl sp, s9, t4
  fence.i
  remuw sp, t4, a5
  sltu a3, s5, tp
  divuw t0, a3, s9
  rem s0, a3, s9
  fence.i
  fence.i
  divuw s3, s0, s11
  div t3, t4, s10
  mulw a4, a3, a4
  fence.i
  mulw s4, s4, s3
  mulhsu a0, s4, a4
  srlw ra, s3, s3
  subw s6, t3, ra
  slt t4, t4, s10
  remuw s11, a0, a0
  divu s6, ra, s9
  mulw a5, a6, s11
  srai a7, ra, 22
  fence.i
  mulhsu t2, t2, s5
  sra sp, s1, s6
  div s7, a5, a7
  srliw s9, s9, 31
  fence.i
  div t4, sp, s9
  lbu s9, -98(t6)
  mulw s0, sp, s7
  srliw s2, t4, 4
  sh t4, -198(t6)
  divu a3, s0, t4
  divu t1, t1, s0
  rem t2, s2, s2
  subw s11, s11, t2
  fence.i
  fence.i
  divu a3, t1, zero
  fence.i
  mulw a1, a3, s11
  mul s0, t2, s11
  divu ra, ra, ra
  srlw t1, s10, s0
  add s3, s3, s0
  lui a4, 1048575
  slliw a2, a4, 24
  or t3, a2, t1
  fence.i
  sraw s0, t3, s0
  fence.i
  remw a7, a7, a4
  mulhsu t3, a4, a7
  mulw a1, s0, a7
  fence.i
  mulhu a5, s0, a1
  rem s3, a7, a1
  div s4, a5, a1
  fence.i
  rem s1, t4, a1
  divw tp, a1, s1
  addiw t3, s1, 0
  slliw sp, sp, 25
  div s5, tp, t3
  addw s7, t3, t3
  remw s1, s1, t3
  mulhu gp, t3, t3
  sraiw a4, sp, 8
  sltiu s8, s8, -1
  sd s3, 1856(t6)
  fence.i
  fence.i
  fence.i
  srli a3, s1, 63
  fence.i
  divuw tp, s1, s1
  divu a0, a1, s11
  srliw s4, tp, 31
  and a1, a0, a1
  srai a6, tp, 63
  remuw a5, a1, a6
  mul s5, a6, a1
  slliw a2, a2, 19
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
.word 0x2c0eaa6d, 0x898a58e3, 0x0c3ff45f, 0x86a4bd26, 0xa881470b, 0x9d2ff9a3, 0xd37009fc, 0x4893bcee
.section .mem_region, "aw", @progbits
.align 4
mem_region:
.word 0x256607c2, 0x2e0c3463, 0x3b8e95bc, 0xafeed606, 0x8ebd71e4, 0xa2e745be, 0x56360202, 0xc9d7be7c
.word 0x4519f306, 0x0644966b, 0x3821d395, 0x0a6af4fd, 0x10cd3d6c, 0x3f1c6095, 0x82b074a4, 0xa219c3d8
.word 0xcf9eb562, 0xc85eb3e9, 0x5012b081, 0x5784431a, 0x521de76c, 0x9c8800cc, 0x9d8bc727, 0x6c0f00ce
.word 0x00344312, 0x84044c67, 0x9ffdb125, 0x26147c4b, 0x8ae2634b, 0xbac4dda4, 0xbda1d2ce, 0xd2650eac
.word 0xb69929ff, 0x9e57bf84, 0x175a376c, 0x0103e127, 0xb97fdb42, 0xa2c88faf, 0xea820272, 0xb4898e24
.word 0xe9c3c762, 0x345462ee, 0xe31b57ca, 0x08e59eb2, 0x76068892, 0xe961e04b, 0x56b2288c, 0xee83f070
.word 0x9daf5c23, 0xf095a45e, 0x7f0d2620, 0xe88047ca, 0x694ce2d3, 0xaff0e302, 0x755c3ae4, 0xdba5c32a
.word 0x633def9b, 0x47a80290, 0x94448d30, 0xbb820cae, 0xbd38e700, 0xb1349ac1, 0xd24a73b4, 0xa165e9af
.word 0x5cb97726, 0x060d1796, 0x793afd10, 0x1fa99e52, 0xd3edad24, 0x4a986b8f, 0xa61ac9dd, 0xfedc7276
.word 0xffe0e41e, 0xf4b1a0d3, 0xe5eb73f1, 0x394101fc, 0xb494bb80, 0x26dbde03, 0x5eb08df4, 0x5b75aaf5
.word 0x4bf8bf5e, 0x2307e5ae, 0x3b99837d, 0xf1b65ad6, 0x3805f92a, 0xe7c3da9c, 0xd1dbdf2a, 0xaa820dea
.word 0x98e9e197, 0x1cd12612, 0xfffe6b98, 0xc12de1dd, 0xb3b7eeb4, 0x5e4963dd, 0x4f9f70dc, 0x36f1c05f
.word 0x69d934e1, 0x3e78f411, 0x2f99c71d, 0xcc669108, 0x2a53c657, 0xe8ebb161, 0x649e9515, 0x3ef35a4b
.word 0xe533d4f1, 0x7830c73f, 0xbe7f7bf0, 0x3e1ff4b8, 0x9069313b, 0x75b80b5f, 0x5a48da83, 0xa4f47674
.word 0x27eb1429, 0x5e814b1a, 0xce460688, 0x51e4b0db, 0x3b464613, 0xccaed4df, 0x0078593c, 0x315515f8
.word 0x2b5abcec, 0x2ba3a280, 0xc7b1896c, 0x983c3408, 0x5831c8b8, 0xbd88ef83, 0x02bc6524, 0x5a075ecc
.word 0xb40a5ea1, 0x630f5b4b, 0xf7f2e853, 0x7e92b872, 0xdede027d, 0xb1723dbf, 0xbb05e572, 0x2c21b193
.word 0xfcff54e1, 0xe6637bf4, 0xb8a82bbd, 0xf7dd26d1, 0x5ce73e09, 0xa4a3a0a1, 0x624c7fe0, 0x8e6ddd5d
.word 0x240f0cf1, 0xaa7d15d9, 0xb7378e1e, 0x11d0dc1e, 0x0ac6fba1, 0x7d05b178, 0x522a6cd6, 0xca6110b0
.word 0xdbdaad98, 0xb20a2c97, 0x354aadc7, 0xc5ce2ad9, 0xef1e27b3, 0x74ba8c7a, 0xa2b00fd8, 0x06d623bc
.word 0xa391b91d, 0x6cec4ca8, 0x957663d6, 0x449e1ee0, 0x96cf517a, 0x9bb93b64, 0xc293bbcd, 0xc65852d0
.word 0xd4db17fb, 0x036e0f86, 0x24affad2, 0xcdc90d6b, 0xff75f249, 0x4cee7a84, 0x4e4aa401, 0x23f3541d
.word 0x5e287f19, 0x5006045b, 0xc0625104, 0x36454cf0, 0x44c102d5, 0x4a61bdc0, 0xfd5e1df0, 0xb138593a
.word 0x8abf0b18, 0x454333b5, 0x0a253771, 0x904e83d0, 0xe98fb211, 0x76d90470, 0x29739635, 0x653cd24e
.word 0xecb24dab, 0x1396b41c, 0xc7cac74c, 0xb997b686, 0xfb412e07, 0x6b68d844, 0xe3596ec8, 0x034ba744
.word 0x7d5ed94d, 0xe259eb47, 0x073a3d5c, 0x2c38056b, 0xd1c127b6, 0x0db35c79, 0x3fec3f8d, 0x1591cc44
.word 0xf9baa62d, 0xd50fa82d, 0xbd6cd10f, 0xda3058a0, 0x58f2908b, 0x1774ae27, 0xbadd0e97, 0x43d865df
.word 0x28312161, 0x21971d3a, 0x598499a5, 0x07776964, 0xfa6aea9c, 0x70e0c2c4, 0x33f1397c, 0x5d698d33
.word 0xce298e1e, 0xb19b07e3, 0xcf4fa714, 0x82ca96ed, 0xcc325e9f, 0x4e8fe746, 0x00f0be61, 0x9693305c
.word 0x3f1a4dbf, 0x4532035e, 0xa754988c, 0x47603449, 0xfd32d016, 0xf45f1210, 0xd1be6211, 0xaef8f89f
.word 0xd7b0e2ae, 0x0c3db663, 0xb576f2c2, 0xe95b8087, 0xf1a92ef7, 0x2727825e, 0x2e67d626, 0x9af6928b
.word 0x088d0518, 0x3bbba19b, 0x2b230f47, 0xca0d138c, 0x009c4dcd, 0x1d04b825, 0x761fa82e, 0x6a901182
.zero 7168
mem_region_end:
