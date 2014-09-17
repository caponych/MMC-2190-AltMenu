ShowTrackGui:

RegRead, NitrogenRunning, HKEY_LOCAL_MACHINE, System\State\Nitrogen, Running
if (NitrogenRunning=0)
	{
	return
	}

if (TrackGuiRunning=0)
	{
	gosub createtrackgui
	}
else
	{
	return
	}
return

createtrackgui:

AudioSongArtist=
AudioSongTitle=
AudioSongTitleOld:=AudioSongTitle

WinGet, active_id, ID, A ;получаем хэндл окна
activewnd:=active_id 
activewnd:= activewnd + 0 ;переводим хэндл в десятичный вид
WinGetTitle, active_title, ahk_id %activewnd%
if (active_title="Nitrogen")
	{
	return
	}
TrackGuiRunning=1
Gui, 10:-SysMenu -Caption +AlwaysOnTop
Gui, 10:Color, %guibackcolor%
Gui, 10:Font, s16 с%fcolor%, %rfont%
Gui, 10:Add, Text, 0x1 vText x0 y10 w800 h25,%AudioSongArtist%
Gui, 10:Add, Text, 0x1 vText2 x0 y35 w800 h25,%AudioSongTitle%
Gui, 10:Show, x0 y0 w800 h70, Track

WinActivate, ahk_id %activewnd%

TrackTickCount=0
SetTimer, starttracktimer, 250
return

;таймер 
starttracktimer:
	TrackTickCount += 1
	RegRead, AudioSongArtist, HKEY_LOCAL_MACHINE, System\State\Nitrogen, SongArtist
	RegRead, AudioSongTitle, HKEY_LOCAL_MACHINE, System\State\Nitrogen, SongTitle
	if (AudioSongTitleOld<>AudioSongTitle)
		{
		GuiControl, 10:, Text, %AudioSongArtist%
		GuiControl, 10:, Text2, %AudioSongTitle%
		AudioSongTitleOld:=AudioSongTitle
		TrackTickCount=0
		}
	if (TrackTickCount>15)
		{
		TrackTickCount=0
		TrackGuiRunning=0
		SetTimer, starttracktimer, off
		Gui, 10:Destroy
		}
return