.686
.model flat,stdcall
option casemap:none
includelib ..\lib\kernel32.lib
includelib ..\lib\user32.lib
ExitProcess proto,:dword
MessageBoxA proto,:dword,:dword,:dword,:dword
MessageBox equ <MessageBoxA>

SYSTEMTIME struct
    wYear dword ?
    wMonth dword ?
    wDayOfWeek dword ?
    wDay dword ?
    wHour dword ?
    wMinute dword ?
    wSecond dword ?
    wMillisconds dword ?
SYSTEMTIME endp

GetLocalTime proto,:dword
writedec marco time
    mov ax,time
    mov cl,10
    div cl
    add ax,3030H
    mov [ebx],ax
    endm

.data
mytime SYSTEMTIME<>
timestring byte '--:--:--',0
timecaption byte 'Now Time',0

.code
start:
    invoke GetLocalTime,addr mytime
    mov ebx,offset timestring
    writedec mytime.wHour
    add ebx,3
    writedec mytime.wMinute
    add ebx,3
    writedec mytime.wSecond
    add ebx,3
    invoke MessageBox,0,addr timestring,addr timecaption,1
    invoke ExitProcess,0
end start