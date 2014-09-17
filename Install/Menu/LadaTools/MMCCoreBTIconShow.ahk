bticonshow:

if(bticonshowing=1)
	{
	if (BTCallState=0 or BTCallState=1)
		{
		gosub bticonhide
		}
	}
else
	{
	if (BTCallState>1)
		{
		WinGet, active_id, ID, A ;получаем хэндл окна
		activewnd:=active_id 
		activewnd:= activewnd + 0 ;переводим хэндл в десятичный вид
		if (SaverRuning=0)
			{
			gosub MoveMouse
			}
		Gui, 18:-SysMenu -Caption +AlwaysOnTop
		Gui, 18:Color, %guibackcolor%
		Gui, 18:Add, Picture, x0 y0 w40 h40, %A_ScriptDir%\skin\BT\BTIcon.bmp
		Gui, 18:Show, x760 y440 w40 h40, BTIcon
		WinActivate, ahk_id %activewnd%
		bticonshowing=1
		}
	}
return

bticonhide:
Gui, 18:Destroy
		WinGet, active_id, ID, A ;получаем хэндл окна
		activewnd:=active_id 
		activewnd:= activewnd + 0 ;переводим хэндл в десятичный вид
		WinActivate, ahk_id %activewnd%
		bticonshowing=0
return