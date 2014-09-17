#SingleInstance ignore
DetectHiddenWindows, on

	Process, Exist, audio.exe
		if ErrorLevel<>0
			{
			sethwnd:=ErrorLevel 
			sethwnd:= sethwnd + 0 
			PostMessage, 0x111, 40002, , , ahk_pid %sethwnd%
			}
	Process, Exist, Media.exe
		if ErrorLevel<>0
			{
			sethwnd:=ErrorLevel 
			sethwnd:= sethwnd + 0 
			;PostMessage, 0x111, 1092, , , ahk_pid %sethwnd%
			PostMessage, 0x111, 1036, , , ahk_pid %sethwnd%
			}
	Process, Exist, LPlayer.exe
		if ErrorLevel<>0
			{
			sethwnd:=ErrorLevel 
			sethwnd:= sethwnd + 0 
			PostMessage, 0x111, 1022, , , ahk_pid %sethwnd%
			}
	Process, Exist, NaviPlayer.exe
		if ErrorLevel<>0
			{
			sethwnd:=ErrorLevel 
			sethwnd:= sethwnd + 0 
			PostMessage, 0x111, 40037, , , ahk_pid %sethwnd%
			}

ExitApp