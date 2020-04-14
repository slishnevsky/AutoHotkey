#Persistent
#SingleInstance, force

toggle := False
playback := "Headset"
recording := "Headset Microphone"

F1:: ; Switch between PC and TV
	toggle := !toggle
	If (toggle)
		run, Tools\DisplaySwitch.exe /external
	Else
		run, Tools\DisplaySwitch.exe /internal
Return

F2:: ; Switch between audio devices
	If (playback = "Headset") {
		playback := "TV"
		; recording := "Microphone"
	}
	Else If (playback = "TV") {
		playback := "Speakers"
		recording := "Microphone"
	}
	Else If (playback = "Speakers") {
		playback := "Headset"
		recording := "Headset Microphone"
	}
	run, Tools\nircmd.exe setdefaultsounddevice "%playback%"
	run, Tools\nircmd.exe setdefaultsounddevice "%recording%"
	soundToggleBox(playback, recording)
Return

PAUSE::
    run, Tools\nircmd.exe standby
Return

; Display sound toggle GUI
soundToggleBox(playback, recording)
{
	IfWinExist, soundToogleWin
		Gui, Destroy

	Gui, +ToolWindow -Caption +AlwaysOnTop
	Gui, Color, 0072C6 ;Blue / 0FF00;Limes
	Gui, Font, cWhite s18, Arial
	Gui, Add, Text, , %playback% Active
	Gui, Show, NoActivate, soundToogleWin

	SetTimer,soundToggleClose, 3000
}
soundToggleClose:
    SetTimer,soundToggleClose, Off
    Gui, Destroy
Return

$ESCAPE:: ; Close active program by pressing Esc 0.5 sec delay
	KeyWait, Escape, T0.5
	If (ErrorLevel)
		PostMessage, 0x112, 0xF060, , , A
	Else
		Send {Esc}
Return
