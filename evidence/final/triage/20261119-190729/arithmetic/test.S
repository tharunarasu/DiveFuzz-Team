.option norvc
.section .text
.globl _start
_start:
  la t0, handler
  csrw mtvec, t0
  li t0, 40
addi t0, t0, 2
li t1, 42
bne t0, t1, fail
j success
.balign 4
handler:
  csrr t0, mcause
  li t1, 0
  bne t0, t1, fail
success:
  li t1, 1
  la t0, tohost
  sd t1, 0(t0)
  .word 0x0000006b
fail:
  li t1, 3
  la t0, tohost
  sd t1, 0(t0)
  li x1, 1
  .word 0x0000806b
.section .tohost,"aw",@progbits
.balign 64
.globl tohost
tohost: .dword 0
.balign 64
.globl fromhost
fromhost: .dword 0
