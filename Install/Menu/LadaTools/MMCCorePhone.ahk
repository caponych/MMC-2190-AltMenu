;используемый шрифт
rfont=Kor_itelma
;используемый цвет шрифта
fcolor=c99ccff
fLcolor=cffffff
guibackcolor=000000
volprogress=Blue

Gui, 15:-SysMenu -Caption +AlwaysOnTop
Gui, 15:Color, %guibackcolor%
Gui, 15:Font, s30 с%fLcolor%, %rfont%

Gui, 15:Add, Picture, x10 y10 w160 h40, %A_ScriptDir%\skin\bt\izbrannoep.bmp
Gui, 15:Add, Picture, x170 y10 w160 h40, %A_ScriptDir%\skin\bt\kontakt.bmp
Gui, 15:Add, Picture, x330 y10 w160 h40, %A_ScriptDir%\skin\bt\zhurnal.bmp

Gui, 15:Add, Picture, gPhone1 vPhone1 x490 y100 w100 h80, %A_ScriptDir%\skin\bt\1.bmp
Gui, 15:Add, Picture, gPhone2 vPhone2 x590 y100 w100 h80, %A_ScriptDir%\skin\bt\2.bmp
Gui, 15:Add, Picture, gPhone3 vPhone3 x690 y100 w100 h80, %A_ScriptDir%\skin\bt\3.bmp

Gui, 15:Add, Picture, gPhone4 vPhone4 x490 y180 w100 h80, %A_ScriptDir%\skin\bt\4.bmp
Gui, 15:Add, Picture, gPhone5 vPhone5 x590 y180 w100 h80, %A_ScriptDir%\skin\bt\5.bmp
Gui, 15:Add, Picture, gPhone6 vPhone6 x690 y180 w100 h80, %A_ScriptDir%\skin\bt\6.bmp

Gui, 15:Add, Picture, gPhone7 vPhone7 x490 y260 w100 h80, %A_ScriptDir%\skin\bt\7.bmp
Gui, 15:Add, Picture, gPhone8 vPhone8 x590 y260 w100 h80, %A_ScriptDir%\skin\bt\8.bmp
Gui, 15:Add, Picture, gPhone9 vPhone9 x690 y260 w100 h80, %A_ScriptDir%\skin\bt\9.bmp

Gui, 15:Add, Picture, gPhonePlus vPhonePlus x490 y340 w100 h80, %A_ScriptDir%\skin\bt\+.bmp
Gui, 15:Add, Picture, gPhone0 vPhone0 x590 y340 w100 h80, %A_ScriptDir%\skin\bt\0.bmp
Gui, 15:Add, Picture, gPhoneCall vPhoneCall x690 y340 w100 h80, %A_ScriptDir%\skin\bt\call.bmp

Gui, 15:Show, x0 y0 w800 h480, Phone
return

Phone1:
Phone2:
Phone3:
Phone4:
Phone5:
Phone6:
Phone7:
Phone8:
Phone9:
Phone0:
PhonePlus:
PhoneCall:
return

;прием звонка
AnswerCall:
CVal1=%A_ScriptDir%\Skin\bt\BTReceiveCall.bmp
CVal2=%A_ScriptDir%\Skin\bt\BTReceiveCallP.bmp
CName=AnswerCall 
ButtonPressF(CName, CVal1, CVal2,15)

return

ButtonPressF(CName, CVal1, CVal2, guinumber)
	{
	GuiControlGet, Pic, %guinumber%:Pos, %CName%
	x:=PicX-1
	y:=PicY-1
	h:=PicH+2
	w:=PicW+2
	GuiControl, %guinumber%:, %CName%, %CVal2%
	GuiControl, %guinumber%:MoveDraw, %CName%, x%X% y%Y% h%h% w%w%
	Sleep, 200
	GuiControl, %guinumber%:, %CName%, %CVal1%
	GuiControl, %guinumber%:MoveDraw, %CName%, x%PicX% y%PicY% h%PicH% w%PicW%
	}