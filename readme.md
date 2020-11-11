This script is a simple way of making hotkeys for chat commands.  

Hotkeys are defined in `keys.conf` using the [syntax of AHK](https://www.autohotkey.com/docs/Hotkeys.htm#Symbols), with a tab separating the hotkey and the message/command to send to chat.

`F1` is hardcoded to make the AC Client borderless and full-screen.

Hotkeys only trigger when the AC Client is active.



The example hotkeys in `keys.conf` are:

* F1 - Remove taskbar/borders
* Escape - Log out (requires Mag-Tools for /mt logout)
* F2 - Requests remote buffs from Robotic Tinker (bot on LostWoods AC)
* Forward mouse button - Tries to fellow with IBControl on fellowship channel
*  Back mouse button - Requests fellow to follow with IBControl on fellowship channel
*  s - IBControl stop all
*  Ctrl+s - IB control start all





*The executable is the compiled Autohotkey script for those who don't want to have Autohotkey installed.*  

*If you're unused to Autohotkey, a taskbar icon with a blue A will be added when the script is running which can be used to pause or exit the script.*