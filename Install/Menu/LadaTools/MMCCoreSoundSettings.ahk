SoundSettingsStartGui:

if (SoundSettingsRun=0)
	{
	SoundSettingsRun=1
	}
else
	{
	gosub SoundExit
	Return
	}

;создаем гуи
Gui, 6:Destroy
#IncludeAgain %A_ScriptDir%\MMCCoreSoundSettings_GUI.ahk
gosub SoundSettingsInit
Return

SoundBalance:
MouseGetPos, xpos, ypos 
xpos:=xpos-527-25
ypos:=ypos-115-75
if (xpos<0)
{
xpos=0
}
if (xpos>200)
{
xpos=200
}
if (ypos<0)
{
ypos=0
}
if (ypos>250)
{
ypos=250
}
SoundBalance:=Round(xpos/14.28)-7
SoundFader:=7-Round(ypos/17.85)

	GuiControl, 6:, BalanceIcon, %A_ScriptDir%\skin\sound\BF.bmp
	x:=(7+SoundBalance)*14.28+527+15
	y:=(7-SoundFader)*17.85+115+62
	GuiControl, 6:Move, BalanceIcon, x%x% y%y%
	DllCall(Aud_SetBalance, int, SoundBalance)
	Sleep, 500
	DllCall(Aud_SetFader, int, SoundFader)
return

SoundSettingsInit:
	CVal1=%A_ScriptDir%\skin\sound\p%SoundPreset%p.bmp
	CVal2=%A_ScriptDir%\skin\sound\p%SoundPreset%p.bmp
	CName=SoundPreset%SoundPreset%
	ButtonPress(CName, CVal1, CVal2, 6)
	if (SoundTone=1)
	{
	CVal1=%A_ScriptDir%\skin\sound\vmsp.bmp
	CVal2=%A_ScriptDir%\skin\sound\vmsp.bmp
	CName=SoundToneB
	ButtonPress(CName, CVal1, CVal2, 6)
	}
	if (SoundToneCF=0)
	{
	GuiControl, 6:, LoudCF, Direct
	}
	if (SoundToneCF=1)
	{
	GuiControl, 6:, LoudCF, 400Hz
	}
	if (SoundToneCF=2)
	{
	GuiControl, 6:, LoudCF, 800Hz
	}
	if (SoundToneCF=3)
	{
	GuiControl, 6:, LoudCF, 2,4kHz
	}
	DllCall(Aud_SetLoud, int, SoundTone)
	GuiControl, 6:, BalanceIcon, %A_ScriptDir%\skin\sound\BF.bmp
	x:=(7+SoundBalance)*14.28+527+15
	y:=(7-SoundFader)*17.85+115+62
	GuiControl, 6:Move, BalanceIcon, x%x% y%y%
	DllCall(Aud_SetBalance, int, SoundBalance)
	Sleep, 500
	DllCall(Aud_SetFader, int, SoundFader)
gosub SoundGetslide
return

LoudCF:
if (SoundToneCF=3)
	{
	SoundToneCF=0
	}
else
	{
	SoundToneCF += 1
	}
	
	if (SoundToneCF=0)
	{
	GuiControl, 6:, LoudCF, Direct
	}
	if (SoundToneCF=1)
	{
	GuiControl, 6:, LoudCF, 400Hz
	}
	if (SoundToneCF=2)
	{
	GuiControl, 6:, LoudCF, 800Hz
	}
	if (SoundToneCF=3)
	{
	GuiControl, 6:, LoudCF, 2,4kHz
	}

DllCall(Aud_SetLoudCFre, int, SoundToneCF)
return

SoundGetslide:
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

GuiControl, 6:, SoundSlider1, %SBass%
GuiControl, 6:, SoundSlider2, %SMid%
GuiControl, 6:, SoundSlider3, %STreble%

GuiControl, 6:, SText1, %SBass%
GuiControl, 6:, SText2, %SMid%
GuiControl, 6:, SText3, %STreble%

if (SoundPreset<>6)
{
GuiControl, 6:Disable , SoundSlider1
GuiControl, 6:Disable , SoundSlider2
GuiControl, 6:Disable , SoundSlider3
}
else
{
GuiControl, 6:Enable , SoundSlider1
GuiControl, 6:Enable , SoundSlider2
GuiControl, 6:Enable , SoundSlider3
}
DllCall(Aud_SetBass, int, SBass)
DllCall(Aud_SetMid, int, SMid)
DllCall(Aud_SetTreble, int, STreble)
return

