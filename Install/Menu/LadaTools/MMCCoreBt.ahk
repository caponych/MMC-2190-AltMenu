;сообщение определения номера звонящего
BT_DETECTED_CALL_NUMBER(wParam, lParam)
{
global MsgCountStart
	if (MsgCountStart=0)
		{
		MsgCountStart=1
		gosub BTRefreshCallNumber
		}
	else
		{
		MsgCountStart=0
		}
}

BTRefreshCallNumber:
		BTCallNumber:=DllCall(BT_GetCurrentCallNumber, "Str")
		GuiControl, 12:, GUICallNumber, %BTCallNumber%
return

;сообщение из длл-ки о текущем состоянии вызова с модуля бт
BT_CHANGE_STATE(wParam, lParam)
{
global MsgCountStart
global BT_GetCallState
global BT_GetCurrentCallNumber
global BTCallState
	if (MsgCountStart=0)
		{
		MsgCountStart=1
		BTCallState:=DllCall(BT_GetCallState, "Int")
		if (BTCallState=1)
			{
			gosub BTSoundOff
			Gui, 12:Destroy
			Gui, 13:Destroy
			Gui, 14:Destroy
			}
		if (BTCallState=3)
			{
			gosub NoCall
			}
		if (BTCallState=4)
			{
			gosub OutgoingCall
			}
		if (BTCallState=5)
			{
			gosub IncomingCall
			}
		if (BTCallState=6)
			{
			gosub ActiveCall
			}
		gosub bticonshow
		BTCallLastState:=BTCallState
		}
	else
		{
		MsgCountStart=0
		}
}

;событие завершения звонка
NoCall:
Gui, 12:Destroy
Gui, 13:Destroy
Gui, 14:Destroy
		WinGet, active_id, ID, A ;получаем хэндл окна
		activewnd:=active_id 
		activewnd:= activewnd + 0 ;переводим хэндл в десятичный вид
		WinActivate, ahk_id %activewnd%
gosub BTSoundOff
BTTerminate:=DllCall(BT_Terminate)
return

;событие исходящего звонка
OutgoingCall:
GuiNumber=14
Gui, 12:Destroy
Gui, 13:Destroy
WinGet, active_id, ID, A ;получаем хэндл окна
activewnd:=active_id 
activewnd:= activewnd + 0 ;переводим хэндл в десятичный вид
if (SaverRuning=1)
	{
	gosub MoveMouse
	}
Gui, 14:-SysMenu -Caption +AlwaysOnTop
Gui, 14:Color, %guibackcolor%
Gui, 14:Font, s30 с%fLcolor%, %rfont%
Gui, 14:Add, Text, 0x1 x20 y10 w430 h40, Исходящий вызов
Gui, 14:Font, s25 с%fLcolor%, %rfont%
Gui, 14:Add, Text, vGUICallNumber 0x1 x20 y60 w430 h40, Номер не определен
Gui, 14:Add, Picture, vAnswerCall x20 y120 w210 h75, %A_ScriptDir%\skin\bt\BTReceiveCallP.bmp
Gui, 14:Add, Picture, gEndCall vEndCall x240 y120 w210 h75, %A_ScriptDir%\skin\bt\BTEndCall.bmp
Gui, 14:Add, Picture, x0 y0 w470 h215, %A_ScriptDir%\skin\bt\bcgrnd.bmp
Gui, 14:Show, x165 y132 w470 h215, OutgoingCall
WinActivate, ahk_id %activewnd%
gosub BTSoundOn
return

;событие входящего звонка
IncomingCall:
GuiNumber=12
Gui, 13:Destroy
Gui, 14:Destroy
WinGet, active_id, ID, A ;получаем хэндл окна
activewnd:=active_id 
activewnd:= activewnd + 0 ;переводим хэндл в десятичный вид
if (SaverRuning=1)
	{
	gosub MoveMouse
	}
