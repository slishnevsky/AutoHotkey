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
#Esc:: Reload ; Restart AutoHotkey app
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
    "Soviet Russia, The Creator of the PLO and the Palestinian people https://rumble.com/v4zryxn-soviet-russia-the-creator-of-the-plo-and-the-palestinian-people.html", 
    "How innocent Palestinians brutally raped, burned, beheaded and mutilated Israelis https://rumble.com/v4zrrir-how-innocent-palestinians-brutally-raped-burned-beheaded-and-mutilated-isra.html", 
    "Palestinians preparing victims for Western media https://rumble.com/v4zrqru-palestinians-preparing-victims-for-western-media.html", 
    "Послание Саудовского писателя Равафа аль-Саина Палестинцам https://rumble.com/v4zrq6t-301944917.html", 
    "Message from a Saudi Writer Rawaf al-Saeen to the Palestinians https://rumble.com/v4zrprl-message-from-a-saudi-writer-to-the-palestinians.html", 
    "Canada under Trudeau's regime https://rumble.com/v4zrv06-canada-under-trudeaus-regime.html", 
    "Canadian reporter woman is brutally attacked by Hamas Antifa mob in front of the Police https://rumble.com/v54x4yo-canadian-reporter-woman-is-brutally-attacked-by-hamas-antifa-mob-in-front-o.html", 
    "Brainwashed Canadian muzzle slaves https://rumble.com/v4zryhr-brainwashed-canadian-muzzle-slaves.html", 
    "Андрей Илларионов - Битва за Цивилизацию https://rumble.com/v5amnnh-320184125.html?e9s=src_v1_ucp", 
    "Andrey Illarionov - A Battle for Civilization https://rumble.com/v5amnpv-andrey-illarionov-a-battle-for-civilization.html", 
    "Андрей Илларионов - Андрей Илларионов на Радио Свобода https://rumble.com/v5amo31-320184685.html?e9s=src_v1_ucp", 
    "Andrey Illarionov - Andrey Illarionov on Radio Liberty https://rumble.com/v5amo39-andrey-illarionov-andrey-illarionov-on-radio-liberty.html", 
    "Western Civilization is in MORTAL DANGER https://rumble.com/v5cbjec-western-civilization-is-in-mortal-danger.html", 
    "World's Deadliest Female Sniper - Lyudmila Pavlichenko https://rumble.com/v5aqhro-worlds-deadliest-female-sniper-lyudmila-pavlichenko.html", 
    "Британцы были предупреждены 18 лет назад https://rumble.com/v5assd9--18-.html", 
    "The Brits have been warned 18 years ago https://rumble.com/v5asu3e-the-brits-have-been-warned-18-years-ago.html", 
    "Томми Робинсон - Обращение Томми Робинсона https://rumble.com/v5aji85-320037125.html", 
    "Tommy Robinson - Message from Tommy Robinson https://rumble.com/v5ajiad-islamofascist-uk-government-persecutes-native-english-people.html", 
    "Томми Робинсон - ВЕЛИКОБРИТАНИЯ АТАКОВАНА https://rumble.com/v59xltn-319015355.html", 
    "Tommy Robinson - GREAT BRITAIN is UNDER ATTACK https://rumble.com/v59xb8b-tommy-robinson-speaks-out-amidst-uk-unrest.html", 
    "Biden at White House pedophile concert https://rumble.com/v5ab0z1-biden-at-white-house-pedophile-concert.html", 
    "Biden the Enemy of The United States https://rumble.com/v52ylfy-joe-biden-enemy-of-the-united-states.html", 
    "Biden's speech for the Black students at the Black college https://rumble.com/v54e2z3-bidens-speech-for-the-black-students-at-the-black-college.html", 
    "Biden spewing hatred and insults towards Republicans and Trump https://rumble.com/v576bc5-biden-spewing-hatred-and-insults-towards-republicans-and-trump.html", 
    "The Racist History of Joe Biden https://rumble.com/v561sbe-the-racist-history-of-joe-biden.html", 
    "The children of Gaza are suffering. Donate us money! https://rumble.com/v52e8u0-the-children-of-gaza-are-suffering.-donate-us-money.html", 

    "https://x.com/krovinushka1/status/1827723774889718082", ; Representatives of True Islam
    "https://x.com/krovinushka1/status/1827723925947547881", ; True face of Islam
    "https://x.com/krovinushka1/status/1827724409504780548", ; Kurdish Islamist drinks hot camel urine because his prophet drank it
    "https://x.com/krovinushka1/status/1827737411045982239", ; Palestinians celebrating 911 terrorist attack on the United States
    "https://x.com/krovinushka1/status/1827737844028170725", ; Palestinians chanting If you have a rifle and you only shoot it at weddings, then go kill a Jew or give the weapon to Hamas
    "https://x.com/krovinushka1/status/1827738014853804298", ; Palestinians teach children to hate and kill Jews
    "https://x.com/krovinushka1/status/1827724341410455986", ; Shameless lie about famine in Gaza
    "https://x.com/krovinushka1/status/1827725231995212287", ; Innocent Palestinians 1 (October 7th footage)
    "https://x.com/krovinushka1/status/1827725421464674754", ; Innocent Palestinians 2 (October 7th footage)
    "https://x.com/krovinushka1/status/1827725554881376342", ; Innocent Palestinians 3 (October 7th footage)
    "https://x.com/krovinushka1/status/1827738396598362430", ; Uninvolved Gazan civilians (October 7th footage)
    "https://x.com/krovinushka1/status/1827739261140947408", ; Genocide of Who?
    "https://x.com/krovinushka1/status/1827739586568548661", ; Геноцид Кого?
    "https://x.com/krovinushka1/status/1827740692182876209", ; America under Biden's regime
    "https://x.com/krovinushka1/status/1827741050355515620", ; Canada under Trudeau's regime
    "https://x.com/krovinushka1/status/1827743898082427128", ; Canadian Police serving hot lunch to Palestinian terrorists

    "https://x.com/krovinushka1/status/1827739787832222117", ; Mister Pallywood Saleh Aljafarawi
    "https://x.com/krovinushka1/status/1827739988714217773", ; Palestinians begging Muslim brothers for help
    "https://x.com/krovinushka1/status/1827740112186216694", ; Palestine History Museum opens in Israel
    "https://x.com/krovinushka1/status/1827740332508725581", ; В Израиле открылся Музей истории Палестины
    "https://x.com/krovinushka1/status/1827740471667425700", ; Hamas supporter they have been waiting for
    "https://x.com/krovinushka1/status/1827738657916104755", ; 50 pounds of fresh Palestinian child
    "https://x.com/krovinushka1/status/1827738842843017686", ; 50 фунтов Палестинского младенца
    "https://x.com/krovinushka1/status/1827744243990802435", ; Heroic Hamas finally burned down Israeli tank

    "https://x.com/krovinushka1/status/1827741470264086806", ; Diversity, Kamala's electorate 1
    "https://x.com/krovinushka1/status/1827741827379716159", ; Diversity, Kamala's electorate 2
    "https://x.com/krovinushka1/status/1827742068799844521", ; Diversity, Kamala's electorate 3
    "https://x.com/krovinushka1/status/1827742376246354143", ; Diversity, Kamala's electorate 4
    "https://x.com/krovinushka1/status/1827742635383046288", ; Diversity, Kamala's electorate 5
    "https://x.com/krovinushka1/status/1827742693532811705", ; Diversity, Kamala's electorate 6
    "https://x.com/krovinushka1/status/1827745074710532366", ; Diversity, Kamala's electorate 7

    "https://x.com/krovinushka1/status/1827742994969100594", ; Trudeau's Pedophile Parade, Toronto 1
    "https://x.com/krovinushka1/status/1827743289421807989", ; Trudeau's Pedophile Parade, Toronto 2
    "https://x.com/krovinushka1/status/1827743352105615748", ; Trudeau's Pedophile Parade, Toronto 3

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
  ; Sleep(500)
  Send("{Enter}")
  Send("g") ; Back 10px border
  Sleep(500)
  Send("{Tab 4}")
  Send("10")
  Click(420, 60)
  Sleep(500)
  Click(20, 140)
  Click(40, 280)
  ; Sleep(500)
  Send("{Enter}")
  Send("t") ; Enter text
  Sleep(500)
  ; Send("^a")
  ; Sleep(500)
  ; Send(A_Clipboard)
  ; Sleep(500)
  Send("^{Enter}") ; Back 10px border
  ; Sleep(500)
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
