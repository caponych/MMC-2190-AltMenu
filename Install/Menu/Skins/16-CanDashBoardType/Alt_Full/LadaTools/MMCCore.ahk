;������ ����:
;2-�����
;3-��������
;4-�����
;5-������
;6-��������� �����
;7-��������� �����
;8-���������
;9-mute
;10-����
;11-�������
;12-�������� �����
;13-�������� �����
;14-��������� �����
;15-�������
;16-����������� ���������
;18-��������� ��

#SingleInstance ignore
DetectHiddenWindows, on
CoordMode, Mouse, Screen

IfExist, %A_ScriptDir%\OnError.ahk
			 run %A_ScriptDir%\OnError.ahk
			 
;������� ���������
msg_ID := DllCall("RegisterWindowMessage", "str", "UWM_KEY-{20E33C37-C776-40ad-9AB0-D80BD031DB13}")
msgC_ID := DllCall("RegisterWindowMessage", "str", "UWM_COMAND-{20E33C37-C776-40ad-9AB0-D80BD031DB13}")
msg_AUD_VOL_ID := DllCall("RegisterWindowMessage", "str", "UWM_AUD_VOL-{20E33C37-C776-40ad-9AB0-D80BD031DB13}")
msg_RADIO_AUTOSEARCHEND_ID := DllCall("RegisterWindowMessage", "str", "UWM_RADIO_AUTOSEARCH_END-{7049499B-0480-44f9-BF71-4AE91FA}")
msg_RADIO_NEWFREQ_ID := DllCall("RegisterWindowMessage", "str", "UWM_RADIO_NEW_FREQ-{7049499B-0480-44f9-BF71-4AE91FA0443C}")
msg_KEY_MODE_ID := DllCall("RegisterWindowMessage", "str", "UWM_KEY_MODE-{20E33C37-C776-40ad-9AB0-D80BD031DB13}")
msg_PUSHENC_ID := DllCall("RegisterWindowMessage", "str", "UWM_KEY_PUSHENC-{20E33C37-C776-40ad-9AB0-D80BD031DB13}")
msg_POWERUP_ID := DllCall("RegisterWindowMessage", "str", "UWM_SYS_POWER_UP-{20E33C37-C776-40ad-9AB0-D80BD031DB13}")
msg_mute_ID := DllCall("RegisterWindowMessage", "str", "UWM_AUD_MUTE-{20E33C37-C776-40ad-9AB0-D80BD031DB13}")

OnMessage(msg_ID, "UWM_KEY")
OnMessage(msgC_ID, "UWM_COMAND")
OnMessage(msg_AUD_VOL_ID, "UWM_AUD_VOL")
OnMessage(msg_RADIO_AUTOSEARCHEND_ID, "UWM_RADIO_AUTOSEARCHEND")
OnMessage(msg_RADIO_NEWFREQ_ID, "UWM_RADIO_NEWFREQ")
OnMessage(msg_KEY_MODE_ID, "UWM_KEY_MODE")
OnMessage(msg_PUSHENC_ID, "UWM_MessageENC")
OnMessage(msg_POWERUP_ID, "UWM_POWERUP")
OnMessage(msg_mute_ID, "UWM_MUTE")
OnMessage(1025, "BT_CHANGE_STATE")
OnMessage(1028, "BT_DETECTED_CALL_NUMBER")
;OnMessage(1026, "BT_INCOMING_CALL")
;OnMessage(1027, "BT_END_CALL")
OnMessage(1088, "CAN_CHANGE_ENGINE_TEMP") ;// ��������� �� ��������� �������� ����������� ���������
OnMessage(1089, "CAN_CHANGE_FUEL") ;// ��������� �� ��������� �������� ������ �������
OnMessage(1090, "CAN_CHANGE_GEARBOX_TEMP") ;// ��������� �� ��������� �������� ����������� ����
OnMessage(1091, "CAN_CHANGE_AIR_TEMP") ;// ��������� �� ��������� �������� ����������� �������
OnMessage(1092, "CAN_CHANGE_BAT_CHARGE_FLAG") ;// ��������� �� ��������� ��������� �����
OnMessage(1093, "CAN_CHANGE_WARN_ENG_TEMP_FLAG") ;// ��������� �� ��������� ��������� �����
OnMessage(1094, "CAN_CHANGE_WARN_OIL_PRES_FLAG") ;// ��������� �� ��������� ��������� �����
OnMessage(1095, "CAN_CHANGE_CHECK_ENGINE_FLAG") ;// ��������� �� ��������� ��������� �����
OnMessage(1096, "CAN_CHANGE_ACTIVE") ;// ��������� �� ��������� ���������� CAN-���� (��������� ��� ���������� ������� �� ���������� �������� � ID 280)
;���������� � ��������
OnMessage(1097, "CAN_CHANGE_SPEED") ;// ��������� �� ��������� ��������



IfExist, Program Files\MMC\MMC21.dll
	mmc21=Program Files\MMC\MMC21.dll
IfExist, Program Files\MMC\MMC21v42.dll
	mmc21=Program Files\MMC\MMC21v42.dll
IfExist, Program Files\MMC\MMC23.dll
	mmc21=Program Files\MMC\MMC23.dll
BluetoothMMCdll=%A_ScriptDir%\BluetoothMMC.dll
CanMMCdll=%A_ScriptDir%\mmc_can.dll

BT_Init=%BluetoothMMCdll%\Init
Can_Init=%CanMMCdll%\Init
MMC21_init=%mmc21%\MMC21_init
MMC21_uninit=%mmc21%\MMC21_uninit

DllCall("LoadLibrary", "Str", mmc21) ;���������
DllCall(MMC21_init) ;��������������

;�������� ������� ����� � ������ ���
#Include %A_ScriptDir%\MMCCoreIniRead.ahk

;�������� � ������� MMCCore ���
gosub MMCCoreGuiCreate

DllCall("LoadLibrary", "Str", BluetoothMMCdll) ;���������
BT_Init_result:=DllCall(BT_Init, "Int", sethwnd) ;��������������
if(CanAutoShowAllow=1)
{
DllCall("LoadLibrary", "Str", CanMMCdll) ;���������
Can_Init_result:=DllCall(Can_Init, "Int", sethwnd) ;��������������
}

;������ ����������� ��������� ����� � ������
DllCall(Api_SetActivateMode,Int,1)
ActivateModeLastState=1
gosub FistInit
gosub caminit
DllCall(Aud_SetVolume,Int,SoundVolume)
gosub AutoUpdateCheck
gosub startclock
Gui, Cancel
return

#IncludeAgain %A_ScriptDir%\MMCCoreMode_ENC.ahk

;������ ����� ������� �����
UWM_RADIO_NEWFREQ(wParam, lParam)
{
global MsgCountStart
	if (MsgCountStart=0)
		{
		MsgCountStart=1
		gosub refreshfreq
		}
	else
		{
		MsgCountStart=0
		}
}

;��������� ����� ��������
UWM_RADIO_AUTOSEARCHEND(wParam, lParam)
{
global MsgCountStart
global RADIOAUTOSEARCHEND
	if (MsgCountStart=0)
		{
		RADIOAUTOSEARCHEND=1
		MsgCountStart=1
		}
	else
		{
		MsgCountStart=0
		}
}

;����� ���������
UWM_AUD_VOL(wParam, lParam)
{
global MsgCountStart
	if (MsgCountStart=0)
		{
		gosub RefreshVol
		MsgCountStart=1
		}
	else
		{
		MsgCountStart=0
		}
}

UWM_MUTE(wParam, lParam)
{
global MsgCountStart
	if (MsgCountStart=0)
		{
		gosub Mute
		MsgCountStart=1
		}
	else
		{
		MsgCountStart=0
		}
}

UWM_POWERUP(wParam, lParam)
{
global BT_GetCallState
global BTCallState
global MsgCountStart
	if (MsgCountStart=0)
		{
		gosub StopSaver
		gosub caminit
		gosub AutoUpdateCheck
		BTCallState:=DllCall(BT_GetCallState, "Int")
		gosub bticonshow
		MsgCountStart=1
		}
	else
		{
		MsgCountStart=0
		}
}

