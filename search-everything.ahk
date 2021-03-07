; Jesse Campbell
; http://www.jbcse.com
; 2021-03-07

; Autohotkey (AHK) script to run the program "Search Everything" when Win+F is pressed.  If the Everything is running but not visible, it will show the program instead of running it again

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Persistent
#SingleInstance force

#F:: ; Windows key + F
    Run "C:\Program Files\Everything\Everything.exe"
    Return