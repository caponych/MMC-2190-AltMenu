IfExist, Program Files\MMC\MMC21.dll ;если есть такая, то путь к ней
	mmc21=Program Files\MMC\MMC21.dll

IfExist, Program Files\MMC\MMC23.dll ;если есть такая, то путь к ней
	mmc21=Program Files\MMC\MMC23.dll

;пропишем функции дллки
MMC21_init=%mmc21%\MMC21_init
MMC21_uninit=%mmc21%\MMC21_uninit

DllCall("LoadLibrary", "Str", mmc21) ;загружаем
DllCall(MMC21_init) ;инициализируем

Section_p=API||Aud|Audi|MMC21|Radio|Rds|Vid

Function_p=Api_BtReset||Api_CallEepromData|API_CallRadioValue|Api_GetActivateMode|API_GetCAMState|Api_GetCurrentTime|Api_GetDLLversion|Api_GetEepromData|Api_GetHwnd|Api_GetMCUversion|Api_GetMuteState|API_GetRadioValue|Api_GetRDSTime|Api_GetSysInitState|Api_GetUsbState|API_RadioAFFreq|API_RadioStationIfc|API_RadioStationLevel|API_RadioStationUsn|API_RadioStationWam|Api_Reset|Api_SetActivateMode|Api_SetBTMuteState|API_SetCAMState|Api_SetCurrentTime|Api_SetEepromData|Api_SetHwnd|Api_SetMuteState|API_SetRadioValue|Api_SetSleepReady|Api_SetTouch

;рисуем гуи
Gui +AlwaysOnTop 
Gui, Add, Text, x12 y10 w70 h20 , Section
Gui, Add, ComboBox, vSectionv x92 y10 w110 h150, %Section_p%
Gui, Add, Button, x212 y10 w30 h20 , OK
Gui, Add, Text, x12 y40 w70 h20 , Function
Gui, Add, ComboBox, VFunctionv x92 y40 w150 h200 , %Function_p%
Gui, Add, Button, x12 y100 w230 h30 , Call
Gui, Add, Text, x12 y70 w70 h20 , Value
Gui, Add, Edit, vParam x92 y70 w150 h20
Gui, Add, Text, vRes_p x12 y140 w222 h20
Gui, Show, x381 y168 h170 w257, MMC21 Tester
Return

;вбиваем функции
ButtonOK:
Gui, Submit, NoHide

if (Sectionv="API")
{
Function_p=Api_BtReset||Api_CallEepromData|API_CallRadioValue|Api_GetActivateMode|API_GetCAMState|Api_GetCurrentTime|Api_GetDLLversion|Api_GetEepromData|Api_GetHwnd|Api_GetMCUversion|Api_GetMuteState|API_GetRadioValue|Api_GetRDSTime|Api_GetSysInitState|Api_GetUsbState|API_RadioAFFreq|API_RadioStationIfc|API_RadioStationLevel|API_RadioStationUsn|API_RadioStationWam|Api_Reset|Api_SetActivateMode|Api_SetBTMuteState|API_SetCAMState|Api_SetCurrentTime|Api_SetEepromData|Api_SetHwnd|Api_SetMuteState|API_SetRadioValue|Api_SetSleepReady|Api_SetTouch
}

if (Sectionv="Aud")
{
Function_p=Aud_GetBalance||Aud_GetBass|Aud_GetBassCFre|Aud_GetBassQ|Aud_GetFader|Aud_GetLoud|Aud_GetLoudCFre|Aud_GetMid|Aud_GetMiddleCFre|Aud_GetMiddleQ|Aud_GetMixAct|Aud_GetMixVol|Aud_GetTreble|Aud_GetTrebleCFre|Aud_GetVolume|Aud_SetBalance|Aud_SetBass|Aud_SetBassCFre|Aud_SetBassQ|Aud_SetFader|Aud_SetLoud|Aud_SetLoudCFre|Aud_SetMid|Aud_SetMiddleCFre|Aud_SetMiddleQ|Aud_SetMixAct|Aud_SetMixVol|Aud_SetTreble|Aud_SetTrebleCFre|Aud_SetVolume
}

if (Sectionv="Audi")
{
Function_p=Audi_GetSetting||Audi_SetSetting
}

if (Sectionv="MMC21")
{
Function_p=MMC21_init||MMC21_uninit
}

if (Sectionv="Radio")
{
Function_p=Radio_AMS||Radio_AutoSearch|Radio_GetCurrentBand|Radio_GetCurrentFreq|Radio_GetPresetFreq|Radio_GetPresetNum|Radio_GetSearchLevel|Radio_GetStereoMsg|Radio_GetStereoStatus|Radio_ManSearch|radio_RecallPreset|Radio_SCAN|Radio_SetBand|Radio_SetFreq|Radio_SetSearchLevel|Radio_SetStereoStatus|Radio_StorePreset
}

if (Sectionv="Rds")
{
Function_p=Rds_GetAFStatus||Rds_GetEONStatus|Rds_GetPSdata|Rds_GetPTYMsg|Rds_GetPTYState|Rds_GetRTStatus|Rds_GetTAmsg|Rds_GetTAStatus|Rds_GetTPStatus|Rds_SetAFMsg|Rds_SetPTYSwitch|Rds_SetTASwitch|Rds_StartPTYSearch|
}

if (Sectionv="Vid")
{
Function_p=Vid_GetBackLightMode||Vid_GetBright|Vid_GetColor|Vid_getContrast|Vid_GetLightMode|Vid_SetBackLightMode|Vid_SetBright|Vid_SetColor|Vid_SetContrast|Vid_SetLightMode|Vid_SetTouchCalibrate|
}

GuiControl,, Functionv, |%Function_p%
Return

ButtonCall:
Gui, Submit, NoHide
CFunction=%mmc21%\%Functionv%
if (Param="")
{
result := DllCall(CFunction)
GuiControl, , Res_p, result "%result%"
}

if (Param<>"")
{
result := DllCall(CFunction, "Int", Param)
GuiControl, , Res_p, send %Param% - result "%result%"
}

return

GuiClose:
DllCall(MMC21_uninit)
DllCall("FreeLibrary", "Int", mmc21) ;выгружаем

ExitApp

