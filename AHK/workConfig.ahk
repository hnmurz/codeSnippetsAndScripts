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
#KeyHistory 0 ; Enable this only if we need to debug

; The specified period is kind of arbitrarily chosen. The idea behind it was to pick a value that will
; be able to respond quick enough to whatever timing I want to choose.
SetTimer, IdleCheck, 150
;SetTimer, IdleCheck, 5000
toolTipText:="Enabling autoclicking"
ToolTip, Enabling autoclicking
SetTimer, FollowCursorTooltip, 35
SetTimer, RemoveToolTip, 2000
; We can use window spy util to see info about stuff under the cursor
;SetTimer, FollowCursorTooltip, 100

tog:=0
; Look at documentation for Labels for ::, this is a hotkey label.*/
; # represent window key
; We could also use SendMode to make send synonymous with sendInput
#r::Reload
#f::SendInput, fr.sh pretty -ED | grep -i 
#n::SendInput, fr.sh pretty -ED | grep -i l3_neighbo
#s::SendInput, monit start cn-node-hal 
#b::SendInput, babeltrace2 --clock-gmt --clock-date . | frpretty -ED 
#p::SendInput, field last  info one_pkt=yes stage=
#h::SendInput, halDebug halState 1
$`::TmuxPrefixShortcut()
$Insert::TmuxPrefixShortcut()
Capslock::Esc
F3::
tog:=HandleMouseToggle(0, tog)
return
F4::HandleWorkSpaceSwitch(1, "F4")
F5::HandleWorkSpaceSwitch(2, "F5")
F6::HandleWorkSpaceSwitch(3, "F6")
F7::HandleWorkSpaceSwitch(4, "F7")
F8::HandleWorkSpaceSwitch(5, "F8")
F9::HandleWorkSpaceSwitch(6, "F9")
F10::HandleWorkSpaceSwitch(7, "F10")
F11::HandleWorkSpaceSwitch(8, "F11")
F12::HandleWorkSpaceSwitch(9, "F12")

; Dollar sign makes use look for non AHK generated Esc
; For more info on this look at the AHK help for symbols (in Hotkeys)
$ESC::MyWinActivate("emacsSSH")
F1::MyWinActivate("tmuxSSH")
F2::AltTabFunction()
return

MyWinActivate(frameName)
{
   if (WinActive(frameName))
   {
      SendInput {LAlt down}{Tab} ; An alt-tab sequence
      Sleep 50
      SendInput {Tab}
      Sleep 50
      SendInput {LAlt up}
   }
   else
   {
      WinActivate, %frameName%
   }
}

AltTabFunction()
{
   if (WinActive("ahk_exe diaw.exe"))
   {
      SendInput {F2}
   }
   else
   {
      SendInput {LAlt down}{Tab} ; An alt-tab sequence
      Sleep 100
      SendInput {LAlt up}
   }
}

TmuxPrefixShortcut()
{
    if WinActive("tmuxSSH")
    {
        SendInput {LCtrl down}{a}
        Sleep 50
        SendInput {LCtrl up}
    }
    else
    {
        SendInput, ``
    }
}

HandleWorkSpaceSwitch(workSpace, key)
{
    if WinActive("tmuxSSH") || WinActive("emacsSSH")
    {
        ;; This key sequence will switch the virtual workspace for both these applications
        SendInput {LCtrl down}{a}
        Sleep 100
        SendInput {LCtrl up}
        SendInput {%workSpace%}
    }
    else
    {
        SendInput {%key%}
    }
}

; In both of these windows I don't really care about toggling the mouse control. In tmux I generally use
; the mouse to switch panes, and in emacs the mouse clicking is disabled. See logic in IdleCheck.
HandleMouseToggle(workSpace, tog)
{
    if WinActive("tmuxSSH") || WinActive("emacsSSH")
    {
        SendInput {LCtrl down}{a}
        Sleep 100
        SendInput {LCtrl up}
        SendInput {%workSpace%}
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
    ;if (A_TimeIdleMouse < 650) || (A_TimeIdleKeyboard < 3000)
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
    SetTimer, RemoveToolTip, off
    SetTimer, FollowCursorTooltip, off
    ToolTip
return