;������� ����
UWM_COMAND(wParam, lParam)
{
	global MsgCountStart
	global NaviProgRuning
	global MediaProgRuning
	global RadioRuning
	global SaverActivate
	global SaverRuning
	global SaverTickCount
	SaverTickCount=0
	if (MsgCountStart=0)
		{
		if (SaverRuning=1 and lParam <> 6 and lParam <> 8 and lParam <> 9)
			{
			gosub StopSaver
			}
;--------------------���������� ����
;	GuiControl,, CoreGUIText, Com %wParam% %lParam%
;--------------------���������� ����
		if (wParam=1 and lParam =1) ;��������� ��������� �����
			{
				gosub VideoSettingsStartGui
			}
		if (wParam=1 and lParam =2) ;��������� ��������� �����
			{
				gosub SoundSettingsStartGui
			}
		if (wParam=1 and lParam =4) ;��������� ��������� ������ ������
			{
				gosub RearCamSettingsStartGui
			}
		if (wParam=1 and lParam =5) ;��������� �����������
			{
				NaviProgRuning=1
			}
		if (wParam=1 and lParam =6) ;��������� ���������
			{
				NaviProgRuning=0
			}
		if (wParam=1 and lParam =7) ;����� �����������
			{
				MediaProgRuning=1
			}
		if (wParam=1 and lParam =8) ;����� ���������
			{
				MediaProgRuning=0
			}
		if (wParam=1 and lParam =9) ;������� ������
			{
				if (NaviProgRuning=0 and MediaProgRuning=0)
					{
					gosub runsaver
					}
			}
		if (wParam=1 and lParam =10) ;��������� �����
			{
			gosub radiooff
			}			
			MsgCountStart=1
			gosub createsavertimer
		}
	else
		{
		MsgCountStart=0
		}
}
return

UWM_KEY(wParam, lParam)
	{
	global MsgCountStart
	global SaverActivate
	global SaverRuning
	global SaverTickCount
	SaverTickCount=0
	
	if (MsgCountStart=0)
		{
		if (SaverRuning=1 and wParam <> 7 and wParam <> 8 and wParam <> 9 and wParam <> 11 and wParam <> 14 and wParam <> 0)
			{
			gosub StopSaver
			}
;--------------------���������� ����
;			GuiControl,, CoreGUIText, Key %wParam% %lParam%
;--------------------���������� ����
		Action:=Action_%wParam%_%lParam%
		Path:=Path_%wParam%_%lParam%
		if (Action="Run")
			{
			IfExist, %A_ScriptDir%\MortScript\%Path%
			 run %A_ScriptDir%\MortScript\%Path%
			}
		if (Action="GoSub")
			{
			 Gosub %Path%
			}
		MsgCountStart=1
		gosub createsavertimer
		}
	else
		{
		MsgCountStart=0
		}
	}

Mute:
MuteState:=DllCall(Api_GetMuteState)
if (MuteState=1)
{
gosub muteshow
}
else
{
gosub mutehide
}
return

;������ ����� ����/����
DayNight:
if LastVideoMode=2
	{
	if (VideoSettingsRun=1)
		{
		gosub ModeVideo1
		}
	else
		{
		DllCall(Vid_SetBright, int, DayBri)
		DllCall(Vid_SetContrast, int, DayCon)
		DllCall(Vid_SetColor, int, DayCol)
		LastVideoMode=1
		}
	}
else
	{
	if (VideoSettingsRun=1)
		{
		gosub ModeVideo2
		}
	else
		{
		DllCall(Vid_SetBright, int, NightrBri)
		DllCall(Vid_SetContrast, int, NightrCon)
		DllCall(Vid_SetColor, int, NightrCol)
		LastVideoMode=2
		}
	}
IniWrite, %LastVideoMode%, %videoini%, Mode, Last
return

ButtonPress(CName, CVal1, CVal2, guinumber)
	{
	GuiControlGet, Pic, %guinumber%:Pos, %CName%
	x:=PicX-1
	y:=PicY-1
	h:=PicH+2
	w:=PicW+2
	GuiControl, %guinumber%:, %CName%, %CVal1%
	GuiControl, %guinumber%:MoveDraw, %CName%, x%X% y%Y% h%h% w%w%
	GuiControl, %guinumber%:MoveDraw, %CName%, x%PicX% y%PicY% h%PicH% w%PicW%
	}


ButtonPressF(CName, CVal1, CVal2, guinumber)
	{
	GuiControlGet, Pic, %guinumber%:Pos, %CName%
	x:=PicX-1
	y:=PicY-1
	h:=PicH+2
	w:=PicW+2
	GuiControl, %guinumber%:, %CName%, %CVal2%
	GuiControl, %guinumber%:MoveDraw, %CName%, x%X% y%Y% h%h% w%w%
	Sleep, 200
	GuiControl, %guinumber%:, %CName%, %CVal1%
	GuiControl, %guinumber%:MoveDraw, %CName%, x%PicX% y%PicY% h%PicH% w%PicW%
	}
	
StartMainMenu:
if (MediaProgRuning=0 and NaviProgRuning=0)
{
IfExist, %A_ScriptDir%\MortScript\Menu.exe
			 run %A_ScriptDir%\MortScript\Menu.exe
}
return

