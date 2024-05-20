#Requires AutoHotkey v2
#SingleInstance
#Include WinClipAPI.ahk
#Include WinClip.ahk

; -------------------------------------------------------------------------------
; Kills AutoHotkey process
; -------------------------------------------------------------------------------
#HotIf ProcessExist("AutoHotkey64.exe")
^Esc:: Reload()
#HotIf

::ahk:: AutoHotkey v2 ; Shortcut to this text
::sli:: slishnevsky@gmail.com ; Shortcut to this text
::dp:: dpenetration23@gmail.com ; Shortcut to this text

Color_Primary := "5573B5"
Color_Danger := "BE5A52"
Color_Success := "7CBB5F"
; -------------------------------------------------------------------------------
; ShowMessageBox
; -------------------------------------------------------------------------------
ShowMessageBox(message, completed := false) {
  MyGui := Gui("-Caption")
  MyGui.BackColor := completed ? Color_Success : Color_Danger
  MyGui.SetFont("s20 cWhite", "Bahnschrift")
  MyGui.AddText("Center", message)
  MyGui.Show()
  Sleep(completed ? 3000 : 1000)
  MyGui.Hide()
}

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
  position := CaretGetPos(&X, &Y)
  folderPath := "d:\Pictures\Web\" folderName
  totalImages := 0
  loop files folderPath "\*.png" ; Count total number of images
    totalImages += 1
  ShowMessageBox("Found " totalImages " images")
  loop files folderPath "\*.png" { ; Loop through all images in the folder
    ; Get current position
    ShowMessageBox("Posting image " A_Index " of " totalImages)
    wc := WinClip()
    wc.Clear()
    wc.SetBitmap(A_LoopFilePath)
    wc.Paste()
    Sleep(1000)
    Send("^{Enter}")
    Sleep(1000)
  }
  ShowMessageBox("Task completed. Posted " totalImages " images.", true)
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
    "Soviet Russia, The Creator of the PLO and the Palestinian people https://www.youtube.com/watch?v=qAm00onkJCo", ; Soviet Russia, The Creator of the PLO and the Palestinian people
    "Message from a Saudi Writer to the Palestinians https://www.youtube.com/watch?v=KubPCfmEXyw", ; Message from a Saudi Writer to the Palestinians
    "Pallywood: Truth and falsehoods about the Israeli-Palestinian conflict https://www.youtube.com/watch?v=2OJpZVSssSI" ; Pallywood: Truth and falsehoods about the Israeli-Palestinian conflict
    "https://x.com/dpenetration24/status/1790854460966678585", ; The representatives of True Islam
    "https://x.com/dpenetration24/status/1790887784623845588", ; I hate you and I will kill you for the sake of Allah
    "https://x.com/dpenetration24/status/1791749925543215514", ; Remember this girl?
    "https://x.com/dpenetration24/status/1790888626802270379", ; Canada under Trudeau's regime
    "https://x.com/dpenetration24/status/1792596398996623668", ; Part1: How "innocent" Palestinians brutally raped, burned, beheaded, mutilated Jews, they even killed the dogs
    "https://x.com/dpenetration24/status/1792596618849464334", ; Part2: How "innocent" Palestinians brutally raped, burned, beheaded, mutilated Jews, they even killed the dogs
    "https://x.com/dpenetration24/status/1790888805446132110", ; Palestinians teach children how to hate and kill Jews
    "https://x.com/dpenetration24/status/1792575035128848718", ; Palestinians preparing "victims" for Western media
    "https://x.com/dpenetration24/status/1790888966075420841", ; Palestinians filming "killed" child burried under the rubble
    "https://x.com/dpenetration24/status/1790889776171589796", ; Make-up Gaza style
    "https://x.com/dpenetration24/status/1790889998935531919", ; Mr. Pallywood (Saleh Aljafarawi)
    "https://x.com/dpenetration24/status/1791801033376550945", ; Welcome to Pallywood... staged Palestinian propaganda!
    "https://x.com/dpenetration24/status/1790889464857801163", ; Palestine History Museum opens in Israel
    "https://x.com/dpenetration24/status/1790891021829636261", ; Genocide of Who?
    "https://x.com/dpenetration24/status/1790889101949829435", ; Palestinians begging Muslim brothers for help
  ]
  ShowMessageBox("Found " messages.Length " messages")
  loop messages.Length { ; Loop through all messages in the array
    ShowMessageBox("Posting message " A_Index " of " messages.Length)
    A_Clipboard := messages[A_Index]
    Send("^{v}")
    Sleep(1000)
    Send("^{Enter}")
    Sleep(1000)
  }
  ShowMessageBox("Task completed. Posted " messages.Length " messages.", true)
  Reload()
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
  A_Clipboard := "ENTER YOUR TEXT HERE?"
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
#HotIf WinActive('ahk_exe Chrome.exe')
^!d:: DeleteRumbleVideos()
#HotIf
DeleteRumbleVideos() {
  color := PixelGetColor(1467, 438) ; Monitor if no records left
  if (color = 0xF3F5F8) {
    Run("https://rumble.com/c/c-6030257") ; Navigate back to the channel
    Sleep(1000)
    ShowMessageBox("Task completed", true)
    Reload()
  }
  ShowMessageBox("Deleting next video...")
  Click(1866, 504) ; Click Three dots menu
  Sleep(1000)
  Click(1815, 711) ; Click Delete option (711 coordinate is important, borderline between 5 and 6 menu items)
  Sleep(1000)
  Click(1210, 685) ; Click Confirm button
  Sleep(13000)
  DeleteRumbleVideos()
}

; -------------------------------------------------------------------------------
; DeleteAuthorizedApps
; -------------------------------------------------------------------------------
#HotIf WinActive('ahk_exe Chrome.exe') and InStr(WinGetTitle('A'), 'Third-party apps & services')
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