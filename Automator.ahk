#Requires AutoHotkey v2
#Warn ; Recommended for catching common errors
#SingleInstance force ; Ensures only one instance of the script is running
#Include WinClipAPI.ahk ; WinClip external library
#Include WinClip.ahk ; WinClip external library

; -------------------------------------------------------------------------------
; General hotstrings
; -------------------------------------------------------------------------------
{
  ::ss::Slava Lishnevsky
  ::sss::slishnevsky@gmail.com
  ::kk::Кровинушка
  ::kkk::krovinushka1@gmail.com
  ::ppp::gorLubUlKir1440
}

; -------------------------------------------------------------------------------
; General actions
; -------------------------------------------------------------------------------
#HotIf ProcessExist("AutoHotkey64.exe")
Escape:: Reload() ; Reloads AutoHotkey process
#HotIf
Pause:: DllCall("PowrProf\SetSuspendState", "Int", 0, "Int", 0, "Int", 0) ; Puts a PC into sleep mode
ScrollLock:: { ; Switchess between displays
  static state := false
  Run(state ? "DisplaySwitch.exe /internal" : "DisplaySwitch.exe /external")
  state := !state
}

; -------------------------------------------------------------------------------
; ShowMessageBox
; -------------------------------------------------------------------------------
ShowMessageBox(message, completed := false) {
  messageBox := Gui("-Caption")
  messageBox.BackColor := completed ? "C80000" : "0000C8"
  messageBox.SetFont("s20 cWhite", "Bahnschrift")
  messageBox.AddText("Center", message)
  messageBox.Show()
  Sleep(completed ? 2000 : 1000)
  messageBox.Hide()
}

; -------------------------------------------------------------------------------
; Folder selection window
; -------------------------------------------------------------------------------
#HotIf WinActive("ahk_id" folderWindow.Hwnd) ; Submit selection by pressing Enter
Enter::
NumpadEnter:: folderWindow.Value := folderWindow.Submit()
#HotIf

