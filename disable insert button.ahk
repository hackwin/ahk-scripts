; Jesse Campbell
; http://www.jbcse.com
; 2021-03-07

; Autohotkey (AHK) script to disable the insert key

#Persistent
#SingleInstance force

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

$Insert::return

!Insert::Send, {Insert} ; Use Alt+Insert to toggle the 'Insert mode'