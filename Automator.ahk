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

::dd:: Double Penetration

; -------------------------------------------------------------------------------
; YouTube copyright disclaimer
; -------------------------------------------------------------------------------
#HotIf WinActive('ahk_exe Chrome.exe') and InStr(WinGetTitle('A'), 'Video details - YouTube Studio')
#Ins:: Send("All the videos, songs, images, and graphics used in the video belong to their respective owners and I or this channel does not claim any right over them. Copyright Disclaimer under section 107 of the Copyright Act of 1976, allowance is made for �fair use� for purposes such as criticism, comment, news reporting, teaching, scholarship, education and research. Fair use is a use permitted by copyright statute that might otherwise be infringing.")
#HotIf

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
  images := [
    "d:\Pictures\Web\Islam\Palestine\001.png", ; Does Palestine meets the definition of state?
    "d:\Pictures\Web\Islam\Palestine\002.png", ; The word "Palestine" comes from Greeks
    "d:\Pictures\Web\Islam\Palestine\003.png"  ; Palestinians are not Arabs
  ]
  videos := [
    ; "Deepshit Muhammad, you, Palestinians, have kidnapped, murdered, burned, raped, beheaded, maimed, and are still holding Jews hostage. You are radical Jew-hating Islamists who must be wiped off the face of the earth. You bring blood, death and terror wherever you go.",
    ; "Deepshit Muhammad, those who call themselves Palestinians are not even Arabs. They are scattered gypsies, fugitives from other countries who have escaped the prosecution for their crimes. That's why not a single Arab country wants to take in these `"Muslim brothers`".",
    ; "Deepshit Muhammad, there is no such thing as allah, you uneducated deepshit. 21st century, space exploration, artificial intelligence, computers, robots, spacecrafts, bio-chemistry... and you, medieval savages still believe in allahs & shaitans.",
    ; "Deepshit Muhammad, do you know many Arab countries attacked Israel in the 6-day war, unprovoked? Egypt, Syria, Jordan, Iraq, Saudi Arabia, Lebanon, Algeria, Kuwait, Sudan, Libya, Morocco, Tunisia, Yemen. Israel alone wiped them all out in 6 days like shit off the floor.",
    "https://www.youtube.com/watch?v=qAm00onkJCo", ; Soviet Russia, The Creator of the PLO and the "Palestinian People"
    "https://www.youtube.com/watch?v=AkHla6NgAM4", ; Palestinian terrorists make fake videos to inove pity
    "https://www.youtube.com/watch?v=dAbEa-BehAg", ; Message to the Palestinians from Saudi writer Rawaf al-Saeen
    "https://www.youtube.com/watch?v=NPRIhiFo1Ho", ; Genocide of Who?
    "https://x.com/dpenetration24/status/1792983679775523314", ; October 7th Footage (Part 1)
    "https://x.com/dpenetration24/status/1792983830179074408", ; October 7th Footage (Part 2)
    "https://x.com/dpenetration24/status/1792984254617378968", ; The representatives of True Islam
    "https://x.com/dpenetration24/status/1792984019455414498", ; I hate you and I will kill you for the sake of Allah
    "https://x.com/dpenetration24/status/1792993354998788596", ; Palestinians teach children to hate and kill Jews
    "https://x.com/dpenetration24/status/1792993670817325253", ; Mr. Pallywood (Saleh Aljafarawi)
  ]
  ShowMessageBox("Found " images.Length " images and " videos.Length " videos")
  loop images.Length { ; Loop through all images in the array
    ShowMessageBox("Posting image " A_Index " of " images.Length)
    wc := WinClip()
    wc.Clear()
    wc.SetBitmap(images[A_Index])
    wc.Paste()
    Sleep(1000)
    Send("^{Enter}")
    Sleep(2000)
  }
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