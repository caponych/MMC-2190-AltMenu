AboutGuiShow:

Gui, 4:Destroy
Gui, 4:-SysMenu -Caption +AlwaysOnTop
Gui, 4:Color, %guibackcolor%
Gui, 4:Font, с%fcolor%, %rfont%
Gui, 4:Font, s12, %rfont%
Gui, 4:Add, Text, gAutoUpdateCheck 0x1 x10 y120 w280 h20, Version %NewMenuVersion%
Gui, 4:Add, Picture, gAutoUpdateCheck gExitAbout x0 y0 w300 h200, %A_ScriptDir%\Skin\About\bcgrnd.bmp
Gui, 4:Show, w300 h200, About

Sleep, 5000

ExitAbout:
Gui, 4:Destroy
return