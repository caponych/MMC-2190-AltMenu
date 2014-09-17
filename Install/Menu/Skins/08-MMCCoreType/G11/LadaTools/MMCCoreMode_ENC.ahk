UWM_KEY_MODE(wParam, lParam)
{
global MsgCountStart
	if (MsgCountStart=0)
		{
		MsgCountStart+=1
			IfExist, %A_ScriptDir%\MortScript\MODE_KEY.mscr
				run %A_ScriptDir%\MortScript\MODE_KEY.mscr
		}
	else
		{
		if (MsgCountStart>=11)
			{
			MsgCountStart=0
			}
		else
			{
			MsgCountStart+=1
			}
		}
}

UWM_MessageENC(wParam, lParam)
{
global MsgCountStart
	if (MsgCountStart=0)
		{
		MsgCountStart+=1
			IfExist, %A_ScriptDir%\MortScript\SoftKey.mscr
				run %A_ScriptDir%\MortScript\SoftKey.mscr
		}
	else
		{
		if (MsgCountStart>=11)
			{
			MsgCountStart=0
			}
		else
			{
			MsgCountStart+=1
			}
		}
}