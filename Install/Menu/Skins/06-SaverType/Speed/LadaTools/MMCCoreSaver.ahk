startsaver:
if (LastCanDashboardINIRead<>1){
	gosub initCANDashboard
}
WinGet, active_id, ID, A ;получаем хэндл окна
activewnds:=active_id 
activewnds:= activewnds + 0 ;переводим хэндл в десятичный вид

SaverRuning=1
;SaverFont=s80 c%fcolor%
MouseGetPos, xss, yss

;создаем гуи
Gui, 3:-SysMenu -Caption
Gui, 3:Color, %guibackcolor%
;Спидометр
;Gui, 3:Font, s80 с%fcolor% , %rfont%
Gui, 3:Font, %SaverFont_N%, %rfont%
Gui, 3:Add, Text, vSaverSpeed gSaverClose  x180 y160 w200 h150 Right, %SaverSpeed%
Gui, 3:Add, Text, vSpeedText gSaverClose  x400 y160 w240 h150 Left, км/ч

Gui, 3:Font, s12, %rfont%
Gui, 3:Add, Text, vVolv x20 y440 w80 h20
Gui, 3:Add, Text, 0x1 vQFreq x20 y20 w760 h20

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
