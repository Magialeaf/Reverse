.686
.model flat,stdcall
option casemap:none
include ..\include\windows.inc
include ..\include\\kernel32.inc
include ..\include\user32.inc
includelib ..\lib\kernel32.lib
includelib ..\lib\user32.lib
WinMain proto :dword,:dword,:dword,:dword

.data
ClassName byte 'SimpleWinClass',0
AppName byte 'Win32 Example',0
hInstance dword ?
CommandLine dword ?

.code
start:
    invoke GetModuleHandle,NULL
    mov hInstance,eax
    invoke GetCommandLine
    mov CommandLine,eax
    invoke WinMain,hInstance,NULL,CommandLine,SW_SHOWDEFAULT
    invoke ExitProcess,eax

WinMain proc hInst:dword,hPrevInst:dword,CmdLine:dword,CmdShow:dword
    local wc:WNDCLASSEX
    local msg:MSG
    local hwnd:dword
    mov wc.cbSize,sizeof WNDCLASSEX
    mov wc.style,CS_HREDRAW or CS_VREDRAW
    mov wc.lpfnWndProc,offset WndProc
    mov wc.cbClsExtra,NULL
    mov wc.cbWndExtra,NULL
    push hInstance
    pop wc.hInstance
    mov wc.hbrBackground,COLOR_WINDOW+1
    mov wc.lpszMenuName,NULL
    mov wc.lpszClassName,offset ClassName
    invoke LoadIcon,NULL,IDI_APPLICATION
    mov wc.hIcon,eax
    mov wc.hIconSm,eax
    invoke LoadCursor,NULL,IDC_ARROW
    mov wc.hCursor,eax
    invoke RegisterClassEx,addr wc
    invoke CreateWindowEx,NULL,addr ClassName,addr AppName,\
    WS_OVERLAPPEDWINDOW,CW_USEDEFAULT,CW_USEDEFAULT,\
    CW_USEDEFAULT,CW_USEDEFAULT,NULL,NULL,hInst,NULL
    mov hwnd,eax
    invoke ShowWindow,hwnd,SW_SHOWDEFAULT
    invoke UpdateWindow,hwnd
    .WHILE TRUE
        invoke GetMessage,addr msg,NULL,0,0
    .BREAK .IF(! eax)
        invoke TranslateMessage,addr msg
        invoke DispatchMessage,addr msg
    .ENDW
    mov eax,msg.wParam
    ret
WinMain endp

WndProc proc hWnd:dword,uMsg:dword,wParam:dword,lParam:dword
    .IF uMsg == WM_DESTROY
        invoke PostQuitMessage,NULL
    .ELSE
        invoke DefWindowProc,hWnd,uMsg,wParam,lParam
        ret
    .ENDIF
    xor eax,eax
    ret
WndProc endp
end start