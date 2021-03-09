#Persistent
#SingleInstance force

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetBatchLines, -1

; Jesse Campbell
; http://www.jbcse.com
; 2021-03-08

; Autohotkey (AHK) script to close a pop-up by clicking a button
; UltraVNC viewer has a pop-up with a button that must be clicked whenever the connection is temporarily lost.  It reconnects automatically.
; This version does not poll every so often, it registers a shell hook which is triggered whenever a window is created.  Thanks tidbit from #ahk on freenode.net IRC.

; ----------------------------------------------
; ------------- SHELL HOOK EXAMPLE -------------
; ----------------------------------------------
; 1   HSHELL_WINDOWCREATED 
; 2   HSHELL_WINDOWDESTROYED 
; 3   HSHELL_ACTIVATESHELLWINDOW 
; 4   HSHELL_WINDOWACTIVATED 
; 5   HSHELL_GETMINRECT 
; 6   HSHELL_REDRAW 
; 7   HSHELL_TASKMAN 
; 8   HSHELL_LANGUAGE 
; 9   HSHELL_SYSMENU 
; 10  HSHELL_ENDTASK 
; 11  HSHELL_ACCESSIBILITYSTATE 
; 12  HSHELL_APPCOMMAND 
; 13  HSHELL_WINDOWREPLACED 
; 14  HSHELL_WINDOWREPLACING 
; 15  HSHELL_HIGHBIT 
; 16  HSHELL_FLASH 
; 17  HSHELL_RUDEAPPACTIVATED

DllCall("RegisterShellHookWindow", "ptr", A_ScriptHwnd)
MsgNum := DllCall("RegisterWindowMessage", "Str", "SHELLHOOK")
OnMessage(MsgNum, "ShellMessage")
Return

ShellMessage(wParam, lParam)
{
	If (wParam=1) ;  HSHELL_WINDOWCREATED := 1
	{
		ID:=lParam
		WinGetTitle, title, Ahk_id %ID%
		if (title == "VncViewer Message Box"){
			WinActivate VncViewer Message Box
			ControlClick, Button1, VncViewer Message Box
		}		
	}
}