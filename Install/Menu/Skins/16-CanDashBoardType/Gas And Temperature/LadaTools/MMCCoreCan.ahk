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
if(CanAutoHideAllow=1 and DashBoardAutoStart=1 and CanEngineTemp>50 and CanEngineTemp<110 and CanFuel>3)
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
Gui, 17:Add, Picture, gDashBoardRun x0 y0 w40 h40, %A_ScriptDir%\skin\can\can_gas_n.bmp
Gui, 17:Add, Text, vFuel gDashBoardRun 0x1 x40 y5 w80 h30
Gui, 17:Add, Picture, vEngineTemp gDashBoardRun x120 y0 w40 h40, %A_ScriptDir%\skin\can\can_enginetemp_n.bmp
Gui, 17:Add, Text, vTempEngine gDashBoardRun 0x1 x160 y5 w80 h30

Gui, 17:Show, x500 y440 w240 h40, CanEngine
WinActivate, ahk_id %activewnd%

goto getallcan

return

getallcan:
	CanEngineTempOld=-1
	CanFuelOld=-1
gosub Fuel
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
}

;сообщение смены флага перегрева двигателя
CAN_CHANGE_WARN_ENG_TEMP_FLAG(wParam, lParam)
{
}

;сообщение смены флага давления масла
CAN_CHANGE_WARN_OIL_PRES_FLAG(wParam, lParam)
{
}

;сообщение смены флага ошибки двигателя
CAN_CHANGE_CHECK_ENGINE_FLAG(wParam, lParam)
{
}

;сообщение смены флага заряда акб
CAN_CHANGE_BAT_CHARGE_FLAG(wParam, lParam)
{
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