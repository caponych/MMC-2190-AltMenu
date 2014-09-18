initCANDashboard:

new_highlight_ver	=2.5
CanDashboardINI=%A_ScriptDir%\ini\CanDashboard.ini


if (LastCanDashboardINIRead<>1){
	highlight_ver		=-1
	IfExist, %CanDashboardINI% 
	{
		IniRead, highlight_ver     	, %CanDashboardINI%, Dashboard		, highlight_ver 
		if (highlight_ver <> new_highlight_ver) {
			FileDelete, %CanDashboardINI%
			need_default=1
		}
	}else{
		need_default=1
	}
	if (need_default=1) {
		CanAutoShowAllow     	=1
		CanAutoHideAllow     	=1
		def_CanFont_Low 	=s15 c0b0bff 	
		def_CanFont_Warn 	=s18 cff9600 
		def_CanFont_Alarm 	=s20 cf70000
		CanChangeFontLow	=0
		CanChangeFontWarn	=0
		CanChangeFontAlarm	=0
		
		ShowEngineTemp      	=1
		ShowGearBoxTemp      	=1
		ShowAirTemp          	=0
		ShowFuel            	=1
		ShowSpeed	     	=1
		CurSpeedProfile_ID      =2
		SpeedProfileName        =Трасса

		EngineTempChangeIcon    =0
		EngineTempChangeFont    =0
		EngineTempSoundNormal   =0
		EngineTempSoundWarn     =0
		EngineTempSoundAlarm    =0
		Min_EngineTemp       	=50
		Warn_EngineTemp      	=97
		Alarm_EngineTemp     	=102

		FuelChangeIcon   	=0
		FuelChangeFont   	=0
		FuelSoundNormal  	=0
		FuelSoundWarn    	=0
		FuelSoundAlarm   	=0
		Warn_Fuel        	=15
		Alarm_Fuel       	=10

		GearBoxTempChangeIcon   =0
		GearBoxTempChangeFont   =0
		GearBoxTempSoundNormal  =0
		GearBoxTempSoundWarn    =0
		GearBoxTempSoundAlarm   =0
		Min_GearBoxTemp      	=37
		Warn_GearBoxTemp     	=70
		Alarm_GearBoxTemp    	=90

		AirTempChangeIcon    	=0
		AirTempChangeFont    	=0
		AirTempSoundNormal   	=0
		AirTempSoundWarn    	=0
		Warn_Max_AirTemp     	=2
		Warn_Min_AirTemp     	=-5
		SpeedChangeIcon    	=0
		SpeedChangeFont     	=0
		SpeedSoundNormal     	=0
		SpeedSoundWarn     	=0
		SpeedSoundAlarm     	=0
		Warn_Speed     	        =110
		Alarm_Speed     	=150
		highlight_ver=%new_highlight_ver%
		gosub CanDashboardINIWrite
		CurSpeedProfile_ID      =1
		SpeedProfileName        =Город
		Warn_Speed     	        =80
		Alarm_Speed     	=120
		gosub CanDashboardINIWrite
	}
	CanFont_N=s15 %fCanN%

	SoundNormal=%A_ScriptDir%\skin\can\can_sound_n.wav
	SoundWarn=%A_ScriptDir%\skin\can\can_sound_warn.wav
	SoundAlarm=%A_ScriptDir%\skin\can\can_sound_alarm.wav



	SaverFont_N=s80 %fCanN%
	SaverFont_Warn=s80 cff9600 
	SaverFont_Alarm=s80 cf70000
	
	EngineTempIcon=%A_ScriptDir%\skin\can\can_enginetemp_n.bmp
	EngineTempIconCur=%EngineTempIcon%
	GearBoxTempIcon=%A_ScriptDir%\skin\can\can_gearboxtemp_n.bmp
	GearBoxTempIconCur=%GearBoxTempIcon%
	SpeedIcon=%A_ScriptDir%\skin\can\can_speed_n%CurSpeedProfile_ID%.bmp
	SpeedIconCur=%SpeedIcon%
	FuelIcon=%A_ScriptDir%\skin\can\can_gas_n.bmp
	FuelIconCur=%FuelIcon%
	AirTempIcon=%A_ScriptDir%\skin\can\can_airtemp.bmp
	AirTempIconCur=%AirTempIcon%
	Fan1Running=0	
	gosub CanDashboardINIRead
	CountSpeedProfile	=2
	CanFont_Low=%def_CanFont_Low%
	CanFont_Warn=%def_CanFont_Warn%
	CanFont_Alarm=%def_CanFont_Alarm%	

	SpeedIcon=%A_ScriptDir%\skin\can\can_speed_n%CurSpeedProfile_ID%.bmp
	SpeedIconCur=%SpeedIcon%
		
	LastCanDashboardINIRead=1
}
	

return

CanDashboardSettings:

Gui, 19:Destroy


	WinGet, active_id, ID, A ;получаем хэндл окна
	activewnd:=active_id 
	activewnd:= activewnd + 0 ;переводим хэндл в десятичный вид
	if (SaverRuning=0){
		gosub MoveMouse
	}

	Gui, 19:-SysMenu -Caption +AlwaysOnTop
	Gui, 19:Color, %guibackcolor%
	Gui, 19:Font, %CanFont_N%, %rfont%
	w_x:=0
	w_y:=0
	w_height:=440
	w_text:=250
	w_param:=35
	x_param_shift:=60


	Gui, 19:Add, Picture, vRSBIcon gRefreshValue 				x0 		y0	w40 h80, %A_ScriptDir%\skin\can\rsb.bmp
	Gui, 19:Add, Picture, vRSFIcon gRefreshValue 				x0		y0	w40 h80, %A_ScriptDir%\skin\can\rsf.bmp
	GuiControl, 19:Hide, RSFIcon 
	GuiControl, 19:Hide, RSBIcon 


	y_pos:=w_height - 130   ;

	Gui, 19:Font, s28 ce0e0e0, %rfont%   ; 
	Gui, 19:Add, Text,  vSubm gSubmitCancel x0 y%y_pos% w800 h40 Center, Сохранить?   ; 
	Gui, 19:Font, %CanFont_N%, %rfont%
	Gui, 19:Add, Picture, vYesIcon gSubmitSettings 			x280 		y+20	w80 h80 , %A_ScriptDir%\skin\can\Yes.bmp    ;
	Gui, 19:Add, Picture, vNoIcon gSubmitCancel 				x420		yp	w80 h80 , %A_ScriptDir%\skin\can\No.bmp    ;

	;флаги
;определяем какие пороги устанавливаем
	Cur_Control:=A_GuiControl

	
if RegExMatch(Cur_Control, "^BatIcon$" ) {
	;настройки панели
	x_pos:=20
	y_pos:=20
	Gui, 19:Font, s30 ce0e0e0, %rfont%
	Gui, 19:Add, Text,  				 	x0			y%y_pos%	   	w400 	h60 	Center, Настройки панели
	Gui, 19:Font, %CanFont_N%, %rfont%
	Gui, 19:Add, Checkbox, vCanAutoShowAllow Checked%CanAutoShowAllow% x%x_pos% y+0 w380 h30 Left, Показывать панель автоматически
	Gui, 19:Add, Checkbox, vCanAutoHideAllow Checked%CanAutoHideAllow% x%x_pos% y+0 w380 hp Left, Скрывать панель автоматически
	Gui, 19:Font, %def_CanFont_Low%, %rfont%	
	Gui, 19:Add, Checkbox, vCanChangeFontLow Checked%CanChangeFontLow% x%x_pos% y+20 w380 h30 Left, Шрифт значений Min
	Gui, 19:Font, %def_CanFont_Warn%, %rfont%
	Gui, 19:Add, Checkbox, vCanChangeFontWarn Checked%CanChangeFontWarn% x%x_pos% y+0 w380 hp Left,Шрифт значений Warn
	Gui, 19:Font, %def_CanFont_Alarm%, %rfont%
	Gui, 19:Add, Checkbox, vCanChangeFontAlarm Checked%CanChangeFontAlarm% x%x_pos% y+0 w380 hp Left, Шрифт значений Alarm
	Gui, 19:Font, %CanFont_N%, %rfont%
	;Индикаторы
	x_pos:=400
	y_pos:=20
	Gui, 19:Font, s30 ce0e0e0, %rfont%
	Gui, 19:Add, Text,  				 			x400	 y%y_pos%	w400 	h60 	Center, Индикаторы
	Gui, 19:Font, %CanFont_N%, %rfont%
	Gui, 19:Add, Checkbox, vShowSpeed 	Checked%ShowSpeed% 		x%x_pos% y+0		w380		h30 	Right, Спидометр
	Gui, 19:Add, Checkbox, vShowEngineTemp 	Checked%ShowEngineTemp% 	x%x_pos% y+10 		wp 		hp 	Right, Температура двигателя
	Gui, 19:Add, Checkbox, vShowGearboxTemp Checked%ShowGearboxTemp% 	x%x_pos% y+10 		wp 		hp 	Right, Температура АКПП
	Gui, 19:Add, Checkbox, vShowFuel 	Checked%ShowFuel% 		x%x_pos% y+10 		wp		hp 	Right, Остаток топлива
	Gui, 19:Add, Checkbox, vShowAirTemp 	Checked%ShowAirTemp% 		x%x_pos% y+10 		wp		hp 	Right, Наружная температура
	

}
if RegExMatch(Cur_Control, "^Speed$") {

	x_pos:=20
	y_pos:=20
	w_text:=380	
	x_param:=x_pos+w_text+x_param_shift

	Gui, 19:Font, s30 ce0e0e0, %rfont%
	Gui, 19:Add, Text,  				 	x0			y%y_pos%	   	w800	h60 	Center, Спидометр, %SpeedProfileName%
	Gui, 19:Font, %CanFont_N%, %rfont%
	y_pos:=80
	Gui, 19:Font, s20 ce0e0e0, %rfont%
	Gui, 19:Add, Text,  				 	x0			y%y_pos%	   	w400	h30 	Center, Настройки
	Gui, 19:Font, %CanFont_N%, %rfont%
	;чекбоксы
	Gui, 19:Add, Checkbox, vSpeedChangeIcon 	Checked%SpeedChangeIcon% 		x%x_pos% y+20		w%w_text%		h30 	Left, Менять иконку
	Gui, 19:Add, Checkbox, vSpeedChangeFont 	Checked%SpeedChangeFont% 		x%x_pos% y+5		w%w_text%		h30 	Left, Менять шрифт значений
	Gui, 19:Add, Checkbox, vSpeedSoundNormal 	Checked%SpeedSoundNormal% 		x%x_pos% y+5		w%w_text%		h30 	Left, Оповещение сигналом Normal
	Gui, 19:Add, Checkbox, vSpeedSoundWarn		Checked%SpeedSoundWarn% 		x%x_pos% y+5		w%w_text%		h30 	Left, Оповещение сигналом Warn
	Gui, 19:Add, Checkbox, vSpeedSoundAlarm 	Checked%SpeedSoundAlarm% 		x%x_pos% y+5		w%w_text%		h30 	Left, Оповещение сигналом Alarm
	
	x_pos:=400
	y_pos:=80
	w_text:=250
	x_param:=x_pos+w_text+x_param_shift
	Gui, 19:Font, s20 ce0e0e0, %rfont%
	Gui, 19:Add, Text,  				 	x400			y%y_pos%   	w400		h30 	Center, Пороги оповещения
	Gui, 19:Font, %CanFont_N%, %rfont%
	Gui, 19:Add, Text,  				 	x%x_pos%		y+20	   	w%w_text% 	h30 	Right, Warn , км/ч:
	Gui, 19:Add, Text,   vWarn_Speed 	gSelControl 	x%x_param%		yp  		w%w_param%	hp 	Right, %Warn_Speed%
	Gui, 19:Add, Text,  				 	x%x_pos%		y+5	   	w%w_text% 	h30 	Right, Alarm , км/ч:
	Gui, 19:Add, Text,   vAlarm_Speed 	gSelControl 	x%x_param%		yp  		w%w_param%	hp 	Right, %Alarm_Speed%









}

