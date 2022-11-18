#Persistent
#SingleInstance force

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetBatchLines, -1

; Jesse Campbell
; http://www.jbcse.com
; 2022-11-18

; Autohotkey (AHK) script to open Extract Files folder from 7zip 
; Bringing the same functionality of "Show extracted files when complete" that Windows has built-in

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
		WinGet, exe, ProcessName, Ahk_id %ID%
		if (exe == "7zG.exe"){
			output := RunCmd("wmic path win32_process where name=""7zG.exe"" get commandline")
			start := InStr(output, "-o")+3
			end := InStr(SubStr(output, start),chr(34))
			zipFolderPath := SubStr(output, start, end-1)
			WinWaitClose, ahk_exe 7zG.exe
			MsgBox, 4, 7zip GUI Interceptor, Show extracted files?
			{
			IfMsgBox, Yes
			Run, %zipFolderPath%
			}
		}
		
	}		
}

RunCMD(CmdLine, WorkingDir:="", Codepage:="CP0", Fn:="RunCMD_Output") {  ;         RunCMD v0.94        
Local         ; RunCMD v0.94 by SKAN on D34E/D37C @ autohotkey.com/boards/viewtopic.php?t=74647                                                             
Global A_Args ; Based on StdOutToVar.ahk by Sean @ autohotkey.com/board/topic/15455-stdouttovar

  Fn := IsFunc(Fn) ? Func(Fn) : 0
, DllCall("CreatePipe", "PtrP",hPipeR:=0, "PtrP",hPipeW:=0, "Ptr",0, "Int",0)
, DllCall("SetHandleInformation", "Ptr",hPipeW, "Int",1, "Int",1)
, DllCall("SetNamedPipeHandleState","Ptr",hPipeR, "UIntP",PIPE_NOWAIT:=1, "Ptr",0, "Ptr",0)

, P8 := (A_PtrSize=8)
, VarSetCapacity(SI, P8 ? 104 : 68, 0)                          ; STARTUPINFO structure      
, NumPut(P8 ? 104 : 68, SI)                                     ; size of STARTUPINFO
, NumPut(STARTF_USESTDHANDLES:=0x100, SI, P8 ? 60 : 44,"UInt")  ; dwFlags
, NumPut(hPipeW, SI, P8 ? 88 : 60)                              ; hStdOutput
, NumPut(hPipeW, SI, P8 ? 96 : 64)                              ; hStdError
, VarSetCapacity(PI, P8 ? 24 : 16)                              ; PROCESS_INFORMATION structure

  If not DllCall("CreateProcess", "Ptr",0, "Str",CmdLine, "Ptr",0, "Int",0, "Int",True
                ,"Int",0x08000000 | DllCall("GetPriorityClass", "Ptr",-1, "UInt"), "Int",0
                ,"Ptr",WorkingDir ? &WorkingDir : 0, "Ptr",&SI, "Ptr",&PI)  
     Return Format("{1:}", "", ErrorLevel := -1
                   ,DllCall("CloseHandle", "Ptr",hPipeW), DllCall("CloseHandle", "Ptr",hPipeR))

  DllCall("CloseHandle", "Ptr",hPipeW)
, A_Args.RunCMD := { "PID": NumGet(PI, P8? 16 : 8, "UInt") }      
, File := FileOpen(hPipeR, "h", Codepage)

, LineNum := 1,  sOutput := ""
  While (A_Args.RunCMD.PID + DllCall("Sleep", "Int",0))
    and DllCall("PeekNamedPipe", "Ptr",hPipeR, "Ptr",0, "Int",0, "Ptr",0, "Ptr",0, "Ptr",0)
        While A_Args.RunCMD.PID and (Line := File.ReadLine())
          sOutput .= Fn ? Fn.Call(Line, LineNum++) : Line

  A_Args.RunCMD.PID := 0
, hProcess := NumGet(PI, 0)
, hThread  := NumGet(PI, A_PtrSize)

, DllCall("GetExitCodeProcess", "Ptr",hProcess, "PtrP",ExitCode:=0)
, DllCall("CloseHandle", "Ptr",hProcess)
, DllCall("CloseHandle", "Ptr",hThread)
, DllCall("CloseHandle", "Ptr",hPipeR)

, ErrorLevel := ExitCode

Return sOutput  
}