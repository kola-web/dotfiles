#Requires AutoHotkey v1.1.33+
#SingleInstance Force ; The script will Reload if launched while already running
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases
#KeyHistory 0 ; Ensures user privacy when debugging is not needed
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability


#+s:: ; 截图
    Run, Snipaste.exe snip
return

#Enter::  ; Win + Enter
    Run, wt.exe
return

; CapsLock::Esc
