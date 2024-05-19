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

::aa:: autohotkey v2 ; Shortcut to this text

Color_Primary := "5573B5"
Color_Danger := "BE5A52"
Color_Success := "7CBB5F"
; -------------------------------------------------------------------------------
; ShowMessageBox
; -------------------------------------------------------------------------------
ShowMessageBox(message, color := Color_Primary, hide := true) {
  MyGui := Gui("-Caption")
  MyGui.BackColor := color
  MyGui.SetFont("s20 cWhite", "Bahnschrift")
  MyGui.AddText("Center", message)
  MyGui.Show()
  Sleep(1000)
  if (hide)
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
; PostTwitterPictures
; -------------------------------------------------------------------------------
#HotIf WinActive('ahk_exe Chrome.exe') and InStr(WinGetTitle('A'), 'on X')
^!a:: PostTwitterImages("America")
^!c:: PostTwitterImages("Canada")
^!f:: PostTwitterImages("Faggots")
^!g:: PostTwitterImages("Globalists")
^!i:: PostTwitterImages("Islam")
^!n:: PostTwitterImages("Niggers")
^!r:: PostTwitterImages("Religion")
^!v:: PostTwitterVideos()
#HotIf
PostTwitterImages(folderName) {
  ; MyGui.Show() ; Folder selection
  ; while (!MyGui.Value)
  ;   Sleep(100)
  ; folderName := MyListBox.Text
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
    Sleep(100)
    Send("^{Enter}")
    Sleep(1000)
  }
  ShowMessageBox("Task completed. Posted " totalImages " images.", Color_Success, true)
  Reload()
}

