#IncludeAgain %A_ScriptDir%\MMCCoreCanSettings.ahk 

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
if(CanAutoHideAllow=1 and DashBoardAutoStart=1 and CanCheckEngine=0 and CanWarningOilPressureFlag=0 and CanWarningEngineTempFlag=0 and CanBatteryChargeFlag=1 and CanEngineTemp>Min_EngineTemp and CanEngineTemp<Warn_EngineTemp and CanFuel>Warn_Fuel and (Min_GearBoxTemp < CanGearboxTemp and CanGearboxTemp < Warn_GearBoxTemp or ShowGearBoxTemp<>1) and (CanAirTemp<Warn_Min_AirTemp or CanAirTemp>Warn_Max_AirTemp or ShowAirTemp<>1) and ( CanSpeed<Warn_Speed or ShowSpeed<>1))
{
DashBoardAutoStart=0
gosub DashBoardRun
}
return

;показать панель приборов
DashBoardShow:
gosub initCANDashboard

if !CanChangeFontLow {
	CanFont_Low=%CanFont_N%
}
if !CanChangeFontWarn {
	CanFont_Warn=%CanFont_N%
}
if !CanChangeFontAlarm {
	CanFont_Alarm=%CanFont_N%
}

y_pos:=440
			

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
Gui, 17:Font, %CanFont_N%, %rfont%
Gui, 17:Add, Picture, vCheckEngine gCheckEngineA x50 y0 w40 h40, %A_ScriptDir%\skin\can\can_checkengine.bmp
Gui, 17:Add, Picture, vOilPressure gDashBoardRun x100 y0 w40 h40, %A_ScriptDir%\skin\can\can_oilpresure.bmp
Gui, 17:Add, Picture, vBatIcon  gCanDashboardSettings x150 y0 w40 h40, %A_ScriptDir%\skin\can\can_bat.bmp



;вывод параметров
if (ShowEngineTemp+ShowGearBoxTemp+ShowAirTemp+ShowSpeed+ShowFuel =  5 ){
	ShowAirTemp=0
	i:=640
	text_shift:=40
	icon_shift:=120
}
if (ShowEngineTemp+ShowGearBoxTemp+ShowAirTemp+ShowSpeed+ShowFuel =  4 ){
	i:=640
	text_shift:=40
	icon_shift:=120
}

if (ShowEngineTemp+ShowGearBoxTemp+ShowAirTemp+ShowSpeed+ShowFuel =  3 ){
	i:=580
	icon_shift:=140
	text_shift:=60
}
if (ShowEngineTemp+ShowGearBoxTemp+ShowAirTemp+ShowSpeed+ShowFuel =  2 ){
	i:=540
	icon_shift:=200
	text_shift:=60
}
if (ShowEngineTemp+ShowGearBoxTemp+ShowAirTemp+ShowSpeed+ShowFuel =  1 ){
	i:=400
	icon_shift:=200
	text_shift:=60
}


;скорость
if (ShowSpeed=1){
	i-=40
	pos_text:=i+text_shift+5
	Gui, 17:Add, Picture, vSpeedIcon gSwitchSpeedProfile x%i% y0 w40 h40, %SpeedIcon%
	Gui, 17:Add, Text, vSpeed gCanDashBoardSettings  x%pos_text% y5 w115 h30 Left, 0.0 км/ч
	i-=icon_shift
}
;коробка
if (ShowGearBoxTemp=1){
	pos_text:=i+text_shift
	Gui, 17:Add, Picture, vGearBoxTempIcon x%i% y0 w40 h40, %GearBoxTempIcon%
	Gui, 17:Add, Text, vGearboxTemp gCanDashBoardSettings  x%pos_text% y5 w80 h30 Left, 0 °C
	i-=icon_shift
}
;Двигатель
if (ShowEngineTemp=1){
	pos_text:=i+text_shift
	Gui, 17:Add, Picture, vEngineTempIcon x%i% y0 w40 h40, %EngineTempIcon%
	Gui, 17:Add, Text, vEngineTemp gCanDashBoardSettings  x%pos_text% y5 w80 h30 Left, 0 °C
	i-=icon_shift
}
;Воздух
if (ShowAirTemp=1){
	pos_text:=i+text_shift
	Gui, 17:Add, Picture, vAirTempIcon  x%i% y0 w40 h40, %AirTempIcon%
	Gui, 17:Add, Text, vAirTemp gCanDashBoardSettings x%pos_text% y5 w80 h30 Left, 0 °C
	i-=icon_shift
}

