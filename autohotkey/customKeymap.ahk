#Requires Autohotkey v2.0
#SingleInstance Force ; The script will Reload if launched while already running
KeyHistory(0) ; Ensures user privacy when debugging is not needed
SetWorkingDir(A_ScriptDir)  ; Ensures a consistent starting directory
SendMode("Input")  ; Recommended for new scripts due to its superior speed and reliability

; 截图
#+s:: {
    global
    Run("Snipaste.exe snip")
    return
}
; 剪切板历史
#v:: {
    global
    Run("`"C:\Program Files\Ditto\Ditto.exe`"  /Open")
    return
}

; Win + Enter
#Enter:: {
    global
    Run("wt.exe")
    return
}

^n:: {
    global
    Send("{Down}")
    return
}

^p:: {
    global
    Send("{Up}")
    return
}

; CapsLock::Escape

$Ctrl:: {
    global
    Send("{Escape}")
    return
}

; $CapsLock:: {
;     global
;     Send("{Escape}")
;     return
; }
