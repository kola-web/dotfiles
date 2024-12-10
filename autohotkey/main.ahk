#Requires AutoHotkey v1.1.33+
#SingleInstance Force ; The script will Reload if launched while already running
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases
#KeyHistory 0 ; Ensures user privacy when debugging is not needed
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability

if not A_IsAdmin
	Run *RunAs "%A_ScriptFullPath%" ; (A_AhkPath is usually optional if the script has the .ahk extension.) You would typically check  first.

Run, C:\Users\kola\dotfiles\autohotkey\desktop.ahk,, Hide
Run, C:\Users\kola\dotfiles\autohotkey\CtrlEscape.ahk,, Hide
Run, C:\Users\kola\dotfiles\autohotkey\customKeymap.ahk,, Hide
