#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

clickMelee() {
    ImageSearch, FoundX, FoundY, 10, 35, 515, 365, *30 C:\AHK Images\meleepray2.png
    FoundY += 50
    MouseClick, Left, %FoundX%, %FoundY%
    Sleep 250
}

clickMage() {
    ImageSearch, FoundX, FoundY, 10, 35, 515, 365, *30 C:\AHK Images\magepray2.png
    FoundY += 50
    MouseClick, Left, %FoundX%, %FoundY%
    Sleep 250
}

clickRange() {
    ImageSearch, FoundX, FoundY, 10, 35, 515, 365, *30 C:\AHK Images\rangepray2.png
    FoundY += 50
    MouseClick, Left, %FoundX%, %FoundY%
    Sleep 250
}
    
clickKj() {
    IniRead, pixelColor, settings.ini, kjpurp, color
    PixelSearch, FoundX, FoundY, 10, 35, 515, 365, %pixelColor%, 0, fast
    
    if (ErrorLevel = 0)
        MouseClick, Left, %FoundX%, %FoundY%
        
    IniRead, pixelColor, settings.ini, kjgold, color
    PixelSearch, FoundX, FoundY, 10, 35, 515, 365, %pixelColor%, 0, fast
    
    if (ErrorLevel = 0)
        MouseClick, Left, %FoundX%, %FoundY%  
}

clickHd() {
    IniRead, pixelColor, settings.ini, hdgrey, color
    PixelSearch, FoundX, FoundY, 10, 35, 515, 365, %pixelColor%, 0, fast
    
    if (ErrorLevel = 0)
        MouseClick, Left, %FoundX%, %FoundY%
        Sleep 250
        
    IniRead, pixelColor, settings.ini, hdgold, color
    PixelSearch, FoundX, FoundY, 10, 35, 515, 365, %pixelColor%, 0, fast
    
    if (ErrorLevel = 0)
        MouseClick, Left, %FoundX%, %FoundY%
        Sleep 250
}

checkPrayer() {
    ImageSearch, FoundX, FoundY, 10, 35, 515, 365, *30 C:\AHK Images\soulsplit.png
    if (ErrorLevel = 0) {
        Return
    }
    Else if (ErrorLevel = 1){
        IniRead, prayerx, settings.ini, quickpray, x
        IniRead, prayery, settings.ini, quickpray, y
        MouseClick, Left, %prayerx%, %prayery%
        Return
    }
}

checkBossBar() {
    bossbarstate = 0
    IniRead, leftpixelx, settings.ini, bossbarleft, x
    IniRead, leftpixely, settings.ini, bossbarleft, y
    IniRead, rightpixelx, settings.ini, bossbarright, x
    IniRead, rightpixely, settings.ini, bossbarright, y

    PixelGetColor, leftpixel, %leftpixelx%, %leftpixely%
    PixelGetColor, rightpixel, %rghtpixelx%, %rightpixely%

    ;if the left pixel is either green or red, we're in combat
    if (leftpixel = 0x007C00 or leftpixel = 0x0024B3) {
        bossbarstate = 1
        return bossbarstate
    }
    ;if both left and right pixels are red, the boss is probably dead
    if (leftpixel = 0x0024B3 and rightpixel = 0x0024B3) {
        bossbarstate = 2
        return bossbarstate
    } else if (rightpixel = 0x007C00) {
        bossbarstate = 3
        return bossbarstate
    }
    return bossbarstate
}

checkCombat() {
    ImageSearch, FoundX, FoundY, 15, 474, 86, 486, *30 C:\AHK Images\combatwrong1.png
    if (ErrorLevel = 1) {
        Return
    }
    Else if (ErrorLevel = 0){
        IniRead, invslot2x, settings.ini, invslot2, x
        IniRead, invslot2y, settings.ini, invslot2, y
        MouseClick, Left, %invslot2x%, %invslot2y%
        Return
    }
}

checkOverload() {
    IniRead, invslot1x, settings.ini, invslot1, x
        IniRead, invslot1y, settings.ini, invslot1, y
        MouseClick, Left, %invslot1x%, %invslot1y%
        Return
}

checkCurrentStyle() {
    ;if we find mage wepaon in inventory, we're currently using range
    currentStyle = none
    ImageSearch, FoundX, FoundY, 602, 237, 650, 278, *45 C:\AHK Images\mage.png
    if (ErrorLevel = 0) {
        showText("Current Style is Range", 1)
        currentStyle = range
        return currentStyle
    } Else {
         showText("Current Style is Mage", 1)
         currentStyle = mage
        return currentStyle
    }
}

checkChatbox(){
    ;checking for wrong combat style on kiljaeden and heimdal
    try {
        ImageSearch, FoundX, FoundY, 15, 474, 86, 486, *30 C:\AHK Images\combatwrong1.png
        if (ErrorLevel = 1) {
            showText("Correct Combat Style", 1)

        } Else if (ErrorLevel = 0) {
            showText("Changing Combat Style", 1)
            IniRead, invslot2x, settings.ini, invslot2, x
            IniRead, invslot2y, settings.ini, invslot2, y
            MouseClick, Left, %invslot2x%, %invslot2y%
        }
    }
}

resetPOV() {
    IniRead, compassx, settings.ini, compass, x
    IniRead, compassy, settings.ini, compass, y
    MouseClick, Left, %compassx%, %compassy%
    Sleep 100

}

saveCoordinates() {
    MouseGetPos, xpos, ypos
    sectionName = default
    
    InputBox, sectionName, Name, Please name this set of coordinates, , 200, 100
    
    if ErrorLevel
        return
    else
        IniWrite %xpos%, settings.ini, %sectionName%, x
        IniWrite %ypos%, settings.ini, %sectionName%, y
}

savePixelColor() {
    MouseGetPos, xpos, ypos
    PixelGetColor, pixelcolor, %xpos%, %ypos%
    sectionName = default
    
    InputBox, sectionName, Name, Please name this pixel, , 200, 100
    
    if ErrorLevel
        return
    else
        IniWrite %pixelcolor%, settings.ini, %sectionName%, color
}

getMouseCoords() {
	MouseGetPos, xpos, ypos 
	MsgBox, The cursor is at X%xpos% Y%ypos%. 
}

showText(a,t:="",x:="",y:="") {
    c:=d:=e:=0, strReplace(a,"`n",,b), g:=strSplit(a,"`n","`r")[1], strReplace(g," ",,h)
    While !(f="" && a_index<>1) {
        f := subStr(g,a_index,1)
        (regExMatch(f, "[a-z]") ? c++ : f="@" ? e++ : d++)
        } SplashTextOn, % 8 + c*6.5 + d*12 + e*13 - h*8, % 23 + b*20, ::*::, % a
    If (x<>"" || y<>"")
        WinMove, ::*::,, x, y
    If (t<>"") {
        Sleep, t*1000
        WinClose, ::*::
    }
}