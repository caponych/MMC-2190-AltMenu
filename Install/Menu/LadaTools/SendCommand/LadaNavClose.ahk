DetectHiddenWindows, on
RegRead, MMCCoreHWND, HKEY_LOCAL_MACHINE, SOFTWARE\LadaTools, CoreHWND
RegRead, msgC_ID, HKEY_LOCAL_MACHINE, SOFTWARE\LadaTools, UWM_COMAND_ID
PostMessage, msgC_ID, 1, 6,, ahk_id %MMCCoreHWND%
ExitApp