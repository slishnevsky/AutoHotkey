#Requires AutoHotkey v2
#Warn ; Recommended for catching common errors
#SingleInstance force ; Ensures only one instance of the script is running
#Include WinClipAPI.ahk ; WinClip external library
#Include WinClip.ahk ; WinClip external library

; -------------------------------------------------------------------------------
; General hotstrings
; -------------------------------------------------------------------------------
{
  ::aa::AutoHotkey v2
  ::ss::Slava Lishnevsky
  ::sss::slishnevsky@gmail.com
  ::kk::Кровинушка
  ::kkk::krovinushka1@gmail.com
  ::ppp::gorLubUlKir1440
}

; -------------------------------------------------------------------------------
; General actions
; -------------------------------------------------------------------------------
#Esc:: ExitApp ; Exits AutoHotkey app
Pause:: DllCall("PowrProf\SetSuspendState", "Int", 0, "Int", 0, "Int", 0) ; Puts a PC into sleep mode
ScrollLock:: { ; Switchess between displays
  static state := false
  Run(state ? "DisplaySwitch.exe /internal" : "DisplaySwitch.exe /external")
  state := !state
}

; -------------------------------------------------------------------------------
; ShowMessageBox
; -------------------------------------------------------------------------------
ShowMessageBox(message) {
  messageBox := Gui("-Caption")
  messageBox.BackColor := "6391EE"
  messageBox.SetFont("s20 cWhite", "Bahnschrift")
  messageBox.AddText("Center", message)
  messageBox.Show()
  Sleep(1000)
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
folderArray := [] ; Initialize an empty array to store folder names
rootFolderPath := "d:\Pictures\Web\"
loop files rootFolderPath "*", "D" { ; Loop through items in the directory
  currentItem := A_LoopFileFullPath
  ; Get the folder name and add it to the array
  folderName := SubStr(currentItem, InStr(currentItem, "\", , -1) + 1)  ; Extract folder name from full path
  folderArray.push(folderName)  ; Add folder name to the array
}
MyListBox := folderWindow.AddListBox("r" folderArray.Length " Choose1 w200", folderArray)
folderWindow.Value := 0

; -------------------------------------------------------------------------------
; InsertTweeterPosts
; -------------------------------------------------------------------------------
#HotIf WinActive("ahk_exe Chrome.exe") and InStr(WinGetTitle("A"), "Home / X")
Ins:: InsertTweeterVideos()
#HotIf

InsertTweeterVideos() {
  folderPath := "d:\Videos\Web\Twitter\" ; Upload videos from this folder
  totalVideos := 0 ; Count number of files in that folder
  loop files folderPath "*.mp4" ; Count total number of videos
    totalVideos += 1
  ShowMessageBox("Found " totalVideos " videos")
  firstTime := true
  loop files folderPath "*.mp4" { ; Loop through all videos in the folder
    ShowMessageBox("Uploading `"" A_LoopFileName "`"")
    Send(StrReplace(A_LoopFileName, ".mp4", ""))
    Send("{Tab 2}")
    Sleep(1000)
    Send("{Enter}")
    Sleep(1000)
    Send(A_LoopFileFullPath)
    Sleep(1000)
    Send("{Enter}")
    Sleep(1000)
    Exit
  }
  ShowMessageBox("Task completed")
}

; -------------------------------------------------------------------------------
; DeleteTweeterPosts
; -------------------------------------------------------------------------------
#HotIf WinActive("ahk_exe Chrome.exe") and InStr(WinGetTitle("A"), "Кровинушка (@krovinushka1) / X")
Del:: DeleteTweeterPosts()
#HotIf

DeleteTweeterPosts() {
  ; Wait for "Deleting..." message to disappear
  if (PixelGetColor(1167, 663) == 0xFFFFFF) {
    ShowMessageBox("Task completed")
    return
  }
  ShowMessageBox("Deleting next post...")
  Click(1167, 663)
  Sleep(1000)
  Click(1000, 673)
  Sleep(1000)
  Click(1000, 673)
  Sleep(1000)
  DeleteTweeterPosts()
}

; -------------------------------------------------------------------------------
; ReplyTwitterImages
; -------------------------------------------------------------------------------
#HotIf WinActive("ahk_exe Chrome.exe") and InStr(WinGetTitle("A"), "on X")
Ins:: ReplyTwitterImages()
#HotIf

ReplyTwitterImages() {
  folderWindow.Show() ; Folder selection
  while (!folderWindow.Value)
    Sleep(1000)
  folderPath := "d:\Pictures\Web\" MyListBox.Text "\"
  totalImages := 0
  loop files folderPath "*.png" ; Count total number of images
    totalImages += 1
  ShowMessageBox("Found " totalImages " images")
  loop files folderPath "*.png" { ; Loop through all images in the folder
    ShowMessageBox("Posting image " A_Index " of " totalImages)
    wc := WinClip()
    wc.Clear()
    wc.SetBitmap(A_LoopFileFullPath)
    wc.Paste()
    Sleep(1000)
    Send("^{Enter}")
    Sleep(2000)
  }
  ShowMessageBox("Task completed")
  Reload()
}

; -------------------------------------------------------------------------------
; ReplyTwitterVideos
; -------------------------------------------------------------------------------
#HotIf WinActive("ahk_exe Chrome.exe") and InStr(WinGetTitle("A"), "on X")
^Ins:: ReplyTwitterVideos()
#HotIf

ReplyTwitterVideos() {
  videos := [
    "Video: Soviet Russia, The Creator of the PLO and the «Palestinian people» https://rumble.com/v4zryxn-soviet-russia-the-creator-of-the-plo-and-the-palestinian-people.html",
    "Video: How «innocent» Palestinians brutally raped, burned, beheaded and mutilated Israelis https://rumble.com/v4zrrir-how-innocent-palestinians-brutally-raped-burned-beheaded-and-mutilated-isra.html",
    "Video: Palestinians preparing «victims» for Western media https://rumble.com/v4zrqru-palestinians-preparing-victims-for-western-media.html",
    "Video: Message from a Saudi Writer Rawaf al-Saeen to the Palestinians https://rumble.com/v4zrprl-message-from-a-saudi-writer-to-the-palestinians.html",
    "Video: The children of Gaza are suffering. Donate us money! https://rumble.com/v52e8u0-the-children-of-gaza-are-suffering.-donate-us-money.html",
    "https://x.com/krovinushka1/status/1802871814915244440", ; The Representatives of True Islam
    "https://x.com/krovinushka1/status/1802872694825734299", ; True Face of Islam
    "https://x.com/krovinushka1/status/1802870283365183725", ; «Innocent» Palestinians (October 7th footage) Part 1
    "https://x.com/krovinushka1/status/1802870340080603354", ; «Innocent» Palestinians (October 7th footage) Part 2
    "https://x.com/krovinushka1/status/1802870388696744396", ; «Innocent» Palestinians (October 7th footage) Part 3
    "https://x.com/krovinushka1/status/1802870469005128165", ; «Innocent» Palestinians (October 7th footage) Part 4
    "https://x.com/krovinushka1/status/1802870558213738502", ; «Innocent» Palestinians (October 7th footage) Part 5
    "https://x.com/krovinushka1/status/1802870604892144014", ; «Innocent» Palestinians (October 7th footage) Part 6
    "https://x.com/krovinushka1/status/1802870717454696851", ; «Peaceful» Palestinians in Ramallah chanting
    "https://x.com/krovinushka1/status/1802870800648745365", ; «Uninvolved» Gazan civilians (October 7th footage)
    "https://x.com/krovinushka1/status/1802871131809947857", ; Mister Pallywood (Saleh Aljafarawi)
    "https://x.com/krovinushka1/status/1802871484156637485", ; Palestinians celebrating 9/11
    "https://x.com/krovinushka1/status/1802871552062394796", ; Palestinians teach children to hate and kill Jews
    "https://x.com/krovinushka1/status/1802873116701388822", ; Canada under Trudeau's regime
    "https://x.com/krovinushka1/status/1802871269555105837", ; Palestinian child ma'am, 50 pounds of fresh Palestinian child
    "https://x.com/krovinushka1/status/1802871182183588097", ; Palestine History Museum opens in Israel
    "https://x.com/krovinushka1/status/1802871382209962288", ; Palestinians begging Muslim brothers for help
    "https://x.com/krovinushka1/status/1802871014981870012", ; Genocide of Who?
    "https://x.com/krovinushka1/status/1803223415383310554", ; Kurdish Islamist drinks hot camel urine because «prophet» drank it
    "https://x.com/krovinushka1/status/1802872350922146265"  ; Hamas supporter they have been waiting for
  ]
  loop videos.Length { ; Loop through all videos in the array
    ShowMessageBox("Posting video " A_Index " of " videos.Length)
    A_Clipboard := videos[A_Index]
    Send("^{v}")
    Sleep(1000)
    Send("^{Enter}")
    Sleep(2000)
  }
  ShowMessageBox("Task completed")
  Reload()
}

; -------------------------------------------------------------------------------
; UploadRumbleVideos
; -------------------------------------------------------------------------------
#HotIf WinActive("ahk_exe Chrome.exe") and InStr(WinGetTitle("A"), "Rumble")
Ins:: UploadRumbleVideos()
#HotIf

UploadRumbleVideos() {
  folderPath := "d:\Videos\Web\Rumble\Russian\" ; Upload videos from this folder
  totalVideos := 0 ; Count number of files in that folder
  loop files folderPath "*.mp4" ; Count total number of videos
    totalVideos += 1
  ShowMessageBox("Found " totalVideos " videos")
  loop files folderPath "*.mp4" { ; Loop through all videos in the folder
    ShowMessageBox("Uploading `"" A_LoopFileName "`"")
    ; Select Upload option
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
    ; Enter video title
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
    ; Check the agreements and click Submit button
    Click(1730, 985)
    Sleep(1000)
    Click(1730, 790)
    Sleep(1000)
    Click(1730, 850)
    Sleep(1000)
    Click(1730, 935)
    Sleep(1000)
    while (PixelGetColor(285, 340) != 0x618035) { ; Wait for View "File name" button to appear
      ShowMessageBox("Uploading `"" A_LoopFileName "`"")
      Sleep(1000)
    }
  }
  ShowMessageBox("Task completed")
}

; -------------------------------------------------------------------------------
; DeleteRumbleVideos
; -------------------------------------------------------------------------------
#HotIf WinActive("ahk_exe Chrome.exe") and InStr(WinGetTitle("A"), "All videos")
; Del:: DeleteRumbleVideos()
#HotIf

DeleteRumbleVideos() {
  ShowMessageBox("Deleting next video...")
  Click(1869, 505) ; 1869 - borderline
  Sleep(1000)
  Click(1865, 711)
  Sleep(1000)
  Click(1210, 700)
  Sleep(1000)
  while (PixelGetColor(1040, 710) == 0xFFFFFF) { ; Wait for "Deleting..." message to disappear
    ShowMessageBox("Deleting video...")
    Sleep(1000)
  }
  DeleteRumbleVideos()
}

; -------------------------------------------------------------------------------
; CreateDemotivator
; -------------------------------------------------------------------------------
#HotIf WinActive("ahk_exe FSCapture.exe")
Ins:: CreateDemotivator()
#HotIf

CreateDemotivator() {
  Send("g") ; White 1px border
  Sleep(500)
  Send("{Tab 4}")
  Send("1")
  Click(420, 60)
  Sleep(500)
  Click(200, 140)
  Click(40, 280)
  Sleep(500)
  Send("{Enter}")
  Send("g") ; Back 10px border
  Sleep(500)
  Send("{Tab 4}")
  Send("10")
  Click(420, 60)
  Sleep(500)
  Click(20, 140)
  Click(40, 280)
  Sleep(500)
  Send("{Enter}")
  Send("t") ; Enter text
  Sleep(500)
  Send("^a")
  Sleep(500)
  ShowMessageBox("Task completed")
}

; -------------------------------------------------------------------------------
; DeleteAuthorizedApps
; -------------------------------------------------------------------------------
#HotIf WinActive("ahk_exe Chrome.exe") and InStr(WinGetTitle("A"), "Third-party apps & services")
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