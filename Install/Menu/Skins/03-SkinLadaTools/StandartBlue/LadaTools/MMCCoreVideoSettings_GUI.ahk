Gui, 7:-SysMenu -Caption
Gui, 7:Color, %guibackcolor%
Gui, 7:Font, с%fLcolor%, %rfont%
Gui, 7:Add, Picture, gExitVideo vExitVideo x20 y100 w0 h0, %A_ScriptDir%\skin\video\ve.bmp
Gui, 7:Add, Picture, gTouch vTouchv x590 y87 w0 h0, %A_ScriptDir%\skin\video\vsc.bmp
Gui, 7:Add, Picture, gModeVideo1 vModeVideo1 x115 y218 w0 h0, %A_ScriptDir%\skin\video\vms.bmp
Gui, 7:Add, Picture, gModeVideo2 vModeVideo2 x115 y304 w0 h0, %A_ScriptDir%\skin\video\vms.bmp
Gui, 7:Add, Picture, gSaverVideo vSaverVideo x115 y400 w0 h0, %A_ScriptDir%\skin\video\vms.bmp
Gui, 7:Add, Slider, gSliderVideo1 vSliderVideo1 Page10 Range1-60 x265 y229 w280 h40 
Gui, 7:Add, Slider, gSliderVideo2 vSliderVideo2 Page10 Range1-60 x265 y314 w280 h40 
Gui, 7:Add, Slider, gSliderVideo3 vSliderVideo3 Page5 Range1-30 x265 y407 w280 h40 
Gui, 7:Font, s12 с%fLcolor%, %rfont%
Gui, 7:Add, Text, 0x1 vTextSliderVideo1 x265 y209 w280 h20
Gui, 7:Add, Text, 0x1 vTextSliderVideo2 x265 y294 w280 h20
Gui, 7:Add, Text, 0x1 vTextSliderVideo3 x265 y387 w280 h20
Gui, 7:Add, Picture, x0 y0 w800 h480, %A_ScriptDir%\skin\video\bcgrnd.bmp
Gui, 7:Show, x0 y0 w800  h480, Lada Video Settings