StartMedia:
if (MediaProgRuning=0 and NaviProgRuning=0)
	{
	MediaProgRuning=1
	gosub radiooff
	IfExist, %A_ScriptDir%\MortScript\media.mscr
			 run %A_ScriptDir%\MortScript\media.mscr
	}
else if (MediaProgRuning=1)
	{
	MediaProgRuning=0
	IfExist, %A_ScriptDir%\MortScript\mediaoff.mscr
			 run %A_ScriptDir%\MortScript\mediaoff.mscr
	}
return

NaviStart:
gosub StopSaver
IfExist, %A_ScriptDir%\MortScript\NaviStart.exe
			 run %A_ScriptDir%\MortScript\NaviStart.exe
return

Navi2Start:
gosub StopSaver
IfExist, %A_ScriptDir%\MortScript\NaviStart2.exe
			 run %A_ScriptDir%\MortScript\NaviStart2.exe
return

StopSaver:
if (SaverRuning=1)
	{
	gosub SaverClose
	}
return

MoveMouse:
	Random, rx, 1, 20
	Random, ry, 1, 20
	MouseMove, rx, ry
return

MMCCoreGuiCreate:
	Gui, -SysMenu -Caption +AlwaysOnTop
	Gui, Color, %guibackcolor%
	Gui, Font, �%fcolor%
	Gui, Add, Text, 0x1 vCoreGUIText x0 y2 w140 h18, MMCCore Starting...
	Gui, Show, x330 y460 w140 h20, MMCCore
	gosub sethwnd
	gosub createsavertimer
return

sethwnd:
WinGet, active_id, ID, A ;�������� ����� ����
sethwnd:=active_id 
sethwnd:= sethwnd + 0 ;��������� ����� � ���������� ���
DllCall(Api_SetHwnd, "Int", sethwnd) ;������ �����
RegWrite, REG_SZ, HKEY_LOCAL_MACHINE, SOFTWARE\LadaTools, CoreHWND, %sethwnd%
return

;������� ������ ���������
createsavertimer:
SaverTickCount=0
if (SaverActivate=1 and NaviProgRuning=0 and MediaProgRuning=0)
	{
	MouseGetPos, xs, ys
	SetTimer, startsavertimer, 1000
	}
else
	{
	SetTimer, startsavertimer, off
	}
return

runsaver:
if (SaverActivate=1 and NaviProgRuning=0 and MediaProgRuning=0  and SaverRuning=0)
	{
	imediatlysaverrun=1
	}
else if (SaverActivate=0 and NaviProgRuning=0 and MediaProgRuning=0  and SaverRuning=0)
	{
	gosub startsaver
	}
return

;������ ���������
startsavertimer:

if (SaverActivate=1 and NaviProgRuning=0 and MediaProgRuning=0  and SaverRuning=0 and imediatlysaverrun=0)
	{
	MouseGetPos, xn, yn
	if  (xn=xs and yn=ys)
		{
		SaverTickCount += 1
		}
	else
		{
		gosub createsavertimer
		}
	if (SaverTickCount>IdleTime)
		{
		gosub startsaver
		}
	}
else
	{
	SaverTickCount=0
	SetTimer, startsavertimer, off
	}
	
if(SaverActivate=1 and NaviProgRuning=0 and MediaProgRuning=0  and SaverRuning=0 and imediatlysaverrun=1)
	{
	imediatlysaverrun=0
	gosub startsaver
	}

;--------------------���������� ����
;	GuiControl,, CoreGUIText, %SaverActivate% %SaverRuning% %NaviProgRuning% %MediaProgRuning% %SaverTickCount%
;--------------------���������� ����
return

startclock:
if (RadioRuning=1 or SaverRuning=1)
{
firstclockstart=1
SetTimer, RefreshClock, 1000
}
return

stopclock:
if (RadioRuning=0 and SaverRuning=0)
{
SetTimer, RefreshClock, off
}
return

