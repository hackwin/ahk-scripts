; Jesse Campbell
; http://www.jbcse.com
; 2026-09-19

; Autohotkey (AHK) script to keep numlock on unless alt+numlock is pressed

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

NumLock::SetNumLockState, AlwaysOn

!NumLock::SetNumLockState, Off ; Use Alt+NumLock to toggle 'NumLock mode'