;Топливо
if (ShowFuel=1){
	i-=10
	pos_text:=i+text_shift
	Gui, 17:Add, Picture, vFuelIcon x%i% y0 w40 h40, %FuelIcon%
	Gui, 17:Add, Text, vFuel gCanDashBoardSettings x%pos_text% y5 w90 h30 Left, 0.0 л.
        i-=icon_shift
}
Gui, 17:Show, x0 y%y_pos% w800 h40, CanEngine

if (MuteState=1)
{
Gui, 9:hide
Gui, 9:Show, x0 y%y_pos% w40 h40, Mute
}

if(bticonshowing=1)
	{
	Gui, 18:hide
	Gui, 18:Show, x760 y%y_pos% w40 h40, BTIcon
	}
WinActivate, ahk_id %activewnd%

goto getallcan

return

getallcan:
	CanSpeedOld=-1	
	SpeedIconCur=%SpeedIcon%
	CanEngineTempOld=-100
	EngineTempIconCur=%EngineTempIcon%
	CanFuelOld=-1
	FuelIconCur=%FuelIcon%
	CanGearboxTempOld=-100
	GearBoxTempIconCur=%GearBoxTempIcon%
	CanAirTempOld=-100
	AirTempIconCur=%AirTempIcon%
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
gosub GearboxTemp
gosub EngineTemp
gosub ChangeSpeed	
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
if (ShowEngineTemp=1){
		CanEngineTemp:=DllCall(Can_GetEngineTemp, "Float")
		CanEngineTemp:=Round(CanEngineTemp)


		if (DashBoardRuning=0 and ( CanEngineTemp<=Min_EngineTemp or CanEngineTemp>=Warn_EngineTemp ) and CanAutoShowAllow=1)
			{
			DashBoardAutoStart=1
			goto DashBoardShow
			}
			
		if(CanEngineTemp<>CanEngineTempOld and DashBoardRuning=1){

				SoundFile=
				CName=EngineTempIcon					
				if ( Min_EngineTemp<CanEngineTemp and CanEngineTemp<Warn_EngineTemp){
					CVal1=%A_ScriptDir%\skin\can\can_enginetemp_n.bmp
					CVal2=%A_ScriptDir%\skin\can\can_enginetemp_n.bmp
					CName=EngineTempIcon		
					If EngineTempSoundNormal {
						SoundFile=%SoundNormal%
					}
				}
				if (CanEngineTemp <= Min_EngineTemp){
					CVal1=%A_ScriptDir%\skin\can\can_enginetemp_low.bmp
					CVal2=%A_ScriptDir%\skin\can\can_enginetemp_low.bmp
					Gui, 17:Font, %CanFont_Low%, %rfont%					
				}
				if ( Warn_EngineTemp<=CanEngineTemp and CanEngineTemp<Alarm_EngineTemp){
					If EngineTempSoundWarn {
						SoundFile=%SoundWarn%
					}
					CVal1=%A_ScriptDir%\skin\can\can_enginetemp_warn.bmp
					CVal2=%A_ScriptDir%\skin\can\can_enginetemp_warn.bmp
					Gui, 17:Font, %CanFont_Warn%, %rfont%					
				}
				if (Alarm_EngineTemp<=CanEngineTemp ){
					If EngineTempSoundAlarm {
						SoundFile=%SoundAlarm%
					}				
					CVal1=%A_ScriptDir%\skin\can\can_enginetemp_alarm.bmp
					CVal2=%A_ScriptDir%\skin\can\can_enginetemp_alarm.bmp
					Gui, 17:Font, %CanFont_Alarm%, %rfont%					
				}
				if (EngineTempIconCur<>CVal1){
					if EngineTempChangeIcon {
						ButtonPress(CName, CVal1, CVal2, 17)
					}
					if !EngineTempChangeFont {
						Gui, 17:Font, %CanFont_N%, %rfont%	
					}					
					EngineTempIconCur=%CVal1%
					GuiControl, 17:Font, EngineTemp
					SoundPlay, %SoundFile%
				}
				GuiControl, 17:, EngineTemp, %CanEngineTemp% °C
				Gui, 17:Font, %CanFont_N%, %rfont%	

			CanEngineTempOld:=CanEngineTemp
		}
		if(DashBoardAutoStart=1){
			gosub DashBoardAutoHideCheck
		}

}
return

