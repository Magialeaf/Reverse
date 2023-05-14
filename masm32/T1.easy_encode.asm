include io32.inc
;data
.data
key    byte 234    ;this is a key
bufnum = 255
buffer byte bufnum+1 dup(0)  ;Define the buffer required for keyboard input
msg1   byte 'Enter message:',0
msg2   byte 'Encrypted message:',0
msg3   byte 13,10,'Original message:',0

;code
.code
start:
    mov eax,offset msg1
    call dispmsg
    mov eax,offset buffer
    call readmsg
    push eax
    mov ecx,eax
    xor ebx,ebx     ;ebx指向输入字符(清空自己)
    mov al,key
encrypt:
    xor buffer[ebx],al
    inc ebx
    dec ecx
    jnz encrypt         ;loop encrypt
    mov eax,offset msg2
    call dispmsg
    mov eax,offset buffer
    call dispmsg
    ;
    pop ecx
    xor ebx,ebx
    mov al,key
decrypt:
    xor buffer[ebx],al
    inc ebx
    dec ecx
    jnz decrypt         ;loop decrypt
    mov eax,offset msg3
    call dispmsg
    mov eax,offset buffer
    call dispmsg

end start