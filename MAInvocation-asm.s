
.globl _MAInvocationCall
_MAInvocationCall:

// Save and set up frame pointer
pushq %rbp
movq %rsp, %rbp

// Save r12-r15 so we can use them
pushq %r12
pushq %r13
pushq %r14
pushq %r15

// Move the struct RawArguments into r12 so we can mess with rdi
mov %rdi, %r12

// Save the current stack pointer to r15 before messing with it
mov %rsp, %r15

// Copy stack arguments to the stack

// Put the number of arguments into r10
movq 56(%r12), %r10

// Put the amount of stack space needed into r11 (# args << 3)
movq %r10, %r11
shlq $3, %r11

// Put the stack argument pointer into r13
movq 64(%r12), %r13

// Move the stack down
subq %r11, %rsp

// Align the stack
andq $-0x10, %rsp

// Track the current argument number, start at 0
movq $0, %r14

// Copy loop
stackargs_loop:

// Stop the loop when r14 == r10 (current offset equals stack space needed
cmpq %r14, %r10
je done

// Copy the current argument (r13[r14]) to the current stack slot
movq 0(%r13, %r14, 8), %rdi
movq %rdi, 0(%rsp, %r14, 8)

// Increment the current argument number
inc %r14

// Back to the top of the loop
jmp stackargs_loop

done:

// Copy registers over
movq 8(%r12), %rdi
movq 16(%r12), %rsi
movq 24(%r12), %rdx
movq 32(%r12), %rcx
movq 40(%r12), %r8
movq 48(%r12), %r9

// Call the function pointer
callq *(%r12)

// Copy the result register into the args struct
movq %rax, 72(%r12)

// Restore the stack pointer
mov %r15, %rsp

// Restore r12-15 for the caller
popq %r15
popq %r14
popq %r13
popq %r12

// Restore the frame pointer and return
leave
ret