;обработка события смены уровня топлива
Fuel:
if ShowFuel {
		CanFuel:=DllCall(Can_GetFuel, "Float")
		CanFuel:=Round(CanFuel,1)
		if (DashBoardRuning=0 and CanFuel<=Warn_Fuel and CanAutoShowAllow=1){
			DashBoardAutoStart=1
			goto DashBoardShow
		}
		if(CanFuel<>CanFuelOld and DashBoardRuning=1){
				SoundFile=
				CName=FuelIcon
				if (CanFuel>Warn_Fuel){
					CVal1=%A_ScriptDir%\skin\can\can_gas_n.bmp
					CVal2=%A_ScriptDir%\skin\can\can_gas_n.bmp
					CName=FuelIcon
					If FuelSoundNormal {
						SoundFile=%SoundNormal%
					}
				}				
				if (Alarm_Fuel <  CanFuel  and CanFuel <= Warn_Fuel) {				
					CVal1=%A_ScriptDir%\skin\can\can_gas_warn.bmp
					CVal2=%A_ScriptDir%\skin\can\can_gas_warn.bmp
					Gui, 17:Font, %CanFont_Warn%, %rfont%	
					If FuelSoundWarn {
						SoundFile=%SoundWarn%
					}															
				}
				if (CanFuel<=Alarm_Fuel){
					CVal1=%A_ScriptDir%\skin\can\can_gas_alarm.bmp
					CVal2=%A_ScriptDir%\skin\can\can_gas_alarm.bmp
					Gui, 17:Font, %CanFont_Alarm%, %rfont%	
					If FuelSoundAlarm {
						SoundFile=%SoundAlarm%
					}																	
				}
				if (FuelIconCur<>CVal1){
					if FuelChangeIcon {
						ButtonPress(CName, CVal1, CVal2, 17)
					}
					if !FuelChangeFont {
						Gui, 17:Font, %CanFont_N%, %rfont%	
					}					
					GuiControl, 17:Font, Fuel
					SoundPlay, %SoundFile%
					FuelIconCur:=CVal1
				}
				GuiControl, 17:, Fuel, %CanFuel% л.
				Gui, 17:Font, %CanFont_N%, %rfont%	

			CanFuelOld:=CanFuel
		}
		if(DashBoardAutoStart=1){
			gosub DashBoardAutoHideCheck
		}
}
return

;обработка события смены температуры акпп
GearboxTemp:

if ShowGearBoxTemp {
	CanGearboxTemp:=DllCall(Can_GetGearboxTemp, "Float")
	CanGearboxTemp:=Round(CanGearboxTemp)	

	if (DashBoardRuning=0 and (CanGearboxTemp < Min_GearBoxTemp or Warn_GearBoxTemp < CanGearboxTemp )  and CanAutoShowAllow=1){
		DashBoardAutoStart=1
		goto DashBoardShow
	}
		if(CanGearboxTemp<>CanGearboxTempOld and DashBoardRuning=1  ){
			SoundFile=
			CName=GearBoxTempIcon
			if (Min_GearBoxTemp < CanGearboxTemp and CanGearboxTemp < Warn_GearBoxTemp ) {
				CVal1=%A_ScriptDir%\skin\can\can_gearboxtemp_n.bmp
				CVal2=%A_ScriptDir%\skin\can\can_gearboxtemp_n.bmp
				If GearBoxTempSoundNormal {
					SoundFile=%SoundNormal%
				}	
			}	
			if ( CanGearboxTemp <= Min_GearBoxTemp ) {				
				CVal1=%A_ScriptDir%\skin\can\can_gearboxtemp_low.bmp
				CVal2=%A_ScriptDir%\skin\can\can_gearboxtemp_low.bmp
				Gui, 17:Font, %CanFont_Low%, %rfont%									
			}
			if ( Warn_GearBoxTemp <= CanGearboxTemp and CanGearboxTemp < Alarm_GearBoxTemp) {				
				CVal1=%A_ScriptDir%\skin\can\can_gearboxtemp_warn.bmp
				CVal2=%A_ScriptDir%\skin\can\can_gearboxtemp_warn.bmp
				Gui, 17:Font, %CanFont_Warn%, %rfont%	
				If GearBoxTempSoundWarn {
					SoundFile=%SoundWarn%

				}		
												
			}
			if ( Alarm_GearBoxTemp <= CanGearboxTemp ) {				
				CVal1=%A_ScriptDir%\skin\can\can_gearboxtemp_alarm.bmp
				CVal2=%A_ScriptDir%\skin\can\can_gearboxtemp_alarm.bmp
				Gui, 17:Font, %CanFont_Alarm%, %rfont%	
				If GearBoxTempSoundAlarm {
					SoundFile=%SoundAlarm%
				}		
								
			}
			if (GearBoxTempIconCur <> CVal1){
				if GearBoxChangeIcon {
					ButtonPress(CName, CVal1, CVal2, 17)
				}
				if !GearBoxChangeFont {
					Gui, 17:Font, %CanFont_N%, %rfont%
				}
				GuiControl, 17:Font, GearboxTemp
				SoundPlay, %SoundFile%				
				GearBoxTempIconCur:=CVal1
			}
			GuiControl, 17:, GearboxTemp, %CanGearboxTemp% °C
			Gui, 17:Font, %CanFont_N%, %rfont%
			CanGearboxTempOld:=CanGearboxTemp					
		}
	if(DashBoardAutoStart=1){
		gosub DashBoardAutoHideCheck
	}	
}	
return