; -------------------------------------------------------------------------------
; PostTwitterVideos
; -------------------------------------------------------------------------------
#HotIf WinActive('ahk_exe Chrome.exe') and InStr(WinGetTitle('A'), 'on X')
^Ins:: PostTwitterVideos()
#HotIf
PostTwitterVideos() {
  messages := [
    ; "Deepshit Muhammads, it's the 21st century, in case you forgot, space exploration, computers, robots, spacecraft, biochemistry, artificial intelligence. But you indoctrinated medieval savages still believe in Allahs and Shaitans.",
    ; "Deepshit Muhammads, do you know how many Arab countries attacked Israel unprovoked in the 6-day war? Egypt, Syria, Jordan, Iraq, Saudi Arabia, Lebanon, Algeria, Kuwait, Sudan, Libya, Morocco, Tunisia, Yemen. Israel alone wiped them all out in 6 days like shit off the floor.",
    ; "Deepshit Muhammads, you, Palestinian terrorists, kidnapped, murdered, burned, raped, beheaded, mutilated Israeli women and babies, and are still holding hostages. You, Palestinians, bring only blood, death and terror wherever you set foot.",
    ; "Those who call themselves Palestinians are not even Arabs. They are scattered gypsies with no origin, fugitives from other Arab countries who have escaped prosecution for their crimes. That's why not a single Arab country wants to take in these Muslim brothers.",
    "Stupid Muhammad, read some other books other than your Allahu Akbar brainwashing crap.`nSoviet Russia, The Creator of the PLO and the Palestinian people https://rumble.com/v4ul6n9-soviet-russia-the-creator-of-the-plo-and-the-palestinian-people.html", ; Soviet Russia, The Creator of the PLO and the Palestinian people
    "The True fase of Islam.`nThe representatives of True Islam https://rumble.com/v4unmou-the-representatives-of-true-islam.html", ; The representatives of True Islam
    "`"Innocent`" Palestinians brurally raped, burned, beheaded, mutilated Jews, they even killed the dogs https://rumble.com/v4vytjt-innocent-palestinians-brurally-raped-burned-beheaded-mutilated-jews-they-ev.html", ; "Innocent" Palestinians brurally raped, burned, beheaded, mutilated Jews, they even killed the dogs
    "Hamas preparing Palestinian victims for Western media https://rumble.com/v4unoac-hamas-preparing-palestinian-victims-for-western-media.html", ; Hamas preparing Palestinian victims for Western media
    "Pallywood falsehoods about the Palestinian victims https://rumble.com/v4vyoq0-pallywood-falsehoods-about-the-palestinian-victims.html", ; Pallywood falsehoods about the Palestinian victims
    "Message from a Saudi Writer to the Palestinians https://rumble.com/v4uk0rb-message-from-a-saudi-writer-to-the-palestinians.html", ; Message from a Saudi Writer to the Palestinians
    "Palestinians teach children to hate and kill Jews https://rumble.com/v4vyqfx-palestinians-teach-children-to-hate-and-kill-jews.html", ; Palestinians teach children to hate and kill Jews
    "Palestine History Museum opens in Israel https://rumble.com/v4unot9-palestine-history-museum-opens-in-israel.html", ; Palestine History Museum opens in Israel
    "Genocide of Who? https://rumble.com/v4unqfn-genocide-of-who.html", ; Genocide of Who?
    "https://x.com/dpenetration24/status/1790887784623845588", ; I hate you and I will kill you for the sake of Allah
    "https://x.com/dpenetration24/status/1791749925543215514", ; Remember this girl?
    "https://x.com/dpenetration24/status/1790889998935531919", ; Mr. Pallywood (Saleh Aljafarawi)
    "https://x.com/dpenetration24/status/1790888966075420841", ; Palestinians filming "killed" child burried under the rubble
    "https://x.com/dpenetration24/status/1790889776171589796", ; Make-up Gaza style
    "https://x.com/dpenetration24/status/1791801033376550945", ; Welcome to Pallywood... staged Palestinian propaganda!
    "https://x.com/dpenetration24/status/1790889101949829435", ; Palestinians begging Muslim brothers for help
  ]
  ShowMessageBox("Found " messages.Length " messages")
  loop messages.Length { ; Loop through all messages in the array
    ShowMessageBox("Posting message " A_Index " of " messages.Length)
    ; SendEvent("r")
    Sleep(1000)
    A_Clipboard := messages[A_Index]
    Send("^{v}")
    Sleep(100)
    Send("^{Enter}")
    Sleep(1000)
  }
  ShowMessageBox("Task completed. Posted " messages.Length " messages.", Color_Success, true)
  Reload()
}

; -------------------------------------------------------------------------------
; PostRumbleVideos
; -------------------------------------------------------------------------------
#HotIf WinActive('ahk_exe Chrome.exe')
^!Ins:: PostRumbleVideos()
#HotIf
PostRumbleVideos() {
  folderPath := "d:\Videos\Web\Rumble" ; Upload videos from this folder
  fileCount := 0 ; Count number of files in that folder
  loop files folderPath "*.mp4"
    fileCount++
  static index := 1 ; File index to start from
  while (index <= fileCount) {
    ShowMessageBox("Uploading next video `"" index "/" fileCount "`"...")
    Click(1757, 154) ; Click Upload button and Upload option
    Sleep(1000)
    Click(1757, 223)
    Sleep(1000)
    Click(517, 540) ; Click Upload area
    Sleep(1000)
    if (index = 1) { ; Set a path to the folder and click Enter, only first time
      Send(folderPath)
      Sleep(1000)
      Send("{Enter}")
      Sleep(1000)
    }
    Send("{Tab 9}") ; Navigate to the next file, copy file name and click Enter
    Sleep(1000)
    if (index = 1) { ; Change view to Details, only first time
      Send("^+6")
      Sleep(1000)
    }
    Send("{Down}")
    Sleep(1000)
    Send("{Up}")
    Sleep(1000)
    Send("{Down " index - 1 "}")
    Sleep(1000)
    Send("{F2}")
    Sleep(1000)
    Send("^c")
    Sleep(1000)
    Send("{Esc}")
    Sleep(1000)
    Send("{Enter}")
    Sleep(1000)
    Click(1085, 330) ; Paste file name into Title field
    Sleep(1000)
    Send(A_Clipboard)
    Sleep(1000)
    Click(1455, 685) ; Click Upload thumbnail area
    Sleep(1000)
    Send("{Tab 9}") ; Navigate to the next file and click Enter
    Sleep(1000)
    Send("{Down}")
    Sleep(1000)
    Send("{Up}")
    Sleep(1000)
    Send("{Down " index - 1 "}")
    Sleep(1000)
    Send("{Enter}")
    Sleep(1000)
    Click(1085, 885) ; Select Rumble channel and click Enter
    Sleep(1000)
    Send("{Down}")
    Sleep(1000)
    Send("{Enter}")
    Sleep(1000)
    Send("{Tab}") ; Scroll to the bottom and click Upload button
    Sleep(1000)
    Click(1480, 1020)
    Sleep(1000)
    Click(1720, 985) ; Check Terms and conditions and click Submit button
    Sleep(1000)
    Click(1720, 1045)
    Sleep(1000)
    Click(1720, 1135)
    Sleep(1000)
    color := PixelGetColor(260, 360) ; Monitor View Video green button (indicator that file uploaded, must wait !!!)
    while (color != 0x567D31) {
      ShowMessageBox("Uploading `"" A_Clipboard "`"...")
      color := PixelGetColor(260, 360)
    }
    index++
  }
  Run("https://rumble.com/c/c-6030257") ; Navigate back to the channel
  Sleep(1000)
  MsgBox("Uploaded " fileCount " videos")
  Reload()
}

; -------------------------------------------------------------------------------
; DeleteRumbleVideos
; -------------------------------------------------------------------------------
#HotIf WinActive('ahk_exe Chrome.exe')
^!Del:: DeleteRumbleVideos()
#HotIf
DeleteRumbleVideos() {
  color := PixelGetColor(1467, 438) ; Monitor if no records left
  if (color = 0xF3F5F8) {
    Run("https://rumble.com/c/c-6030257") ; Navigate back to the channel
    Sleep(1000)
    MsgBox("Deletion completed")
    Reload()
  }
  ShowMessageBox("Deleting next video...")
  Click(1466, 436) ; Click Three dots menu
  Sleep(1000)
  Click(1400, 645) ; Click Delete option (645 coordinate is important, it fits various dropdown menus)
  Sleep(1000)
  Click(1210, 685) ; Click Confirm button
  color := PixelGetColor(1010, 650) ; Monitor View Video green button (indicator that file uploaded)
  while (color = 0xFFFFFF) {
    ShowMessageBox("Deleting video...")
    color := PixelGetColor(1010, 650)
  }
  DeleteRumbleVideos()
}

; -------------------------------------------------------------------------------
; CreateDemotivator
; -------------------------------------------------------------------------------
#HotIf WinActive('ahk_exe FSCapture.exe')
Ins:: CreateDemotivator()
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
  A_Clipboard := "WHAT DO YOU IMAGINE WHEN YOU HEAR THE WORD `"TERRORIST`"?"
  Send("^{v}")
  Sleep(100)
  Send("{Tab}")
  Send("{Enter}")
  Send("g") ; Repeat adding 10px black border
  Send("{Enter}")
  ShowMessageBox("Task completed", Color_Success, true)
}


; -------------------------------------------------------------------------------
; DeleteAuthorizedApps
; -------------------------------------------------------------------------------
#HotIf WinActive('ahk_exe Chrome.exe') and InStr(WinGetTitle('A'), 'Third-party apps & services')
Del:: DeleteAuthorizedApps()
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
#HotIf