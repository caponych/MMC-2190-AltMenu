#SingleInstance ignore
#Persistent
SetTitleMatchMode, 2
DetectHiddenWindows, on
DetectHiddenText, On

SearchString = Error
SetTimer, findwindows, 2000
return

findwindows:

WinGetTitle, active_wintitle, A 
IfInString, active_wintitle, %SearchString%
{
    IfExist, %A_ScriptDir%\MortScript\OnError.mscr
		run %A_ScriptDir%\MortScript\OnError.mscr
}

return