;обработка события смены температуры воздуха
AirTemp:
if (ShowAirTemp=1) {

	CanAirTemp:=DllCall(Can_GetAirTemp, "Float")
	CanAirTemp:=Round(CanAirTemp)	


	if (DashBoardRuning=0 and Warn_Min_AirTemp<=CanAirTemp and CanAirTemp<=Warn_Max_AirTemp and CanAutoShowAllow=1){
		DashBoardAutoStart=1
		goto DashBoardShow
	}

		if(CanAirTemp<>CanAirTempOld and DashBoardRuning=1) {
			SoundFile=
			CName=AirTempIcon			
			if (CanAirTemp or < Warn_Min_AirTemp or Warn_Max_AirTemp < CanAirTemp){
				CVal1=%A_ScriptDir%\skin\can\can_airtemp.bmp
				CVal2=%A_ScriptDir%\skin\can\can_airtemp.bmp
				If AirTempSoundNormal {
					SoundFile=%SoundNormal%
				}
			}
			if (Warn_Min_AirTemp<=CanAirTemp and CanAirTemp <= Warn_Max_AirTemp){
				CVal1=%A_ScriptDir%\skin\can\can_airtemp_warn.bmp
				CVal2=%A_ScriptDir%\skin\can\can_airtemp_warn.bmp
				Gui, 17:Font, %CanFont_Low%, %rfont%	
				If AirTempSoundWarn {
					SoundFile=%SoundWarn%
				}
			}									
			if (AirTempIconCur<>CVal1){
				if AirTempChangeIcon {
					ButtonPress(CName, CVal1, CVal2, 17)
				}
				if !AirTempChangeFont {
					Gui, 17:Font, %CanFont_N%, %rfont%
				}
				GuiControl, 17:Font, AirTemp
				SoundPlay, %SoundFile%				
				AirTempIconCur:=CVal1
			}
			GuiControl, 17:, AirTemp, %CanAirTemp% °C
			Gui, 17:Font, %CanFont_N%, %rfont%					
			CanAirTempOld:=CanAirTemp
		}

		if(DashBoardAutoStart=1){
			gosub DashBoardAutoHideCheck
		}
}		
return


ChangeSpeed:
CanSpeed:=DllCall(Can_GetSpeed, "Float")
SaverSpeed:=Round(CanSpeed)	
CanSpeed:=Round(CanSpeed,1)	

;Saver

if (SaverRuning and SaverSpeed<>SaverSpeedOld ) {
		if (SaverSpeed < Warn_Speed ){	
			SaverFont=%SaverFont_N%
		}
		if (Warn_Speed<=SaverSpeed and SaverSpeed < Alarm_Speed ){
			SaverFont=%SaverFont_Warn%
		}
		if (Alarm_Speed<=SaverSpeed){
			SaverFont=%SaverFont_Alarm%
		}
		if !SpeedChangeFont {
			SaverFont=%SaverFont_N%
		}
		
		Gui, 3:Font, %SaverFont%, %rfont%
		GuiControl, 3:Font, SaverSpeed
		GuiControl, 3:, SaverSpeed, %SaverSpeed% км/ч
		SaverSpeedOld:=SaverSpeed
}		

