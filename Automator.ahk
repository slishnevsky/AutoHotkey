#Requires AutoHotkey v2
#SingleInstance
#Include WinClipAPI.ahk
#Include WinClip.ahk

; -------------------------------------------------------------------------------
; Kills AutoHotkey process
; -------------------------------------------------------------------------------
#HotIf ProcessExist("AutoHotkey64.exe")
Pause:: Reload()
#HotIf

::dd::Double Penetration
::ddd::dpenetration24@gmail.com
::ss::Slava Lishnevsky
::sss::slishnevsky@gmail.com
::ppp::gorLubUlKir1440

; -------------------------------------------------------------------------------
; ShowMessageBox
; -------------------------------------------------------------------------------
ShowMessageBox(message, completed := false) {
  MyGui := Gui("-Caption")
  MyGui.BackColor := completed ? "C80000" : "0000C8"
  MyGui.SetFont("s20 cWhite", "Bahnschrift")
  MyGui.AddText("Center", message)
  MyGui.Show()
  Sleep(completed ? 2000 : 1000)
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
#^Ins:: PostTwitterVideos()
#HotIf

PostTwitterImages() {
  MyGui.Show() ; Folder selection
  while (!MyGui.Value)
    Sleep(100)
  folderName := MyListBox.Text
  folderPath := "d:\Pictures\Web\" folderName
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
  ShowMessageBox("Task completed", true)
  Reload()
}

PostTwitterVideos() {
  videos := [
    "Soviet Russia, The Creator of the PLO and the `"Palestinian people`" https://rumble.com/v4xy8rz-soviet-russia-the-creator-of-the-plo-and-the-palestinian-people.html",
    "How `"innocent`" Palestinians brutally raped, burned, beheaded, mutilated Jews https://rumble.com/v4xxph5-innocent-palestinians-brutally-raped-burned-beheaded-mutilated-jews-they-ev.html",
    "Message from a Saudi writer Rawaf al-Saeen to the `"Palestinians`" https://rumble.com/v4xy7ke-message-from-a-saudi-writer-rawaf-al-saeen-to-the-palestinians.html",
    "The representatives of True Islam https://rumble.com/v4xxaie-representatives-of-true-islam.html",
    "I hate you and I will kill you for the sake of Allah https://rumble.com/v4xxx8q-i-hate-you-and-i-will-kill-you-for-the-sake-of-allah.html",
    "Palestinians preparing `"victims`" for Western media https://rumble.com/v4xxfzx-palestinians-preparing-victims-for-western-media.html",
    "Palestinians begging Muslim brothers for help https://rumble.com/v4xy1ae-palestinians-begging-muslim-brothers-for-help.html",
    "Palestine History Museum opens in Israel https://rumble.com/v4xy9sn-palestine-history-museum-opens-in-israel.html",
    "Genocide of Who? https://rumble.com/v4xy4l3-genocide-of-who.html",
    "The Brutal Reality of the Middle East https://www.youtube.com/watch?v=I5VPFw0vI6U"
  ]
  loop videos.Length { ; Loop through all videos in the array
    ShowMessageBox("Posting video " A_Index " of " videos.Length)
    A_Clipboard := videos[A_Index]
    Send("^{v}")
    Sleep(1000)
    Send("^{Enter}")
    Sleep(2000)
  }
  ShowMessageBox("Task completed", true)
  Reload()
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
  ; A_Clipboard := "ENTER YOUR TEXT HERE"
  ; Send("^{v}")
  ; Sleep(100)
  ; Send("{Tab}")
  ; Send("{Enter}")
  ; Send("g") ; Repeat adding 10px black border
  ; Send("{Enter}")
  ShowMessageBox("Task completed", true)
}

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

; -------------------------------------------------------------------------------
; UploadRumbleVideos
; -------------------------------------------------------------------------------
#HotIf WinActive('ahk_exe Chrome.exe') and InStr(WinGetTitle('A'), 'Rumble')
#Ins:: UploadRumbleVideos()
#HotIf
UploadRumbleVideos() {
  folderPath := "d:\Videos\Web" ; Upload videos from this folder
  A_Clipboard := folderPath
  totalVideos := 0 ; Count number of files in that folder
  loop files folderPath "\*.mp4" ; Count total number of videos
    totalVideos += 1
  ShowMessageBox("Found " totalVideos " videos")
  loop files folderPath "\*.mp4" { ; Loop through all videos in the folder
    if (A_Index < 5)
      continue
    ShowMessageBox("Uploading `"" A_LoopFileName "`"")
    ; Select Upload
    Click(1757, 154)
    Sleep(100)
    Click(1757, 223)
    Sleep(1000)
    ; Upload video file
    Click(517, 540)
    Sleep(1000)
    Send(A_LoopFileFullPath)
    Sleep(100)
    Send("{Enter}")
    Sleep(1000)
    ; Enter Video info
    Send("{Tab}")
    Sleep(100)
    Send(StrReplace(A_LoopFileName, ".mp4", ""))
    Sleep(100)
    ; Select Category
    Send("{Tab 2}")
    Sleep(100)
    Send("Vlogs")
    Sleep(100)
    ; Select channel
    Send("{Tab 8}")
    Sleep(100)
    Send("{Down}")
    Sleep(100)
    ; Upload thumbnail file
    Click(1455, 685)
    Sleep(1000)
    Send(StrReplace(A_LoopFileFullPath, ".mp4", ".png"))
    Sleep(100)
    Send("{Enter}")
    Sleep(1000)
    ; Scroll to the bottom
    Send("{Tab 3}")
    Sleep(100)
    ; Click Upload button
    Click(1480, 1015) 
    Sleep(1000)
    ; Click to check Agreement 1, Agreement 2 and Submit button
    Click(1730, 985) 
    Sleep(100)
    Click(1730, 1055)
    Sleep(100)
    Click(1730, 1135)
    Sleep(100)
    ; Wait for View "File name" button to appear
    while (PixelGetColor(285, 340) != 0x618035) {
      ShowMessageBox("Uploading `"" A_LoopFileName "`"")
      Sleep(1000)
    }
  }
  ShowMessageBox("Task completed", true)
  Run("https://rumble.com/user/krovinushka1")
}

; -------------------------------------------------------------------------------
; DeleteRumbleVideos
; -------------------------------------------------------------------------------
#HotIf WinActive('ahk_exe Chrome.exe') and InStr(WinGetTitle('A'), 'All videos')
#Del:: DeleteRumbleVideos()
#HotIf
DeleteRumbleVideos() {
  ShowMessageBox("Deleting next video...")
  Click(1865, 505) 
  Sleep(1000)
  Click(1865, 711)
  Sleep(1000)
  Click(1210, 700)
  Sleep(1000)
  ; Wait for "Deleting..." message to disappear
  while (PixelGetColor(1040, 710) == 0xFFFFFF) {
    ShowMessageBox("Deleting video...")
    Sleep(1000)
  }
  DeleteRumbleVideos()
}