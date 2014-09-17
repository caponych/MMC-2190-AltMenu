;обновляем громкость
RefreshVol:
	AUD_VOL:=DllCall(Aud_GetVolume)
	if (VolRuning=0)
	{
	gosub VolShowGuiCreate
	SetTimer, startvoltimer, 300
	}
	else
	{
	gosub VOLCHANGE
	}
VolTickCount=0
gosub mutehide
return

VolShowGuiCreate:
VolRuning=1

WinGet, active_id, ID, A ;получаем хэндл окна
activewnd:=active_id 
activewnd:= activewnd + 0 ;переводим хэндл в десятичный вид
if (SaverRuning=0)
	{
	gosub MoveMouse
	}
Gui, 8:-SysMenu -Caption +AlwaysOnTop
Gui, 8:Color, %Volguibackcolor%
Gui, 8:Font, s12 с%Volfcolor%
Gui, 8:Add, Text, 0x1 vText x%VolTextX% y%VolTextY% w%VolTextW% h%VolTextH%
Gui, 8:Add, Picture, vMyProgress x%VolMeterX% y%VolMeterY% w0 h%VolMeterH%, %A_ScriptDir%\skin\VolShow\VolMeter.bmp
Gui, 8:Add, Picture, x0 y0 w%VolMainW% h%VolMainH%, %A_ScriptDir%\skin\VolShow\bcgrnd.bmp
VolMeterCurW:=VolMeterW/100*AUD_VOL
GuiControl, 8:Move, MyProgress, x%VolMeterX% y%VolMeterY% w%VolMeterCurW% h%VolMeterH%
GuiControl, 8:, Text, %AUD_VOL%
Gui, 8:Show, x%VolMainX% y%VolMainY% w%VolMainW% h%VolMainH%, Volume

AUD_VOLOld:=AUD_VOL
WinActivate, ahk_id %activewnd%
return

VOLCHANGE:
	if (AUD_VOL<>AUD_VOLOld)
		{
		VolMeterCurW:=VolMeterW/100*AUD_VOL
		GuiControl, 8:Move, MyProgress, x%VolMeterX% y%VolMeterY% w%VolMeterCurW% h%VolMeterH%
		GuiControl, 8:, Text, %AUD_VOL%
		AUD_VOLOld:=AUD_VOL
		}
return

;таймер громкости
startvoltimer:
	VolTickCount += 1
	if (VolTickCount>3)
		{
		VolTickCount=0
		VolRuning=0
		SetTimer, startvoltimer, off
		Gui, 8:Destroy
		if(BTCallState=6)
		{
		IniWrite, %AUD_VOL%, %SoundIni%, Sound, BtVolume
		BtVolume:=AUD_VOL
		}
		else
		{
		IniWrite, %AUD_VOL%, %SoundIni%, Sound, Volume
		SoundVolume:=AUD_VOL
		}
		WinGet, active_id, ID, A ;получаем хэндл окна
		activewnd:=active_id 
		activewnd:= activewnd + 0 ;переводим хэндл в десятичный вид
		WinActivate, ahk_id %activewnd%
		}
return
