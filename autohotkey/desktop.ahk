#Requires AutoHotkey v1.1.33+
#SingleInstance Force ; The script will Reload if launched while already running
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases
#KeyHistory 0 ; Ensures user privacy when debugging is not needed
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability

; Globals
DesktopCount := 2        ; Windows starts with 2 desktops at boot
CurrentDesktop := 1      ; Desktop count is 1-indexed (Microsoft numbers them this way)
LastOpenedDesktop := 1

; DLL
hVirtualDesktopAccessor := DllCall("LoadLibrary", "Str", A_ScriptDir . "\dll\VirtualDesktopAccessor.dll", "Ptr")
global IsWindowOnDesktopNumberProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "IsWindowOnDesktopNumber", "Ptr")
global MoveWindowToDesktopNumberProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "MoveWindowToDesktopNumber", "Ptr")
global GoToDesktopNumberProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "GoToDesktopNumber", "Ptr")

; Main
SetKeyDelay, 75
mapDesktopsFromRegistry()
OutputDebug, [loading] desktops: %DesktopCount% current: %CurrentDesktop%

return

;
; This function examines the registry to build an accurate list of the current virtual desktops and which one we're currently on.
; List of desktops appears to be in HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops
; On Windows 11 the current desktop UUID appears to be in the same location
; On previous versions in HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo\1\VirtualDesktops
;
mapDesktopsFromRegistry()
{
    global CurrentDesktop, DesktopCount

    ; Get the current desktop UUID. Length should be 32 always, but there's no guarantee this couldn't change in a later Windows release so we check.
    IdLength := 32
    SessionId := getSessionId()
    if (SessionId) {
        RegRead, CurrentDesktopId, HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops, CurrentVirtualDesktop
        if ErrorLevel {
            RegRead, CurrentDesktopId, HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo\%SessionId%\VirtualDesktops, CurrentVirtualDesktop
        }

        if (CurrentDesktopId) {
            IdLength := StrLen(CurrentDesktopId)
        }
    }

    ; Get a list of the UUIDs for all virtual desktops on the system
    RegRead, DesktopList, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops, VirtualDesktopIDs
    if (DesktopList) {
        DesktopListLength := StrLen(DesktopList)
        ; Figure out how many virtual desktops there are
        DesktopCount := floor(DesktopListLength / IdLength)
    }
    else {
        DesktopCount := 1
    }

    ; Parse the REG_DATA string that stores the array of UUID's for virtual desktops in the registry.
    i := 0
    while (CurrentDesktopId and i < DesktopCount) {
        StartPos := (i * IdLength) + 1
        DesktopIter := SubStr(DesktopList, StartPos, IdLength)
        OutputDebug, The iterator is pointing at %DesktopIter% and count is %i%.

        ; Break out if we find a match in the list. If we didn't find anything, keep the
        ; old guess and pray we're still correct :-D.
        if (DesktopIter = CurrentDesktopId) {
            CurrentDesktop := i + 1
            OutputDebug, Current desktop number is %CurrentDesktop% with an ID of %DesktopIter%.
            break
        }
        i++
    }
}

;
; This functions finds out ID of current session.
;
getSessionId()
{
    ProcessId := DllCall("GetCurrentProcessId", "UInt")
    if ErrorLevel {
        OutputDebug, Error getting current process id: %ErrorLevel%
        return
    }
    OutputDebug, Current Process Id: %ProcessId%

    DllCall("ProcessIdToSessionId", "UInt", ProcessId, "UInt*", SessionId)
    if ErrorLevel {
        OutputDebug, Error getting session id: %ErrorLevel%
        return
    }
    OutputDebug, Current Session Id: %SessionId%
    return SessionId
}

_switchDesktopToTarget(targetDesktop)
{
    ; Globals variables should have been updated via updateGlobalVariables() prior to entering this function
    global CurrentDesktop, DesktopCount, LastOpenedDesktop

    ; Don't attempt to switch to an invalid desktop
    if (targetDesktop > DesktopCount || targetDesktop < 1 || targetDesktop == CurrentDesktop) {
        OutputDebug, [invalid] target: %targetDesktop% current: %CurrentDesktop%
        return
    }

    LastOpenedDesktop := CurrentDesktop

    ; Focus the taskbar to ensure that the application icons are not flashing
    ; while switching desktops. Using SetForegroundWindow() instead of
    ; WinActivate() here, because WinActivate() introduces a noticeable delay
    ; in the interaction.
    taskbarHwnd := DllCall("FindWindow", "Str", "Shell_TrayWnd", "Ptr", 0, "UPtr")
    if (taskbarHwnd) {
        DllCall("SetForegroundWindow", "UPtr", taskbarHwnd)
    }

    DllCall(GoToDesktopNumberProc, Int, targetDesktop-1)
    focusTheForemostWindow(targetDesktop)
}

