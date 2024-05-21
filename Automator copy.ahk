#Requires AutoHotkey v2
#SingleInstance
#Include WinClipAPI.ahk
#Include WinClip.ahk

; -------------------------------------------------------------------------------
; Kills AutoHotkey process
; -------------------------------------------------------------------------------
#HotIf ProcessExist("AutoHotkey64.exe")
#Esc:: Reload()
#HotIf

::ahk:: AutoHotkey v2 ; Shortcut to this text
::sli:: slishnevsky@gmail.com ; Shortcut to this text
::dp:: dpenetration23@gmail.com ; Shortcut to this text

; -------------------------------------------------------------------------------
; ShowMessageBox
; -------------------------------------------------------------------------------
ShowMessageBox(message, completed := false) {
  MyGui := Gui("-Caption")
  MyGui.BackColor := completed ? "C80000" : "0000C8"
  MyGui.SetFont("s20 cWhite", "Bahnschrift")
  MyGui.AddText("Center", message)
  MyGui.Show()
  Sleep(completed ? 3000 : 1000)
  MyGui.Hide()
}

; -------------------------------------------------------------------------------
; Folder selection window
; -------------------------------------------------------------------------------
#HotIf WinActive("ahk_id" MyGui.Hwnd)
Enter::
NumpadEnter:: MyGui.Value := MyGui.Submit()
#HotIf

MyGui := Gui("AlwaysOnTop", "Folder")
MyGui.SetFont("s10", "Bahnschrift")
MyGui.AddText(, "Select your folder")
MyListBox := MyGui.AddListBox("r7 Choose1 w200", ["America", "Canada", "Faggots", "Globalists", "Islam", "Niggers", "Religion"])
MyGui.Value := 0

; -------------------------------------------------------------------------------
; PostTwitterImages & PostTwitterVideos
; -------------------------------------------------------------------------------
#HotIf WinActive('ahk_exe Chrome.exe') and InStr(WinGetTitle('A'), 'on X')
#Ins:: PostTwitterImages()
#HotIf

PostTwitterImages() {
  MyGui.Show() ; Folder selection
  while (!MyGui.Value)
    Sleep(100)
  folderName := MyListBox.Text
  folderPath := "d:\Pictures\Web\" folderName

  if (folderName = "Islam")
    PostTwitterVideos()

  totalImages := 0
  loop files folderPath "\*.png" ; Count total number of images
    totalImages += 1
  ShowMessageBox("Found " totalImages " images")
  loop files folderPath "\*.png" { ; Loop through all images in the folder
    ShowMessageBox("Posting image " A_Index " of " totalImages)
    wc := WinClip()
    wc.Clear()
    wc.SetBitmap(A_LoopFilePath)
    wc.Paste()
    Sleep(1000)
    Send("^{Enter}")
    Sleep(2000)
  }
  ShowMessageBox("Task completed. Posted " totalImages " images.", true)
  Reload()
}

PostTwitterVideos() {
  videos := [
    "https://www.youtube.com/watch?v=qAm00onkJCo", ; Soviet Russia, The Creator of the PLO and the "Palestinian People"
    "https://www.youtube.com/watch?v=KubPCfmEXyw", ; Message to the Palestinians from Saudi Writer
    "https://x.com/dpenetration24/status/1792984254617378968", ; The representatives of True Islam
    "https://x.com/dpenetration24/status/1792984019455414498", ; I hate you and I will kill you for the sake of Allah
    "https://x.com/dpenetration24/status/1792983679775523314", ; October 7th Footage (Part 1)
    "https://x.com/dpenetration24/status/1792983830179074408", ; October 7th Footage (Part 2)
  ]
  ShowMessageBox("Found " videos.Length " messages")
  loop videos.Length { ; Loop through all messages in the array
    ShowMessageBox("Posting message " A_Index " of " videos.Length)
    A_Clipboard := videos[A_Index]
    Send("^{v}")
    Sleep(1000)
    Send("^{Enter}")
    Sleep(2000)
  }
  ShowMessageBox("Task completed. Posted " videos.Length " videos.", true)
}

; -------------------------------------------------------------------------------
; CreateDemotivator
; -------------------------------------------------------------------------------
#HotIf WinActive('ahk_exe FSCapture.exe')
#Ins:: CreateDemotivator()
#HotIf

CreateDemotivator() {
  Send("g") ; White 1px border
  Sleep(1000)
  Send("{Tab 4}")
  Send("1")
  Click(420, 60)
  Sleep(100)
  Click(200, 140)
  Click(40, 280)
  Sleep(100)
  Send("{Enter}")
  Send("g") ; Back 10px border
  Sleep(1000)
  Send("{Tab 4}")
  Send("10")
  Click(420, 60)
  Sleep(100)
  Click(20, 140)
  Click(40, 280)
  Sleep(100)
  Send("{Enter}")
  Send("t") ; Enter text
  Sleep(1000)
  Send("^a")
  Sleep(100)
  A_Clipboard := "ENTER YOUR TEXT HERE"
  Send("^{v}")
  Sleep(100)
  Send("{Tab}")
  Send("{Enter}")
  Send("g") ; Repeat adding 10px black border
  Send("{Enter}")
  ShowMessageBox("Task completed", true)
}

; -------------------------------------------------------------------------------
; DeleteRumbleVideos
; -------------------------------------------------------------------------------
; #HotIf WinActive('ahk_exe Chrome.exe')
; #Del:: DeleteRumbleVideos()
; #HotIf

; DeleteRumbleVideos() {
;   color := PixelGetColor(1467, 438) ; Monitor if no records left
;   if (color = 0xF3F5F8) {
;     Run("https://rumble.com/c/c-6030257") ; Navigate back to the channel
;     Sleep(1000)
;     ShowMessageBox("Task completed", true)
;     Reload()
;   }
;   ShowMessageBox("Deleting next video...")
;   Click(1866, 504) ; Click Three dots menu
;   Sleep(1000)
;   Click(1815, 711) ; Click Delete option (711 coordinate is important, borderline between 5 and 6 menu items)
;   Sleep(1000)
;   Click(1210, 685) ; Click Confirm button
;   Sleep(13000)
;   DeleteRumbleVideos()
; }

; -------------------------------------------------------------------------------
; DeleteAuthorizedApps
; -------------------------------------------------------------------------------
#HotIf WinActive('ahk_exe Chrome.exe') and InStr(WinGetTitle('A'), 'Third-party apps & services')
#Del:: DeleteAuthorizedApps()
#HotIf
DeleteAuthorizedApps() {
  Click(780, 610)
  Sleep(1000)
  Click(1150, 820)
  Sleep(1000)
  Click(1150, 800)
  Click(1150, 840)
  Sleep(8000)
  DeleteAuthorizedApps()
}