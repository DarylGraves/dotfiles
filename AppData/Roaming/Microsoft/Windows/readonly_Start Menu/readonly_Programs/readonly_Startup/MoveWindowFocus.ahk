; --------------------------------------------------------------
; Hotkeys
; --------------------------------------------------------------

; Hotkeys for Moving Focus
#HotIf !GetKeyState("Shift", "P")  ; Only execute if Shift is NOT pressed
Alt & h:: MoveFocus("left")
Alt & j:: MoveFocus("down")
Alt & k:: MoveFocus("up")
Alt & l:: MoveFocus("right")
#HotIf

; --------------------------------------------------------------
; Functions
; --------------------------------------------------------------

; Function: Move Focus Based on Direction
MoveFocus(direction) {
    ; Get the handle of the currently active window
    activeHwnd := WinGetID("A")

    ; Get the position and size of the active window
    WinGetPos(&X, &Y, &W, &H, activeHwnd)

    ; Find the border of the current window and add a bit extra
    offset := 50

    if (direction = "left") {
        checkX := X - offset
        checkY := Y + (H // 2)
    } else if (direction = "right") {
        checkX := X + W + offset
        checkY := Y + (H // 2)
    } else if (direction = "up") {
        checkX := X + (W // 2)
        checkY := Y - offset
    } else if (direction = "down") {
        checkX := X + (W // 2)
        checkY := Y + H + offset
    } else {
        return
    }

    ; Find the window at the calculated point
    targetHwnd := WindowFromPoint(checkX, checkY)

    ; Skip if the target window is invalid or the same as the current window
    if (targetHwnd && targetHwnd != activeHwnd) {
        ; Get the title of the target window
        targetTitle := WinGetTitle("ahk_id " targetHwnd)

        ; Skip windows with no title
        if (targetTitle == "") {
            return
        }

        if (targetTitle = "Program Manager") {
            return
        }

        ; Activate the target window
        WinActivate("ahk_id " targetHwnd)
    }
}

; Function: WindowFromPoint
WindowFromPoint(X, Y) {
    return DllCall("GetAncestor", "Ptr"
        , DllCall("User32\WindowFromPoint", "Int64", X | (Y << 32), "Ptr")
        , "UInt", 2)  ; GA_ROOT = 2
}
