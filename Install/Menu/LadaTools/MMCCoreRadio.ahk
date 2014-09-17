RadioStartGui:

if (RadioRuning=0)
{
RadioRuning=1
PressedPreset=0
IfExist, %A_ScriptDir%\MortScript\mediaoff.mscr
			 run %A_ScriptDir%\MortScript\mediaoff.mscr
IfExist, %A_ScriptDir%\MortScript\Audiooff.mscr
			 run %A_ScriptDir%\MortScript\Audiooff.mscr 
MediaProgRuning=0
RadioBandValue=1
;создаем гуи
#IncludeAgain %A_ScriptDir%\MMCCoreRadio_GUI.ahk
;инициализируем радио и полосу
gosub BTSoundOff
DllCall(Api_SetActivateMode,Int,0) ;0-радио 1-медиа 3-бт+медиа 4-бт+радио
ActivateModeLastState=0
RadioBand:=DllCall(Radio_GetCBand)
gosub getbandfrompreset
If (RadioBand<>RadioBandValue)
	{
	DllCall(Radio_SetBand, Int, RadioBandValue) ;0-укв 1-фм 2-ам
	}
ActiveF:=DllCall(Radio_GetFreq)
if (ActiveF <> RadioPreset%RadioActivePreset%)
	{
	ActiveF:=RadioPreset%RadioActivePreset%	
DllCall(Radio_SetFreq, Int, ActiveF)
	}
	
;флаг режима добавления частоты в пресет
addpreset=0
;флаг режима сканирования 0 - авто 1 - ручной
SearchMode=0

RadioBandValueOld=-1
gosub RefreshRadioBand
ActiveRPGroup:=Ceil(RadioActivePreset/7)
ActiveF:=DllCall(Radio_GetFreq)
Freq := FreqString(ActiveF)
GuiControl, 2:, QFreq, %Freq%
GuiControl, 3:, QFreq, %Freq%
gosub ActivePRefresh ;обновляем выбор группы пресетов
}

if (RadioRuning=1)
{
Gui, 2:Show, x0 y0 h480 w800, LadaRadio
gosub startclock
}
return

getbandfrompreset:
RadioBandValueOld:=RadioBandValue
if (RadioPreset%RadioActivePreset% >= 522 and RadioPreset%RadioActivePreset% <= 1620)
{
RadioBandValue:=2
}
if (RadioPreset%RadioActivePreset% >= 6500 and RadioPreset%RadioActivePreset% <= 7400)
{
RadioBandValue:=0
}
if (RadioPreset%RadioActivePreset% >= 8750 and RadioPreset%RadioActivePreset% <= 10800)
{
RadioBandValue:=1
}
return

RadioBand:
if (RadioBandValue < 2)
{
RadioBandValue += 1
}
else
{
RadioBandValue = 0
}
DllCall(Radio_SetBand, Int, RadioBandValue)
RadioBandValueOld=-1
gosub RefreshRadioBand
return

RefreshRadioBand:
if (RadioBandValueOld<>RadioBandValue)
{
if (RadioBandValue=0)
{
CVal1=%A_ScriptDir%\Skin\Radio\UKV.bmp
CVal2=%A_ScriptDir%\Skin\Radio\UKV.bmp
CName=RadioBand
ButtonPress(CName, CVal1, CVal2, 2)
}
if (RadioBandValue=1)
{
CVal1=%A_ScriptDir%\Skin\Radio\FM.bmp
CVal2=%A_ScriptDir%\Skin\Radio\FM.bmp
CName=RadioBand
ButtonPress(CName, CVal1, CVal2, 2)
}
if (RadioBandValue=2)
{
CVal1=%A_ScriptDir%\Skin\Radio\AM.bmp
CVal2=%A_ScriptDir%\Skin\Radio\AM.bmp
CName=RadioBand
ButtonPress(CName, CVal1, CVal2, 2)
}
}
return

;включить следующую станцию
radiosetnextpreset:
loopstart:=RadioActivePreset
loopcount:=28-loopstart
newpreset:=0
loop, %loopcount%
	{
	loopstart += 1
	if (RadioPreset%loopstart%<>0 and newpreset=0)
		{
		newpreset:=loopstart
		}
	}
