#Persistent
#SingleInstance force

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


Loop{
	WinWait Pixel 6a
	{
		WinActivate Pixel 6a
		WinClose, Pixel 6a
	}
	Sleep,50
}