if RegExMatch(Cur_Control, "^GearboxTemp$") {
	;GearboxTemp
	x_pos:=20
	y_pos:=20
	w_text:=380
	x_param:=x_pos+w_text+x_param_shift
	
	Gui, 19:Font, s30 ce0e0e0, %rfont%
	Gui, 19:Add, Text,  				 	x0			y%y_pos%	   	w800	h60 	Center, Температура АКПП
	Gui, 19:Font, %CanFont_N%, %rfont%
	y_pos:=80
	Gui, 19:Font, s20 ce0e0e0, %rfont%
	Gui, 19:Add, Text,  				 	x0			y%y_pos%	   	w400	h30 	Center, Настройки
	Gui, 19:Font, %CanFont_N%, %rfont%
	;чекбоксы
	Gui, 19:Add, Checkbox, vGearBoxTempChangeIcon 	Checked%GearBoxTempChangeIcon% 		x%x_pos% y+20		w%w_text%		h30 	Left, Менять иконку
	Gui, 19:Add, Checkbox, vGearBoxTempChangeFont 	Checked%GearBoxTempChangeFont% 		x%x_pos% y+5		w%w_text%		h30 	Left, Менять шрифт значений
	Gui, 19:Add, Checkbox, vGearBoxTempSoundNormal 	Checked%GearBoxTempSoundNormal% 	x%x_pos% y+5		w%w_text%		h30 	Left, Оповещение сигналом Normal
	Gui, 19:Add, Checkbox, vGearBoxTempSoundWarn	Checked%GearBoxTempSoundWarn% 		x%x_pos% y+5		w%w_text%		h30 	Left, Оповещение сигналом Warn
	Gui, 19:Add, Checkbox, vGearBoxTempSoundAlarm 	Checked%GearBoxTempSoundAlarm% 		x%x_pos% y+5		w%w_text%		h30 	Left, Оповещение сигналом Alarm
	
	x_pos:=400
	y_pos:=80
	w_text:=250
	x_param:=x_pos+w_text+x_param_shift
	Gui, 19:Font, s20 ce0e0e0, %rfont%
	Gui, 19:Add, Text,  				 	x400			y%y_pos%   	w400		h30 	Center, Пороги оповещения
	Gui, 19:Font, %CanFont_N%, %rfont%

	Gui, 19:Add, Text,  				 	x%x_pos%		y+20	   	w%w_text% 	h30 	Right, t АКПП   Min, °C:
	Gui, 19:Add, Text,   vMin_GearBoxTemp gSelControl 	x%x_param%		yp  		w%w_param%	hp 	Right, %Min_GearBoxTemp%
	Gui, 19:Add, Text,  				 	x%x_pos%		y+0   		w%w_text% 	hp 	Right, t АКПП  Warn, °C:
	Gui, 19:Add, Text,   vWarn_GearBoxTemp gSelControl 	x%x_param%		yp  		w%w_param% 	hp 	Right, %Warn_GearBoxTemp%
	Gui, 19:Add, Text,  					x%x_pos%		y+0   		w%w_text% 	hp 	Right, t АКПП Alarm, °C:
	Gui, 19:Add, Text,   vAlarm_GearBoxTemp gSelControl 	x%x_param%		yp  		w%w_param% 	hp 	Right, %Alarm_GearBoxTemp%
	

}
if RegExMatch(Cur_Control, "^EngineTemp$") {

	x_pos:=20
	y_pos:=20
	w_text:=380
	x_param:=x_pos+w_text+x_param_shift
	
	Gui, 19:Font, s30 ce0e0e0, %rfont%
	Gui, 19:Add, Text,  				 	x0			y%y_pos%	   	w800	h60 	Center, Температура Двигателя
	Gui, 19:Font, %CanFont_N%, %rfont%
	y_pos:=80
	Gui, 19:Font, s20 ce0e0e0, %rfont%
	Gui, 19:Add, Text,  				 	x0			y%y_pos%	   	w400	h30 	Center, Настройки
	Gui, 19:Font, %CanFont_N%, %rfont%
	;чекбоксы
	Gui, 19:Add, Checkbox, vEngineTempChangeIcon 	Checked%EngineTempChangeIcon% 		x%x_pos% y+20		w%w_text%		h30 	Left, Менять иконку
	Gui, 19:Add, Checkbox, vEngineTempChangeFont 	Checked%EngineTempChangeFont% 		x%x_pos% y+5		w%w_text%		h30 	Left, Менять шрифт значений
	Gui, 19:Add, Checkbox, vEngineTempSoundNormal 	Checked%EngineTempSoundNormal% 		x%x_pos% y+5		w%w_text%		h30 	Left, Оповещение сигналом Normal
	Gui, 19:Add, Checkbox, vEngineTempSoundWarn	Checked%EngineTempSoundWarn% 		x%x_pos% y+5		w%w_text%		h30 	Left, Оповещение сигналом Warn
	Gui, 19:Add, Checkbox, vEngineTempSoundAlarm 	Checked%EngineTempSoundAlarm% 		x%x_pos% y+5		w%w_text%		h30 	Left, Оповещение сигналом Alarm


	;EngineTemp
	x_pos:=400
	y_pos:=80
	w_text:=250
	x_param:=x_pos+w_text+x_param_shift
	Gui, 19:Font, s20 ce0e0e0, %rfont%
	Gui, 19:Add, Text,  				 	x400			y%y_pos%   	w400		h30 	Center, Пороги оповещения
	Gui, 19:Font, %CanFont_N%, %rfont%

	Gui, 19:Add, Text,  				 	x%x_pos%		y+20   	w%w_text% 	h30	Right, t двигателя   Min, °C:
	Gui, 19:Add, Text,   vMin_EngineTemp gSelControl 	x%x_param%		yp  		w%w_param%	hp 	Right, %Min_EngineTemp%
	Gui, 19:Add, Text,  				 	x%x_pos%		y+0   		w%w_text% 	hp 	Right, t двигателя  Warn, °C:
	Gui, 19:Add, Text,   vWarn_EngineTemp gSelControl 	x%x_param%		yp  		w%w_param% 	hp 	Right, %Warn_EngineTemp%
	Gui, 19:Add, Text,  				 	x%x_pos%		y+0   		w%w_text% 	hp 	Right, t двигателя Alarm, °C:
	Gui, 19:Add, Text,   vAlarm_EngineTemp gSelControl 	x%x_param%		yp  		w%w_param% 	hp 	Right, %Alarm_EngineTemp%



}
if RegExMatch(Cur_Control, "^AirTemp$") {

	x_pos:=20
	y_pos:=20
	w_text:=380
	x_param:=x_pos+w_text+x_param_shift
	Gui, 19:Font, s30 ce0e0e0, %rfont%
	Gui, 19:Add, Text,  				 	x0			y%y_pos%	   	w800	h60 	Center, Наружная температура
	Gui, 19:Font, %CanFont_N%, %rfont%
	y_pos:=80
	Gui, 19:Font, s20 ce0e0e0, %rfont%
	Gui, 19:Add, Text,  				 	x0			y%y_pos%	   	w400	h30 	Center, Настройки
	Gui, 19:Font, %CanFont_N%, %rfont%
	;чекбоксы
	Gui, 19:Add, Checkbox, vAirTempChangeIcon 	Checked%AirTempChangeIcon% 		x%x_pos% y+20		w%w_text%		h30 	Left, Менять иконку
	Gui, 19:Add, Checkbox, vAirTempChangeFont 	Checked%AirTempChangeFont% 		x%x_pos% y+5		w%w_text%		h30 	Left, Менять шрифт значений
	Gui, 19:Add, Checkbox, vAirTempSoundNormal 	Checked%AirTempSoundNormal% 		x%x_pos% y+5		w%w_text%		h30 	Left, Оповещение сигналом, нет гололёда
	Gui, 19:Add, Checkbox, vAirTempSoundWarn	Checked%AirTempSoundWarn% 		x%x_pos% y+5		w%w_text%		h30 	Left, Оповещение сигналом, есть гололёд
;	Gui, 19:Add, Checkbox, vAirTempSoundAlarm 	Checked%AirTempSoundAlarm% 		x%x_pos% y+5		w%w_text%		h30 	Left, Оповещение сигналом Alarm

	;AirTemp
	x_pos:=400
	y_pos:=80
	w_text:=250
	x_param:=x_pos+w_text+x_param_shift
	Gui, 19:Font, s20 ce0e0e0, %rfont%
	Gui, 19:Add, Text,  				 	x400			y%y_pos%   	w400		h30 	Center, Пороги оповещения
	Gui, 19:Font, %CanFont_N%, %rfont%
	Gui, 19:Add, Text,  				 	x%x_pos%		y+20 		w%w_text% 	h30 	Right, Гололёд Max, °C:
	Gui, 19:Add, Text,   vWarn_Max_AirTemp gSelControl 	x%x_param%		yp  		w%w_param% 	hp 	Right, %Warn_Max_AirTemp%
	Gui, 19:Add, Text,  				 	x%x_pos%		y+0   		w%w_text% 	hp 	Right, Гололёд Min, °C:
	Gui, 19:Add, Text,   vWarn_Min_AirTemp gSelControl 	x%x_param%		yp  		w%w_param% 	hp 	Right, %Warn_Min_AirTemp%

}
if RegExMatch(Cur_Control, "^Fuel$") {
	x_pos:=20
	y_pos:=20
	w_text:=380
	x_param:=x_pos+w_text+x_param_shift
	Gui, 19:Font, s30 ce0e0e0, %rfont%
	Gui, 19:Add, Text,  				 	x0			y%y_pos%	   	w800	h60 	Center, Остаток топлива
	Gui, 19:Font, %CanFont_N%, %rfont%
	y_pos:=80
	Gui, 19:Font, s20 ce0e0e0, %rfont%
	Gui, 19:Add, Text,  				 	x0			y%y_pos%	   	w400	h30 	Center, Настройки
	Gui, 19:Font, %CanFont_N%, %rfont%
	;чекбоксы
	Gui, 19:Add, Checkbox, vFuelChangeIcon 	Checked%FuelChangeIcon% 		x%x_pos% y+20		w%w_text%		h30 	Left, Менять иконку
	Gui, 19:Add, Checkbox, vFuelChangeFont 	Checked%FuelChangeFont% 		x%x_pos% y+5		w%w_text%		h30 	Left, Менять шрифт значений
	Gui, 19:Add, Checkbox, vFuelSoundNormal Checked%FuelSoundNormal% 		x%x_pos% y+5		w%w_text%		h30 	Left, Оповещение сигналом Normal
	Gui, 19:Add, Checkbox, vFuelSoundWarn	Checked%FuelSoundWarn% 			x%x_pos% y+5		w%w_text%		h30 	Left, Оповещение сигналом Warn
	Gui, 19:Add, Checkbox, vFuelSoundAlarm 	Checked%FuelSoundAlarm% 		x%x_pos% y+5		w%w_text%		h30 	Left, Оповещение сигналом Alarm

	x_pos:=400
	y_pos:=80
	w_text:=250
	x_param:=x_pos+w_text+x_param_shift
	Gui, 19:Font, s20 ce0e0e0, %rfont%
	Gui, 19:Add, Text,  				 	x400			y%y_pos%   	w400		h30 	Center, Пороги оповещения
	Gui, 19:Font, %CanFont_N%, %rfont%
	Gui, 19:Add, Text,  			 	x%x_pos%		y+20 	w%w_text% 	h30 	Right, Остаток топлива  Warn, л.:
	Gui, 19:Add, Text,   vWarn_Fuel gSelControl 	x%x_param%		yp  		w%w_param% 	hp 	Right, %Warn_Fuel%
	Gui, 19:Add, Text,  			 	x%x_pos%		y+0   		w%w_text% 	hp 	Right, Остаток топлива Alarm, л.:
	Gui, 19:Add, Text,   vAlarm_Fuel gSelControl 	x%x_param%		yp  		w%w_param% 	hp 	Right, %Alarm_Fuel%

}
	
	



	

	Gui, 19:Show, x0 y%w_y% w800 h%w_height%, DashBoardSettings
	WinActivate, ahk_id %activewnd%

