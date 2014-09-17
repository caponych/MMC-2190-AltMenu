DashBoardRun:
DashBoardAutoStart=0
if (DashBoardRuning=0)
	{
	if(CanAutoShowAllow=0)
	{
	DllCall("LoadLibrary", "Str", CanMMCdll) ;загружаем
	Can_Init_result:=DllCall(Can_Init, "Int", sethwnd) ;инициализируем
	}
	goto DashBoardShow
	}
else
	{
	if(CanAutoShowAllow=0)
	{
	DllCall("FreeLibrary", "Int", CanMMCdll) ;выгружаем
	}
	goto DashBoardHide
	}
return

DashBoardAutoHideCheck:
if(CanAutoHideAllow=1 and DashBoardAutoStart=1 and CanCheckEngine=0 and CanWarningOilPressureFlag=0 and CanWarningEngineTempFlag=0 and CanBatteryChargeFlag=1 and CanEngineTemp>50 and CanEngineTemp<110 and CanFuel>3)
{
DashBoardAutoStart=0
gosub DashBoardRun
}
return

;показать панель приборов
DashBoardShow:
Gui, 17:Destroy
DashBoardRuning=1

WinGet, active_id, ID, A ;получаем хэндл окна
activewnd:=active_id 
activewnd:= activewnd + 0 ;переводим хэндл в десятичный вид
if (SaverRuning=0)
	{
	gosub MoveMouse
	}
	
Gui, 17:-SysMenu -Caption +AlwaysOnTop
Gui, 17:Color, %guibackcolor%
Gui, 17:Font, s15 с%fCanN%, %rfont%
Gui, 17:Add, Picture, vCheckEngine gCheckEngineA x60 y0 w40 h40, %A_ScriptDir%\skin\can\can_checkengine.bmp
Gui, 17:Add, Picture, vOilPressure gDashBoardRun x120 y0 w40 h40, %A_ScriptDir%\skin\can\can_oilpresure.bmp
Gui, 17:Add, Picture, vBATCHARGE  gDashBoardRun x180 y0 w40 h40, %A_ScriptDir%\skin\can\can_bat.bmp
Gui, 17:Add, Picture, gDashBoardRun x285 y0 w40 h40, %A_ScriptDir%\skin\can\can_gas_n.bmp
Gui, 17:Add, Picture, gDashBoardRun x430 y0 w40 h40, %A_ScriptDir%\skin\can\can_airtemp.bmp
Gui, 17:Add, Picture, vEngineTemp gDashBoardRun x575 y0 w40 h40, %A_ScriptDir%\skin\can\can_enginetemp_n.bmp

Gui, 17:Add, Text, vFuel gDashBoardRun 0x1 x325 y5 w105 h30, 0.0 л.
Gui, 17:Add, Text, vAirTemp gDashBoardRun 0x1 x470 y5 w105 h30, 0 °C
Gui, 17:Add, Text, vTempEngine gDashBoardRun 0x1 x615 y5 w105 h30, 0 °C
Gui, 17:Show, x0 y440 w800 h40, CanEngine
if (MuteState=1)
{
Gui, 9:hide
Gui, 9:Show, x0 y440 w40 h40, Mute
}
if(bticonshowing=1)
	{
	Gui, 18:hide
	Gui, 18:Show, x760 y440 w40 h40, BTIcon
	}
WinActivate, ahk_id %activewnd%

goto getallcan

return

getallcan:
	CanEngineTempOld=-1
	CanFuelOld=-1
	CanGearboxTempOld=-1
	CanAirTempOld=-1
	CanBatteryChargeFlagold=-1
	CanWarningEngineTempFlagOld=-1
	CanWarningOilPressureFlagOld=-1
	CanCheckEngineOld=-1
gosub CheckEngine
gosub OilPressureFlag
gosub BATCHARGEFLAG
gosub EngineTempFlag
gosub Fuel
gosub AirTemp
gosub EngineTemp
return

