#Requires AutoHotkey v2
#Warn ; Recommended for catching common errors
#SingleInstance force ; Ensures only one instance of the script is running
#Include "Libs\WinClip.ahk"  ; WinClip external library
#Include "Libs\WinClipAPI.ahk" ; WinClip external library
#Include "TwitterPosts.ahk" ; Data file

; -------------------------------------------------------------------------------
; Replacements
; -------------------------------------------------------------------------------
::its::it's
::isnt::isn't
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
::lets::let's

; -------------------------------------------------------------------------------
; General actions
; -------------------------------------------------------------------------------

~Esc:: Reload() ; Reload script
#WheelUp:: Send("{Volume_Up}") ; Volume up
#WheelDown:: Send("{Volume_Down}") ; Volume down
Pause:: Run("nircmd/nircmd.exe standby") ; Put PC in sleep mode
ScrollLock:: { ; Switch between displays
  static state := false
  Run(state ? "displayswitch.exe /internal" : "displayswitch.exe /external")
  state := !state
}

; -------------------------------------------------------------------------------
; Folder selection window
; -------------------------------------------------------------------------------
SelectTwitterPosts() {
  global window := Gui("AlwaysOnTop")
  window.SetFont("s10", "Bahnschrift")
  window.AddText(, "Select category")
  categories := [] ; Create a new array to hold the names
  for item in twitterPosts { ; Loop through each object in the array and add the 'name' property to the 'names' array
    categories.Push(item.category)
  }
  category := ""
  listbox := window.AddListBox("r" categories.Length " Choose1 w200", categories)
  listbox.OnEvent("DoubleClick", (*) => (
    category := listbox.Text
    window.Hide()))
  button := window.AddButton("Default w80", "OK")
  button.OnEvent("Click", (*) => (
    category := listbox.Text
    window.Hide()))
  window.Show()
  WinWaitClose(window)
  for item in twitterPosts {
    if (item.category == category) {
      return item.posts
    }
  }
  return
}

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
  SetWorkingDir(folderPath)
  count := 0
  loop files "*.png" ; Count total number of images
    count++
  ShowMessageBox("Found " count " images")
  SplitPath(folderPath, &folderName, &OutDir, &OutExtension, &OutNameNoExt, &OutDrive)
  if (folderName == "")
    return
  wc := WinClip()
  loop files "*.png" { ; Loop through all images in the folder
    ShowMessageBox("Posting image " A_Index " of " count)
    wc.Clear(), wc.SetBitmap(A_LoopFileName), wc.Paste(), Sleep(1000), Send("^{Enter}"), Sleep(2000)
  }
  ShowMessageBox("Task completed")
  Reload()
}

ReplyTwitterVideos() {
  posts := SelectTwitterPosts()
  loop posts.Length { ; Loop through all posts in array
    ShowMessageBox("Posting video " A_Index " of " posts.Length)
    A_Clipboard := posts[A_Index], Send("^v"), Sleep(1000), Send("^{Enter}"), Sleep(1000)
  }
  ShowMessageBox("Task completed")
  Reload()
}

UploadTweeterVideos() {
  folderPath := DirSelect("d:\Videos\Twitter", 0) ; Upload videos from this folder
  SetWorkingDir(folderPath)
  count := 0 ; Count number of files in that folder
  loop files "*.mp4" ; Count total number of videos
    count++
  ShowMessageBox("Found " count " videos")
  wc := WinClip()
  loop files "*.mp4" { ; Loop through all videos in the folder
    ShowMessageBox("Uploading `"" A_LoopFileName "`"")
    fileName := SubStr(StrReplace(A_LoopFileName, ".mp4", ""), 7)
    A_Clipboard := fileName, Send("^v"), Sleep(1000), wc.Clear(), wc.SetFiles(A_LoopFileFullPath), wc.Paste(), Sleep(1000), Send("^{Enter}")
    while (PixelGetColor(1130, 250) != 0x8DCCF7) { ; Wait for "Post" button to appear
      ShowMessageBox("Uploading `"" A_LoopFileName "`"")
      Sleep(1000)
    }
    Send("{Tab 2}"), Sleep(2000)
  }
  ShowMessageBox("Task completed")
}

UploadRumbleVideos() {
  folderPath := DirSelect("d:\Videos\Rumble", 0) ; Upload videos from this folder
  SetWorkingDir(folderPath)
  totalVideos := 0 ; Count number of files in that folder
  loop files "*.mp4" ; Count total number of videos
    totalVideos++
  ShowMessageBox("Found " totalVideos " videos")
  loop files "*.mp4" { ; Loop through all videos in the folder
    ShowMessageBox("Uploading `"" A_LoopFileName "`"")
    Click(1757, 154), Sleep(1000) ; Click Upload button
    Click(1757, 223), Sleep(1000) ; Select Upload option
    Click(517, 540), Sleep(2000) ; Click Upload area
    A_Clipboard := A_LoopFileName, Send("^v"), Sleep(1000), Send("{Enter}"), Sleep(1000)  ; Enter vide file name to upload
    Send("{Tab}")
    Sleep(1000)
    fileName := SubStr(StrReplace(A_LoopFileName, ".mp4", ""), 7)
    A_Clipboard := fileName, Send("^v"), Sleep(1000) ; Enter video title
    Send("{Tab 2}"), Sleep(100), Send("{Up}"), Sleep(100), Send("{Enter}"), Sleep(100) ; Click Enter to select category
    Click(1455, 685), Sleep(2000) ; Click thumbnail upload area
    A_Clipboard := StrReplace(A_LoopFileName, ".mp4", ".png")
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