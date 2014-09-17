FistInit:

;звук 
	DllCall(Aud_SetLoud, int, SoundTone)
	Sleep, 500
	DllCall(Aud_SetLoudCFre, int, SoundToneCF)
	Sleep, 500
	DllCall(Aud_SetBalance, int, SoundBalance)
	Sleep, 500
	DllCall(Aud_SetFader, int, SoundFader)

;джаз
if (SoundPreset=1)
{
SBass=5
SMid=5
STreble=3
}
;Рок
if (SoundPreset=2)
{
SBass=5
SMid=4
STreble=6
}
;Класика
if (SoundPreset=3)
{
SBass=2
SMid=3
STreble=7
}
;Поп
if (SoundPreset=4)
{
SBass=3
SMid=5
STreble=4
}
;Вокал
if (SoundPreset=5)
{
SBass=2
SMid=4
STreble=3
}
;Пользовательский
if (SoundPreset=6)
{
SBass:=UBass
SMid:=UMid
STreble:=UTreble
}
DllCall(Aud_SetBass, int, SBass)
DllCall(Aud_SetMid, int, SMid)
DllCall(Aud_SetTreble, int, STreble)
return

caminit:

RegWrite, REG_SZ, HKEY_LOCAL_MACHINE, SOFTWARE\LadaTools, MuteState, 0

;видео
	if (LastVideoMode=1)
		{
		DllCall(Vid_SetBright, int, DayBri)
		DllCall(Vid_SetContrast, int, DayCon)
		DllCall(Vid_SetColor, int, DayCol)
		}
	else
		{
		DllCall(Vid_SetBright, int, NightrBri)
		DllCall(Vid_SetContrast, int, NightrCon)
		DllCall(Vid_SetColor, int, NightrCol)
		}

;камера
IniRead, RearCamLastMode, %RearCamINI%, RearCam, Mode
if RearCamLastMode=0
{
DllCall(API_SetCAMState, int, 0)
}
else
{
DllCall(API_SetCAMState, int, 1)
}

return