#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

#Include, Functions.ahk
#Include, debugui.ahk



Numpad1::
    doTheShit()
return

doTheShit() {
    sleepTimer = 1000
    checkPrayer()
    sleep 1000
    checkOverload()
    sleep 1000
    resetPOV()
    sleep 1000
    IniRead, move1x, settings.ini, movekjroom, x
    IniRead, move1y, settings.ini, movekjroom, y
    MouseClick, Left, %move1x%, %move1y%
    bossbarstate = 0
    Loop {
        bossbarstate := checkBossBar()
        if (bossbarstate = 0) {
            sleepTimer = 1000
            clickKj()
            sleep %sleepTimer%
        } else if (bossbarstate = 1) {
            sleepTimer = 200
        }
        if (bossbarstate = 2) {
            break
        } else if (bossbarstate = 3) {
            IniRead, invslot2x, settings.ini, invslot2, x
            IniRead, invslot2y, settings.ini, invslot2, y
            MouseClick, Left, %invslot2x%, %invslot2y%
            sleep 100
            clickKj()
            sleep 3000
        }
        sleep %sleepTimer%

    }

}

XButton2::
    savePixelColor()
return
    

XButton1::
    saveCoordinates()
return

Numpad0::
    getMouseCoords()
return

;pauseeverything
Numpad9::
Pause
Suspend
return
