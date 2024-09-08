#SingleInstance

;;;;;;;;;;;! Key Bindings ;;;;;;;;;;;
;;;;? Glaze WM ;;;;
;; Rebinding Workspaces to Win + Num

; 禁止单独按下 Windows 键，但允许 Win + 其他键
;#If (GetKeyState("LWin", "P") or GetKeyState("RWin", "P"))
;{
;    LWin Up::Return
;    RWin Up::Return
;}
;#If

#1::Send #!1
#2::Send #!2
#3::Send #!3
#4::Send #!4
#5::Send #!5
#6::Send #!6
#7::Send #!7
#8::Send #!8
#9::Send #!9

;; Rebinding Moving Windows to Win + Shfit + Num
#+1::Send #!+1
#+2::Send #!+2
#+3::Send #!+3
#+4::Send #!+4
#+5::Send #!+5
#+6::Send #!+6
#+7::Send #!+7
#+8::Send #!+8
#+9::Send #!+9

#[::Send #![
#]::Send #!]

