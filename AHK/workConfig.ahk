; On my work machine I connect to a linux machine where I do most of my work. I generally have two ssh
; windows open, one titled emacsSSH and the other tmuxSSH.

;; TODO
;; * Make mouse more responsive in tmux pane (reduce timeout)
;; * Make idle click not happen when scrolling
;; * Make idle click not happen after we just did physical mouse clicks. This will prevent us from
;;      Unselecting text.
;; * Work on emacs ahk mode

#Persistent
#InstallMouseHook
#InstallKeybdHook

; The specified period is kind of arbitrarily chosen. The idea behind it was to pick a value that will
; be able to respond quick enough to whatever timing I want to choose.
SetTimer, IdleCheck, 150
toolTipText:="Enabling autoclicking"
ToolTip, Enabling autoclicking
SetTimer, FollowCursorTooltip, 35
SetTimer, RemoveToolTip, 2000
; We can use window spy util to see info about stuff under the cursor
;SetTimer, FollowCursorTooltip, 100

tog:=0
; Look at documentation for Labels for ::, this is a hotkey label.*/
; # represent window key
#r::Reload
#f::SendRaw fr.sh pretty -ED | grep -i 
#n::SendRaw fr.sh pretty -ED | grep -i l3_neighbo
#s::SendRaw monit start cn-node-hal 
$`::TmuxPrefixShortcut()
$Insert::TmuxPrefixShortcut()
Capslock::Esc
F3::
tog:=HandleMouseToggle(0, tog)
return
F4::HandleWorkSpaceSwitch(1)
F5::HandleWorkSpaceSwitch(2)
F6::HandleWorkSpaceSwitch(3)
F7::HandleWorkSpaceSwitch(4)
F8::HandleWorkSpaceSwitch(5)
F9::HandleWorkSpaceSwitch(6)
F10::HandleWorkSpaceSwitch(7)
F11::HandleWorkSpaceSwitch(8)
F12::HandleWorkSpaceSwitch(9)
$ESC::WinActivate, emacsSSH ; Dollar sign makes use look for non AHK generated Esc
                            ; For more info on this look at the AHK help for symbols (in Hotkeys)
F1::WinActivate, tmuxSSH
F2::
Send {LAlt down}{Tab} ; An alt-tab sequence
Sleep 100
Send {LAlt up}
return

TmuxPrefixShortcut()
{
    if WinActive("tmuxSSH") || WinActive("emacsSSH")
    {
        Send {LCtrl down}{a}
        Sleep 50
        Send {LCtrl up}
    }
    else
    {
        Send, ``
    }
}

HandleWorkSpaceSwitch(workSpace)
{
    if WinActive("tmuxSSH") || WinActive("emacsSSH")
    {
        ;; This key sequence will switch the virtual workspace for both these applications
        Send {LCtrl down}{a}
        Sleep 100
        Send {LCtrl up}
        Send {%workSpace%}
    }
    else
    {
        Reload
    }
}

; In both of these windows I don't really care about toggling the mouse control. In tmux I generally use
; the mouse to switch panes, and in emacs the mouse clicking is disabled. See logic in IdleCheck.
HandleMouseToggle(workSpace, tog)
{
    if WinActive("tmuxSSH") || WinActive("emacsSSH")
    {
        Send {LCtrl down}{a}
        Sleep 100
        Send {LCtrl up}
        Send {%workSpace%}
        return tog
    }
    else
    {
        if (tog = 1)
        {
            SetTimer, IdleCheck, On
            global toolTipText:="Enabling autoclicking"
            ToolTip, Enabling autoclicking
            SetTimer, FollowCursorTooltip, on
            SetTimer, RemoveToolTip, on
        }
        else
        {
            SetTimer, IdleCheck, Off
            global toolTipText:="Disabling autoclicking"
            ToolTip, Disabling autoclicking
            SetTimer, FollowCursorTooltip, on
            SetTimer, RemoveToolTip, on
        }
        return !tog
    }
}

; Looking at keyholds... Look at the help for timer

; Still trying to figure something out to look at key history,
; see: https://www.autohotkey.com/boards/viewtopic.php?t=69611

; This subroute still needs some more work and thought. Currently, if the cursor is idle and some
; specific criteria is filled, then it will click with a delay of 650-800ms. The precondition
IdleCheck:
    ; Check time constraints
    if (A_TimeIdleMouse < 650) || (A_TimeIdleMouse > 800) || (A_TimeIdleKeyboard < 3000)
    {
        return
    }
    ; Check for mouse scroll down and scroll up, work in progress
    lastKey:=prevKey
    prevKey:=A_PriorKey
    if (A_PriorKey = "WheelDown") || (A_PriorKey = "WheelUp") || (GetKeyState("LButton") = 1)
    {
        if (lastKey != prevKey)
        {
            return
        }
    }

    ; Only perform a click on the emacsSSH window if it is not the current active pane
    CoordMode, Mouse, Screen
    MouseGetPos, , , winId, control
    WinGetTitle, mousePosWinTitle, ahk_id %winId%
    if !(mousePosWinTitle = "emacsSSH") || !(WinActive("emacsSSH"))
    {
        click
    }
return

FollowCursorTooltip:
    global toolTipText
    CoordMode, Mouse, Screen
    MouseGetPos, x,y
    ; An alternative is to use winmove like this:
    ; WinMove, ahk_class tooltips_class32, , %x%, %y%
    ; For some reason this does not work very well though. Just recreating the tooltip each time works better.
    ToolTip, %toolTipText%
return

RemoveToolTip:
    ToolTip
    SetTimer, RemoveToolTip, off
    SetTimer, FollowCursorTooltip, off
return
