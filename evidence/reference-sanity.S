.section .text
.globl _start
_start:
    li t0, 40
    addi t0, t0, 2
    li t2, 42
    bne t0, t2, fail
    li t0, 1
    j finish
fail:
    li t0, 3
finish:
    la t1, tohost
    sd t0, 0(t1)
1:  j 1b
.section .tohost,"aw",@progbits
.balign 64
.globl tohost
tohost: .dword 0
.balign 64
.globl fromhost
fromhost: .dword 0
