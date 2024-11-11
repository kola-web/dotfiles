g_LastCtrlKeyDownTime := 0
g_AbortSendEsc := false
g_ControlRepeatDetected := false

; 按下 Ctrl 时触发
*Ctrl::
    if (g_ControlRepeatDetected)  ; 如果已经检测到 Ctrl 重复按下
        return

    send, {Ctrl down}  ; 发送 Ctrl 按下
    g_LastCtrlKeyDownTime := A_TickCount
    g_AbortSendEsc := false
    g_ControlRepeatDetected := true
    return

; 松开 Ctrl 时触发
*Ctrl Up::
    send, {Ctrl up}  ; 发送 Ctrl 释放
    g_ControlRepeatDetected := false

    if (g_AbortSendEsc)
        return

    time_elapsed := A_TickCount - g_LastCtrlKeyDownTime
    if (time_elapsed <= 250)  ; 如果按下时间小于等于 250 毫秒
        SendInput {Esc}
    return

; 检测所有 Ctrl + 键组合，避免发送 Esc
~*^::g_AbortSendEsc := true

~LWin::Send {Blind}{vkE8}
#1::Send {Blind}{LWin Down}1{LWin Up}{Esc}
;#s::Send, {LWin}

#+s::
    Run, Snipaste.exe snip
return
