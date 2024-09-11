#Requires AutoHotkey v2
#Warn ; Recommended for catching common errors
#SingleInstance force ; Ensures only one instance of the script is running
#Include WinClipAPI.ahk ; WinClip external library
#Include WinClip.ahk ; WinClip external library
; #Include Autotext.ahk ; Autotext script

; -------------------------------------------------------------------------------
; General actions
; -------------------------------------------------------------------------------
#Esc:: Reload ; Restart AutoHotkey app
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
#HotIf WinActive("ahk_id" folderWindow.Hwnd) ; Submit selection by pressing Enter
Enter::
NumpadEnter:: folderWindow.Value := folderWindow.Submit()
#HotIf

folderWindow := Gui("AlwaysOnTop")
folderWindow.SetFont("s10", "Bahnschrift")
folderWindow.AddText(, "Select your folder")
folderArray := [] ; Initialize an empty array to store folder names
rootFolderPath := "d:\Pictures\Twitter\"
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
Ins:: UploadTweeterVideos()
#HotIf

UploadTweeterVideos() {
  folderPath := "d:\Videos\Twitter\" ; Upload videos from this folder
  totalVideos := 0 ; Count number of files in that folder
  loop files folderPath "*.mp4" ; Count total number of videos
    totalVideos += 1
  ShowMessageBox("Found " totalVideos " videos")
  firstTime := true
  loop files folderPath "*.mp4" { ; Loop through all videos in the folder
    ShowMessageBox("Uploading `"" A_LoopFileName "`"")
    A_Clipboard := StrReplace(A_LoopFileName, ".mp4", "")
    A_Clipboard := StrReplace(A_Clipboard, "(Biden) ", "")
    A_Clipboard := StrReplace(A_Clipboard, "(Canada) ", "")
    A_Clipboard := StrReplace(A_Clipboard, "(Niggers) ", "")
    A_Clipboard := StrReplace(A_Clipboard, "(Palestinians) ", "")
    A_Clipboard := SubStr(A_Clipboard, 5)
    Send(A_Clipboard)
    wc := WinClip()
    wc.Clear()
    wc.SetFiles(A_LoopFileFullPath)
    wc.Paste()
    Sleep(1000)
    Send("^{Enter}")
    while (PixelGetColor(1123, 265) != 0x8DCCF7) { ; Wait for View "File name" button to appear
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
; #HotIf WinActive("ahk_exe Chrome.exe") and InStr(WinGetTitle("A"), "Кровинушка (@krovinushka1) / X")
; Del:: DeleteTweeterPosts()
; #HotIf

; DeleteTweeterPosts() {
;   ; Wait for "Deleting..." message to disappear
;   if (PixelGetColor(1167, 663) == 0xFFFFFF) {
;     ShowMessageBox("Task completed")
;     return
;   }
;   ShowMessageBox("Deleting next post...")
;   Click(1167, 663)
;   Sleep(1000)
;   Click(1000, 673)
;   Sleep(1000)
;   Click(1000, 673)
;   Sleep(1000)
;   DeleteTweeterPosts()
; }

; -------------------------------------------------------------------------------
; ReplyTwitterImages
; -------------------------------------------------------------------------------
; #HotIf WinActive("ahk_exe Chrome.exe") and InStr(WinGetTitle("A"), "on X")
; Ins:: ReplyTwitterImages()
; #HotIf

#HotIf WinActive("ahk_exe Chrome.exe") and InStr(WinGetTitle("A"), "on X")
+!a:: ReplyTwitterImages("America")
+!c:: ReplyTwitterImages("Canada")
+!e:: ReplyTwitterImages("Europe")
+!f:: ReplyTwitterImages("Faggots")
+!g:: ReplyTwitterImages("Globalists")
+!i:: ReplyTwitterImages("Islam")
+!n:: ReplyTwitterImages("Niggers")
+!r:: ReplyTwitterImages("Religion")
#HotIf

ReplyTwitterImages(what) {
  ; folderWindow.Show() ; Folder selection
  ; while (!folderWindow.Value)
  ;   Sleep(1000)
  ; folderPath := "d:\Pictures\Twitter\" MyListBox.Text "\"
  folderPath := "d:\Pictures\Twitter\" what "\"
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
^!b:: ReplyTwitterVideos("Biden")
^!t:: ReplyTwitterVideos("Trudeau")
^!k:: ReplyTwitterVideos("Kamala")
^!p:: ReplyTwitterVideos("Palestinians")
#HotIf

ReplyTwitterVideos(what) {
  if (what = "Biden")
    videos := ["1833823927249834280", "1833823970442772915", "1833824018253726162", "1833824063354986611", "1833824108284461241", "1833824150567186673", "1833824209656508508", "1833824272134832592", "1833824332574802168", "1833824391064436772"]
  if (what = "Canada")
    videos := ["1833824452821303500", "1833824520798388720", "1833824604130795649", "1833824669843038641", "1833824734791774583"]
  if (what = "Kamala")
    videos := ["1833824804056502617", "1833824908113072379", "1833825013201346695", "1833825086190612738", "1833825212615242152", "1833825270257643727", "1833825293255024882", "1833825446837846075", "1833825544011485251", "1833825621614428665", "1833825706469450032", "1833825783246193076", "1833825869371973633", "1833825960954560692", "1833826011571507399", "1833826087354122340", "1833826158174998888", "1833826215355990259", "1833826274482979285", "1833826328946086056", "1833826387662143808"]
  if (what = "Palestinians")
    videos := ["1833826494382006282", "1833826578251362760", "1833826652859556324", "1833826734317117865", "1833826786431385881", "1833826856694362155", "1833826913611038997", "1833826992518516810", "1833835299715096761", "1833835443592548698", "1833835561523540343", "1833835607853858996", "1833835736816033837", "1833835922426638453", "1833836011245228320", "1833836076495933628", "1833836120959807604", "1833836183232614421", "1833836310039048306", "1833836430482645204", "1833836527165616224"]

  loop videos.Length { ; Loop through all videos in the array
    ShowMessageBox("Posting video " A_Index " of " videos.Length)
    A_Clipboard := "Kamala's electorate https://x.com/krovinushka1/status/" videos[A_Index]
    Send(A_Clipboard)
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
  folderPath := "d:\Videos\Rumble3\" ; Upload videos from this folder
  totalVideos := 0 ; Count number of files in that folder
  loop files folderPath "*.mp4" ; Count total number of videos
    totalVideos += 1
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
    Send(A_Clipboard) ; Enter vide file name to upload
    Sleep(1000)
    Send("{Enter}") ; Click Enter to upload
    Sleep(1000)
    Send("{Tab}")
    Sleep(1000)
    A_Clipboard := SubStr(StrReplace(A_LoopFileName, ".mp4", ""), 7)
    Send(A_Clipboard) ; Enter video title
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
    Send(A_Clipboard) ; Enter thumbnail file name to upload
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
  Send("{Enter}")
  Send("g") ; Back 10px border
  Sleep(500)
  Send("{Tab 4}")
  Send("10")
  Click(420, 60)
  Sleep(500)
  Click(20, 140)
  Click(40, 280)
  Send("{Enter}")
  Send("t") ; Enter text
  Sleep(500)
  Send("^{Enter}") ; Back 10px border
  Send("g")
  Send("{Enter}")
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

; -------------------------------------------------------------------------------
; Replacements
; -------------------------------------------------------------------------------
::ss::Slava Lishnevsky
::sss::slishnevsky@gmail.com
::kk::Кровинушка
::kkk::krovinushka1@gmail.com
::ppp::gorLubUlKir1440

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
::lol::LOL
::lmao::LMAO
