#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

$CapsLock::
  KeyWait, CapsLock, T0.1

  if (ErrorLevel) {					;received a long press - go to thesaurus
    Send, {LControl down}
  }
  else{
    Send, {Esc}
  }
Return

$CapsLock up::
  Send, {LControl up}

Return

Escape::Capslock
