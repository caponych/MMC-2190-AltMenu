#SingleInstance ignore
DetectHiddenWindows, on

	Process, Exist, audio.exe
		if ErrorLevel<>0
			{
			sethwnd:=ErrorLevel 
			sethwnd:= sethwnd + 0 
			PostMessage, 0x111, 40003, , , ahk_pid %sethwnd%
			}
	Process, Exist, Media.exe
		if ErrorLevel<>0
			{
			sethwnd:=ErrorLevel 
			sethwnd:= sethwnd + 0 
			;PostMessage, 0x111, 1093, , , ahk_pid %sethwnd%
			PostMessage, 0x111, 1035, , , ahk_pid %sethwnd%
			}
	Process, Exist, LPlayer.exe
		if ErrorLevel<>0
			{
			sethwnd:=ErrorLevel 
			sethwnd:= sethwnd + 0 
			PostMessage, 0x111, 1023, , , ahk_pid %sethwnd%
			}
	Process, Exist, NaviPlayer.exe
		if ErrorLevel<>0
			{
			sethwnd:=ErrorLevel 
			sethwnd:= sethwnd + 0 
			PostMessage, 0x111, 40038, , , ahk_pid %sethwnd%
			}

ExitApp