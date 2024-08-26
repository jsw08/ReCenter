#Requires AutoHotkey v2.0
#include ./Lib/UIA.ahk

WMRBar := false

checkWMRBar() {
    if (PixelGetColor(5, 5) != "0x0078d4") {
        return
    }

    WMRBar := true
    Send("#y")
    Sleep(100)
}

Recenter() {
    If !WinExist("Mixed Reality Portal") {
        return
    }
    checkWMRBar()
    WinActivate("Mixed Reality Portal")

    WMR := UIA.ElementFromHandle("Mixed Reality Portal")
    try {
        while 1 {
            WMR.FindElement({ name: "Back" }).Click()
        }
    } 

    if WMR.WaitElement({ name: "Ready" }).Location.w == 0 {
        WMR.FindElement({ name: "Expand" }).Click()
    }
    WMR.WaitElement({ name: "Set up room boundary" }).Click()
    WMR.WaitElement({
        name: "Set me up for seated and standing You won't have a boundary, so you'll need to stay put. To create a boundary later, go to Start > Mixed Reality Portal on your desktop."
    }).Click()
    WMR.WaitElement({ name: "I'm sure" }).Click()
    WMR.WaitElement({ name: "Centre" }).Click() ; Sometimes it get's stuck when there's e.g not enough light. TODO: fix

    WMR.WaitElement({ name: "Expand"}) ; Make sure window doesn't hide too soon.

    if WMRBar {
        Send("#y")
    }

    WinMinimize
}

Recenter()