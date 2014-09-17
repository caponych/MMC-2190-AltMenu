UWM_KEY_MODE(wParam, lParam)
{
global MsgCountStart
	if (MsgCountStart=0)
		{
			IfExist, %A_ScriptDir%\MortScript\MODE_KEY.mscr
				run %A_ScriptDir%\MortScript\MODE_KEY.mscr
		MsgCountStart=1
		}
	else
		{
		MsgCountStart=0
		}
}

UWM_MessageENC(wParam, lParam)
{
global MsgCountStart
	if (MsgCountStart=0)
		{
			IfExist, %A_ScriptDir%\MortScript\SoftKey.mscr
				run %A_ScriptDir%\MortScript\SoftKey.mscr
		MsgCountStart=1
		}
	else
		{
		MsgCountStart=0
		}
}