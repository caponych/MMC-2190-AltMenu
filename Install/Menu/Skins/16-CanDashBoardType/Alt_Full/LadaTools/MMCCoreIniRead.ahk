#IncludeAgain %A_ScriptDir%\MMCCoreColor.ahk
#IncludeAgain %A_ScriptDir%\MMCCoreColorCan.ahk
#IncludeAgain %A_ScriptDir%\MMCCoreCanAutoShow.ahk
#IncludeAgain %A_ScriptDir%\MMCCoreCanAutoHide.ahk

NaviProgRuning=0
AudioProgRuning=0
MediaProgRuning=0
SaverRuning=0
VolRuning=0
SoundSettingsRun=0
VideoSettingsRun=0
RadioRuning=0
MsgCountStart=0
RADIOAUTOSEARCHEND=0
NewMenuVersion=0
TrackGuiRunning=0
FreckGuiRunning=0
imediatlysaverrun=0
BTActive=0
DashBoardRuning=0
CanEngineTempOld=-100
CanFuelOld=-1
CanGearboxTempOld=-100
CanAirTempOld=-100
CanBatteryChargeFlagold=-1
CanWarningEngineTempFlagOld=-1
CanWarningOilPressureFlagOld=-1
CanCheckEngineOld=-1
DashBoardAutoStart=0
ActiveCAN=0
bticonshowing=0
btvolchange=0

Day1=Воскресенье
Day2=Понедельник
Day3=Вторник
Day4=Среда
Day5=Четверг
Day6=Пятница
Day7=Суббота
Mon01=января
Mon02=февраля
Mon03=марта
Mon04=апреля
Mon05=мая
Mon06=июня
Mon07=июля
Mon08=августа
Mon09=сентября
Mon10=октября
Mon11=ноября
Mon12=декабря

Can_GetEngineTemp=%CanMMCdll%\GetEngineTemp ; float / Функция возвращает значение температуры двигателя
Can_GetFuel=%CanMMCdll%\GetFuel ; float / Функция возвращает значение уровня топлива
Can_GetGearboxTemp=%CanMMCdll%\GetGearboxTemp ; float / Функция возвращает значение температуры АКПП
Can_GetAirTemp=%CanMMCdll%\GetAirTemp ; float/ Функция возвращает значение температуры воздуха (при наличии датчика внешней температуры)
Can_GetBatteryChargeFlag=%CanMMCdll%\GetBatteryChargeFlag ; int / Функция возвращает значение флага отсутствия заряда АБК
Can_GetWarningEngineTempFlag=%CanMMCdll%\GetWarningEngineTempFlag ; int / Функция возвращает значение флага превышения температуры двигателя
Can_GetWarningOilPressureFlag=%CanMMCdll%\GetWarningOilPressureFlag ; int / Функция возвращает значение флага аварийного давления масла
Can_GetCheckEngine=%CanMMCdll%\GetCheckEngine ; int / Функция возвращает значение флагов Check Engine (2 флага)
Can_GetActiveCAN=%CanMMCdll%\GetActiveCAN ; int/ Функция возвращает значение 1 если сообщения от комбинации приборов принимаются (вкл. зажигание), 0 - если не принимаются.
Can_ResetECUErrors=%CanMMCdll%\ResetECUErrors ; int / Функция посылает запрос на сброс ошибок в КСУД
Can_ResetEngineECU=%CanMMCdll%\ResetEngineECU; ;int / Функция выполняет запрос на сброс КСУД: mode = 1  - простой сброс как при выключении питания
                                                                         ;mode = 144  - полный сброс к заводским установкам
                                                                         ;mode = 145  - сброс обучения
;вентилятор и скорость
CAN_GetSpeed=%CanMMCdll%\GetSpeed		; float // Функция возвращает значение текущей скорости в км/ч
CAN_Fan1On=%CanMMCdll%\Fan1On			; // Функция посылает запрос на включение вентилятора охлаждения двигателя. После перезапуска двигателя управление переходит к контроллеру ЭСУД
CAN_Fan1Off=%CanMMCdll%\Fan1Off			; // Функция посылает запрос на передачу управления вентилятором контроллеру ЭСУД
CAN_SetIdleRPM=%CanMMCdll%\SetIdleRPM		; (int rpm)// Функция посылает запрос на изменение оборотов холостого хода. После перезапуска двигателя обороты холостого хода сбрасываются к заводским.



