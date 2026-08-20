.intel_syntax noprefix
.global atoi
atoi:
mov rcx, 0
mov rax, 0
push rbx
mov rbx, 0
cmp byte ptr [rdi], 0x2d
je rcxinc1
jmp loop
loop:
imul rax, 10
movzx rbx, byte ptr [rdi+rcx]
add rax, rbx
cmp byte ptr [rdi+rcx], 0x39
ja done
cmp byte ptr [rdi+rcx], 0x30
jb done
sub rax, 0x30
inc rcx
cmp byte ptr [rdi+rcx], 0x39
ja done
cmp byte ptr [rdi+rcx], 0x30
jb done
jmp loop
done:
pop rbx
ret
rcxinc1:
inc rcx
jmp negloop
negloop:
imul rax, 10
movzx rbx, byte ptr [rdi+rcx]
add rax, rbx
cmp byte ptr [rdi+rcx], 0x39
ja negdone
cmp byte ptr [rdi+rcx], 0x30
jb negdone
sub rax, 0x30
inc rcx
cmp byte ptr [rdi+rcx], 0x39
ja negdone
cmp byte ptr [rdi+rcx], 0x30
jb negdone
jmp negloop
negdone:
neg rax
pop rbx
ret
