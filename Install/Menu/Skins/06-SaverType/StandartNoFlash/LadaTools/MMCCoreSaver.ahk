startsaver:

WinGet, active_id, ID, A ;получаем хэндл окна
activewnds:=active_id 
activewnds:= activewnds + 0 ;переводим хэндл в десятичный вид

SaverRuning=1
MouseGetPos, xss, yss

lasts=0
;создаем гуи
Gui, 3:-SysMenu -Caption
Gui, 3:Color, %guibackcolor%
;часы
Gui, 3:Font, с%fcolor% s60, %rfont%
Gui, 3:Add, Text, vMyTimeH gSaverClose 0x2 x0 y135 w380h85
Gui, 3:Add, Text, vMyTimeDD gSaverClose 0x1 x380 y135 w40 h85
Gui, 3:Add, Text, vMyTimeM gSaverClose 0 x420 y135 w380 h85
Gui, 3:Font, с%fcolor% s25, %rfont%
Gui, 3:Add, Text, vMyDayS gSaverClose 0x1 x0 y260 w800 h40
Gui, 3:Add, Text, vMyDateS gSaverClose 0x1 x0 y300 w800 h40
Gui, 3:Font, s12, %rfont%
Gui, 3:Add, Picture, gSaverClose x0 y0 w800 h480
Gui, 3:Show, x0 y0 h480 w800, LadaScreenSaver
gosub startclock
return

changeslider:
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
