#Persistent
#SingleInstance force

playback := "Headset"
recording := "Headset Microphone"

F1::
	toggle := !toggle
	If toggle {
		run, DisplaySwitch.exe /external
	}
	Else {
		run, DisplaySwitch.exe /internal
	}
Return

F2::
	If (playback = "Headset") {
		playback := "TV"
		recording := "Webcam Microphone"
	}
	Else If (playback = "TV") {
		playback := "Speakers"
		recording := "Webcam Microphone"
	}
	Else If (playback = "Speakers") {
		playback := "Headset"
		recording := "Headset Microphone"
	}
	run, nircmd.exe setdefaultsounddevice "%playback%"
	run, nircmd.exe setdefaultsounddevice "%recording%"
	soundToggleBox(playback, recording)
Return

PAUSE::
    run, nircmd.exe standby
Return

; Display sound toggle GUI
soundToggleBox(playback, recording)
{
	IfWinExist, soundToggleWin 
	{
		Gui, Destroy
	}
	
	Gui, +ToolWindow -Caption +AlwaysOnTop
	Gui, Color, 00FF00 ;Lime
	Gui, Font, s16, Arial
	Gui, Add, Text, , %playback% (%recording%)
	Gui, Show, NoActivate, soundToggleWin
	
	SetTimer,soundToggleClose, 3000
}
soundToggleClose:
    SetTimer,soundToggleClose, Off
    Gui, Destroy
Return