BT_Answer=%BluetoothMMCdll%\Answer
BT_Terminate=%BluetoothMMCdll%\Terminate
BT_GetCurrentCallNumber=%BluetoothMMCdll%\GetCurrentCallNumber
BT_Dial=%BluetoothMMCdll%\Dial
BT_GetCallState=%BluetoothMMCdll%\GetCallState
BT_Dial=%BluetoothMMCdll%\Dial
BT_GetCallState=%BluetoothMMCdll%\GetCallState
BT_GetLocalDeviceName=%BluetoothMMCdll%\GetLocalDeviceName
BT_GetLocalPinCode=%BluetoothMMCdll%\GetLocalPinCode
BT_SetLocalDeviceName=%BluetoothMMCdll%\SetLocalDeviceName
BT_SetPinCode=%BluetoothMMCdll%\SetPinCode
BT_SetPinCodeAuto=%BluetoothMMCdll%\SetPinCodeAuto
BT_AVRCPCmd=%BluetoothMMCdll%\AVRCPCmd

;пропишем функции дллки
Api_SetHwnd=%mmc21%\Api_SetHwnd
Api_SetActivateMode=%mmc21%\Api_SetActivateMode
Api_GetActivateMode=%mmc21%\Api_GetActivateMode
Api_GetCurrentTime=%mmc21%\Api_GetCurrentTime
API_GetCAMState=%mmc21%\API_GetCAMState
API_SetCAMState=%mmc21%\API_SetCAMState
Api_SetBTMuteState=%mmc21%\Api_SetBTMuteState
Api_GetMuteState=%mmc21%\Api_GetMuteState
Api_SetMuteState=%mmc21%\Api_SetMuteState

Aud_GetVolume=%mmc21%\Aud_GetVolume
Aud_SetVolume=%mmc21%\Aud_SetVolume
Aud_SetBalance=%mmc21%\Aud_SetBalance
Aud_SetFader=%mmc21%\Aud_SetFader
Aud_SetLoud=%mmc21%\Aud_SetLoud
Aud_SetLoudCFre=%mmc21%\Aud_SetLoudCFre
Aud_SetBass=%mmc21%\Aud_SetBass
Aud_SetMid=%mmc21%\Aud_SetMid
Aud_SetTreble=%mmc21%\Aud_SetTreble

Radio_GetCBand=%mmc21%\Radio_GetCurrentBand
Radio_SetBand=%mmc21%\Radio_SetBand
Radio_SetFreq=%mmc21%\Radio_SetFreq
Radio_GetFreq=%mmc21%\Radio_GetCurrentFreq
Radio_Search=%mmc21%\Radio_AutoSearch
Radio_ManSearch=%mmc21%\Radio_ManSearch
Radio_GetStereoMsg=%mmc21%\Radio_GetStereoMsg

Vid_SetBright=%mmc21%\Vid_SetBright
Vid_SetColor=%mmc21%\Vid_SetColor
Vid_SetContrast=%mmc21%\Vid_SetContrast

videoini=%A_ScriptDir%\ini\LadaVideo.ini
SoundIni=%A_ScriptDir%\ini\LadaSound.ini
radioini=%A_ScriptDir%\ini\LadaRadio.ini
RearCamINI=%A_ScriptDir%\ini\RearCam.ini
NewMenuVersionini=%A_ScriptDir%\ini\NewMenuVersion.ini
VolShowINI=%A_ScriptDir%\ini\VolShow.ini


