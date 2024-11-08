#Requires AutoHotkey v2
#Warn ; Recommended for catching common errors
#SingleInstance force ; Ensures only one instance of the script is running
#Include WinClipAPI.ahk ; WinClip external library
#Include WinClip.ahk ; WinClip external library
#Include "TwitterData.ahk"

; -------------------------------------------------------------------------------
; Replacements
; -------------------------------------------------------------------------------
::its::it's
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
; General
; -------------------------------------------------------------------------------
~Esc:: {
  Reload
  Run("NirCmd/nircmd.exe emptybin")
}
; SetCapsLockState "AlwaysOff"
; #WheelUp:: Send("{Volume_Up}")
; #WheelDown:: Send("{Volume_Down}")
; Pause:: {
;   ; DllCall("PowrProf\SetSuspendState", "Int", 0, "Int", 0, "Int", 0) ; Puts a PC into sleep mode
;   Run("NirCmd/nircmd.exe standby")
;   Run("NirCmd/nircmd.exe emptybin")
; }
; ScrollLock:: { ; Switch between displays
;   static state := false
;   Run(state ? "DisplaySwitch.exe /internal" : "DisplaySwitch.exe /external")
;   state := !state
; }

; -------------------------------------------------------------------------------
; ShowMessageBox
; -------------------------------------------------------------------------------
ShowMessageBox(message) {
  messageBox := Gui("-Caption")
  messageBox.BackColor := "0E639C"
  messageBox.SetFont("s20 cWhite", "Bahnschrift")
  messageBox.AddText("Center", message)
  messageBox.Show()
  Sleep(1000)
  messageBox.Hide()
}

; -------------------------------------------------------------------------------
; Actions
; -------------------------------------------------------------------------------
#HotIf WinActive("ahk_exe Chrome.exe")
; #Ins:: UploadTweeterVideos()
; #Ins:: UploadRumbleVideos()
; #Del:: DeleteTweeterPosts()
; #Del:: DeleteRumbleVideos()
; #Del:: DeleteAuthorizedApps()
; #Del:: DeleteHDRezkaHistory()
+Ins:: ReplyTwitterImages()
^Ins:: ReplyTwitterVideos()
#HotIf

ReplyTwitterImages() {
  folderPath := DirSelect("d:\Pictures\Twitter", 0)
  if (folderPath == "")
    return
  count := 0
  loop files folderPath "\*.png" ; Count total number of images
    count++
  ShowMessageBox("Found " count " images")
  SplitPath(folderPath, &folderName, &OutDir, &OutExtension, &OutNameNoExt, &OutDrive)
  if (folderName == "")
    return
  loop files folderPath "\*.png" { ; Loop through all images in the folder
    ShowMessageBox("Posting image " A_Index " of " count)
    wc := WinClip()
    wc.Clear()
    wc.SetBitmap(A_LoopFileFullPath)
    wc.Paste()
    Sleep(1000)
    Send("^{Enter}")
    Sleep(3000)
  }
  ShowMessageBox("Task completed")
  Reload()
}

ReplyTwitterVideos() {
  posts := []
  folderPath := DirSelect("d:\Videos\Twitter", 0)
  SplitPath(folderPath, &folderName, &OutDir, &OutExtension, &OutNameNoExt, &OutDrive)
  if (folderName == "")
    return
  if (folderName == "Biden")
    posts := Biden
  if (folderName == "Kamala")
    posts := Kamala
  if (folderName == "Palestinians")
    posts := Palestinians
  if (folderName == "Trudeau")
    posts := Trudeau
  if (folderName == "Ezra")
    posts := Ezra
  loop posts.Length { ; Loop through all posts in array
    ShowMessageBox("Posting video " A_Index " of " posts.Length)
    A_Clipboard := posts[A_Index]
    Send("^v")
    Sleep(100)
    Send("^{Enter}")
    Sleep(1000)
  }
  ShowMessageBox("Task completed")
  Reload()
}

UploadTweeterVideos() {
  folderPath := DirSelect("d:\Videos\Twitter", 0) ; Upload videos from this folder
  count := 0 ; Count number of files in that folder
  loop files folderPath "\*.mp4" ; Count total number of videos
    count++
  ShowMessageBox("Found " count " videos")
  firstTime := true
  loop files folderPath "\*.mp4" { ; Loop through all videos in the folder
    ShowMessageBox("Uploading `"" A_LoopFileName "`"")
    A_Clipboard := SubStr(StrReplace(A_LoopFileName, ".mp4", ""), 7)
    Send("^v")
    Sleep(1000)
    wc := WinClip()
    wc.Clear()
    wc.SetFiles(A_LoopFileFullPath)
    wc.Paste()
    Sleep(1000)
    Send("^{Enter}")
    while (PixelGetColor(1125, 265) != 0x8DCDF7) { ; Wait for "Post" button to appear
      ShowMessageBox("Uploading `"" A_LoopFileName "`"")
      Sleep(1000)
    }
    Send("{Tab 2}")
    Sleep(2000)
  }
  ShowMessageBox("Task completed")
}

UploadRumbleVideos() {
  folderPath := DirSelect("d:\Videos\Rumble", 0) ; Upload videos from this folder
  totalVideos := 0 ; Count number of files in that folder
  loop files folderPath "\*.mp4" ; Count total number of videos
    totalVideos++
  ShowMessageBox("Found " totalVideos " videos")
  loop files folderPath "\*.mp4" { ; Loop through all videos in the folder
    ShowMessageBox("Uploading `"" A_LoopFileName "`"")
    Click(1757, 154) ; Click Upload button
    Sleep(1000)
    Click(1757, 223) ; Select Upload option
    Sleep(1000)
    Click(517, 540) ; Click Upload area
    Sleep(2000)
    A_Clipboard := A_LoopFileFullPath
    Send("^v") ; Enter vide file name to upload
    Sleep(1000)
    Send("{Enter}") ; Click Enter to upload
    Sleep(1000)
    Send("{Tab}")
    Sleep(1000)
    A_Clipboard := SubStr(StrReplace(A_LoopFileName, ".mp4", ""), 7)
    Send("^v") ; Enter video title
    Sleep(1000)
    Send("{Tab 2}")
    Sleep(100)
    Send("{Up}")
    Sleep(100)
    Send("{Enter}") ; Click Enter to select category
    Sleep(100)
    Click(1455, 685) ; Click thumbnail upload area
    Sleep(2000)
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
    while (PixelGetColor(300, 335) != 0x567D31) { ; Wait for View "File name" button to appear
      ShowMessageBox("Uploading `"" A_LoopFileName "`"")
      Sleep(1000)
    }
  }
  ShowMessageBox("Task completed")
}

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

DeleteHDRezkaHistory() {
  ShowMessageBox("Deleting next video...")
  Click(1417, 378)
  Sleep(1000)
  Click(1042, 188)
  Sleep(1000)
  DeleteHDRezkaHistory()
}