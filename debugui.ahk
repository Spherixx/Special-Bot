#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

tempvar1 = something
tempvar2 = 342

Gui, Margin, 12, 4
Gui, Font, s10

Gui, Add, Text, Section, Current Boss: kil'jaeden
Gui, Add, Text, ys, Boss Status: Immune

Gui, Add, Text, xs Section, Prayer Status: Active
Gui, Add, Text, ys, Overload Status: Active

Gui, Add, Edit, r14 w407 xs, Log Start

Gui, Show, w430 h286 center
;Gui, Show, w800 h600 center
