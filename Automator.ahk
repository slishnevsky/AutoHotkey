#Requires AutoHotkey v2
#Warn ; Recommended for catching common errors
#SingleInstance force ; Ensures only one instance of the script is running
#Include WinClipAPI.ahk ; WinClip external library
#Include WinClip.ahk ; WinClip external library
#Include "TwitterData.ahk"

; -------------------------------------------------------------------------------
; Replacements
; -------------------------------------------------------------------------------
::cant::can't
::couldnt::couldn't
::dont::don't
::doesnt::doesn't
::didnt::didn't
::havent::haven't
::hasnt::hasn't
::hadnt::hadn't
::thats::that's
::wasnt::wasn't
::whats::what's
::wont::won't
::wouldnt::wouldn't
::shouldnt::shouldn't

; -------------------------------------------------------------------------------
; General actions
; -------------------------------------------------------------------------------

; SetCapsLockState "AlwaysOff"
~Esc:: Reload
#WheelUp:: Send("{Volume_Up}")
#WheelDown:: Send("{Volume_Down}")
Pause:: DllCall("PowrProf\SetSuspendState", "Int", 0, "Int", 0, "Int", 0) ; Puts a PC into sleep mode
ScrollLock:: { ; Switch between displays
  static state := false
  Run(state ? "DisplaySwitch.exe /internal" : "DisplaySwitch.exe /external")
  state := !state
}
^!h:: Run("https://slishnevsky.github.io/")


; -------------------------------------------------------------------------------
; ShowMessageBox
; -------------------------------------------------------------------------------
ShowMessageBox(message) {
  messageBox := Gui("-Caption")
  messageBox.BackColor := "BF2517"
  messageBox.SetFont("s20 cWhite", "Bahnschrift")
  messageBox.AddText("Center", message)
  messageBox.Show()
  Sleep(1000)
  messageBox.Hide()
}

