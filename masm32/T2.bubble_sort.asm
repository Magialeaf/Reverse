;会异常
include io32.inc
.data
array dword 587,-632,777,234,-34
count = lengthof array

.code
start:
    mov ecx,count
    dec ecx
outlp:
    mov edx,ecx
    mov ebx,offset array
inlp:
    mov eax,[ebx]
    cmp eax,[ebx+4]
    jng next

    xchg eax,[ebx+4]
    mov [ebx],eax
next:
    add ebx,4
    dec edx
    jnz inlp
    loop outlp
end start