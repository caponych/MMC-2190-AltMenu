ShowFreckGui:
if (FreckGuiRunning=0)
	{
	gosub createfreckgui
	}
else
	{
	return
	}
return

createfreckgui:

WinGet, active_id, ID, A ;�������� ����� ����
activewnd:=active_id 
activewnd:= activewnd + 0 ;��������� ����� � ���������� ���
WinGetTitle, active_title, ahk_id %activewnd%
if (active_title="LadaRadio")
	{
	return
	}

FreckGuiRunning=1
Freq := FreqString(ActiveF)
Gui, 11:-SysMenu -Caption +AlwaysOnTop
Gui, 11:Color, %guibackcolor%
Gui, 11:Font, s16 �%fcolor%, %rfont%
Gui, 11:Add, Text, 0x1 vText x0 y20 w800 h25, ������������: %Freq%
Gui, 11:Show, x0 y0 w800 h70, Freq

WinActivate, ahk_id %activewnd%

FreqOld:=ActiveF
freqTickCount=0
SetTimer, startfreqtimer, 250
return

;������ 
startfreqtimer:
	freqTickCount += 1
	if (FreqOld<>ActiveF)
		{
		Freq := FreqString(ActiveF)
		GuiControl, 11:, Text, ������������: %Freq%
		FreqOld:=ActiveF
		freqTickCount=0
		}
	if (freqTickCount>12)
		{
		freqTickCount=0
		FreckGuiRunning=0
		SetTimer, startfreqtimer, off
		Gui, 11:Destroy
		}
return