return





SelControl:

	Gui, 19:Font, %CanFont_N%
	GuiControl, 19:Font, %Cur_Control%
	Cur_Control:=A_GuiControl
	;определить куда подвинуть иконки
	GuiControlGet, CParam, Pos, %Cur_Control%


	yshift_button:=-17
	xshift_Down:=-60
	x_down:=CParamX+xshift_Down
	x_up:=CParamX+CParamW
	y_new:= CParamY + yshift_button

	;подсветить очередную
	Gui, 19:Font, s15 cffffff
	GuiControl, 19:Font, %Cur_Control%
	Gui, 19:Font, %CanFont_N%
	;подвинуть кнопки
	GuiControl, 19:Hide, RSFIcon 
	GuiControl, 19:Hide, RSBIcon 
	GuiControl, 19:Move, RSBIcon, x%x_down% y%y_new%
	GuiControl, 19:Move, RSFIcon, x%x_up% y%y_new%
	GuiControl, 19:Show, RSFIcon 
	GuiControl, 19:Show, RSBIcon 



return


RefreshValue:
	CName:=A_GuiControl
	if (instr(CName,"RSFIcon")>0){
		;+1
;		CVal1=%A_ScriptDir%\skin\can\rsf.bmp
;		CVal2=%A_ScriptDir%\skin\can\rsfp.bmp
;		ButtonPressF(CName, CVal1, CVal2, 19)
		Temp:=%Cur_Control%+1
		%Cur_Control%=%Temp%

}else{
	;-1
;		CVal1=%A_ScriptDir%\skin\can\rsb.bmp
;		CVal2=%A_ScriptDir%\skin\can\rsbp.bmp
;		ButtonPressF(CName, CVal1, CVal2, 19)
		Temp:=%Cur_Control%-1
		%Cur_Control%=%Temp%

}
	GuiControl, 19:, %Cur_Control%, %Temp%
