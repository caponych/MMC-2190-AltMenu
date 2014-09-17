#SingleInstance ignore

#Include %A_ScriptDir%\MMCCoreColor.ahk

start:

razdel=
Loop, \StaticStore\Menu\Skins\*,2,0
{
	if (a_index=1)
		{
		razdel=%A_LoopFileName%|
		razdelsel=%A_LoopFileName%
		}
	else
		{
		razdel=%razdel%|%A_LoopFileName%
		}
}
gosub adlistbox

Gui, -SysMenu -Caption +AlwaysOnTop
Gui, Color, %guibackcolor%
Gui, Font, с%fcolor%
Gui, Font, s12
Gui, Add, Text, x10 y430 w330 h40 vabout
Gui, Add, Text, x405 y400 w385 h20 vlastchoice
Gui, Font, s18
Gui, Add, Text, 0x1 x0 y10 w800 h30, Настройки NewMenu
Gui, Font, cc000000
Gui, Add, ListBox, gadlistbox vrazdelsel x10 y40 w385 h400, %razdel%
Gui, Add, ListBox, vChoice x405 y40 w385 h360, %ListboxItems%
Gui, Add, Button, x350 y430 w140 h40 gYesg , Применить
Gui, Add, Button, x500 y430 w140 h40 gDelg, Удалить
Gui, Add, Button, x650 y430 w140 h40 gGuiClose, Закрыть
Gui, Show, w800 h480, NewMenuSettings
gosub aboutshow
return

aboutshow:

scinini=\StaticStore\Menu\Skins\%razdelsel%\scinini.ini
IniRead, lastchoice, %scinini%, NewMenuSettings, lastchange
GuiControl, , lastchoice, Текущий выбор: %lastchoice%

IfExist, \StaticStore\Menu\Skins\%razdelsel%\about.txt
	{
	FileReadLine, textabout, \StaticStore\Menu\Skins\%razdelsel%\about.txt, 1
	GuiControl, , about, %textabout%
	}
else
	{
	GuiControl, , about
	}
return

adlistbox:
Gui, Submit, NoHide
ListboxItems=
Loop, \StaticStore\Menu\Skins\%razdelsel%\*,2,0
{
	if (a_index=1)
		{
		ListboxItems=%A_LoopFileName%
		}
	else
		{
		ListboxItems=%ListboxItems%|%A_LoopFileName%
		}
}
GuiControl, , Choice, |%ListboxItems%
gosub aboutshow
return

Yesg:
Gui, Submit, NoHide
IfExist, \StaticStore\Menu\Skins\%razdelsel%\%Choice%\Skin.mscr
run \StaticStore\Menu\Skins\%razdelsel%\%Choice%\Skin.mscr
scinini=\StaticStore\Menu\Skins\%razdelsel%\scinini.ini
IfNotExist, %scinini%
	{
	FileAppend,, %scinini%
	}
IniWrite, %Choice%, %scinini%, NewMenuSettings, lastchange
goto GuiClose
return

Delg:
Gui, Submit, NoHide
Gui, Cancel

if (!Choice=1)
{
MsgBox, 4, , Удалить %razdelsel%?
delitem=1
}
else
{
MsgBox, 4, , Удалить %Choice%?
delitem=0
}

IfMsgBox No
{
Gui, Show
return
}
else
{
if (delitem=0)
{
FileRemoveDir, \StaticStore\Menu\Skins\%razdelsel%\%Choice%, 1
}
else
{
FileRemoveDir, \StaticStore\Menu\Skins\%razdelsel%, 1
}
Gui, Destroy
goto start
}
Return

GuiClose:
ExitApp