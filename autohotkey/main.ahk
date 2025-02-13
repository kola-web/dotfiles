#Requires AutoHotkey v1.1.33+
#SingleInstance Force ; The script will Reload if launched while already running
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases
#KeyHistory 0 ; Ensures user privacy when debugging is not needed
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability

if not A_IsAdmin
  Run *RunAs "%A_ScriptFullPath%" ; (A_AhkPath is usually optional if the script has the .ahk extension.) You would typically check  first.

EnvGet, userDir, USERPROFILE  ; 获取用户目录
scripts := []  ; 创建一个空数组

; 将脚本路径添加到数组中
scripts.Push(userDir . "\dotfiles\autohotkey\desktop.ahk")
scripts.Push(userDir . "\dotfiles\autohotkey\customKeymap.ahk")
; scripts.Push(userDir . "\dotfiles\autohotkey\CtrlEscape.ahk")

; 遍历脚本路径数组并运行每个脚本
for index, scriptPath in scripts {
  Run, % scriptPath, , Hide
}