updateGlobalVariables()
{
    ; Re-generate the list of desktops and where we fit in that. We do this because
    ; the user may have switched desktops via some other means than the script.
    mapDesktopsFromRegistry()
}

switchDesktopByNumber(targetDesktop)
{
    global CurrentDesktop, DesktopCount
    updateGlobalVariables()
    _switchDesktopToTarget(targetDesktop)
}

switchDesktopToLastOpened()
{
    global CurrentDesktop, DesktopCount, LastOpenedDesktop
    updateGlobalVariables()
    _switchDesktopToTarget(LastOpenedDesktop)
}

switchDesktopToRight()
{
    global CurrentDesktop, DesktopCount
    updateGlobalVariables()
    _switchDesktopToTarget(CurrentDesktop == DesktopCount ? 1 : CurrentDesktop + 1)
}

switchDesktopToLeft()
{
    global CurrentDesktop, DesktopCount
    updateGlobalVariables()
    _switchDesktopToTarget(CurrentDesktop == 1 ? DesktopCount : CurrentDesktop - 1)
}

focusTheForemostWindow(targetDesktop) {
    foremostWindowId := getForemostWindowIdOnDesktop(targetDesktop)
    if isWindowNonMinimized(foremostWindowId) {
        DllCall("SetForegroundWindow", "UPtr", foremostWindowId)
    }
}

isWindowNonMinimized(windowId) {
    WinGet MMX, MinMax, ahk_id %windowId%
    return MMX != -1
}

getForemostWindowIdOnDesktop(n)
{
    n := n - 1 ; Desktops start at 0, while in script it's 1

    ; winIDList contains a list of windows IDs ordered from the top to the bottom for each desktop.
    WinGet winIDList, list
    Loop % winIDList {
        windowID := % winIDList%A_Index%
        windowIsOnDesktop := DllCall(IsWindowOnDesktopNumberProc, UInt, windowID, UInt, n)
        ; Select the first (and foremost) window which is in the specified desktop.
        if (windowIsOnDesktop == 1) {
            return windowID
        }
    }
}

MoveCurrentWindowToDesktop(desktopNumber) {
    WinGet, activeHwnd, ID, A
    DllCall(MoveWindowToDesktopNumberProc, UInt, activeHwnd, UInt, desktopNumber - 1)
    switchDesktopByNumber(desktopNumber)
}

MoveCurrentWindowToRightDesktop()
{
    global CurrentDesktop, DesktopCount
    updateGlobalVariables()
    WinGet, activeHwnd, ID, A
    DllCall(MoveWindowToDesktopNumberProc, UInt, activeHwnd, UInt, (CurrentDesktop == DesktopCount ? 1 : CurrentDesktop + 1) - 1)
    _switchDesktopToTarget(CurrentDesktop == DesktopCount ? 1 : CurrentDesktop + 1)
}

MoveCurrentWindowToLeftDesktop()
{
    global CurrentDesktop, DesktopCount
    updateGlobalVariables()
    WinGet, activeHwnd, ID, A
    DllCall(MoveWindowToDesktopNumberProc, UInt, activeHwnd, UInt, (CurrentDesktop == 1 ? DesktopCount : CurrentDesktop - 1) - 1)
    _switchDesktopToTarget(CurrentDesktop == 1 ? DesktopCount : CurrentDesktop - 1)
}

;
; This function creates a new virtual desktop and switches to it
;
createVirtualDesktop()
{
    global CurrentDesktop, DesktopCount
    Send, #^d
    DesktopCount++
    CurrentDesktop := DesktopCount
    OutputDebug, [create] desktops: %DesktopCount% current: %CurrentDesktop%
}

;
; This function deletes the current virtual desktop
;
deleteVirtualDesktop()
{
    global CurrentDesktop, DesktopCount, LastOpenedDesktop
    Send, #^{F4}
    if (LastOpenedDesktop >= CurrentDesktop) {
        LastOpenedDesktop--
    }
    DesktopCount--
    CurrentDesktop--
    OutputDebug, [delete] desktops: %DesktopCount% current: %CurrentDesktop%
}

; 聚焦到指定窗口
#1:: switchDesktopByNumber(1)
#2:: switchDesktopByNumber(2)
#3:: switchDesktopByNumber(3)
#4:: switchDesktopByNumber(4)
#5:: switchDesktopByNumber(5)
#6:: switchDesktopByNumber(6)
#7:: switchDesktopByNumber(7)
#8:: switchDesktopByNumber(8)
#9:: switchDesktopByNumber(9)


; 移动窗口到指定窗口
#+1::MoveCurrentWindowToDesktop(1)
#+2::MoveCurrentWindowToDesktop(2)
#+3::MoveCurrentWindowToDesktop(3)
#+4::MoveCurrentWindowToDesktop(4)
#+5::MoveCurrentWindowToDesktop(5)
#+6::MoveCurrentWindowToDesktop(6)
#+7::MoveCurrentWindowToDesktop(7)
#+8::MoveCurrentWindowToDesktop(8)
#+9::MoveCurrentWindowToDesktop(9)

