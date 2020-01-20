if WinExist("Elite - Dangerous (CLIENT)")
    WinActivate ; use the window found above
    Sleep, 100
    Send, {f10 down}
    Sleep 100
    Send, {f10 up}
    