;скрыть панель приборов
DashBoardHide:
Gui, 17:Destroy
		DashBoardRuning=0
		WinGet, active_id, ID, A ;получаем хэндл окна
		activewnd:=active_id 
		activewnd:= activewnd + 0 ;переводим хэндл в десятичный вид
		WinActivate, ahk_id %activewnd%
return

;обработка события смены температуры двигателя
EngineTemp:
		CanEngineTemp:=DllCall(Can_GetEngineTemp, "Float")
		CanEngineTemp:=Round(CanEngineTemp)
		
		if(DashBoardAutoStart=1)
			{
			gosub DashBoardAutoHideCheck
			}
		
		if (DashBoardRuning=0 and CanEngineTemp<51 and CanAutoShowAllow=1)
			{
			DashBoardAutoStart=1
			goto DashBoardShow
			}
		if (DashBoardRuning=0 and CanEngineTemp>109 and CanAutoShowAllow=1)
			{
			DashBoardAutoStart=1
			goto DashBoardShow
			}
			
		if(CanEngineTemp<>CanEngineTempOld)
			{
			if (DashBoardRuning=1)
				{
				if(CanEngineTemp>104 or CanEngineTemp<50)
					{
					Gui, 17:Font, s18 cRed, %rfont%
					GuiControl, 17:Font, TempEngine
					GuiControl, 17:, TempEngine, %CanEngineTemp% °C
					}
				else
					{
					Gui, 17:Font, s15 с%fCanN%, %rfont%
					GuiControl, 17:Font, TempEngine
					GuiControl, 17:, TempEngine, %CanEngineTemp% °C
					}
				}
			CanEngineTempOld:=CanEngineTemp
			}
return

;обработка события смены уровня топлива
Fuel:
		CanFuel:=DllCall(Can_GetFuel, "Float")
		CanFuel:=Round(CanFuel,1)
			
		if(DashBoardAutoStart=1)
			{
			gosub DashBoardAutoHideCheck
			}
		
		if (DashBoardRuning=0 and CanFuel<3 and CanAutoShowAllow=1)
			{
			DashBoardAutoStart=1
			goto DashBoardShow
			}
			
			if(CanFuel<>CanFuelOld)
			{
			if (DashBoardRuning=1)
				{
				if(CanFuel<5)
					{
					Gui, 17:Font, s18 cRed, %rfont%
					GuiControl, 17:Font, Fuel
					GuiControl, 17:, Fuel, %CanFuel% л.
					}
				else
					{
					Gui, 17:Font, s15 с%fCanN%, %rfont%
					GuiControl, 17:Font, Fuel
					GuiControl, 17:, Fuel, %CanFuel% л.
					}
				}
			CanFuelOld:=CanFuel
			}
return

;обработка события смены температуры воздуха
AirTemp:
		if (DashBoardRuning=1)
			{
			CanAirTemp:=DllCall(Can_GetAirTemp, "Float")
			CanAirTemp:=Round(CanAirTemp)
			if(CanAirTemp<>CanAirTempOld)
			{
			GuiControl, 17:, AirTemp, %CanAirTemp% °C
			CanAirTempOld:=CanAirTemp
			}
			}
return

;обработка события смены состояния заряда акб
BATCHARGEFLAG:
		CanBatteryChargeFlag:=DllCall(Can_GetBatteryChargeFlag, "Int")
		
		if(DashBoardAutoStart=1)
			{
			gosub DashBoardAutoHideCheck
			}
		
		if (DashBoardRuning=0 and CanBatteryChargeFlag=0 and CanAutoShowAllow=1)
			{
			DashBoardAutoStart=1
			goto DashBoardShow
			}
		
		if (DashBoardRuning=1)
			{
			if(CanBatteryChargeFlag<>CanBatteryChargeFlagold)
			{
			if (CanBatteryChargeFlag=1)
				{
				CVal1=%A_ScriptDir%\skin\can\can_bat.bmp
				CVal2=%A_ScriptDir%\skin\can\can_bat.bmp
				CName=BATCHARGE
				ButtonPress(CName, CVal1, CVal2, 17)
				}
				else
				{
				CVal1=%A_ScriptDir%\skin\can\can_bat_l.bmp
				CVal2=%A_ScriptDir%\skin\can\can_bat_l.bmp
				CName=BATCHARGE
				ButtonPress(CName, CVal1, CVal2, 17)
				}
			CanBatteryChargeFlagold:=CanBatteryChargeFlag
			}
			}