return

SubmitSettings:
	CVal1=%A_ScriptDir%\skin\can\Yes.bmp
	CVal2=%A_ScriptDir%\skin\can\YesP.bmp
	CName=YesIcon
	ButtonPressF(CName, CVal1, CVal2, 19)
	Gui, 19:Submit, NoHide

	;Записать в ини файл
	gosub CanDashboardINIWrite
	gosub DashboardShow
Gui, 19:Destroy
return

SubmitCancel:
	CVal1=%A_ScriptDir%\skin\can\No.bmp
	CVal2=%A_ScriptDir%\skin\can\NoP.bmp
	CName=NoIcon
	ButtonPressF(CName, CVal1, CVal2, 19)
	;перечитать все из ини файла
	gosub CanDashboardINIRead	
	Gui, 19:Destroy
return

CanDashboardINIRead:
	IfNotExist, %CanDashboardINI% 
	{
	gosub CanDashboardINIWrite
		
	}
	IniRead, highlight_ver     	, %CanDashboardINI%, Dashboard		, highlight_ver  	
	IniRead, CanAutoShowAllow     	, %CanDashboardINI%, Dashboard		, CanAutoShowAllow  	
	IniRead, CanAutoHideAllow     	, %CanDashboardINI%, Dashboard		, CanAutoHideAllow    	
	IniRead, CanChangeFontLow 	, %CanDashboardINI%, Dashboard		, CanChangeFontLow	
	IniRead, CanChangeFontWarn 	, %CanDashboardINI%, Dashboard		, CanChangeFontWarn	
	IniRead, CanChangeFontAlarm 	, %CanDashboardINI%, Dashboard		, CanChangeFontAlarm	
	IniRead, def_CanFont_Low 	, %CanDashboardINI%, Dashboard		, def_CanFont_Low	
	IniRead, def_CanFont_Warn 	, %CanDashboardINI%, Dashboard		, def_CanFont_Warn	
	IniRead, def_CanFont_Alarm 	, %CanDashboardINI%, Dashboard		, def_CanFont_Alarm	
	IniRead, ShowEngineTemp      	, %CanDashboardINI%, Dashboard		, ShowEngineTemp     	
	IniRead, ShowGearBoxTemp      	, %CanDashboardINI%, Dashboard		, ShowGearBoxTemp     	
	IniRead, ShowAirTemp          	, %CanDashboardINI%, Dashboard		, ShowAirTemp         	
	IniRead, ShowFuel            	, %CanDashboardINI%, Dashboard		, ShowFuel		
	IniRead, ShowSpeed	     	, %CanDashboardINI%, Dashboard		, ShowSpeed    	
	IniRead, CurSpeedProfile_ID	, %CanDashboardINI%, Dashboard		, CurSpeedProfile_ID   	
	                                                                        
	IniRead, EngineTempChangeIcon   , %CanDashboardINI%, EngineTemp		, EngineTempChangeIcon    	
	IniRead, EngineTempChangeFont   , %CanDashboardINI%, EngineTemp		, EngineTempChangeFont    	
	IniRead, EngineTempSoundNormal  , %CanDashboardINI%, EngineTemp		, EngineTempSoundNormal    	
	IniRead, EngineTempSoundWarn    , %CanDashboardINI%, EngineTemp		, EngineTempSoundWarn    	
	IniRead, EngineTempSoundAlarm   , %CanDashboardINI%, EngineTemp		, EngineTempSoundAlarm    	
	IniRead, Min_EngineTemp       	, %CanDashboardINI%, EngineTemp		, Min_EngineTemp      	
	IniRead, Warn_EngineTemp      	, %CanDashboardINI%, EngineTemp		, Warn_EngineTemp     	
	IniRead, Alarm_EngineTemp     	, %CanDashboardINI%, EngineTemp		, Alarm_EngineTemp    	
	                                                                        
	IniRead, FuelChangeIcon   	, %CanDashboardINI%, Fuel		, FuelChangeIcon    	
	IniRead, FuelChangeFont   	, %CanDashboardINI%, Fuel		, FuelChangeFont    	
	IniRead, FuelSoundNormal  	, %CanDashboardINI%, Fuel		, FuelSoundNormal    	
	IniRead, FuelSoundWarn    	, %CanDashboardINI%, Fuel		, FuelSoundWarn    	
	IniRead, FuelSoundAlarm   	, %CanDashboardINI%, Fuel		, FuelSoundAlarm    	
	IniRead, Warn_Fuel        	, %CanDashboardINI%, Fuel		, Warn_Fuel           	
	IniRead, Alarm_Fuel       	, %CanDashboardINI%, Fuel		, Alarm_Fuel    
	                                                                        
	IniRead, GearBoxTempChangeIcon  , %CanDashboardINI%, GearBoxTemp	, GearBoxTempChangeIcon    	
	IniRead, GearBoxTempChangeFont  , %CanDashboardINI%, GearBoxTemp	, GearBoxTempChangeFont    	
	IniRead, GearBoxTempSoundNormal , %CanDashboardINI%, GearBoxTemp	, GearBoxTempSoundNormal    	
	IniRead, GearBoxTempSoundWarn   , %CanDashboardINI%, GearBoxTemp	, GearBoxTempSoundWarn    	
	IniRead, GearBoxTempSoundAlarm  , %CanDashboardINI%, GearBoxTemp	, GearBoxTempSoundAlarm    	
	IniRead, Min_GearBoxTemp      	, %CanDashboardINI%, GearBoxTemp	, Min_GearBoxTemp     	
	IniRead, Warn_GearBoxTemp     	, %CanDashboardINI%, GearBoxTemp	, Warn_GearBoxTemp    	
	IniRead, Alarm_GearBoxTemp    	, %CanDashboardINI%, GearBoxTemp	, Alarm_GearBoxTemp   	
	                                                                        
	IniRead, AirTempChangeIcon    	, %CanDashboardINI%, AirTemp		, AirTempChangeIcon    	
	IniRead, AirTempChangeFont    	, %CanDashboardINI%, AirTemp		, AirTempChangeFont    	
	IniRead, AirTempSoundNormal   	, %CanDashboardINI%, AirTemp		, AirTempSoundNormal    	
	IniRead, AirTempSoundWarn    	, %CanDashboardINI%, AirTemp		, AirTempSoundWarn    	
