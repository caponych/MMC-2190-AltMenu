RearCamSettingsStartGui:

IniRead, RearCamLastMode, %RearCamINI%, RearCam, Mode

if RearCamLastMode=0
{
RearCamMode=%A_ScriptDir%\Skin\RearCam\CamOn.bmp

}
else
{
RearCamMode=%A_ScriptDir%\Skin\RearCam\CamOff.bmp
}
Gui, 5:Destroy
Gui, 5:-SysMenu -Caption +AlwaysOnTop
Gui, 5:Color, 1e1e1e
Gui, 5:Add, Picture, gRearCamModeOn vRearCamModeOn x40 y140 w100 h40, %A_ScriptDir%\Skin\RearCam\Yes.bmp
Gui, 5:Add, Picture, gRearCamModeOff vRearCamModeOff x160 y140 w100 h40, %A_ScriptDir%\Skin\RearCam\No.bmp
Gui, 5:Add, Picture, x0 y0 w300 h200, %RearCamMode%
Gui, 5:Show, w300 h200, RearCamMode
return

RearCamModeOn:
CVal1=%A_ScriptDir%\Skin\RearCam\Yes.bmp
CVal2=%A_ScriptDir%\Skin\RearCam\Yesp.bmp
CName=RearCamModeOn
ButtonPressF(CName, CVal1, CVal2,5)
if RearCamLastMode=0
{
DllCall(API_SetCAMState, int, 1)
IniWrite, 1, %RearCamINI%, RearCam, Mode
}
else
{
DllCall(API_SetCAMState, int, 0)
IniWrite, 0, %RearCamINI%, RearCam, Mode
}
CVal1=%A_ScriptDir%\Skin\RearCam\No.bmp
CVal2=%A_ScriptDir%\Skin\RearCam\Nop.bmp
CName=RearCamModeOff
ButtonPressF(CName, CVal1, CVal2, 5)
Gui, 5:Destroy
return

RearCamModeOff:
CVal1=%A_ScriptDir%\Skin\RearCam\No.bmp
CVal2=%A_ScriptDir%\Skin\RearCam\Nop.bmp
CName=RearCamModeOff
ButtonPressF(CName, CVal1, CVal2, 5)
Gui, 5:Destroy
Return
