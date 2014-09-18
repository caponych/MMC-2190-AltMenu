startsaver:
if (LastCanDashboardINIRead<>1){
	gosub initCANDashboard
}
WinGet, active_id, ID, A ;получаем хэндл окна
activewnds:=active_id 
activewnds:= activewnds + 0 ;переводим хэндл в десятичный вид

SaverRuning=1
SaverFont=s80 c%fcolor%
MouseGetPos, xss, yss
RegRead, AudioRunning, HKEY_LOCAL_MACHINE, System\State\Nitrogen, Running
RegRead, AudioSongArtist, HKEY_LOCAL_MACHINE, System\State\Nitrogen, SongArtist
RegRead, AudioSongTitle, HKEY_LOCAL_MACHINE, System\State\Nitrogen, SongTitle
AudioSongTitleOldS:=AudioSongTitle


;создаем гуи
Gui, 3:-SysMenu -Caption
Gui, 3:Color, %guibackcolor%
;Спидометр
;Gui, 3:Font, s80 с%fcolor% , %rfont%
Gui, 3:Font, %SaverFont%, %rfont%
Gui, 3:Add, Text, vSaverSpeed gSaverClose  x0 y160 w800 h150 Center, %SaverSpeed% км/ч
Gui, 3:Font, s12, %rfont%
Gui, 3:Add, Text, vVolv x20 y440 w80 h20
Gui, 3:Add, Text, 0x1 vQFreq x20 y20 w760 h20
Gui, 3:Font, c%fcolor% s60, %rfont%
Gui, 3:Add, Text, vMyTimeH gSaverClose x0 y315 w380 h85 Right
Gui, 3:Add, Text, vMyTimeD gSaverClose x380 y315 w40 h85 Center
Gui, 3:Add, Text, vMyTimeM gSaverClose x420 y315 w380 h85 left


Gui, 3:Add, Picture, gSaverClose x0 y0 w800 h480
Gui, 3:Show, x0 y0 h480 w800, LadaScreenSaver

if (AudioRunning=1)
	{
	GuiControl, 3:, QFreq,%AudioSongArtist% - %AudioSongTitle%
	}

if (RadioRuning=1)
	{
	gosub refreshfreq
	}
	
gosub startclock
return

changeslider:
	if (lasts=0)
		{
		lasts=1
		GuiControl, 3:, MyTimeD, :
		}
	else
		{
		lasts=0
		GuiControl, 3:, MyTimeD,
		}

return


RefreshSaverTrack:
if (AudioRunning=1)
	{
	RegRead, AudioSongTitle, HKEY_LOCAL_MACHINE, System\State\Nitrogen, SongTitle
	if (AudioSongTitleOldS<>AudioSongTitle)
		{
		RegRead, AudioSongArtist, HKEY_LOCAL_MACHINE, System\State\Nitrogen, SongArtist
		GuiControl, 3:, QFreq,%AudioSongArtist% - %AudioSongTitle%
		AudioSongTitleOldS:=AudioSongTitle
		}
	}
return

SaverClose:
Gui, 3:Destroy
WinActivate, ahk_id %activewnds%
gosub stopclock
SaverRuning=0
gosub createsavertimer
return