return

;обработка события смены флага перегрева двигателя
EngineTempFlag:
		CanWarningEngineTempFlag:=DllCall(Can_GetWarningEngineTempFlag, "Int")
		
		if(DashBoardAutoStart=1)
			{
			gosub DashBoardAutoHideCheck
			}
		
		if (DashBoardRuning=0 and CanWarningEngineTempFlag=1 and CanAutoShowAllow=1)
			{
			DashBoardAutoStart=1
			goto DashBoardShow
			}

		if (DashBoardRuning=1)
			{
			if(CanWarningEngineTempFlag<>CanWarningEngineTempFlagold)
			{
			if (CanWarningEngineTempFlag=1)
				{
				CVal1=%A_ScriptDir%\skin\can\can_enginetemp_h.bmp
				CVal2=%A_ScriptDir%\skin\can\can_enginetemp_h.bmp
				CName=EngineTemp
				ButtonPress(CName, CVal1, CVal2, 17)
				}
				else
				{
				CVal1=%A_ScriptDir%\skin\can\can_enginetemp_n.bmp
				CVal2=%A_ScriptDir%\skin\can\can_enginetemp_n.bmp
				CName=EngineTemp
				ButtonPress(CName, CVal1, CVal2, 17)
				}
			CanWarningEngineTempFlagOld:=CanWarningEngineTempFlag
			}
			}
return

;обработка события смены флага давления масла
OilPressureFlag:
		CanWarningOilPressureFlag:=DllCall(Can_GetWarningOilPressureFlag, "Int")
		if(DashBoardAutoStart=1)
			{
			gosub DashBoardAutoHideCheck
			}
		
		if (DashBoardRuning=0 and CanWarningOilPressureFlag=1 and CanAutoShowAllow=1)
			{
			DashBoardAutoStart=1
			goto DashBoardShow
			}

		if (DashBoardRuning=1)
			{
			if(CanWarningOilPressureFlag<>CanWarningOilPressureFlagOld)
			{
			if (CanWarningOilPressureFlag=1)
				{
				CVal1=%A_ScriptDir%\skin\can\can_oilpresure_l.bmp
				CVal2=%A_ScriptDir%\skin\can\can_oilpresure_l.bmp
				CName=OilPressure
				ButtonPress(CName, CVal1, CVal2, 17)
				}
				else
				{
				CVal1=%A_ScriptDir%\skin\can\can_oilpresure.bmp
				CVal2=%A_ScriptDir%\skin\can\can_oilpresure.bmp
				CName=OilPressure
				ButtonPress(CName, CVal1, CVal2, 17)
				}
			CanWarningOilPressureFlagOld:=CanWarningOilPressureFlag
			}
			}
return

;обработка события смены флага ошибки двигателя
CheckEngine:
		CanCheckEngine:=DllCall(Can_GetCheckEngine, "Int")
		
		if(DashBoardAutoStart=1)
			{
			gosub DashBoardAutoHideCheck
			}
		
		if (DashBoardRuning=0 and CanCheckEngine=1 and CanAutoShowAllow=1)
			{
			DashBoardAutoStart=1
			goto DashBoardShow
			}
		
		if (DashBoardRuning=1)
			{
			if(CanCheckEngine<>CanCheckEngineold)
			{
			if (CanCheckEngine=1)
				{
				CVal1=%A_ScriptDir%\skin\can\can_checkengine_l.bmp
				CVal2=%A_ScriptDir%\skin\can\can_checkengine_l.bmp
				CName=CheckEngine
				ButtonPress(CName, CVal1, CVal2, 17)
				}
				else
				{
				CVal1=%A_ScriptDir%\skin\can\can_checkengine.bmp
				CVal2=%A_ScriptDir%\skin\can\can_checkengine.bmp
				CName=CheckEngine
				ButtonPress(CName, CVal1, CVal2, 17)
				}
			CanCheckEngineOld:=CanCheckEngine
			}
			}
