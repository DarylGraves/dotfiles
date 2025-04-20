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

MoveWindow(direction) {
	A_MenuMaskKey := "vkE8"
    BlockInput(true)
    Send("{LWin Down}")
    Send("{" direction "}")
    Send("{LWin Up}")
}

; --------------------------------------------------------------
; Hotkeys
; --------------------------------------------------------------

; Block Alt+H/L if Ctrl is down to allow Ctrl+Alt+H/L
#HotIf GetKeyState("Ctrl", "P")
Alt & h::return
Alt & l::return
#HotIf

; Hotkeys for Moving Focus
#HotIf !GetKeyState("Shift", "P") && !GetKeyState("Ctrl", "P")
Alt & h:: MoveFocus("left")
Alt & j:: MoveFocus("down")
Alt & k:: MoveFocus("up")
Alt & l:: MoveFocus("right")
#HotIf

; Hotkeys for Window Management using Alt+Shift
#HotIf GetKeyState("Shift", "P")
!+h:: MoveWindow("Left")
!+j:: MoveWindow("Up")
!+k:: MoveWindow("Down")
!+l:: MoveWindow("Right")
#HotIf

; Toggle Maximised Window
!+Space::WinGetMinMax("A") = 1 ? WinRestore("A") : WinMaximize("A")

; New Outlook Quick Action Steps as it doesn't support Ctrl+Shift 1-4
^+1::Send("^+5")
^+2::Send("^+6")
^+3::Send("^+7")

; Change Virutal Desktop using Win+Shift+H/L
#+h::Send('^#{Left}')   ; Win+Shift+H -> Win+Ctrl+Left
#+l::Send('^#{Right}')  ; Win+Shift+L -> Win+Ctrl+Right