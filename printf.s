.intel_syntax noprefix
.global _start

_start:

xor r13, 13
lea r12, [rsp+24]
mov rbx, 0x0a
mov rsi, [rsp+16]
cmp byte ptr [rsi], 0
je exit
jmp loop

loop:

mov al, byte ptr [rsi]
cmp al, 0
je exit
cmp al, 0x5c
je slash
cmp al, 0x25
je percent
mov rdi, 1
mov rdx, 1
mov rax, 1
syscall
inc rsi
jmp loop

exit:

mov rdi, 0
mov rax, 60
syscall

percent:

inc rsi
cmp byte ptr [rsi], al
je doublepercent
cmp byte ptr [rsi], 0x64
je decimal
cmp byte ptr [rsi], 0x73
je string
dec rsi
mov rdi, 1
mov rdx, 1
mov rax, 1
syscall
inc rsi
jmp loop
doublepercent:
mov rdi, 1
mov rdx, 1
mov rax, 1
syscall
inc rsi
jmp loop

slash:

inc rsi
cmp byte ptr [rsi], 0x6e
je newline
cmp byte ptr [rsi], 0x78
je hexesc
mov rdi, 1
mov rdx, 1
mov rax, 1
syscall
inc rsi
jmp loop

newline:

dec rsi
push rsi
push rbx
mov rdi, 1
mov rsi, rsp
mov rdx, 1
mov rax, 1
syscall
pop rbx
pop rsi
add rsi, 2
jmp loop

decimal:

add r13, 1
inc rsi
push rsi
mov rdi, [r12]
add r12, 8
call atoi
sub rsp, 0x80
mov rsi, rsp
mov rdi, rax
call itoa
mov rdi, 1
mov rsi, rsp
mov rdx, rax
mov rax, 1
syscall
add rsp, 0x80
pop rsi
cmp byte ptr [rsi], 0
je exit
jmp loop

string:

inc rsi
push rsi
mov rsi, [r12]
add r12, 8
xor rdx, rdx
jmp strlen
strlen:
cmp byte ptr [rsi+rdx], 0
je printstr
inc rdx
jmp strlen
printstr:
mov rdi, 1
mov rax, 1
syscall
pop rsi
cmp byte ptr [rsi], 0
je exit
jmp loop

hexesc:

mov rcx, 2
inc rsi
jmp checkloop
checkloop:
mov al, byte ptr [rsi]
cmp al, '9'
jle digit
cmp al, 'Z'
jle uppercase
cmp al, 'z'
jle lowercase
digit:
sub al, 0x30
jmp hexdone
uppercase:
sub al, 0x37
jmp hexdone
lowercase:
sub al, 0x57
jmp hexdone
hexdone:
shl r13b, 4
or r13b, al
inc rsi
dec rcx
jnz checkloop
push rsi
push r13
mov rdi, 1
mov rsi, rsp
mov rdx, 1
mov rax, 1
syscall
pop r13
pop rsi
jmp loop