if (newpreset<>0)
	{
	RadioActivePreset:=newpreset
	pn:=newpreset
	gosub getbandfrompreset
		RadioBand:=DllCall(Radio_GetCBand)
		If (RadioBand<>RadioBandValue)
			{
			DllCall(Radio_SetBand, Int, RadioBandValue) ;0-укв 1-фм 2-ам
			RadioBandValueOld=-1
			gosub RefreshRadioBand
			}
	ActiveF:=RadioPreset%RadioActivePreset%	
	DllCall(Radio_SetFreq, Int, ActiveF)
	if (ActiveRPGroup<>Ceil(RadioActivePreset/7))
		{
		ActiveRPGroup:=Ceil(RadioActivePreset/7)
		gosub ActivePRefresh ;обновляем выбор группы пресетов
		}
	else
		{
		gosub RadioPresetPress ;обновляем пресеты
		}
	}
return

;включить предыдущую станцию
radiosetprewpreset:
loopstart:=RadioActivePreset
loopcount:=loopstart-1
newpreset:=0
loop, %loopcount%
	{
	loopstart -= 1
	if (RadioPreset%loopstart%>0 and newpreset=0)
		{
		newpreset:=loopstart
		}
	}
if (newpreset>0)
	{
	RadioActivePreset:=newpreset
	pn:=newpreset
	gosub getbandfrompreset
		RadioBand:=DllCall(Radio_GetCBand)
		If (RadioBand<>RadioBandValue)
			{
			DllCall(Radio_SetBand, Int, RadioBandValue) ;0-укв 1-фм 2-ам
			RadioBandValueOld=-1
			gosub RefreshRadioBand
			}
	ActiveF:=RadioPreset%RadioActivePreset%	
	DllCall(Radio_SetFreq, Int, ActiveF)
	if (ActiveRPGroup<>Ceil(RadioActivePreset/7))
		{
		ActiveRPGroup:=Ceil(RadioActivePreset/7)
		gosub ActivePRefresh ;обновляем выбор группы пресетов
		}
	else
		{
		gosub RadioPresetPress ;обновляем пресеты
		}
	}
return

;обновляем выбор группы пресетов
ActivePRefresh:
Loop 4
	{
	if (ActiveRPGroup <> a_index)
	{
	CVal1=%A_ScriptDir%\Skin\Radio\rfm%a_index%.bmp
	CVal2=%A_ScriptDir%\Skin\Radio\rfm%a_index%.bmp
	CName=SetFM%a_index%
	ButtonPress(CName, CVal1, CVal2, 2)
	}
	else
	{
	CVal1=%A_ScriptDir%\Skin\Radio\rfm%a_index%p.bmp
	CVal2=%A_ScriptDir%\Skin\Radio\rfm%a_index%p.bmp
	CName=SetFM%a_index%
	ButtonPress(CName, CVal1, CVal2, 2)
	}
	}
gosub RefreshRadioPreset ;обновляем пресеты
gosub refreshlogo ;обновляем логотипы над кнопками
return

;обновляем логотипы над кнопками
refreshlogo:
pn:=ActiveRPGroup*7-7
Loop 7
	{
	pn += 1 
	pf:=RadioPreset%pn%
	if (ShowLogo=1)
	{
		IfExist, %A_ScriptDir%\Skin\Radio\Stations\%pf%.bmp
		{
			CVal1=%A_ScriptDir%\Skin\Radio\Stations\%pf%.bmp
			CVal2=%A_ScriptDir%\Skin\Radio\Stations\%pf%.bmp
			CName=logo%a_index%
			ButtonPress(CName, CVal1, CVal2, 2)
		}
		else
		{
			CVal1=
			CVal2=
			CName=logo%a_index%
			ButtonPress(CName, CVal1, CVal2, 2)
		}
	}
	else
		{
			CVal1=
			CVal2=
			CName=logo%a_index%
			ButtonPress(CName, CVal1, CVal2, 2)
		}
	}
return

;обновляем статус стерео
refreshstereostatus:
		STEREOUPDATE:=DllCall(Radio_GetStereoMsg)
		if STEREOUPDATE=1
			{
			GuiControl, 2:, Stereov, Stereo
			}
		else 
			{
			GuiControl, 2:, Stereov
			}
