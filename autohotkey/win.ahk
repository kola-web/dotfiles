#Requires AutoHotkey v2.0
#SingleInstance Force

LWin:: {
    Send "{LWin Down}"
}

LWin Up:: {
     Send "{Blind}{vkE8}{LWin Up}"
}
