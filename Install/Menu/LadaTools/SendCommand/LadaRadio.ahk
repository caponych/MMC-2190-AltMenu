DetectHiddenWindows, on
RegRead, MMCCoreHWND, HKEY_LOCAL_MACHINE, SOFTWARE\LadaTools, CoreHWND
RegRead, msg_ID, HKEY_LOCAL_MACHINE, SOFTWARE\LadaTools, UWM_KEY_ID
PostMessage, msg_ID, 5, 0,, ahk_id %MMCCoreHWND%
ExitApp
