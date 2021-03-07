#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

!F1::
Send {$F1}
return

!F2::
Send {$F2}
return

F1::SetTimer, IdleCheck, 100
F2::SetTimer, IdleCheck, Off

IdleCheck:
If(A_TimeIdle<500)
SendMessage,0x112,0xF170,2,,Program Manager
Return