;Dashboard
if (ShowSpeed=1) {
		
		
		if (DashBoardRuning=0 and CanSpeed>=Warn_Speed and CanAutoShowAllow=1){
			DashBoardAutoStart=1
			goto DashBoardShow
		}
			if(CanSpeed<>CanSpeedOld and DashBoardRuning=1){
				SoundFile=
				CName=SpeedIcon
				if (CanSpeed < Warn_Speed ){
					CVal1=%A_ScriptDir%\skin\can\can_speed_n%CurSpeedProfile_ID%.bmp	
					CVal2=%A_ScriptDir%\skin\can\can_speed_n%CurSpeedProfile_ID%.bmp
					CName=SpeedIcon
					If SpeedSoundNormal {
						SoundFile=%SoundNormal%
					}	
				}			
				if (Warn_Speed<=CanSpeed and CanSpeed < Alarm_Speed ){
					CVal1=%A_ScriptDir%\skin\can\can_speed_warn.bmp	
					CVal2=%A_ScriptDir%\skin\can\can_speed_warn.bmp	
					Gui, 17:Font, %CanFont_Warn%, %rfont%										
					If SpeedSoundWarn {
						SoundFile=%SoundWarn%
					}			

				}
				if (Alarm_Speed<=CanSpeed){
					CVal1=%A_ScriptDir%\skin\can\can_speed_alarm.bmp
					CVal2=%A_ScriptDir%\skin\can\can_speed_alarm.bmp
					Gui, 17:Font, %CanFont_Alarm%, %rfont%										
					if SpeedSoundAlarm {
						SoundFile=%SoundAlarm% 
					}		
				}

				if (SpeedIconCur<>CVal1){
					if SpeedChangeIcon {
						ButtonPress(CName, CVal1, CVal2, 17)
					}
					if !SpeedChangeFont {
						Gui, 17:Font, %CanFont_N%, %rfont%
					}
					GuiControl, 17:Font, Speed
					SoundPlay, %SoundFile%				
					SpeedIconCur:=CVal1
					GuiControl, 17:Font, Speed
				}
				GuiControl, 17:, Speed, %CanSpeed% км/ч
				Gui, 17:Font, %CanFont_N%, %rfont%					
				CanSpeedOld:=CanSpeed				
			}
		if(DashBoardAutoStart=1){
			gosub DashBoardAutoHideCheck
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
				CName=BatIcon
				ButtonPress(CName, CVal1, CVal2, 17)
				}
				else
				{
				CVal1=%A_ScriptDir%\skin\can\can_bat_l.bmp
				CVal2=%A_ScriptDir%\skin\can\can_bat_l.bmp
				CName=BatIcon
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
				CVal1=%A_ScriptDir%\skin\can\can_enginetemp_alarm.bmp
				CVal2=%A_ScriptDir%\skin\can\can_enginetemp_alarm.bmp
				CName=EngineTempIcon
				ButtonPress(CName, CVal1, CVal2, 17)
				}
				else
				{
				CVal1=%A_ScriptDir%\skin\can\can_enginetemp_n.bmp
				CVal2=%A_ScriptDir%\skin\can\can_enginetemp_n.bmp
				CName=EngineTempIcon
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
;переключение профайла
SwitchSpeedProfile:
	if (CurSpeedProfile_ID=CountSpeedProfile) {
		CurSpeedProfile_ID=1
		isEq1=%CurSpeedProfile_ID%
		IniRead, SpeedChangeIcon , %CanDashboardINI%, Speed%CurSpeedProfile_ID% , SpeedChangeIcon%CurSpeedProfile_ID%
		isEmpty := !(SpeedChangeIcon>-1)
		if  (isEmpty) {
			SpeedProfileName=Город
			Warn_Speed=80
			Alarm_Speed=120
			gosub CanDashboardINIWrite
		}else{

		IniWrite, %CurSpeedProfile_ID%		, %CanDashboardINI%, Dashboard		, CurSpeedProfile_ID
			gosub CanDashboardINIRead
		}
	}else{
		CurSpeedProfile_ID+=1
		IniRead, SpeedChangeIcon , %CanDashboardINI%, Speed%CurSpeedProfile_ID% , SpeedChangeIcon%CurSpeedProfile_ID%
		isEmpty := !(SpeedChangeIcon>-1)
		if (isEmpty) {
			SpeedProfileName=Трасса
			Warn_Speed=110
			Alarm_Speed=150
			gosub CanDashboardINIWrite			

		}else{
			IniWrite, %CurSpeedProfile_ID%		, %CanDashboardINI%, Dashboard		, CurSpeedProfile_ID
			gosub CanDashboardINIRead
		}
	}
	CVal1=%A_ScriptDir%\skin\can\can_speed_n%CurSpeedProfile_ID%.bmp	
	CVal2=%A_ScriptDir%\skin\can\can_speed_n%CurSpeedProfile_ID%.bmp
	CName=SpeedIcon
	ButtonPress(CName, CVal1, CVal2, 17)
return 

;-----------------------------------------------------------------------------------------------------
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
global MsgCountStart
	if (MsgCountStart=0)
		{
		MsgCountStart=1
		gosub GearboxTemp
		}
	else
		{
		MsgCountStart=0
		}
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
;изменение скорости
CAN_CHANGE_SPEED(wParam, lParam)
{
global MsgCountStart
	if (MsgCountStart=0)
		{
		MsgCountStart=1
		gosub ChangeSpeed
		}
	else
		{
		MsgCountStart=0
		}
}
