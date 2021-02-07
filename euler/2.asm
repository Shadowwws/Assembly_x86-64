%define SYS_EXIT 60
%define SYS_WRITE 1
%define STDOUT 1
%define SYS_READ 0
%define SYS_OPEN 2
%define SYS_CLOSE 3
%define STDIN 0

section .text
global _start
_start:

	xor rcx, rcx
	mov r11, 2
	mov r8, 1
	mov r9, 1
	xor r10, r10

_solv:
	
	mov rdx, 0
	mov r10, r8
	add r10, r9
	mov r8, r9
	mov r9, r10
	mov rax, r10
	div r11
	cmp rdx, 0
	jne .check
	add rcx, r10

 .check:
 	cmp r10, 4000000
 	jae _itoa
 	jmp _solv

; Following part from Alicja Piecha, just to print the result, pretty fast and independant from the challenge.
_itoa:
	mov rbp, rsp
	mov r10, 10
	sub rsp, 22
	                   
	mov byte [rbp-1], 10  
	lea r12, [rbp-2]
	; r12: string pointer
	mov rax, rcx

 .loop:
	xor edx, edx
	div r10
	add rdx, 48
	mov [r12], dl
	dec r12
	cmp r12, rsp
	jne .loop

	mov r9, rsp
	mov r11, 22
 .trim:
	inc r9
	dec r11
	cmp byte [r9], 48
	je .trim

	mov rax, 1
	mov rdi, 1
	mov rsi, r9
	mov rdx, r11
	syscall

	mov rax, 60
	mov rdi, 0
	syscall
	
