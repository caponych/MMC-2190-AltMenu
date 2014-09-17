#SingleInstance ignore

F1=%A_scriptdir%\obdII.csv
fcolor=c99ccff
guibackcolor=1e1e1e
Er1=1
Er2=1
Er3=1
Er4=1
Er5=1
Ers1=P
Ers2=0
Ers3=0
Ers4=0
Ers5=0

Gui, -SysMenu -Caption +AlwaysOnTop
Gui, Color, %guibackcolor%
Gui, Font, с%fcolor%
Gui, Font, S20
Gui, Add, Button, x10 y40 w40 h40 gD1, <
Gui, Add, Button, x10 y80 w40 h40 gD2, <
Gui, Add, Button, x10 y120 w40 h40 gD3, <
Gui, Add, Button, x10 y160 w40 h40 gD4, <
Gui, Add, Button, x10 y200 w40 h40 gD5, <
Gui, Add, Button, x100 y40 w40 h40 gI1, >
Gui, Add, Button, x100 y80 w40 h40 gI2, >
Gui, Add, Button, x100 y120 w40 h40 gI3, >
Gui, Add, Button, x100 y160 w40 h40 gI4, >
Gui, Add, Button, x100 y200 w40 h40 gI5, >
Gui, Font, S26
Gui, Add, Text, 0x1 x55 y40 w40 h40 vEr1, P
Gui, Add, Text, 0x1 x55 y80 w40 h40 vEr2, 0
Gui, Add, Text, 0x1 x55 y120 w40 h40 vEr3, 0
Gui, Add, Text, 0x1 x55 y160 w40 h40 vEr4, 0
Gui, Add, Text, 0x1 x55 y200 w40 h40 vEr5, 0
Gui, Font, S14
Gui, Add, Text, 0x1 x0 y5 w600 h30, Коды OBDII для ВАЗ
Gui, Add, Text, 0x1 x150 y320 w450 h30 vPOS1, автор: Magix, NVRSK
Gui, Font, ccFFFFFF
Gui, Add, Text, x160 y60 w420 h240 vResult
Gui, Font, с%fcolor%
Gui, Add, GroupBox, x150 y30 w440 h280, Результат поиска
Gui, Font, cc000000
Gui, Add, Button, x10 y250 w130 h40 gSEARCH, Поиск
Gui, Add, Button, x10 y300 w130 h40 gGuiclose, Выход
Gui,Show, w600 h350,OBDII Code
return

D1:
ChangeERNum(1,5,1,1)
return

D2:
ChangeERNum(2,4,2,1)
return

D3:
ChangeERNum(3,14,3,1)
return

D4:
ChangeERNum(4,14,3,1)
return

D5:
ChangeERNum(5,14,3,1)
return

I1:
ChangeERNum(1,5,1,2)
return

I2:
ChangeERNum(2,4,2,2)
return

I3:
ChangeERNum(3,14,3,2)
return

I4:
ChangeERNum(4,14,3,2)
return

I5:
ChangeERNum(5,14,3,2)
return

ChangeERNum(ErNum,MaxNum,ERCType,IDN)
{
ERC1 = P|B|C|U|D
ERC2 = 0|1|2|6
ERC3 = 0|1|2|3|4|5|6|7|8|9|A|B|D|E
if (IDN=1)
	{
	if (Er%ErNum%>1)
		{
		Er%ErNum%-=1
		}
	else
		{
		Er%ErNum%=%MaxNum%
		}
	}
if (IDN=2)
	{
	if (Er%ErNum%<MaxNum)
		{
		Er%ErNum%+=1
		}
	else
		{
		Er%ErNum%=1
		}
	}
	Loop, parse, ERC%ERCType%, |
	{
	if (Er%ErNum%=A_index)
		{
		ErS%ErNum%=%A_LoopField%
		er:=ErS%ErNum%
		}
	}
	GuiControl,,Er%ErNum%,%Er%
	
}


SEARCH:
searchok=0
SearchString=%Ers1%%Ers2%%Ers3%%Ers4%%Ers5%
GuiControl,,POS1,Идет поиск %Ers1%%Ers2%%Ers3%%Ers4%%Ers5%
Gui,submit,nohide
GuiControl,,Result,
loop,read,%F1%
 {
 LR=%A_loopreadline%
 stringsplit,C,LR,;,
 if(C1=SearchString)
	{
	GuiControl,,Result, Код ошибки: %C1%`nПроизводитель: %C2%`nОписание:`n%C3%`n%C4%`n%C5%
	searchok=1
	}
 }
 GuiControl,,POS1,Поиск завершен.
 if (searchok=0)
 {
 GuiControl,,Result, Запись с кодом ошибки %SearchString% не найдена.
 }
return


Guiclose:
exitapp