Gui, 12:-SysMenu -Caption +AlwaysOnTop
Gui, 12:Color, %guibackcolor%
Gui, 12:Font, s30 с%fLcolor%, %rfont%
Gui, 12:Add, Text, 0x1 x20 y10 w430 h40, Входящий вызов
Gui, 12:Font, s25 с%fLcolor%, %rfont%
Gui, 12:Add, Text, vGUICallNumber 0x1 x20 y60 w430 h40, Номер не определен
Gui, 12:Add, Picture, gAnswerCall vAnswerCall x20 y120 w210 h75, %A_ScriptDir%\skin\bt\BTReceiveCall.bmp
Gui, 12:Add, Picture, gEndCall vEndCall x240 y120 w210 h75, %A_ScriptDir%\skin\bt\BTEndCall.bmp
Gui, 12:Add, Picture, x0 y0 w470 h215, %A_ScriptDir%\skin\bt\bcgrnd.bmp
Gui, 12:Show, x165 y132 w470 h215, IncomingCall
WinActivate, ahk_id %activewnd%
gosub BTSoundOn
return

;событие активного звонка
ActiveCall:
GuiNumber=13
Gui, 12:Destroy
Gui, 14:Destroy
		btvolchange=1
		DllCall(Aud_SetVolume, "Int", BtVolume)
BTCallNumber:=DllCall(BT_GetCurrentCallNumber, "Str")
WinGet, active_id, ID, A ;получаем хэндл окна
activewnd:=active_id 
activewnd:= activewnd + 0 ;переводим хэндл в десятичный вид
if (SaverRuning=1)
	{
	gosub MoveMouse
	}
Gui, 13:-SysMenu -Caption +AlwaysOnTop
Gui, 13:Color, %guibackcolor%
Gui, 13:Font, s30 с%fLcolor%, %rfont%
Gui, 13:Add, Text, 0x1 x20 y10 w430 h40, Активный вызов
Gui, 13:Font, s25 с%fLcolor%, %rfont%
Gui, 13:Add, Text, vGUICallNumber 0x1 x20 y60 w430 h40, %BTCallNumber%
Gui, 13:Add, Picture, vAnswerCall x20 y120 w210 h75, %A_ScriptDir%\skin\bt\BTReceiveCallP.bmp
Gui, 13:Add, Picture, gEndCall vEndCall x240 y120 w210 h75, %A_ScriptDir%\skin\bt\BTEndCall.bmp
Gui, 13:Add, Picture, x0 y0 w470 h215, %A_ScriptDir%\skin\bt\bcgrnd.bmp
Gui, 13:Show, x165 y132 w470 h215, ActiveCall
WinActivate, ahk_id %activewnd%
return

;прием звонка
AnswerCall:
CVal1=%A_ScriptDir%\Skin\bt\BTReceiveCall.bmp
CVal2=%A_ScriptDir%\Skin\bt\BTReceiveCallP.bmp
CName=AnswerCall 
ButtonPressF(CName, CVal1, CVal2,GuiNumber)
gosub PickUpPhone
return

;завершениея звонка
EndCall:
CVal1=%A_ScriptDir%\Skin\bt\BTEndCall.bmp
CVal2=%A_ScriptDir%\Skin\bt\BTEndCallP.bmp
CName=EndCall 
ButtonPressF(CName, CVal1, CVal2,GuiNumber)
gosub PutDownPhone
Gui, 12:Destroy
Gui, 13:Destroy
Gui, 14:Destroy
return

;подымаем трубку
PickUpPhone:
if (BTCallState=5)
	{
	BTAnswer:=DllCall(BT_Answer)
	}
return

;ложим трубку
PutDownPhone:
;if (BTCallState=6 or BTCallState=4 or BTCallState=5)
;{
BTTerminate:=DllCall(BT_Terminate)
gosub BTSoundOff
BTTerminate:=DllCall(BT_Terminate)
;}
return

;включаем звук с бт
BTSoundOn:
if(BTActive=0)
	{
	DllCall(Api_SetActivateMode,Int,3)
	DllCall(Api_SetBTMuteState,Int,0)
	BTActive=1
	}
return

;выключаем звук с бт
BTSoundOff:
if(BTActive=1)
	{
	DllCall(Api_SetActivateMode,Int,ActivateModeLastState)
	DllCall(Api_SetBTMuteState,Int,1)
	BTActive=0
	if(btvolchange=1)
		{
		DllCall(Aud_SetVolume, "Int", SoundVolume)
		}
	btvolchange=0
	}
return
