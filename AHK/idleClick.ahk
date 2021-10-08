#Persistent
#InstallMouseHook
#InstallKeybdHook

SetTimer, IdleCheck, 150

tog:=1
F12::
if (tog = 1)
	SetTimer, IdleCheck, 150
else
	SetTimer, IdleCheck, Off
tog:=!tog
return

IdleCheck:
	if (A_TimeIdleMouse > 650) && (A_TimeIdleMouse < 800) && (A_TimeIdleKeyboard > 3000)
		click
return