; -------------------------------------------------------------------------------
; Folder selection window
; -------------------------------------------------------------------------------
SelectFolder(parentFolder) {
  global window := Gui("AlwaysOnTop")
  window.SetFont("s10", "Bahnschrift")
  window.AddText(, "Select your folder")
  folders := [] ; Initialize an empty array to store folder names
  loop files parentFolder "\*", "D" { ; Loop through items in the directory
    folders.push(A_LoopFileFullPath "\")  ; Add folder path to the array
  }
  selection := ""
  listbox := window.AddListBox("r" folders.Length " Choose1 w200", folders)
  listbox.OnEvent("DoubleClick", (*) => (
    selection := listbox.Text
    window.Hide()))
  button := window.AddButton("Default w80", "OK")
  button.OnEvent("Click", (*) => (
    selection := listbox.Text
    window.Hide()))
  window.Show()
  WinWaitClose(window)
  return selection
}

; -------------------------------------------------------------------------------
; ReplyTwitterImages
; -------------------------------------------------------------------------------
#HotIf WinActive("ahk_exe Chrome.exe") and InStr(WinGetTitle("A"), "on X")
+Ins:: ReplyTwitterImages()
#HotIf

ReplyTwitterImages() {
  folder := SelectFolder("d:\Pictures\Twitter\")
  count := 0
  loop files folder "*.png" ; Count total number of images
    count += 1
  ShowMessageBox("Found " count " images")
  loop files folder "*.png" { ; Loop through all images in the folder
    ShowMessageBox("Posting image " A_Index " of " count)
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
  posts := []
  folder := SelectFolder("d:\Videos\Twitter\")
  if (folder = "d:\Videos\Twitter\Biden\")
    posts := Biden
  if (folder = "d:\Videos\Twitter\Kamala\")
    posts := Kamala
  if (folder = "d:\Videos\Twitter\Palestinians\")
    posts := Palestinians
  if (folder = "d:\Videos\Twitter\Trudeau\")
    posts := Trudeau
  loop posts.Length { ; Loop through all posts in array
    ShowMessageBox("Posting video " A_Index " of " posts.Length)
    A_Clipboard := posts[A_Index]
    Send("^v")
    Sleep(1000)
    Send("^{Enter}")
    Sleep(2000)
  }
  ShowMessageBox("Task completed")
  Reload()
}

; -------------------------------------------------------------------------------
; UploadTweeterVideos
; -------------------------------------------------------------------------------
#HotIf WinActive("ahk_exe Chrome.exe") and InStr(WinGetTitle("A"), "Home / X")
!Ins:: UploadTweeterVideos()
#HotIf

UploadTweeterVideos() {
  folder := SelectFolder("d:\Videos\Twitter\") ; Upload videos from this folder
  count := 0 ; Count number of files in that folder
  loop files folder "*.mp4" ; Count total number of videos
    count++
  ShowMessageBox("Found " count " videos")
  firstTime := true
  loop files folder "*.mp4" { ; Loop through all videos in the folder
    ShowMessageBox("Uploading `"" A_LoopFileName "`"")
    A_Clipboard := SubStr(StrReplace(A_LoopFileName, ".mp4", ""), 5)
    Send("^v")
    Sleep(1000)
    wc := WinClip()
    wc.Clear()
    wc.SetFiles(A_LoopFileFullPath)
    wc.Paste()
    Sleep(1000)
    Send("^{Enter}")
    while (PixelGetColor(1125, 265) != 0xB0C7F6) { ; Wait for "Post" button to appear
      ShowMessageBox("Uploading `"" A_LoopFileName "`"")
      Sleep(1000)
    }
    Send("{Tab 2}")
    Sleep(2000)
  }
  ShowMessageBox("Task completed")
}

; -------------------------------------------------------------------------------
; DeleteTweeterPosts
; -------------------------------------------------------------------------------
#HotIf WinActive("ahk_exe Chrome.exe") and InStr(WinGetTitle("A"), "Кровинушка (@krovinushka1) / X")
!Del:: DeleteTweeterPosts()
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
; UploadRumbleVideos
; -------------------------------------------------------------------------------
#HotIf WinActive("ahk_exe Chrome.exe") and InStr(WinGetTitle("A"), "Rumble")
!Ins:: UploadRumbleVideos()
#HotIf

UploadRumbleVideos() {
  folderPath := "d:\Videos\Rumble\" ; Upload videos from this folder
  totalVideos := 0 ; Count number of files in that folder
  loop files folderPath "*.mp4" ; Count total number of videos
    totalVideos++
  ShowMessageBox("Found " totalVideos " videos")
  loop files folderPath "*.mp4" { ; Loop through all videos in the folder
    ShowMessageBox("Uploading `"" A_LoopFileName "`"")
    Click(1757, 154) ; Click Upload button
    Sleep(1000)
    Click(1757, 223) ; Select Upload option
    Sleep(1000)
    Click(517, 540) ; Click Upload area
    Sleep(1000)
    A_Clipboard := A_LoopFileFullPath
    Send("^v") ; Enter vide file name to upload
    Sleep(1000)
    Send("{Enter}") ; Click Enter to upload
    Sleep(1000)
    Send("{Tab}")
    Sleep(1000)
    A_Clipboard := SubStr(StrReplace(A_LoopFileName, ".mp4", ""), 5)
    Send("^v") ; Enter video title
    Sleep(1000)
    Send("{Tab 2}")
    Sleep(100)
    Send("{Up}")
    Sleep(100)
    Send("{Enter}") ; Click Enter to select category
    Sleep(100)
    Click(1455, 685) ; Click thumbnail upload area
    Sleep(1000)
    A_Clipboard := StrReplace(A_LoopFileFullPath, ".mp4", ".png")
    Send("^v") ; Enter thumbnail file name to upload
    Sleep(1000)
    Send("{Enter}") ; Click Enter to upload
    Sleep(1000)
    Send("{Tab 2}") ; Scroll to the bottom
    Sleep(100)
    Click(1480, 1015) ; Click Upload button
    Sleep(1000)
    Click(1730, 790) ; Check the agreements 1
    Sleep(100)
    Click(1730, 850) ; Check the agreements 2
    Sleep(1000)
    Click(1730, 935) ; Click Submit button
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
!Del:: DeleteRumbleVideos()
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
; DeleteAuthorizedApps
; -------------------------------------------------------------------------------
#HotIf WinActive("ahk_exe Chrome.exe") and (InStr(WinGetTitle("A"), "Third-party apps & services") or InStr(WinGetTitle("A"), "Сторонние приложения и сервисы"))
!Del:: DeleteAuthorizedApps()
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

; ; -------------------------------------------------------------------------------
; ; CreateDemotivator
; ; -------------------------------------------------------------------------------
; #HotIf WinActive("ahk_exe FSCapture.exe")
; Ins:: CreateDemotivator()
; #HotIf

; CreateDemotivator() {
;   Send("g") ; White 1px border
;   Sleep(500)
;   Send("{Tab 4}")
;   Send("1")
;   Click(420, 60)
;   Sleep(500)
;   Click(200, 140)
;   Click(40, 280)
;   Send("{Enter}")
;   Send("g") ; Back 10px border
;   Sleep(500)
;   Send("{Tab 4}")
;   Send("10")
;   Click(420, 60)
;   Sleep(500)
;   Click(20, 140)
;   Click(40, 280)
;   Send("{Enter}")
;   Send("t") ; Enter text
;   Sleep(500)
;   Send("^{Enter}") ; Back 10px border
;   Send("g")
;   Send("{Enter}")
;   ShowMessageBox("Task completed")
; }

; -------------------------------------------------------------------------------
; DeleteRumbleRezkaHistory
; -------------------------------------------------------------------------------
#HotIf WinActive("ahk_exe Chrome.exe") and InStr(WinGetTitle("A"), "Досмотреть")
!Del:: DeleteRumbleRezkaHistory()
#HotIf

DeleteRumbleRezkaHistory() {
  ShowMessageBox("Deleting next video...")
  Click(1417, 378)
  Sleep(1000)
  Click(1042, 188)
  Sleep(1000)
  DeleteRumbleRezkaHistory()
}