; ========== Window Cycling (Win+J/K) ==========
global cycleWindowIDs := []   ; frozen window order for the current cycle session
global cyclePos := 0          ; 0-based index of the window we last showed
global cycleTick := 0

#k:: CycleWindow(1)   ; Next (toward less recently used)
#j:: CycleWindow(-1)  ; Previous (toward more recently used)

CycleWindow(direction) {
    global CurrentDesktop, cycleWindowIDs, cyclePos, cycleTick

    updateGlobalVariables()
    now := A_TickCount

    ; Fresh snapshot of the windows on the current desktop, z-order
    ; (foremost / most-recently-used first).
    WinGet winIDList, list
    fresh := []
    Loop % winIDList {
        windowID := % winIDList%A_Index%
        windowIsOnDesktop := DllCall(IsWindowOnDesktopNumberProc, UInt, windowID, UInt, CurrentDesktop - 1)
        if (windowIsOnDesktop == 1) {
            WinGetTitle title, ahk_id %windowID%
            if (title != "")
                fresh.Push(windowID)
        }
    }

    if (fresh.Length() <= 1)
        return

    ; Decide whether to start a NEW cycle session (freeze a fresh order) or
    ; keep continuing the current one.
    ;
    ; The order MUST stay frozen across consecutive presses. If it were rebuilt
    ; every press, the window we just activated would jump to the front of the
    ; list, and advancing "front -> second" would only ping-pong between the two
    ; most-recent windows -- every other window (a third window, or both windows
    ; of the same app alongside another app) would never be reached.
    newSession := (now - cycleTick > 2000) || (cycleWindowIDs.Length() != fresh.Length()) || (cyclePos >= cycleWindowIDs.Length()) || (cycleWindowIDs.Length() == 0)

    ; Restart if the window we are positioned on disappeared.
    if (!newSession) {
        curTarget := cycleWindowIDs[cyclePos + 1]
        if !WinExist("ahk_id " . curTarget)
            newSession := true
    }

    ; Restart if focus moved to a window outside the current cycle set
    ; (e.g. the user clicked another app or a new window appeared).
    if (!newSession) {
        WinGet activeID, ID, A
        if (activeID AND WinExist("ahk_id " . activeID))
            if (IndexOf(cycleWindowIDs, activeID) < 0)
                newSession := true
    }

    if (newSession) {
        cycleWindowIDs := fresh.Clone()
        WinGet activeID, ID, A
        cyclePos := IndexOf(cycleWindowIDs, activeID)
        if (cyclePos < 0) {
            ; Foreground window isn't in the list (empty title / not found).
            if (activeID AND WinExist("ahk_id " . activeID)) {
                cycleWindowIDs.InsertAt(1, activeID)
                cyclePos := 0
            } else {
                cyclePos := 0
            }
        }
        cycleTick := now
    }

    ; Advance one step, wrapping around in both directions.
    cyclePos += direction
    if (cyclePos >= cycleWindowIDs.Length())
        cyclePos := 0
    if (cyclePos < 0)
        cyclePos := cycleWindowIDs.Length() - 1

    targetID := cycleWindowIDs[cyclePos + 1]  ; AHK arrays are 1-indexed
    if !WinExist("ahk_id " . targetID)
        return

    ; Restore then activate (WinActivate alone won't un-minimize).
    WinGet minMax, MinMax, ahk_id %targetID%
    if (minMax == -1)
        WinRestore, ahk_id %targetID%
    WinActivate, ahk_id %targetID%

    cycleTick := now
}

; Returns the 0-based position of `value` in array `arr`, or -1 if not found.
IndexOf(arr, value) {
    Loop % arr.Length() {
        if (arr[A_Index] == value)
            return A_Index - 1
    }
    return -1
}

; Win+Q 关闭当前窗口（等同于点右上角 ×）
#q::WinClose, A

; Win+F 最大化/还原切换 toggle
#f::
WinGet, winState, MinMax, A
if (winState = 1) {
    SysGet, work, MonitorWorkArea, 1
    WorkLeft := workLeft
    WorkTop := workTop
    WorkRight := workRight
    WorkBottom := workBottom

    WorkWidth := WorkRight - WorkLeft
    WorkHeight := WorkBottom - WorkTop

    w := Floor(WorkWidth * 0.6)
    h := Floor(WorkHeight * 0.7)
    x := Floor(WorkLeft + (WorkWidth - w) / 2)
    y := Floor(WorkTop + (WorkHeight - h) / 2)

    WinRestore, A
    WinMove, A,, x, y, w, h
} else {
    WinMaximize, A
}
return
