#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
#InstallKeybdHook


SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#IfWinActive
*Space:: Send {Blind}{Space}
;Space & RShift:: Send {Blind}{vk1C} ;変換
;Space & LShift:: Send {Blind}{vk1D} ;無変換
Space & h:: Send {Blind}{Left}
Space & j:: Send {Blind}{Down}
Space & k:: Send {Blind}{Up}
Space & l:: Send {Blind}{Right}
Space & vkBA:: Send {Blind}{Backspace}
Space & ':: Send {Blind}{Delete}
Space & y:: Send {Blind}{Home}
Space & o:: Send {Blind}{End}
Space & u:: Send {Blind}{PgDn}
Space & i:: Send {Blind}{PgUp}
Space & 1:: Send {Blind}{F1}
Space & 2:: Send {Blind}{F2}
Space & 3:: Send {Blind}{F3}
Space & 4:: Send {Blind}{F4}
Space & 5:: Send {Blind}{F5}
Space & 6:: Send {Blind}{F6}
Space & 7:: Send {Blind}{F7}
Space & 8:: Send {Blind}{F8}
Space & 9:: Send {Blind}{F9}
Space & 0:: Send {Blind}{F10}
Space & -:: Send {Blind}{F11}
Space & =:: Send {Blind}{F12}
Space & Tab:: Send {Blind}{Esc}




*~LShift::Return
LShift up::
    if ( A_PriorKey == "LShift" && A_TimeSincePriorHotkey<200 )
    {
        Send {vk1D} ;無変換
    }
Return

*~RShift::Return
RShift up::
    if ( A_PriorKey == "RShift" && A_TimeSincePriorHotkey<200 )
    {
       Send {vk1C} ;変換
    }
Return

VK07::
    global GameWin
    WinGetActiveTitle,  GameWin
Return

Joy1::
Joy2::
Joy3::
Joy4::
Joy5::
Joy6::
Joy7::
Joy8::
    global GameWin
    IF (!WinActive( GameWin)) && (WinExist(GameWin))
    {
        WinActivate, GameWin
    } 
Return

