VideoSettingsStartGui:

if (VideoSettingsRun=0)
	{
	VideoSettingsRun=1
	}
else
	{
	gosub ExitVideo
	Return
	}
	
;создаем гуи
Gui, 7:Destroy
#IncludeAgain %A_ScriptDir%\MMCCoreVideoSettings_GUI.ahk
gosub VideoSettingsInit
Return

VideoSettingsInit:
if (SaverActivate=0)
{
	GuiControl, 7:, SaverVideo, %A_ScriptDir%\skin\video\vms.bmp
	GuiControlGet, Pic, 7:Pos, SaverVideo
	x:=PicX-1
	y:=PicY-1
	GuiControl, 7:Move, SaverVideo, x%x% y%y%
}
else
{
	GuiControl, 7:, SaverVideo, %A_ScriptDir%\skin\video\vmsp.bmp
	GuiControlGet, Pic, 7:Pos, SaverVideo
	x:=PicX+1
	y:=PicY+1
	GuiControl, 7:Move, SaverVideo, x%x% y%y%
}
GuiControl, 7:, ModeVideo%LastVideoMode%, %A_ScriptDir%\skin\video\vmsp.bmp
GuiControlGet, Pic, 7:Pos, ModeVideo%LastVideoMode%
x:=PicX+1
y:=PicY+1
GuiControl, 7:Move, ModeVideo%LastVideoMode%, x%x% y%y%
gosub GetSliderVideo
return

GetSliderVideo:
if (LastVideoMode=1)
{
VBright:=DayBri
VContrast:=DayCon
VColor:=DayCol
}
if (LastVideoMode=2)
{
VBright:=NightrBri
VContrast:=NightrCon
VColor:=NightrCol
}

GuiControl, 7:, SliderVideo1, %VBright%
GuiControl, 7:, SliderVideo2, %VContrast%
GuiControl, 7:, SliderVideo3, %VColor%
GuiControl, 7:, TextSliderVideo1, %VBright%
GuiControl, 7:, TextSliderVideo2, %VContrast%
GuiControl, 7:, TextSliderVideo3, %VColor%

DllCall(Vid_SetBright, int, VBright)
DllCall(Vid_SetContrast, int, VContrast)
DllCall(Vid_SetColor, int, VColor)
return

ModeVideo1:
VSButtonMode(1, LastVideoMode)
LastVideoMode=1
gosub GetSliderVideo
return

ModeVideo2:
VSButtonMode(2, LastVideoMode)
LastVideoMode=2
gosub GetSliderVideo
return

VSButtonMode(CMode, Clast)
	{
	if CMode = %Clast%
	{
	return
	}
	GuiControl, 7:, ModeVideo%Clast%, %A_ScriptDir%\skin\video\vms.bmp
	GuiControlGet, Pic, 7:Pos, ModeVideo%Clast%
	x:=PicX-1
	y:=PicY-1
	GuiControl, 7:Move, ModeVideo%Clast%, x%x% y%y%
	GuiControl, 7:, ModeVideo%CMode%, %A_ScriptDir%\skin\video\vmsp.bmp
	GuiControlGet, Pic, 7:Pos, ModeVideo%CMode%
	x:=PicX+1
	y:=PicY+1
	GuiControl, 7:Move, ModeVideo%CMode%, x%x% y%y%
	}

SaverVideo:
if (SaverActivate=0)
{
	SaverActivate=1
	GuiControl, 7:, SaverVideo, %A_ScriptDir%\skin\video\vmsp.bmp
	GuiControlGet, Pic, 7:Pos, SaverVideo
	x:=PicX+1
	y:=PicY+1
	GuiControl, 7:Move, SaverVideo, x%x% y%y%
	SetTimer, startsavertimer, off
	SaverTickCount=0
	gosub createsavertimer
}
else
{
	SaverActivate=0
	GuiControl, 7:, SaverVideo, %A_ScriptDir%\skin\video\vms.bmp
	GuiControlGet, Pic, 7:Pos, SaverVideo
	x:=PicX-1
	y:=PicY-1
	GuiControl, 7:Move, SaverVideo, x%x% y%y%
	SaverTickCount=0
	SetTimer, startsavertimer, off
}
IniWrite, %SaverActivate%, %videoini%, Saver, Activate
return

SliderVideo1:
	if LastVideoMode =1
	{
	DayBri=%SliderVideo1%
	}
	else
	{
	NightrBri=%SliderVideo1%
	}
	DllCall(Vid_SetBright, int, SliderVideo1)
	GuiControl, 7:, TextSliderVideo1, %SliderVideo1%
return

SliderVideo2:
	if LastVideoMode =1
	{
	DayCon=%SliderVideo2%
	}
	else
	{
	NightrCon=%SliderVideo2%
	}
	DllCall(Vid_SetContrast, int, SliderVideo2)
	GuiControl, 7:, TextSliderVideo2, %SliderVideo2%
return

SliderVideo3:
	if LastVideoMode =1
	{
	DayCol=%SliderVideo3%
	}
	else
	{
	NightrCol=%SliderVideo3%
	}
	DllCall(Vid_SetColor, int, SliderVideo3)
	GuiControl, 7:, TextSliderVideo3, %SliderVideo3%
return

Touch:
CName=Touchv
CVal1=%A_ScriptDir%\skin\video\vsc.bmp
CVal2=%A_ScriptDir%\skin\video\vscp.bmp
ButtonPress(CName, CVal1, CVal2, 1)
IfExist, %A_ScriptDir%\Tools\Touch\touch.exe
	run %A_ScriptDir%\Tools\Touch\touch.exe
return

ExitVideo:
CName=ExitVideo
CVal1=%A_ScriptDir%\skin\video\ve.bmp
CVal2=%A_ScriptDir%\skin\video\vep.bmp
ButtonPress(CName, CVal1, CVal2, 1)
	IniWrite, %DayBri%, %videoini%, Day, Bright
	IniWrite, %DayCon%, %videoini%, Day, Contrast
	IniWrite, %DayCol%, %videoini%, Day, Color
	IniWrite, %NightrBri%, %videoini%, Night, Bright
	IniWrite, %NightrCon%, %videoini%, Night, Contrast
	IniWrite, %NightrCol%, %videoini%, Night, Color
	IniWrite, %LastVideoMode%, %videoini%, Mode, Last
	VideoSettingsRun=0
Gui, 7:Destroy
return