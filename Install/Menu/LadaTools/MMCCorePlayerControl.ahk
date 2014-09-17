OkPress:
if (RadioRuning=0)
	{
	if (SaverRuning=0)
		{
		gosub MoveMouse
		}
	IfExist, %A_ScriptDir%\OK.ahk
			run %A_ScriptDir%\OK.ahk
	if(BTCallState<>6 and BTActive=1)
		{
		if(BTAVRCPLastState=1)
			{
			DllCall(BT_AVRCPCmd, "Int",2)
			BTAVRCPLastState=0
			}
		else
			{
			DllCall(BT_AVRCPCmd, "Int",1)
			BTAVRCPLastState=1
			}
		}
	}
return

;кнопка вперед
ForwardPress:
if (RadioRuning=1)
	{
	gosub radiosetnextpreset
	gosub ShowFreckGui
	}
else
	{
	if (SaverRuning=0)
		{
		gosub MoveMouse
		}
		IfExist, %A_ScriptDir%\Forward.ahk
			run %A_ScriptDir%\Forward.ahk
	if(BTCallState<>6 and BTActive=1)
		{
			DllCall(Api_SetBTMuteState,Int,0)
			DllCall(BT_AVRCPCmd, "Int",4)
			DllCall(Api_SetBTMuteState,Int,1)
		}
		gosub ShowTrackGui
	}
return

;кнопка назад
BackwardPress:
if (RadioRuning=1)
	{
	gosub radiosetprewpreset
	gosub ShowFreckGui
	}
else
	{
	if (SaverRuning=0)
		{
		gosub MoveMouse
		}
		IfExist, %A_ScriptDir%\Backward.ahk
			run %A_ScriptDir%\Backward.ahk
	if(BTCallState<>6 and BTActive=1)
		{
			DllCall(Api_SetBTMuteState,Int,0)
			DllCall(BT_AVRCPCmd, "Int",5)
			DllCall(Api_SetBTMuteState,Int,1)
		}
		gosub ShowTrackGui
	}
return