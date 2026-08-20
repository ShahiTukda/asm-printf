.intel_syntax noprefix
.global itoa
itoa:
push rbx
xor rbx, rbx
xor r11, r11
xor r10, r10
xor rdx, rdx
mov rcx, 10
mov rax, rdi
cmp rdi, 0
jl negprep1
jmp loop1
loop1:
div rcx
add rdx, 0x30
push rdx
inc r11
xor rdx, rdx
cmp rax, 0
je loop2
jmp loop1
loop2:
cmp r10, r11
je done
pop rdx
mov [rsi+r10], dl
inc r10
jmp loop2
done:
pop rbx
mov rax, r11
ret
negprep1:
neg rax
jmp negloop1
negloop1:
div rcx
add rdx, 0x30
push rdx
inc r11
xor rdx, rdx
cmp rax, 0
je negprep2
jmp negloop1
negprep2:
mov rbx, 0x2d
mov [rsi], bl
inc rsi
jmp negloop2
negloop2:
cmp r10, r11
je negdone
pop rdx
mov [rsi+r10], dl
inc r10
jmp negloop2
negdone:
pop rbx
inc r11
mov rax, r11
ret
