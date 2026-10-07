; Jesse Campbell
; https://www.jbcse.com
; 2026-10-06

; Autohotkey (AHK) script to run after a reboot has occurred

#Persistent
#SingleInstance force

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

FormatTime, CurrentTime,, M/d/yyyy h:mm tt
Message = System has rebooted at %CurrentTime%
FileAppend, %Message%`n, C:\Users\%A_UserName%\Desktop\reboot.log
MsgBox %Message%