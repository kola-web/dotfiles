#Requires AutoHotkey v1.1.33+
#SingleInstance Force ; The script will Reload if launched while already running
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases
#KeyHistory 0 ; Ensures user privacy when debugging is not needed
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability

; 1. Win+Shift+S 映射为 PrintScreen
$#+s::
Send {PrintScreen}
return

; 2. 针对 raycast 窗口
#IfWinActive ahk_exe raycast.exe
^n::Send {Down}
^p::Send {Up}
#IfWinActive

; 3. Pause键映射为媒体播放暂停
Pause::Send {Media_Play_Pause}