;	IniRead, AirTempSoundAlarm    	, %CanDashboardINI%, AirTemp		, AirTempSoundAlarm    	
	IniRead, Warn_Max_AirTemp     	, %CanDashboardINI%, AirTemp		, Warn_Max_AirTemp    	
	IniRead, Warn_Min_AirTemp     	, %CanDashboardINI%, AirTemp		, Warn_Min_AirTemp    	
	IniRead, SpeedChangeIcon    	, %CanDashboardINI%, Speed%CurSpeedProfile_ID%	, SpeedChangeIcon%CurSpeedProfile_ID%    
	IniRead, SpeedChangeFont     	, %CanDashboardINI%, Speed%CurSpeedProfile_ID%	, SpeedChangeFont%CurSpeedProfile_ID%    
	IniRead, SpeedSoundNormal     	, %CanDashboardINI%, Speed%CurSpeedProfile_ID%	, SpeedSoundNormal%CurSpeedProfile_ID%   
	IniRead, SpeedSoundWarn     	, %CanDashboardINI%, Speed%CurSpeedProfile_ID%	, SpeedSoundWarn%CurSpeedProfile_ID%    
	IniRead, SpeedSoundAlarm     	, %CanDashboardINI%, Speed%CurSpeedProfile_ID%	, SpeedSoundAlarm%CurSpeedProfile_ID%  	 
	IniRead, Warn_Speed     	, %CanDashboardINI%, Speed%CurSpeedProfile_ID%	, Warn_Speed%CurSpeedProfile_ID%    	 
	IniRead, Alarm_Speed     	, %CanDashboardINI%, Speed%CurSpeedProfile_ID%	, Alarm_Speed%CurSpeedProfile_ID%        
	if (CurSpeedProfile_ID=1) {
		SpeedProfileName=Город 	
	}
	if (CurSpeedProfile_ID=2) {
		SpeedProfileName=Трасса	
	}

