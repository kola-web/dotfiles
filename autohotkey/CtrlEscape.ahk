#Requires AutoHotkey v2
InstallKeybdHook(true)
g_DoNotAbortSendEsc := true

$*LControl::{
  global g_DoNotAbortSendEsc
  g_DoNotAbortSendEsc := true
  Send("{LControl Down}")
  KeyWait("LControl")
  Send("{LControl Up}")
  if (A_PriorKey == "LControl" && g_DoNotAbortSendEsc) {
    Send("{Esc}")
  }
  return
}


; capture any key with Ctrl key down
~^*a:: ; * means can be used with any modifier key, ~ means donot block the original key, ^ means Ctrl key, a means the key is a
~^*b::
~^*c::
~^*d::
~^*e::
~^*f::
~^*g::
~^*h::
~^*i::
~^*j::
~^*k::
~^*l::
~^*m::
~^*n::
~^*o::
~^*p::
~^*q::
~^*r::
~^*s::
~^*t::
~^*u::
~^*v::
~^*w::
~^*x::
~^*y::
~^*z::
~^*1::
~^*2::
~^*3::
~^*4::
~^*5::
~^*6::
~^*7::
~^*8::
~^*9::
~^*0::
~^*Space::
~^*Backspace::
~^*Delete::
~^*Insert::
~^*Home::
~^*End::
~^*PgUp::
~^*PgDn::
~^*Tab::
~^*Enter::
~^*,::
~^*.::
~^*/::
~^*;::
~^*'::
~^*[::
~^*]::
~^*\::
~^*-::
~^*=::
~^*`::
~^*F1::
~^*F2::
~^*F3::
~^*F4::
~^*F5::
~^*F6::
~^*F7::
~^*F8::
~^*F9::
~^*F10::
~^*F11::
~^*F12::{
  global g_DoNotAbortSendEsc
  g_DoNotAbortSendEsc := false
}
