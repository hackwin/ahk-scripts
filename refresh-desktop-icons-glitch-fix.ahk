; Jesse Campbell
; http://www.jbcse.com
; 2026-01-15

; Glitch fix for shortcut icons on Desktop changing on their own.  Tested on Windows 11.

#Persistent
#SingleInstance force

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

RefreshExplorer() { ; by teadrinker on D437 @ tiny.cc/refreshexplorer
   local Windows := ComObjCreate("Shell.Application").Windows
   Windows.Item(ComObject(0x13, 8)).Refresh()
   for Window in Windows
      if (Window.Name != "Internet Explorer")
         if (Window.Name != "File Explorer")
            Window.Refresh()
}

Loop{
   RefreshExplorer()
   Sleep, 5000
}