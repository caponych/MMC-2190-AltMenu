#SingleInstance ignore
DetectHiddenWindows, on

Gui, -SysMenu -Caption +AlwaysOnTop
Gui, Color, 1e1e1e
Gui, Add, Picture, gExitShtatg vExitShtat x20 y20 w160 h40, %A_ScriptDir%\Skin\Exit\Shtat.bmp
Gui, Add, Picture, gExitDesktopg vExitDesktop x20 y80 w160 h40, %A_ScriptDir%\Skin\Exit\Desktop.bmp
Gui, Add, Picture, gExitCancelg vExitCancel x20 y140 w160 h40, %A_ScriptDir%\Skin\Exit\Cancel.bmp
;Gui, Add, Picture, x0 y0 w200 h200, %A_ScriptDir%\Skin\Exit\bcgrnd.bmp
Gui, Show, w200 h200, Exit
return

ExitShtatg:
CVal1=%A_ScriptDir%\Skin\Exit\Shtat.bmp
CVal2=%A_ScriptDir%\Skin\Exit\Shtatp.bmp
CName=ExitShtat
ButtonPress(CName, CVal1, CVal2)
IfExist, %A_ScriptDir%\MortScript\power.exe
			 run %A_ScriptDir%\MortScript\power.exe
return

ExitDesktopg:
CVal1=%A_ScriptDir%\Skin\Exit\Desktop.bmp
CVal2=%A_ScriptDir%\Skin\Exit\Desktopp.bmp
CName=ExitDesktop
ButtonPress(CName, CVal1, CVal2)
IfExist, %A_ScriptDir%\MortScript\Desktop.exe
			 run %A_ScriptDir%\MortScript\Desktop.exe
return

ExitCancelg:
CVal1=%A_ScriptDir%\Skin\Exit\Cancel.bmp
CVal2=%A_ScriptDir%\Skin\Exit\Cancelp.bmp
CName=ExitCancel
ButtonPress(CName, CVal1, CVal2)
exitapp
return

ButtonPress(CName, CVal1, CVal2)
	{
	GuiControlGet, Pic, Pos, %CName%
	GuiControl, , %CName%, %CVal2%
	x:=PicX+1
	y:=PicY+1
	GuiControl Move, %CName%, x%x% y%y%
	Sleep, 200
	GuiControl, , %CName%, %CVal1%
	GuiControl Move, %CName%, x%PicX% y%PicY%
	}
	
GuiClose:
ExitApp