#SingleInstance ignore
DetectHiddenWindows, on

	Process, Exist, audio.exe
		if ErrorLevel<>0
			{
			sethwnd:=ErrorLevel 
			sethwnd:= sethwnd + 0 
			PostMessage, 0x111, 40001, , , ahk_pid %sethwnd%
			}
	Process, Exist, Media.exe
		if ErrorLevel<>0
			{
			sethwnd:=ErrorLevel 
			sethwnd:= sethwnd + 0 
			PostMessage, 0x111, 1091, , , ahk_pid %sethwnd%
			}
	Process, Exist, LPlayer.exe
		if ErrorLevel<>0
			{
			sethwnd:=ErrorLevel 
			sethwnd:= sethwnd + 0 
			PostMessage, 0x111, 1073, , , ahk_pid %sethwnd%
			}
	Process, Exist, NaviPlayer.exe
		if ErrorLevel<>0
			{
			sethwnd:=ErrorLevel 
			sethwnd:= sethwnd + 0 
			PostMessage, 0x111, 40027, , , ahk_pid %sethwnd%
			}
ExitApp