#Persistent
#SingleInstance force

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Jesse Campbell
; http://www.jbcse.com
; 2021-03-07

; Autohotkey (AHK) script to close a pop-up by clicking a button
; UltraVNC viewer has a pop-up with a button that must be clicked whenever the connection is temporarily lost.  It reconnects automatically.

Loop{
	if WinActive("ahk_class SunAwtDialog")
	{
		Send, {Enter}
	}
	Sleep,50
}