;пишем HWND
RegWrite, REG_SZ, HKEY_LOCAL_MACHINE, SOFTWARE\LadaTools, CoreHWND, %sethwnd%
RegWrite, REG_SZ, HKEY_LOCAL_MACHINE, SOFTWARE\LadaTools, UWM_KEY_ID, %msg_ID%
RegWrite, REG_SZ, HKEY_LOCAL_MACHINE, SOFTWARE\LadaTools, UWM_COMAND_ID, %msgC_ID%


		
;пишем ини громкости
IfNotExist, %VolShowINI%
	{
	FileAppend,, %VolShowINI%
	IniWrite, 353535, %VolShowINI%, VolShow, guibackcolor
	IniWrite, c00cc00, %VolShowINI%, VolShow, fcolor
	
	IniWrite, 205, %VolShowINI%, VolShow, MainX
	IniWrite, 420, %VolShowINI%, VolShow, MainY
	IniWrite, 390, %VolShowINI%, VolShow, MainW
	IniWrite, 58, %VolShowINI%, VolShow, MainH
	
	IniWrite, 75, %VolShowINI%, VolShow, MeterX
	IniWrite, 19, %VolShowINI%, VolShow, MeterY
	IniWrite, 290, %VolShowINI%, VolShow, MeterW
	IniWrite, 20, %VolShowINI%, VolShow, MeterH
	
	IniWrite, 25, %VolShowINI%, VolShow, TextX
	IniWrite, 19, %VolShowINI%, VolShow, TextY
	IniWrite, 40, %VolShowINI%, VolShow, TextW
	IniWrite, 20, %VolShowINI%, VolShow, TextH
	}
	
	IniRead, Volguibackcolor, %VolShowINI%, VolShow, guibackcolor
	IniRead, Volfcolor, %VolShowINI%, VolShow, fcolor
	
	IniRead, VolMainX, %VolShowINI%, VolShow, MainX
	IniRead, VolMainY, %VolShowINI%, VolShow, MainY
	IniRead, VolMainW, %VolShowINI%, VolShow, MainW
	IniRead, VolMainH, %VolShowINI%, VolShow, MainH
	
	IniRead, VolMeterX, %VolShowINI%, VolShow, MeterX
	IniRead, VolMeterY, %VolShowINI%, VolShow, MeterY
	IniRead, VolMeterW, %VolShowINI%, VolShow, MeterW
	IniRead, VolMeterH, %VolShowINI%, VolShow, MeterH
	
	IniRead, VolTextX, %VolShowINI%, VolShow, TextX
	IniRead, VolTextY, %VolShowINI%, VolShow, TextY
	IniRead, VolTextW, %VolShowINI%, VolShow, TextW
	IniRead, VolTextH, %VolShowINI%, VolShow, TextH

;пишем ини задней камеры
IfNotExist, %RearCamINI%
	{
	FileAppend,, %RearCamINI%
	IniWrite, 0, %RearCamINI%, RearCam, Mode
	}
	IniRead, RearCamLastMode, %RearCamINI%, RearCam, Mode

;читаем радио ини
IfNotExist, %radioini%
	{
	FileAppend,, %radioini%
	IniWrite, LadaRadio v1 by Magix NVRSK, %radioini%, ABOUT, Info
	IniWrite, 1, %radioini%, Radio, ActivePreset
	IniWrite, 1, %radioini%, Radio, ShowLogo
	Loop 28
		{
		IniWrite, 0, %radioini%, Radio, Preset%a_index%
		}
	IniWrite, 8750, %radioini%, Radio, Preset1
	}

IniRead, RadioActivePreset, %radioini%, Radio, ActivePreset
if (RadioActivePreset ! or RadioActivePreset<1 or RadioActivePreset>28 or RadioActivePreset= )
{
RadioActivePreset=1
}
IniRead, ShowLogo, %radioini%, Radio, ShowLogo

Loop 28
	{
	IniRead, RadioPreset%a_index%, %radioini%, Radio, Preset%a_index%
	}
	
;читаем ини SoundIni
IfNotExist, %SoundIni%
	{
	FileAppend,, %SoundIni%
	IniWrite, LadaSoundSettings v1 by Magix NVRSK, %SoundIni%, ABOUT, Info
	IniWrite, 1, %SoundIni%, Sound, Ton
	IniWrite, 0, %SoundIni%, Sound, TonCF
	IniWrite, 6, %SoundIni%, Sound, Preset
	IniWrite, 4, %SoundIni%, Sound, Bass
	IniWrite, 1, %SoundIni%, Sound, Mid
	IniWrite, 4, %SoundIni%, Sound, Treble
	IniWrite, 0, %SoundIni%, Sound, Balance
	IniWrite, 0, %SoundIni%, Sound, Fader
	IniWrite, 30, %SoundIni%, Sound, Volume
	IniWrite, 30, %SoundIni%, Sound, BtVolume
	}
	IniRead, SoundTone, %SoundIni%, Sound, Ton
	IniRead, SoundToneCF, %SoundIni%, Sound, TonCF
	IniRead, SoundPreset, %SoundIni%, Sound, Preset
	IniRead, UBass, %SoundIni%, Sound, Bass
	IniRead, UMid, %SoundIni%, Sound, Mid
	IniRead, UTreble, %SoundIni%, Sound, Treble
	IniRead, SoundBalance, %SoundIni%, Sound, Balance
	IniRead, SoundFader, %SoundIni%, Sound, Fader
	IniRead, SoundVolume, %SoundIni%, Sound, Volume
	IniRead, BtVolume, %SoundIni%, Sound, BtVolume

