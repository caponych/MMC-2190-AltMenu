startsaver:

WinGet, active_id, ID, A ;получаем хэндл окна
activewnds:=active_id 
activewnds:= activewnds + 0 ;переводим хэндл в десятичный вид

SaverRuning=1
MouseGetPos, xss, yss

RegRead, AudioRunning, HKEY_LOCAL_MACHINE, System\State\Nitrogen, Running
RegRead, AudioSongArtist, HKEY_LOCAL_MACHINE, System\State\Nitrogen, SongArtist
RegRead, AudioSongTitle, HKEY_LOCAL_MACHINE, System\State\Nitrogen, SongTitle
AudioSongTitleOldS:=AudioSongTitle

;создаем гуи
Gui, 3:-SysMenu -Caption
Gui, 3:Color, %guibackcolor%
;часы
Gui, 3:Font, с%fcolor% s60, %rfont%
Gui, 3:Add, Text, vMyTimeH gSaverClose 0x2 x0 y135 w380h85
Gui, 3:Add, Text, vMyTimeD gSaverClose 0x1 x380 y135 w40 h85
Gui, 3:Add, Text, vMyTimeM gSaverClose 0 x420 y135 w380 h85
Gui, 3:Font, с%fcolor% s25, %rfont%
Gui, 3:Add, Text, vMyDayS gSaverClose 0x1 x0 y260 w800 h40
Gui, 3:Add, Text, vMyDateS gSaverClose 0x1 x0 y300 w800 h40
Gui, 3:Add, Picture, gSaverClose vSliderv x262 y233 w276 h20
Gui, 3:Font, s12, %rfont%
Gui, 3:Add, Text, vVolv x20 y440 w80 h20
Gui, 3:Add, Text, 0x1 vQFreq x20 y20 w760 h20
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
