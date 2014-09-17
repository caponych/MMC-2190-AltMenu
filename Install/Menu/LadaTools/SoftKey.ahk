#SingleInstance ignore
DetectHiddenWindows, on
CoordMode, Mouse, Screen

RegRead, MMCCoreHWND, HKEY_LOCAL_MACHINE, SOFTWARE\LadaTools, CoreHWND
RegRead, msg_ID, HKEY_LOCAL_MACHINE, SOFTWARE\LadaTools, UWM_KEY_ID

WinGet, active_id, ID, A ;получаем хэндл окна
activewnd:=active_id 
activewnd:= activewnd + 0 ;переводим хэндл в десятичный вид
;создаем гуи
#Include %A_ScriptDir%\SoftKey_GUI.ahk
WinActivate, ahk_id %activewnd%
Return

SKeyok:
CVal1=%A_ScriptDir%\skin\softkey\ok.bmp
CVal2=%A_ScriptDir%\skin\softkey\okp.bmp
CName=SKeyok
ButtonPress(CName, CVal1, CVal2)
loop, 2
{
PostMessage, msg_ID, 11, 2,, ahk_id %MMCCoreHWND%
}
return

SKeyaudio:
CVal1=%A_ScriptDir%\skin\softkey\audio.bmp
CVal2=%A_ScriptDir%\skin\softkey\audiop.bmp
CName=SKeyaudio
ButtonPress(CName, CVal1, CVal2)
loop, 2
{
PostMessage, msg_ID, 16, 0,, ahk_id %MMCCoreHWND%
}
return

SKeyaf:
CVal1=%A_ScriptDir%\skin\softkey\af.bmp
CVal2=%A_ScriptDir%\skin\softkey\afp.bmp
CName=SKeyaf
ButtonPress(CName, CVal1, CVal2)
loop, 2
{
PostMessage, msg_ID, 17, 0,, ahk_id %MMCCoreHWND%
}
return

SKeyasps:
CVal1=%A_ScriptDir%\skin\softkey\navi.bmp
CVal2=%A_ScriptDir%\skin\softkey\navip.bmp
CName=SKeyasps
ButtonPress(CName, CVal1, CVal2)
loop, 2
{
PostMessage, msg_ID, 13, 0,, ahk_id %MMCCoreHWND%
}
return

SKeylightmode:
CVal1=%A_ScriptDir%\skin\softkey\lightmode.bmp
CVal2=%A_ScriptDir%\skin\softkey\lightmodep.bmp
CName=SKeylightmode
ButtonPress(CName, CVal1, CVal2)
PostMessage, msg_ID, 7, 0,, ahk_id %MMCCoreHWND%
return

SKeymedia:
CVal1=%A_ScriptDir%\skin\softkey\media.bmp
CVal2=%A_ScriptDir%\skin\softkey\mediap.bmp
CName=SKeymedia
ButtonPress(CName, CVal1, CVal2)
loop, 2
{
PostMessage, msg_ID, 6, 0,, ahk_id %MMCCoreHWND%
}
return

SKeyradio:
CVal1=%A_ScriptDir%\skin\softkey\radio.bmp
CVal2=%A_ScriptDir%\skin\softkey\radiop.bmp
CName=SKeyradio
ButtonPress(CName, CVal1, CVal2)
loop, 2
{
PostMessage, msg_ID, 5, 0,, ahk_id %MMCCoreHWND%
}
return

SKeymenu:
CVal1=%A_ScriptDir%\skin\softkey\menu.bmp
CVal2=%A_ScriptDir%\skin\softkey\menup.bmp
CName=SKeymenu
ButtonPress(CName, CVal1, CVal2)
loop, 2
{
PostMessage, msg_ID, 15, 0,, ahk_id %MMCCoreHWND%
}
return

SKeyinfo:
CVal1=%A_ScriptDir%\skin\softkey\info.bmp
CVal2=%A_ScriptDir%\skin\softkey\infop.bmp
CName=SKeyinfo
ButtonPress(CName, CVal1, CVal2)
loop, 2
{
PostMessage, msg_ID, 14, 0,, ahk_id %MMCCoreHWND%
}
return

SKeyforward:
CVal1=%A_ScriptDir%\skin\softkey\forward.bmp
CVal2=%A_ScriptDir%\skin\softkey\forwardp.bmp
CName=SKeyforward
ButtonPress(CName, CVal1, CVal2)
loop, 2
{
PostMessage, msg_ID, 9, 2,, ahk_id %MMCCoreHWND%
}
return

SKeybackward:
CVal1=%A_ScriptDir%\skin\softkey\backward.bmp
CVal2=%A_ScriptDir%\skin\softkey\backwardp.bmp
CName=SKeybackward
ButtonPress(CName, CVal1, CVal2)
loop, 2
{
PostMessage, msg_ID, 8, 2,, ahk_id %MMCCoreHWND%
}
return

SKeyputdownphone:
CVal1=%A_ScriptDir%\skin\softkey\putdownphone.bmp
CVal2=%A_ScriptDir%\skin\softkey\putdownphonep.bmp
CName=SKeyputdownphone
ButtonPress(CName, CVal1, CVal2)
loop, 2
{
PostMessage, msg_ID, 12, 1,, ahk_id %MMCCoreHWND%
}
return

SKeypickupphone:
CVal1=%A_ScriptDir%\skin\softkey\pickupphone.bmp
CVal2=%A_ScriptDir%\skin\softkey\pickupphonep.bmp
CName=SKeypickupphone
ButtonPress(CName, CVal1, CVal2)
loop, 2
{
PostMessage, msg_ID, 10, 1,, ahk_id %MMCCoreHWND%
}
return

SKeyPower:
goto GuiClose
;CVal1=%A_ScriptDir%\skin\softkey\power.bmp
;CVal2=%A_ScriptDir%\skin\softkey\powerp.bmp
;CName=SKeyPower
;ButtonPress(CName, CVal1, CVal2)
;loop, 2
;{
;PostMessage, msg_ID, 4, 0,, ahk_id %MMCCoreHWND%
;}
return

ButtonPress(CName, CVal1, CVal2)
	{
	GuiControlGet, Pic, Pos, %CName%
	GuiControl, , %CName%, %CVal2%
	x:=PicX+1
	y:=PicY+1
	GuiControl Move, %CName%, x%x% y%y%
	Sleep, 200
	GuiControl, , %CName%, %CVal1%
	GuiControl Move, %CName%, x%PicX% y%PicY%
	}

GuiClose:
ExitApp