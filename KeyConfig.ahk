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
Space & j:: Send {Blind}{Up}
Space & k:: Send {Blind}{Down}
Space & l:: Send {Blind}{Right}
Space & vkBA:: Send {Blind}{Backspace}
Space & ':: Send {Blind}{Delete}
Space & y:: Send {Blind}{Home}
Space & o:: Send {Blind}{End}
Space & u:: Send {Blind}{PgUp}
Space & i:: Send {Blind}{PgDn}


<<<<<<< HEAD
*~LShift::Return
LShift up::
    if ( A_PriorKey == "LShift" && A_TimeSincePriorHotkey<200 )
=======
~LShift::Return
~LShift up::
    if (A_PriorKey == "LShift" && A_TimeSincePriorHotkey < 500 )
>>>>>>> b730f04ab7340de0ddcac1c23ee9114f163e3423
    {
        Send {vk1D} ;無変換
    }
Return

<<<<<<< HEAD
*~RShift::Return
RShift up::
    if ( A_PriorKey == "RShift" && A_TimeSincePriorHotkey<200 )
=======
~RShift::Return
~RShift up::
    if (A_PriorKey == "RShift" and A_TimeSincePriorHotkey < 500)
>>>>>>> b730f04ab7340de0ddcac1c23ee9114f163e3423
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

