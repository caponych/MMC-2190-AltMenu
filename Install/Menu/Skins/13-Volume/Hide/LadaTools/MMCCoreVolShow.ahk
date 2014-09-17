;обновляем громкость
RefreshVol:
	AUD_VOL:=DllCall(Aud_GetVolume)
	if (VolRuning=0)
		{
		VolRuning=1
		AUD_VOLOld:=AUD_VOL
		SetTimer, startvoltimer, 300
		}
	else
		{
		if (AUD_VOL<>AUD_VOLOld)
			{
			AUD_VOLOld:=AUD_VOL
			}
		}
	VolTickCount=0
return

;таймер громкости
startvoltimer:
	VolTickCount += 1
	if (VolTickCount>3)
		{
		VolTickCount=0
		VolRuning=0
		SetTimer, startvoltimer, off
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

		}
return