return






CanDashboardINIWrite:
	IfNotExist, %CanDashboardINI% 
	{
		FileAppend,, %CanDashboardINI%
	}
	IniWrite, %highlight_ver%     		, %CanDashboardINI%, Dashboard		, highlight_ver  	
	IniWrite, %CanAutoShowAllow% 		, %CanDashboardINI%, Dashboard		, CanAutoShowAllow
	IniWrite, %CanAutoHideAllow% 		, %CanDashboardINI%, Dashboard		, CanAutoHideAllow
	IniWrite, %CanChangeFontLow% 		, %CanDashboardINI%, Dashboard		, CanChangeFontLow
	IniWrite, %CanChangeFontWarn% 		, %CanDashboardINI%, Dashboard		, CanChangeFontWarn
	IniWrite, %CanChangeFontAlarm% 		, %CanDashboardINI%, Dashboard		, CanChangeFontAlarm
	IniWrite, %def_CanFont_Low% 		, %CanDashboardINI%, Dashboard		, def_CanFont_Low
	IniWrite, %def_CanFont_Warn% 		, %CanDashboardINI%, Dashboard		, def_CanFont_Warn
	IniWrite, %def_CanFont_Alarm% 		, %CanDashboardINI%, Dashboard		, def_CanFont_Alarm
	IniWrite, %ShowEngineTemp% 		, %CanDashboardINI%, Dashboard		, ShowEngineTemp
	IniWrite, %ShowGearBoxTemp% 		, %CanDashboardINI%, Dashboard		, ShowGearBoxTemp
	IniWrite, %ShowAirTemp% 		, %CanDashboardINI%, Dashboard		, ShowAirTemp
	IniWrite, %ShowFuel% 			, %CanDashboardINI%, Dashboard		, ShowFuel
	IniWrite, %ShowSpeed% 			, %CanDashboardINI%, Dashboard		, ShowSpeed
	IniWrite, %CurSpeedProfile_ID%		, %CanDashboardINI%, Dashboard		, CurSpeedProfile_ID

	IniWrite, %EngineTempChangeIcon% 	, %CanDashboardINI%, EngineTemp		, EngineTempChangeIcon    	
	IniWrite, %EngineTempChangeFont% 	, %CanDashboardINI%, EngineTemp		, EngineTempChangeFont    	
	IniWrite, %EngineTempSoundNormal%	, %CanDashboardINI%, EngineTemp		, EngineTempSoundNormal    	
	IniWrite, %EngineTempSoundWarn% 	, %CanDashboardINI%, EngineTemp		, EngineTempSoundWarn    	
	IniWrite, %EngineTempSoundAlarm% 	, %CanDashboardINI%, EngineTemp		, EngineTempSoundAlarm    	
	IniWrite, %Min_EngineTemp%		, %CanDashboardINI%, EngineTemp		, Min_EngineTemp      	
	IniWrite, %Warn_EngineTemp%		, %CanDashboardINI%, EngineTemp		, Warn_EngineTemp     	
	IniWrite, %Alarm_EngineTemp%		, %CanDashboardINI%, EngineTemp		, Alarm_EngineTemp    	

	IniWrite, %FuelChangeIcon%		, %CanDashboardINI%, Fuel		, FuelChangeIcon    	
	IniWrite, %FuelChangeFont%		, %CanDashboardINI%, Fuel		, FuelChangeFont    	
	IniWrite, %FuelSoundNormal%		, %CanDashboardINI%, Fuel		, FuelSoundNormal    	
	IniWrite, %FuelSoundWarn%		, %CanDashboardINI%, Fuel		, FuelSoundWarn    	
	IniWrite, %FuelSoundAlarm%		, %CanDashboardINI%, Fuel		, FuelSoundAlarm    	
	IniWrite, %Warn_Fuel%			, %CanDashboardINI%, Fuel		, Warn_Fuel           	
	IniWrite, %Alarm_Fuel%			, %CanDashboardINI%, Fuel		, Alarm_Fuel    

	IniWrite, %GearBoxTempChangeIcon% 	, %CanDashboardINI%, GearBoxTemp	, GearBoxTempChangeIcon    	
	IniWrite, %GearBoxTempChangeFont% 	, %CanDashboardINI%, GearBoxTemp	, GearBoxTempChangeFont    	
	IniWrite, %GearBoxTempSoundNormal% 	, %CanDashboardINI%, GearBoxTemp	, GearBoxTempSoundNormal    	
	IniWrite, %GearBoxTempSoundWarn% 	, %CanDashboardINI%, GearBoxTemp	, GearBoxTempSoundWarn    	
	IniWrite, %GearBoxTempSoundAlarm%	, %CanDashboardINI%, GearBoxTemp	, GearBoxTempSoundAlarm    	
	IniWrite, %Min_GearBoxTemp%		, %CanDashboardINI%, GearBoxTemp	, Min_GearBoxTemp     	
	IniWrite, %Warn_GearBoxTemp%		, %CanDashboardINI%, GearBoxTemp	, Warn_GearBoxTemp    	
	IniWrite, %Alarm_GearBoxTemp%		, %CanDashboardINI%, GearBoxTemp	, Alarm_GearBoxTemp   	

	IniWrite, %AirTempChangeIcon%		, %CanDashboardINI%, AirTemp		, AirTempChangeIcon    	
	IniWrite, %AirTempChangeFont%		, %CanDashboardINI%, AirTemp		, AirTempChangeFont    	
	IniWrite, %AirTempSoundNormal%		, %CanDashboardINI%, AirTemp		, AirTempSoundNormal    	
	IniWrite, %AirTempSoundWarn%		, %CanDashboardINI%, AirTemp		, AirTempSoundWarn    	
