Gui, 6:-SysMenu -Caption
Gui, 6:Color, 000000
Gui, 6:Font, с%fcolor%, %rfont%
Gui, 6:Add, Picture, gSoundExit vSoundExit x20 y100 w100 h65, %A_ScriptDir%\skin\sound\ve.bmp
Gui, 6:Add, Picture, gSoundToneB vSoundToneB x605 y33 w100 h40, %A_ScriptDir%\skin\sound\vms.bmp
Gui, 6:Add, Button, x710 y33 w60 h40 vLoudCF gLoudCF
Gui, 6:Add, Picture, gSoundPreset1 vSoundPreset1 x20 y245 w100 h65, %A_ScriptDir%\skin\sound\p1.bmp
Gui, 6:Add, Picture, gSoundPreset2 vSoundPreset2 x130 y245 w100 h65, %A_ScriptDir%\skin\sound\p2.bmp
Gui, 6:Add, Picture, gSoundPreset3 vSoundPreset3 x20 y320 w100 h65, %A_ScriptDir%\skin\sound\p3.bmp
Gui, 6:Add, Picture, gSoundPreset4 vSoundPreset4 x130 y320 w100 h65, %A_ScriptDir%\skin\sound\p4.bmp
Gui, 6:Add, Picture, gSoundPreset5 vSoundPreset5 x20 y395 w100 h65, %A_ScriptDir%\skin\sound\p5.bmp
Gui, 6:Add, Picture, gSoundPreset6 vSoundPreset6 x130 y395 w100 h65, %A_ScriptDir%\skin\sound\p6.bmp
Gui, 6:Add, Slider, gSoundSlider1 vSoundSlider1 Range-14-14 Vertical Invert Page1 x280 y150 w40 h300 
Gui, 6:Add, Slider, gSoundSlider2 vSoundSlider2 Range-14-14 Vertical Invert Page1 x365 y150 w40 h300 
Gui, 6:Add, Slider, gSoundSlider3 vSoundSlider3 Range-14-14 Vertical Invert Page1 x450 y150 w40 h300 
Gui, 6:Font, s12 с%fcolor%, %rfont%
Gui, 6:Add, Text, 0x1 vSText1 x275 y130 w40 h20
Gui, 6:Add, Text, 0x1 vSText2 x360 y130 w40 h20
Gui, 6:Add, Text, 0x1 vSText3 x445 y130 w40 h20
Gui, 6:Add, Picture, vBalanceIcon x652 y287 w20 h20, %A_ScriptDir%\skin\sound\BF.bmp
Gui, 6:Add, Picture, gSoundBalance x527 y115 w250 h345, %A_ScriptDir%\skin\sound\balance.bmp
Gui, 6:Add, Picture, x0 y0 w800 h480, %A_ScriptDir%\skin\sound\bcgrnd.bmp
Gui, 6:Show, x0 y0 w800  h480, Lada Sound Settings