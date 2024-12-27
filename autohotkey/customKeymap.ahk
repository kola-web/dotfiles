#Requires Autohotkey v2.0
#SingleInstance Force ; The script will Reload if launched while already running
; V1toV2: Removed #NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases
KeyHistory(0) ; Ensures user privacy when debugging is not needed
SetWorkingDir(A_ScriptDir)  ; Ensures a consistent starting directory
SendMode("Input")  ; Recommended for new scripts due to its superior speed and reliability


#+s:: ; 截图
{ ; V1toV2: Added bracket
global ; V1toV2: Made function global
    Run("Snipaste.exe snip")
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

#Enter::  ; Win + Enter
{ ; V1toV2: Added bracket
global ; V1toV2: Made function global
    Run("wt.exe")
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

CapsLock::Esc

