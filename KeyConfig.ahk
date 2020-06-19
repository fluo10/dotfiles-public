#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#IfWinActive
Space:: Send {Space}
Space & RShift:: Send {vk1C} ;変換
Space & LShift:: Send {vk1D} ;無変換
Space & h:: Send {Left}
Space & j:: Send {Up}
Space & k:: Send {Down}
Space & l:: Send {Right}
Space & vkBA:: Send {Baskspace}
Space & ':: Send {Delete}
Space & y:: Send {Home}
Space & o:: Send {End}
Space & u:: Send {PgUp}
Space & i:: Send {PgDn}
 