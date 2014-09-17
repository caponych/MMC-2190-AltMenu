startsaver:

WinGet, active_id, ID, A ;получаем хэндл окна
activewnds:=active_id 
activewnds:= activewnds + 0 ;переводим хэндл в десятичный вид

SaverRuning=1
MouseGetPos, xss, yss

;создаем гуи
Gui, 3:-SysMenu -Caption
Gui, 3:Color, %guibackcolor%
;часы
Gui, 3:Font, с%fcolor% s15, %rfont%
Gui, 3:Add, Text, vMyTimeH gSaverClose 0x2 x0 y415 w395 h25
Gui, 3:Add, Text, vMyTimeD gSaverClose 0x1 x395 y415 w10 h25
Gui, 3:Add, Text, vMyTimeM gSaverClose 0 x405 y415 w395 h25
Gui, 3:Font, с%fcolor% s12, %rfont%
Gui, 3:Add, Text, vMyDateS gSaverClose 0x1 x100 y440 w600 h25
Gui, 3:Font, s12, %rfont%
Gui, 3:Add, Picture, gSaverClose x40 y40 w720 h360, %A_ScriptDir%\Skin\ScreenSaver\saver.bmp
Gui, 3:Show, x0 y0 h480 w800, LadaScreenSaver
gosub startclock
return

changeslider:
	if (lasts=0)
		{
		lasts=1
		GuiControl, 3:, MyTimeD,:
		}
	else
		{
		lasts=0
		GuiControl, 3:, MyTimeD,
		}
return

RefreshSaverTrack:
return

SaverClose:
Gui, 3:Destroy
WinActivate, ahk_id %activewnds%
gosub stopclock
SaverRuning=0
gosub createsavertimer
return