SoundToneB:
if (SoundTone=0)
{
CVal1=%A_ScriptDir%\skin\sound\vmsp.bmp
CVal2=%A_ScriptDir%\skin\sound\vmsp.bmp
CName=SoundToneB
ButtonPressF(CName, CVal1, CVal2, 6)
SoundTone=1
}
else
{
CVal1=%A_ScriptDir%\skin\sound\vms.bmp
CVal2=%A_ScriptDir%\skin\sound\vms.bmp
CName=SoundToneB
ButtonPressF(CName, CVal1, CVal2, 6)
SoundTone=0
}
DllCall(Aud_SetLoud, int, SoundTone)
return

SoundPreset1:
CVal1=%A_ScriptDir%\skin\sound\p%SoundPreset%.bmp
CVal2=%A_ScriptDir%\skin\sound\p%SoundPreset%.bmp
CName=SoundPreset%SoundPreset%
ButtonPress(CName, CVal1, CVal2, 6)
SoundPreset=1
gosub SoundPresetPress
return

SoundPreset2:
CVal1=%A_ScriptDir%\skin\sound\p%SoundPreset%.bmp
CVal2=%A_ScriptDir%\skin\sound\p%SoundPreset%.bmp
CName=SoundPreset%SoundPreset%
ButtonPress(CName, CVal1, CVal2, 6)
SoundPreset=2
gosub SoundPresetPress
return

SoundPreset3:
CVal1=%A_ScriptDir%\skin\sound\p%SoundPreset%.bmp
CVal2=%A_ScriptDir%\skin\sound\p%SoundPreset%.bmp
CName=SoundPreset%SoundPreset%
ButtonPress(CName, CVal1, CVal2, 6)
SoundPreset=3
gosub SoundPresetPress
return

SoundPreset4:
CVal1=%A_ScriptDir%\skin\sound\p%SoundPreset%.bmp
CVal2=%A_ScriptDir%\skin\sound\p%SoundPreset%.bmp
CName=SoundPreset%SoundPreset%
ButtonPress(CName, CVal1, CVal2, 6)
SoundPreset=4
gosub SoundPresetPress
return

SoundPreset5:
CVal1=%A_ScriptDir%\skin\sound\p%SoundPreset%.bmp
CVal2=%A_ScriptDir%\skin\sound\p%SoundPreset%.bmp
CName=SoundPreset%SoundPreset%
ButtonPress(CName, CVal1, CVal2, 6)
SoundPreset=5
gosub SoundPresetPress
return

SoundPreset6:
CVal1=%A_ScriptDir%\skin\sound\p%SoundPreset%.bmp
CVal2=%A_ScriptDir%\skin\sound\p%SoundPreset%.bmp
CName=SoundPreset%SoundPreset%
ButtonPress(CName, CVal1, CVal2, 6)
SoundPreset=6
gosub SoundPresetPress
return

SoundPresetPress:
CVal1=%A_ScriptDir%\skin\sound\p%SoundPreset%p.bmp
CVal2=%A_ScriptDir%\skin\sound\p%SoundPreset%p.bmp
CName=SoundPreset%SoundPreset%
ButtonPress(CName, CVal1, CVal2, 6)
gosub SoundGetslide
return


SoundSlider1:
	UBass=%SoundSlider1%
	GuiControl, 6:, SText1, %UBass%
	DllCall(Aud_SetBass, int, UBass)
return

SoundSlider2:
	UMid=%SoundSlider2%
	GuiControl, 6:, SText2, %UMid%
	DllCall(Aud_SetMid, int, UMid)
return

SoundSlider3:
	UTreble=%SoundSlider3%
	GuiControl, 6:, SText3, %UTreble%
	DllCall(Aud_SetTreble, int, UTreble)
return

SoundExit:
CVal1=%A_ScriptDir%\skin\sound\vep.bmp
CVal2=%A_ScriptDir%\skin\sound\vep.bmp
CName=SoundExit
ButtonPressF(CName, CVal1, CVal2, 6)
	IniWrite, %SoundTone%, %SoundIni%, Sound, Ton
	IniWrite, %SoundToneCF%, %SoundIni%, Sound, TonCF
	IniWrite, %SoundPreset%, %SoundIni%, Sound, Preset
	IniWrite, %UBass%, %SoundIni%, Sound, Bass
	IniWrite, %UMid%, %SoundIni%, Sound, Mid
	IniWrite, %UTreble%, %SoundIni%, Sound, Treble
	IniWrite, %SoundBalance%, %SoundIni%, Sound, Balance
	IniWrite, %SoundFader%, %SoundIni%, Sound, Fader
	SoundSettingsRun=0
Gui, 6:Destroy
return