#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

CapsLock:: Send {vkF0} ;英数（CapsLock
CapsLock & Space:: Send {vkF2} ;ひらがな/カタカナキー
CapsLock & h:: Send {Left}
CapsLock & j:: Send {Up}
CapsLock & k:: Send {Down}
CapsLock & l:: Send {Right}
CapsLock & [:: Send {Baskspace}
CapsLock & ]:: Send {Delete}
CapsLock & vk40:: Send {Home}
CapsLock & vk41:: Send {End}
CapsLock & vk53:: Send {PgUp}
CapsLock & vk54:: Send {PgDn}
 