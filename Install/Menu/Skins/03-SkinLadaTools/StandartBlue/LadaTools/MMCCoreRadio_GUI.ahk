Gui, 2:-SysMenu -Caption
Gui, 2:Color, %guibackcolor%
Gui, 2:Font, с%fcolor%, %rfont%
Gui, 2:Add, Picture,gSetFM1 vSetFM1 x130 y25 w100 h65
Gui, 2:Add, Picture,gSetFM2 vSetFM2 x240 y25 w100 h65
Gui, 2:Add, Picture,gSetFM3 vSetFM3 x350 y25 w100 h65
Gui, 2:Add, Picture,gSetFM4 vSetFM4 x460 y25 w100 h65
Gui, 2:Add, Picture,gRadioBand vRadioBand x570 y25 w100 h65
Gui, 2:Add, Picture,gExitRadio vExitv x680 y25 w100 h65, %A_ScriptDir%\Skin\Radio\rexit.bmp
Gui, 2:Add, Picture,gScanLg vScanL x20 y187 w61 h58, %A_ScriptDir%\Skin\Radio\rsb.bmp
Gui, 2:Add, Picture,gScanRg vScanR x720 y187 w61 h58, %A_ScriptDir%\Skin\Radio\rsf.bmp
Gui, 2:Font, s12, %rfont%
Gui, 2:Add, Text, 0x1 gScanModeg vScanModev x10 y120 w80 h20, Auto
Gui, 2:Add, Text, 0x1 vStereov x710 y120 w80 h20
;Gui, 2:Add, Text, vVolv x20 y440 w80 h20, Vol:
;текст пресетов
Gui, 2:Font, s12, %rfont%
Gui, 2:Add, Text, 0x1 gRadioPresetB1 vRadioPresetBText1 x28 y355 w84 h20
Gui, 2:Add, Text, 0x1 gRadioPresetB2 vRadioPresetBText2 x138 y355 w84 h20
Gui, 2:Add, Text, 0x1 gRadioPresetB3 vRadioPresetBText3 x248 y355 w84 h20
Gui, 2:Add, Text, 0x1 gRadioPresetB4 vRadioPresetBText4 x358 y355 w84 h20
Gui, 2:Add, Text, 0x1 gRadioPresetB5 vRadioPresetBText5 x468 y355 w84 h20
Gui, 2:Add, Text, 0x1 gRadioPresetB6 vRadioPresetBText6 x578 y355 w84 h20
Gui, 2:Add, Text, 0x1 gRadioPresetB7 vRadioPresetBText7 x688 y355 w84 h20
;кнопки пресетов
Presetp=%A_ScriptDir%\Skin\Radio\rpb.bmp
Gui, 2:Add, Picture,gRadioPresetB1 vPreset1 x20 y345 w100 h40, %Presetp%
Gui, 2:Add, Picture,gRadioPresetB2 vPreset2 x130 y345 w100 h40, %Presetp%
Gui, 2:Add, Picture,gRadioPresetB3 vPreset3 x240 y345 w100 h40, %Presetp%
Gui, 2:Add, Picture,gRadioPresetB4 vPreset4 x350 y345 w100 h40, %Presetp%
Gui, 2:Add, Picture,gRadioPresetB5 vPreset5 x460 y345 w100 h40, %Presetp%
Gui, 2:Add, Picture,gRadioPresetB6 vPreset6 x570 y345 w100 h40, %Presetp%
Gui, 2:Add, Picture,gRadioPresetB7 vPreset7 x680 y345 w100 h40, %Presetp%
;лого станций
Gui, 2:Add, Picture,gRadioPresetB1 vLogo1 x20 y275 w100 h65
Gui, 2:Add, Picture,gRadioPresetB2 vLogo2 x130 y275 w100 h65
Gui, 2:Add, Picture,gRadioPresetB3 vLogo3 x240 y275 w100 h65
Gui, 2:Add, Picture,gRadioPresetB4 vLogo4 x350 y275 w100 h65
Gui, 2:Add, Picture,gRadioPresetB5 vLogo5 x460 y275 w100 h65
Gui, 2:Add, Picture,gRadioPresetB6 vLogo6 x570 y275 w100 h65
Gui, 2:Add, Picture,gRadioPresetB7 vLogo7 x680 y275 w100 h65
;текущая частота
Gui, 2:Font, s90, %rfont%
Gui, 2:Add, Text, 0x1 gQFreqg vQFreq x100 y140 w600 h150
;часы
Gui, 2:Font, s15, %rfont%
Gui, 2:Add, Text, vMyTime 0x1 x100 y415 w600 h25
Gui, 2:Font, s12, %rfont%
Gui, 2:Add, Text, vMyDate 0x1 x100 y440 w600 h25
Gui, 2:Add, Picture, x0 y405 w0 h0, %A_ScriptDir%\Skin\Radio\rline.bmp
Gui, 2:Add, Picture, glogog vlogov x20 y25 w100 h65, %A_ScriptDir%\Skin\Radio\rlogo.bmp