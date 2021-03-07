; Jesse Campbell
; http://www.jbcse.com
; 2021-03-07

; Autohotkey (AHK) script to put have all displays go into sleep mode, by pressing F1 for off and F2 for on

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

F1::SetTimer, IdleCheck, 100 ; Check to turn turn off the display
F2::SetTimer, IdleCheck, Off ; Turn on the display

IdleCheck:
If(A_TimeIdle<500)
SendMessage,0x112,0xF170,2,,Program Manager
Return

!F1:: ; Simulate F1 key by pressing Alt+F1
Send {$F1}
Return

!F2::
Send {$F2} ; Simulate F2 key by pressing Alt+F2
Return