RefreshClock:
	;���������� �����
	if(firstclockstart=1)
		{
		FSec2= -1
		FMin2= -1
		FDay2= -1
		lasts=1
		firstclockstart=0
		}
	FSec=%A_Sec%
	 if (FSec<>FSec2) 
		{
		gosub changeslider
		FSec2=%FSec%
		gosub RefreshSaverTrack
		}
		
	FMin = %A_Min%
	if (FMin<>FMin2) 
		{
		GuiControl, 2:, MyTime, %A_Hour% : %A_Min%
		GuiControl, 3:, MyTimeH, %A_Hour%
		GuiControl, 3:, MyTimeDD, :
		GuiControl, 3:, MyTimeM, %A_Min%
		FMin2=%FMin%
		;���������� ����
		FDay = %A_DD%
		if (FDay<>FDay2) 
			{
			Wday:=Day%A_WDay%
			Mon:=Mon%A_Mon%
			Day:=floor(FDay)
			GuiControl, 2:, MyDate, %Wday%, %Day% %Mon% %A_YYYY%
			GuiControl, 3:, MyDateS, %Day% %Mon% %A_YYYY%
			GuiControl, 3:, MyDayS, %Wday%
			FDay2=%FDay%
			}
		}
	if (SaverRuning=1)
		{
		gosub findmousemove
		}
return

findmousemove:
	MouseGetPos, xns, yns
		if  (xns<>xss or yns<>yss)
			{
			Gui, 3:Destroy
			SaverRuning=0
			gosub stopclock
			gosub createsavertimer
			}
return

AutoUpdateCheck:
;������ ��� ������
IfNotExist, %NewMenuVersionini%
	{
	FileAppend,, %NewMenuVersionini%
	IniWrite, 0, %NewMenuVersionini%, NewMenu, Version
	}
IniRead, NewMenuVersion, %NewMenuVersionini%, NewMenu, Version

;�������������� 
AutoUpdate=0
IfExist, \SDMMC\Install\Menu\LadaTools\INI\NewMenuVersion.ini
	AutoUpdate=1
IfExist, \USB Disk\Install\Menu\LadaTools\INI\NewMenuVersion.ini
	AutoUpdate=2
	
if (AutoUpdate=1)
	{
	IniRead, NewMenuVersionNew, \SDMMC\Install\Menu\LadaTools\INI\NewMenuVersion.ini, NewMenu, Version
	if (NewMenuVersionNew<>NewMenuVersion)
		{
		IfExist, \SDMMC\Install\UpDate.exe
			{
			run \SDMMC\Install\UpDate.exe
			}
		else
			{
			IfExist, \SDMMC\Install\Install.exe
				run \SDMMC\Install\Install.exe
			}
		}
	}
	
if (AutoUpdate=2)
	{
	IniRead, NewMenuVersionNew, \USB Disk\Install\Menu\LadaTools\INI\NewMenuVersion.ini, NewMenu, Version
	if (NewMenuVersionNew<>NewMenuVersion)
		{
		IfExist, \USB Disk\Install\UpDate.exe
			{
			run \USB Disk\Install\UpDate.exe
			}
		else
			{
			IfExist, \USB Disk\Install\Install.exe
				run \USB Disk\Install\Install.exe
			}
		}
	}		 
return		

;�����������
#IncludeAgain %A_ScriptDir%\MMCCoreSaver.ahk

;��������� �����
#IncludeAgain %A_ScriptDir%\MMCCoreVideoSettings.ahk

;��������� �����
#IncludeAgain %A_ScriptDir%\MMCCoreSoundSettings.ahk

;������ ������� ����
#IncludeAgain %A_ScriptDir%\MMCCoreRearViewCam.ahk

;�����
#IncludeAgain %A_ScriptDir%\MMCCoreRadio.ahk

;������ ����������� ��������� ����� � ������
#IncludeAgain %A_ScriptDir%\MMCCoreAudioVideoInit.ahk

;�����
#IncludeAgain %A_ScriptDir%\MMCCoreAbout.ahk

;���� ���������
#IncludeAgain %A_ScriptDir%\MMCCoreVolShow.ahk

;���� mute
#IncludeAgain %A_ScriptDir%\MMCCoreMuteShow.ahk

;���� �����
#IncludeAgain %A_ScriptDir%\MMCCoreShowTrack.ahk

;���� �������
#IncludeAgain %A_ScriptDir%\MMCCoreShowFreq.ahk

;���� �������
#IncludeAgain %A_ScriptDir%\MMCCorePlayerControl.ahk

;����� ���
#IncludeAgain %A_ScriptDir%\MMCCoreBt.ahk
#IncludeAgain %A_ScriptDir%\MMCCoreBTIconShow.ahk
;can
#IncludeAgain %A_ScriptDir%\MMCCoreCan.ahk

DeBugMe:
;ListVars
;Pause
return

GuiClose:
DllCall(MMC21_uninit)
DllCall("FreeLibrary", "Int", mmc21) ;���������
DllCall("FreeLibrary", "Int", BluetoothMMCdll) ;���������
DllCall("FreeLibrary", "Int", CanMMCdll) ;���������
ExitApp