return

;обновляем частоту
refreshfreq:
if (RadioRuning=1)
{
ActiveF:=DllCall(Radio_GetFreq)
Freq := FreqString(ActiveF)
GuiControl, 2:, QFreq, %Freq%
GuiControl, 3:, QFreq, %Freq%
}
return

;обновляем пресеты
RefreshRadioPreset:
pn:=ActiveRPGroup*7-7
Loop 7
	{
	pn += 1 
	if (addpreset=0)
		{
		if (RadioActivePreset <> pn)
			{
			CVal1=%A_ScriptDir%\Skin\Radio\rpb.bmp
			CVal2=%A_ScriptDir%\Skin\Radio\rpb.bmp
			CName=Preset%a_index%
			ButtonPress(CName, CVal1, CVal2, 2)
			Gui, 2:Font, с%fcolor%
			GuiControl, 2:Font, RadioPresetBText%a_index%
			}
		else
			{
			CVal1=%A_ScriptDir%\Skin\Radio\rpbp.bmp
			CVal2=%A_ScriptDir%\Skin\Radio\rpbp.bmp
			CName=Preset%a_index%
			ButtonPress(CName, CVal1, CVal2, 2)
			PressedPreset:=pn
			Gui, 2:Font, c%fLcolor%
			GuiControl, 2:Font, RadioPresetBText%a_index%
			Gui, 2:Font, с%fcolor%
			}
		pf:=RadioPreset%pn%
		if (pf=0)
			{
			pf=
			}
		Freq := FreqString(pf)
		GuiControl, 2:, RadioPresetBText%a_index%, %Freq%
		}
	}
gosub refreshstereostatus
gosub getbandfrompreset
gosub RefreshRadioBand
return

;режим сохранения частоты в пресет (меняется тапом по текущей частоте)
QFreqg:
	if (addpreset=0)
		{
		addpreset=1
		Loop 7
			{
			CVal1=%A_ScriptDir%\Skin\Radio\rpbp.bmp
			CVal2=%A_ScriptDir%\Skin\Radio\rpbp.bmp
			CName=Preset%a_index%
			ButtonPress(CName, CVal1, CVal2, 2)
			}
		}
	else
		{
		addpreset=0
			gosub RefreshRadioPreset
		}
return

;задаем режим сканирования 0-авто 1-ручной
ScanModeg:
if (SearchMode=0)
	{
	SearchMode=1
	GuiControl, 2:, ScanModev, Manual
	}
else
	{
	SearchMode=0
	GuiControl, 2:, ScanModev, Auto
	}
return

;выбор пресета (реакция на тап по кнопке пресета)
RadioPresetB1:
	pn:=ActiveRPGroup*7-6
	gosub SubmitPreset
return

RadioPresetB2:
	pn:=ActiveRPGroup*7-5
	gosub SubmitPreset
return

RadioPresetB3:
	pn:=ActiveRPGroup*7-4
	gosub SubmitPreset
return

RadioPresetB4:
	pn:=ActiveRPGroup*7-3
	gosub SubmitPreset
return

RadioPresetB5:
	pn:=ActiveRPGroup*7-2
	gosub SubmitPreset
return

RadioPresetB6:
	pn:=ActiveRPGroup*7-1
	gosub SubmitPreset
return

RadioPresetB7:
	pn:=ActiveRPGroup*7
	gosub SubmitPreset
return

;выделяем нажатый пресет
RadioPresetPress:
RadioActivePreset:=PressedPreset
gosub getbandfrompreset
RadioBandValueOld:=RadioBandValue
PressedPreset:=PressedPreset-(ActiveRPGroup-1)*7
CVal1=%A_ScriptDir%\Skin\Radio\rpb.bmp
CVal2=%A_ScriptDir%\Skin\Radio\rpb.bmp
CName=Preset%PressedPreset%
ButtonPress(CName, CVal1, CVal2, 2)
Gui, 2:Font, с%fcolor%
GuiControl, 2:Font, RadioPresetBText%PressedPreset%

