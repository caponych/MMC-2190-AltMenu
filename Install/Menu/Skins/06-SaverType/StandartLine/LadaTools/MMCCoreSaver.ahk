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
Gui, 3:Font, с%fcolor% s60, %rfont%
Gui, 3:Add, Text, vMyTimeH gSaverClose 0x2 x0 y135 w380h85
Gui, 3:Add, Text, vMyTimeDD gSaverClose 0x1 x380 y135 w40 h85
Gui, 3:Add, Text, vMyTimeM gSaverClose 0 x420 y135 w380 h85
Gui, 3:Font, с%fcolor% s25, %rfont%
Gui, 3:Add, Text, vMyDayS gSaverClose 0x1 x0 y260 w800 h40
Gui, 3:Add, Text, vMyDateS gSaverClose 0x1 x0 y300 w800 h40
Gui, 3:Add, Picture, gSaverClose vSliderv x262 y233 w276 h20
Gui, 3:Font, s12, %rfont%
Gui, 3:Add, Picture, gSaverClose x0 y0 w800 h480
Gui, 3:Show, x0 y0 h480 w800, LadaScreenSaver
gosub startclock
return

changeslider:
			if (lasts=0)
				{
				lasts=1
				CVal=%A_ScriptDir%\Skin\ScreenSaver\slide.bmp
				Slider(CVal)
				}
			else
				{
				lasts=0
				CVal=
				Slider(CVal)
				}
return

Slider(CVal)
	{
	GuiControlGet, Pic, 3:Pos, Sliderv
	GuiControl, 3:, Sliderv,
	x:=PicX+1
	y:=PicY+1
	GuiControl, 3:Move, Sliderv, x%x% y%y%
	GuiControl, 3:, Sliderv, %CVal%
	GuiControl, 3:Move, Sliderv, x%PicX% y%PicY%
	}

RefreshSaverTrack:
return

SaverClose:
Gui, 3:Destroy
WinActivate, ahk_id %activewnds%
gosub stopclock
SaverRuning=0
gosub createsavertimer
return