folderWindow := Gui("AlwaysOnTop")
folderWindow.SetFont("s10", "Bahnschrift")
folderWindow.AddText(, "Select your folder")
folderArray := []  ; Initialize an empty array to store folder names
; Loop through items in the directory
rootFolderPath := "d:\Pictures\Web"
Loop Files rootFolderPath "\*", "D"
{
  currentItem := A_LoopFileFullPath
  ; Get the folder name and add it to the array
  folderName := SubStr(currentItem, InStr(currentItem, "\", , -1) + 1)  ; Extract folder name from full path
  folderArray.push(folderName)  ; Add folder name to the array
}
MyListBox := folderWindow.AddListBox("r" folderArray.Length " Choose1 w200", folderArray)
folderWindow.Value := 0

; -------------------------------------------------------------------------------
; PostTwitterImages & PostTwitterVideos
; -------------------------------------------------------------------------------
#HotIf WinActive("ahk_exe Chrome.exe") and InStr(WinGetTitle("A"), "on X")
Ins:: PostTwitterImages()
^Ins:: PostTwitterVideos()
#HotIf

PostTwitterImages() {
  folderWindow.Show() ; Folder selection
  while (!folderWindow.Value)
    Sleep(1000)
  folderPath := "d:\Pictures\Web\" MyListBox.Text
  totalImages := 0
  Loop Files folderPath "\*.png" ; Count total number of images, "D"
    totalImages += 1
  ShowMessageBox("Found " totalImages " images")
  Loop Files folderPath "\*.png" { ; Loop through all images in the folder, "D"
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
    "https://rumble.com/v4zryxn-soviet-russia-the-creator-of-the-plo-and-the-palestinian-people.html",
    "https://rumble.com/v4zrrir-how-innocent-palestinians-brutally-raped-burned-beheaded-and-mutilated-isra.html",
    "https://rumble.com/v4zrqru-palestinians-preparing-victims-for-western-media.html",
    "https://rumble.com/v4zrprl-message-from-a-saudi-writer-to-the-palestinians.html",
    "https://x.com/TheMossadIL/status/1734962161200275821", ; The leaders of HamISIS are moved by your donations. Moved to a bigger house.
    "https://x.com/krovinushka1/status/1800497436999499886", ; True face of Islam and "Palestinian people"
    "https://x.com/krovinushka1/status/1799458701595832441", ; I hate you and I will kill you for the sake of Allah
    "https://x.com/krovinushka1/status/1802079239610450411", ; "Peaceful" Palestinians in Ramallah today chanting: “If you have a rifle and you only shoot it at weddings, then go kill a Jew or give the weapon to Hamas”
    "https://x.com/krovinushka1/status/1799458537946730658", ; October 7 - 1
    "https://x.com/krovinushka1/status/1799458654808387712", ; October 7 - 2
    "https://x.com/krovinushka1/status/1800498901965021246", ; October 7 - 3
    "https://x.com/krovinushka1/status/1800499049487102051", ; October 7 - 4
    "https://x.com/krovinushka1/status/1800499196539380045", ; October 7 - 5
    "https://x.com/krovinushka1/status/1800499315506643369", ; October 7 - 6
    "https://x.com/krovinushka1/status/1799459044459151644", ; Palestinians celebrating 9-11
    "https://x.com/krovinushka1/status/1799459321920765996", ; Uninvolved Gazan civilians (October 7th footage)
    "https://x.com/krovinushka1/status/1799459056018772305", ; Palestinians teach children to hate and kill Jews
    "https://x.com/krovinushka1/status/1799458325412856262", ; Canada under Trudeau's regime
    "https://x.com/krovinushka1/status/1799458875395227727", ; Palestinian child, 50 pounds
    "https://x.com/krovinushka1/status/1799459032799084924", ; Palestinians begging Muslim brothers for help
    "https://x.com/krovinushka1/status/1799459931994915307", ; Музей Истории Палестины
    "https://x.com/krovinushka1/status/1799460041176776954", ; Геноцид Кого?
    "https://x.com/krovinushka1/status/1799803714431222179", ; Kurdish Islamist drinks hot camel urine because the “prophet” also drank it
    "https://x.com/krovinushka1/status/1800186799345807671", ; Palestinian Gaza terrorist cockroach (funded by UN & UNRWA) crawled out of his hole and went straight to Allah!
    "https://x.com/krovinushka1/status/1800494799642075605"  ; Supporter of Palestinian terrorists, they have been waiting for so long
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
#HotIf WinActive("ahk_exe FSCapture.exe")
Ins:: CreateDemotivator()
#HotIf

CreateDemotivator() {
  Send("g") ; White 1px border
  Sleep(1000)
  Send("{Tab 4}")
  Send("1")
  Click(420, 60)
  Sleep(1000)
  Click(200, 140)
  Click(40, 280)
  Sleep(1000)
  Send("{Enter}")
  Send("g") ; Back 10px border
  Sleep(1000)
  Send("{Tab 4}")
  Send("10")
  Click(420, 60)
  Sleep(1000)
  Click(20, 140)
  Click(40, 280)
  Sleep(1000)
  Send("{Enter}")
  Send("t") ; Enter text
  Sleep(1000)
  Send("^a")
  Sleep(1000)
  ; A_Clipboard := "ENTER YOUR TEXT HERE"
  ; Send("^{v}")
  ; Sleep(1000)
  ; Send("{Tab}")
  ; Send("{Enter}")
  ; Send("g") ; Repeat adding 10px black border
  ; Send("{Enter}")
  ShowMessageBox("Task completed", true)
}

; -------------------------------------------------------------------------------
; DeleteAuthorizedApps
; -------------------------------------------------------------------------------
#HotIf WinActive("ahk_exe Chrome.exe") and (InStr(WinGetTitle("A"), "Third-party apps & services") or InStr(WinGetTitle("A"), "Сторонние приложения и сервисы"))
Del:: DeleteAuthorizedApps()
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
#HotIf WinActive("ahk_exe Chrome.exe") and InStr(WinGetTitle("A"), "Rumble")
Ins:: UploadRumbleVideos()
#HotIf
UploadRumbleVideos() {
  folderPath := "d:\Videos\Web\New2" ; Upload videos from this folder
  A_Clipboard := folderPath
  totalVideos := 0 ; Count number of files in that folder
  Loop Files folderPath "\*.mp4" ; Count total number of videos, "D"
    totalVideos += 1
  ShowMessageBox("Found " totalVideos " videos")
  Loop Files folderPath "\*.mp4" { ; Loop through all videos in the folder, "D"
    ShowMessageBox("Uploading `"" A_LoopFileName "`"")
    ; Select Upload
    Click(1757, 154)
    Sleep(1000)
    Click(1757, 223)
    Sleep(1000)
    ; Upload video file
    Click(517, 540)
    Sleep(1000)
    Send(A_LoopFileFullPath)
    Sleep(1000)
    Send("{Enter}")
    Sleep(1000)
    ; Enter Video info
    Send("{Tab}")
    Sleep(1000)
    Send(StrReplace(A_LoopFileName, ".mp4", ""))
    Sleep(1000)
    ; Select Category
    Send("{Tab 2}")
    Sleep(1000)
    Send("{Up}")
    Sleep(1000)
    Send("{Enter}")
    Sleep(1000)
    ; Upload thumbnail file
    Click(1455, 685)
    Sleep(1000)
    Send(StrReplace(A_LoopFileFullPath, ".mp4", ".png"))
    Sleep(1000)
    Send("{Enter}")
    Sleep(1000)
    ; Select channel
    Send("{Tab 2}")
    Sleep(1000)
    Send("{Down}")
    Sleep(1000)
    ; Scroll to the bottom
    Send("{Tab}")
    Sleep(1000)
    ; Click Upload button
    Click(1480, 1015)
    Sleep(1000)
    ; Click to check Agreement 1, Agreement 2 and Submit button
    Click(1730, 985)
    Sleep(1000)
    Click(1730, 790)
    Sleep(1000)
    Click(1730, 850)
    Sleep(1000)
    Click(1730, 935)
    Sleep(1000)
    ; Wait for View "File name" button to appear
    while (PixelGetColor(285, 340) != 0x618035) {
      ShowMessageBox("Uploading `"" A_LoopFileName "`"")
      Sleep(1000)
    }
  }
  ShowMessageBox("Task completed", true)
  Run("https://rumble.com/c/c-6332874")
}

; -------------------------------------------------------------------------------
; DeleteRumbleVideos
; -------------------------------------------------------------------------------
#HotIf WinActive("ahk_exe Chrome.exe") and InStr(WinGetTitle("A"), "All videos")
Del:: DeleteRumbleVideos()
#HotIf
DeleteRumbleVideos() {
  ShowMessageBox("Deleting next video...")
  Click(1869, 505) ; 1869 - borderline
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