;	IniWrite, %AirTempSoundAlarm%		, %CanDashboardINI%, AirTemp		, AirTempSoundAlarm    	
	IniWrite, %Warn_Max_AirTemp%		, %CanDashboardINI%, AirTemp		, Warn_Max_AirTemp    	
	IniWrite, %Warn_Min_AirTemp%		, %CanDashboardINI%, AirTemp		, Warn_Min_AirTemp    	
	IniWrite, %SpeedChangeIcon%		, %CanDashboardINI%, Speed%CurSpeedProfile_ID%	, SpeedChangeIcon%CurSpeedProfile_ID%
	IniWrite, %SpeedChangeFont%		, %CanDashboardINI%, Speed%CurSpeedProfile_ID%	, SpeedChangeFont%CurSpeedProfile_ID%    	
	IniWrite, %SpeedSoundNormal%		, %CanDashboardINI%, Speed%CurSpeedProfile_ID%	, SpeedSoundNormal%CurSpeedProfile_ID%   	
	IniWrite, %SpeedSoundWarn%		, %CanDashboardINI%, Speed%CurSpeedProfile_ID%	, SpeedSoundWarn%CurSpeedProfile_ID%    	
	IniWrite, %SpeedSoundAlarm%		, %CanDashboardINI%, Speed%CurSpeedProfile_ID%	, SpeedSoundAlarm%CurSpeedProfile_ID%  	
	IniWrite, %Warn_Speed%			, %CanDashboardINI%, Speed%CurSpeedProfile_ID%	, Warn_Speed%CurSpeedProfile_ID%    	
	IniWrite, %Alarm_Speed%			, %CanDashboardINI%, Speed%CurSpeedProfile_ID%	, Alarm_Speed%CurSpeedProfile_ID%



return

                                                                      