CVal1=%A_ScriptDir%\Skin\Radio\rpbp.bmp
CVal2=%A_ScriptDir%\Skin\Radio\rpbp.bmp
PressedPreset:=pn-(ActiveRPGroup-1)*7
CName=Preset%PressedPreset%
ButtonPress(CName, CVal1, CVal2, 2)
Gui, 2:Font, c%fLcolor%
GuiControl, 2:Font, RadioPresetBText%PressedPreset%

RadioActivePreset:=pn
PressedPreset:=pn

gosub refreshstereostatus
gosub getbandfrompreset
gosub RefreshRadioBand
return

;действие при выборе пресета (или активировать или сохранить новую частоту)
SubmitPreset:
if (addpreset=0)
	{
	if (RadioActivePreset<>pn) and (RadioPreset%pn% <> 0)
		{
		RadioActivePreset:=pn
		gosub getbandfrompreset
		RadioBand:=DllCall(Radio_GetCBand)
		If (RadioBand<>RadioBandValue)
			{
			DllCall(Radio_SetBand, Int, RadioBandValue) ;0-укв 1-фм 2-ам
			}
		ActiveF:=RadioPreset%pn%
		DllCall(Radio_SetFreq, Int, ActiveF)
		gosub RadioPresetPress
		}
	}
else
	{
	addpreset=0
	RadioPreset%pn%=%ActiveF%
	RadioActivePreset:=pn
	IniWrite, %ActiveF%, %radioini%, Radio, Preset%RadioActivePreset%
	gosub RefreshRadioPreset
	gosub refreshlogo
	}
return

;выбор группы пресетов
SetFM1:
	ActiveRPGroup=1
	gosub ActivePRefresh
return

SetFM2:
	ActiveRPGroup=2
	gosub ActivePRefresh
return

SetFM3:
	ActiveRPGroup=3
	gosub ActivePRefresh
return

SetFM4:
	ActiveRPGroup=4
	gosub ActivePRefresh
return

;скан в лево
ScanLg:
	CVal1=%A_ScriptDir%\Skin\Radio\rsb.bmp
	CVal2=%A_ScriptDir%\Skin\Radio\rsbp.bmp
	CName=ScanL
	ButtonPressF(CName, CVal1, CVal2, 2)
if (SearchMode=0)
	{
	DllCall(Radio_Search, Int, 1)
	RADIOAUTOSEARCHEND=0
	}
else
	{
	DllCall(Radio_ManSearch, Int, 1)
	}
return

;скан в право
ScanRg:
	CVal1=%A_ScriptDir%\Skin\Radio\rsf.bmp
	CVal2=%A_ScriptDir%\Skin\Radio\rsfp.bmp
	CName=ScanR
	ButtonPressF(CName, CVal1, CVal2, 2)
if (SearchMode=0)
	{
	DllCall(Radio_Search, Int, 0)
	RADIOAUTOSEARCHEND=0
	}
else
	{
	DllCall(Radio_ManSearch, Int, 0)
	}
return

;функция преобразования вида частоты (10240-102,40)
FreqString(FString)
	{
	if (FString>1620)
		{
		return SubStr(FString/100, 1, StrLen(FString)+1)
		}
	else
		{
		return FString
		}
	}

;отображать или нет логотипы
logog:
if (ShowLogo=0)
{
ShowLogo=1
}
else
{
ShowLogo=0
}
gosub refreshlogo
return

radiooff:
if (RadioRuning=1)
{
RadioRuning=0
SetTimer, RefreshClock, off
gosub StopSaver
IniWrite, %RadioActivePreset%, %radioini%, Radio, ActivePreset
IniWrite, %ShowLogo%, %radioini%, Radio, ShowLogo
DllCall(Api_SetActivateMode,Int,1)
ActivateModeLastState=1
gui, 2:Destroy
}
return

ExitRadio:
CVal1=%A_ScriptDir%\Skin\Radio\rexit.bmp
CVal2=%A_ScriptDir%\Skin\Radio\rexitp.bmp
CName=Exitv
ButtonPressF(CName, CVal1, CVal2, 2)
RadioRuning=0
SetTimer, RefreshClock, off
IniWrite, %RadioActivePreset%, %radioini%, Radio, ActivePreset
IniWrite, %ShowLogo%, %radioini%, Radio, ShowLogo
DllCall(Api_SetActivateMode,Int,1)
ActivateModeLastState=1
gosub stopclock
gui, 2:Destroy
return