include io32.inc
.data
regd byte 'EAX=',8 dup(0),'H',0
.code
start:
    mov eax,11223344
    xor ebx,ebx
    mov ecx,8
again:
    rol eax,4
    push eax
    call htoasc
    mov regd+4[ebx],al
    pop eax
    inc ebx
    loop again
    mov eax,offset regd
    call dispmsg
htoasc proc
    and EAX,0fH
    MOV AL,ASCII[EAX]
    RET
ASCII BYTE '0123456789ABCDEF'
htoasc endp
end start