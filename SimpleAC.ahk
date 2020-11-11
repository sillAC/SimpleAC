;Only one copy allowed
#SingleInstance, force
#InstallKeybdHook
;Set icon
Menu, Tray, Icon , icon.ico,, 1

;Associative array to store hotkeys and their associated text to send to chat 
global commands := Object()

;Hotkeys only active in Asheron's Call
Hotkey, IfWinActive, ahk_exe acclient.exe
Loop, Read, keys.conf 
{
    ;Skip lines starting with semicolons or missing a tab
    if(SubStr(A_LoopReadLine, 1, 1) == ";") 
        Continue
    if(!InStr(A_LoopReadLine, A_Tab))
        Continue

    ;Hotkeys tab separated
    hotkey := StrSplit(A_LoopReadLine, [A_Tab])

    ;Assign hotkey
    hk := hotkey[1]
    Hotkey, %hk%, SendCommandToChat
    ;Store command associated with hotkey
    commands[hotkey[1]] := hotkey[2]
}
;Test commands are getting read
; for key, value in commands
; MsgBox dict.%key% = %value%
Return

SendCommandToChat:
text := commands[A_ThisHotkey]
;MsgBox % "Pressed " . A_ThisHotkey . " with text: " . text
;KeyWait, A_ThisHotkey  ;Unsure of a good way to implement this offhand
SendCommand(text)
Return

;Still hardcoding F1 to fullscreen or parse that differently/remove it?
F1::
ForceFakeFullscreen()
Return

;Send command (assumes window is active/chat box isn't currently used)
SendCommand(command = "") {
    MsgBox % command
    to := 100
    oldClip := Clipboard
    Clipboard := command
    Sleep %to%
    Send {enter}
    Sleep %to%
    Send {ctrl down}v{ctrl up}
    Sleep %to%
    Send {enter}
    Clipboard := oldClip
}
ForceFakeFullscreen()
{
    CoordMode Screen, Window
    static WINDOW_STYLE_UNDECORATED := -0xC40000
    static savedInfo := Object() ;; Associative array!
    WinGet, id, ID, A
    savedInfo[id] := inf := Object()
    WinGet, ltmp, Style, A
    inf["style"] := ltmp
    WinGetPos, ltmpX, ltmpY, ltmpWidth, ltmpHeight, ahk_id %id%
    inf["x"] := ltmpX
    inf["y"] := ltmpY
    inf["width"] := ltmpWidth
    inf["height"] := ltmpHeight
    WinSet, Style, %WINDOW_STYLE_UNDECORATED%, ahk_id %id%
    mon := GetMonitorActiveWindow()
    SysGet, mon, Monitor, %mon%
    WinMove, A,, %monLeft%, %monTop%, % monRight-monLeft, % monBottom-monTop
}
GetMonitorActiveWindow(){
    ;; Get Monitor number at the center position of the Active window.
    WinGetPos x,y,width,height, A
    return GetMonitorAtPos(x+width/2, y+height/2)
}
GetMonitorAtPos(x,y)
{
    ;; Monitor number at position x,y or -1 if x,y outside monitors.
    SysGet monitorCount, MonitorCount
    i := 0
    while(i < monitorCount)
    {
        SysGet area, Monitor, %i%
        if ( areaLeft <= x && x <= areaRight && areaTop <= y && y <= areaBottom )
        {
            return i
        }
        i := i+1
    }
    return -1
}