#Requires AutoHotkey v2
#Warn ; Recommended for catching common errors
#SingleInstance force ; Ensures only one instance of the script is running
#Include WinClipAPI.ahk ; WinClip external library
#Include WinClip.ahk ; WinClip external library

; -------------------------------------------------------------------------------
; Replacements
; -------------------------------------------------------------------------------
::ss::Slava Lishnevsky
::sss::slishnevsky@gmail.com
::kk::Кровинушка
::kkk::krovinushka1@gmail.com

::cant::can't
::couldnt::couldn't
::dont::don't
::doesnt::doesn't
::didnt::didn't
::havent::haven't
::hasnt::hasn't
::hadnt::hadn't
::ive::iv'e
::thats::that's
::wasnt::wasn't
::whats::what's
::wont::won't
::wouldnt::wouldn't

; -------------------------------------------------------------------------------
; General actions
; -------------------------------------------------------------------------------
^!End:: Reload ; Reloads AutoHotkey script
#WheelUp:: Send("{Volume_Up}")
#WheelDown:: Send("{Volume_Down}")
Pause:: DllCall("PowrProf\SetSuspendState", "Int", 0, "Int", 0, "Int", 0) ; Puts a PC into sleep mode
ScrollLock:: { ; Switch between displays
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
SelectFolder(parentFolder) {
  window := Gui("AlwaysOnTop")
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
  folder := SelectFolder("d:\Videos\Twitter\")
  switch [folder] {
    case "d:\Videos\Twitter\Biden\":
      videos := ["1837606063354663231", "1837606116982710615", "1837606170439438542", "1837606214491881711", "1837606266102854116", "1837606309128294514", "1837606378317266975", "1837606447699665062", "1837606515483537505", "1837606569829117975"]
    case "d:\Videos\Twitter\Trudeau\":
      videos := ["1837606718358147313", "1837606803011498316", "1837606900013080939", "1837606958033260804", "1837607014945464767"]
    case "d:\Videos\Twitter\Kamala\":
      videos := ["1837609261393756463", "1837609363877265820", "1837609426796032239", "1837609491560648907", "1837609599840801163", "1837609675996426710", "1837609731734606000", "1837609853402894451", "1837609906431557950", "1837609995736641719", "1837610093917138998", "1837610166617100585", "1837610261298937918", "1837610348351983972", "1837610436214108460", "1837610533903912994", "1837610610671931409", "1837610679492399439", "1837610729731485756", "1837610796232462792", "1837610865358414152", "1837610918693269565", "1837610982157230403", "1837611041422778398", "1837611089695015273"]
    case "d:\Videos\Twitter\Palestinians\":
      videos := ["1837607224396702022", "1837607324665446706", "1837607405200232868", "1837607487182123202", "1837607551711535396", "1837607656023851171", "1837607707177869548", "1837607775561552281", "1837607831798714616", "1837607980784931082", "1837608114096345333", "1837608166181556634", "1837608296166871070", "1837608487549059509", "1837608557002289183", "1837608622979010877", "1837608669158023275", "1837608739009860026", "1837608884124422302", "1837609117973991726", "1837609026877604093"]
    default:
      return
    default:
  }
  loop videos.Length { ; Loop through all videos in the array
    ShowMessageBox("Posting video " A_Index " of " videos.Length)
    A_Clipboard := "https://x.com/krovinushka1/status/" videos[A_Index]
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
  folderPath := "d:\Videos\Twitter\Kamala\" ; Upload videos from this folder
  count := 0 ; Count number of files in that folder
  loop files folderPath "*.mp4" ; Count total number of videos
    count++
  ShowMessageBox("Found " count " videos")
  firstTime := true
  loop files folderPath "*.mp4" { ; Loop through all videos in the folder
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
#HotIf WinActive("ahk_exe Chrome.exe") and InStr(WinGetTitle("A"), "Krovinushka (Кровинушка) (@krovinushka1) / X")
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