;читаем ини videoini
IfNotExist, %videoini%
	{
	FileAppend,, %videoini%
	IniWrite, LadaVideoSettings v1 by Magix NVRSK, %videoini%, ABOUT, Info
	IniWrite, 30, %videoini%, Day, Bright
	IniWrite, 30, %videoini%, Day, Contrast
	IniWrite, 30, %videoini%, Day, Color
	IniWrite, 10, %videoini%, Night, Bright
	IniWrite, 30, %videoini%, Night, Contrast
	IniWrite, 30, %videoini%, Night, Color
	IniWrite, 1, %videoini%, Mode, Last
	IniWrite, 0, %videoini%, Saver, Activate
	IniWrite, 30, %videoini%, Saver, IdleTime
	}
	IniRead, DayBri, %videoini%, Day, Bright
	IniRead, DayCon, %videoini%, Day, Contrast
	IniRead, DayCol, %videoini%, Day, Color
	IniRead, NightrBri, %videoini%, Night, Bright
	IniRead, NightrCon, %videoini%, Night, Contrast
	IniRead, NightrCol, %videoini%, Night, Color
	IniRead, LastVideoMode, %videoini%, Mode, Last
	IniRead, SaverActivate, %videoini%, Saver, Activate
	IniRead, IdleTime, %videoini%, Saver, IdleTime
	
;настройки аппаратных кнопок
Action_0_0= ;Mute
Path_0_0= ;Mute
Action_4_0= ;Power
Path_4_0= ;Power
Action_5_0=GoSub ;Radio
Path_5_0=RadioStartGui ;Radio
Action_5_1=GoSub ;RadioLongP
Path_5_1=radiooff ;RadioLongP
Action_6_0=GoSub ;Media
Path_6_0=StartMedia ;Media
Action_6_1=GoSub ;MediaLongP
Path_6_1=StartMedia ;MediaLongP
Action_7_0=GoSub ;DayNight
Path_7_0=DayNight ;DayNight
Action_7_1=GoSub ;DayNightLongP
Path_7_1=VideoSettingsStartGui ;DayNightLongP
Action_8_2=GoSub ;BackwardOnPress
Path_8_2=BackwardPress ;BackwardOnPress
Action_8_3= ;BackwardRelease
Path_8_3= ;BackwardRelease
Action_9_2=GoSub ;ForwardOnPress
Path_9_2=ForwardPress ;ForwardOnPress
Action_9_3= ;ForwardRelease
Path_9_3= ;ForwardRelease
Action_10_0=GoSub ;PickUpPhone
Path_10_0=PickUpPhone ;PickUpPhone
Action_10_1=GoSub ;PickUpPhoneLongP
Path_10_1=BTSoundOn ;PickUpPhoneLongP
Action_11_2=GoSub ;OkOnPress
Path_11_2=OkPress ;OkOnPress
Action_11_3= ;OkRelease
Path_11_3= ;OkRelease
Action_12_0=GoSub ;PutDownPhone
Path_12_0=PutDownPhone ;PutDownPhone
Action_12_1=GoSub ;PutDownPhoneLongP
Path_12_1=BTSoundOff ;PutDownPhoneLongP
Action_13_0=GoSub ;AsPs
Path_13_0=NaviStart ;AsPs
Action_13_1=GoSub ;AsPsLongP
Path_13_1=Navi2Start ;AsPsLongP
Action_14_0=GoSub ;Info
Path_14_0=DashBoardRun ;Info
Action_14_1=GoSub ;InfoLongP
Path_14_1=AboutGuiShow ;InfoLongP
Action_15_0=GoSub ;Menu
Path_15_0=StartMainMenu ;Menu
Action_15_1=Run ;MenuLongP
Path_15_1=MODE_KEY.mscr ;MenuLongP
Action_16_0=Run ;Audio
Path_16_0=Audio.mscr ;Audio
Action_16_1=Run ;AudioLongP
Path_16_1=Audiooff.mscr ;AudioLongP
Action_17_0=GoSub ;AF
Path_17_0=SoundSettingsStartGui ;AF
Action_17_1=Run ;AFLongP
Path_17_1=SoftKey.mscr ;AFLongP