return

;действие по нажатию значка чекэнжин
CheckEngineA:
if (CanCheckEngine=1)
	{
	gosub ResetECUErrors
	}
else
	{
	gosub ResetEngineECU144
	}
return

;сброс ошибок двигателя
ResetECUErrors:
DllCall(Can_ResetECUErrors, "Int")
return

;форсаж
ResetEngineECU144:
DllCall(Can_ResetEngineECU, "Int", 145)
return

;сообщение смены температуры двигателя
CAN_CHANGE_ENGINE_TEMP(wParam, lParam)
{
global MsgCountStart
	if (MsgCountStart=0)
		{
		MsgCountStart=1
		gosub EngineTemp
		}
	else
		{
		MsgCountStart=0
		}
}

;сообщение смены остатка топлива
CAN_CHANGE_FUEL(wParam, lParam)
{
global MsgCountStart
	if (MsgCountStart=0)
		{
		MsgCountStart=1
		gosub Fuel
		}
	else
		{
		MsgCountStart=0
		}
}

;сообщение смены температуры акпп
CAN_CHANGE_GEARBOX_TEMP(wParam, lParam)
{
}

;сообщение смены температуры воздуха
CAN_CHANGE_AIR_TEMP(wParam, lParam)
{
global MsgCountStart
	if (MsgCountStart=0)
		{
		MsgCountStart=1
		gosub AirTemp
		}
	else
		{
		MsgCountStart=0
		}
}

;сообщение смены флага заряда акб
CAN_CHANGE_BAT_CHARGE_FLAG(wParam, lParam)
{
global MsgCountStart
	if (MsgCountStart=0)
		{
		MsgCountStart=1
		gosub BATCHARGEFLAG
		}
	else
		{
		MsgCountStart=0
		}
}

;сообщение смены флага перегрева двигателя
CAN_CHANGE_WARN_ENG_TEMP_FLAG(wParam, lParam)
{
global MsgCountStart
	if (MsgCountStart=0)
		{
		MsgCountStart=1
		gosub EngineTempFlag
		}
	else
		{
		MsgCountStart=0
		}
}

;сообщение смены флага давления масла
CAN_CHANGE_WARN_OIL_PRES_FLAG(wParam, lParam)
{
global MsgCountStart
	if (MsgCountStart=0)
		{
		MsgCountStart=1
		gosub OilPressureFlag
		}
	else
		{
		MsgCountStart=0
		}
}

;сообщение смены флага ошибки двигателя
CAN_CHANGE_CHECK_ENGINE_FLAG(wParam, lParam)
{
global MsgCountStart
	if (MsgCountStart=0)
		{
		MsgCountStart=1
		gosub CheckEngine
		}
	else
		{
		MsgCountStart=0
		}
}

;смена активности кан-линии
CAN_CHANGE_ACTIVE(wParam, lParam)
{
global MsgCountStart
global ActiveCAN
global Can_GetActiveCAN
global DashBoardRuning
global CanAutoHideAllow
	if (MsgCountStart=0)
		{
		MsgCountStart=1
		ActiveCAN:=DllCall(Can_GetActiveCAN, "Int")
		if(CanAutoHideAllow=1 and DashBoardRuning=1 and ActiveCAN=0)
			{
			gosub DashBoardRun
			}
		}
	else
		{
		MsgCountStart=0
		}
}