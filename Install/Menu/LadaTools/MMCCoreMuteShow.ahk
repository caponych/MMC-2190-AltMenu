muteshow:
WinGet, active_id, ID, A ;�������� ����� ����
activewnd:=active_id 
activewnd:= activewnd + 0 ;��������� ����� � ���������� ���
if (SaverRuning=0)
	{
	gosub MoveMouse
	}
Gui, 9:-SysMenu -Caption +AlwaysOnTop
Gui, 9:Color, %guibackcolor%
Gui, 9:Add, Picture, x0 y0 w40 h40, %A_ScriptDir%\skin\VolShow\mute.bmp
Gui, 9:Show, x0 y440 w40 h40, Mute
WinActivate, ahk_id %activewnd%
return

mutehide:
Gui, 9:Destroy
		WinGet, active_id, ID, A ;�������� ����� ����
		activewnd:=active_id 
		activewnd:= activewnd + 0 ;��������� ����� � ���������� ���
		WinActivate, ahk_id %activewnd%
return