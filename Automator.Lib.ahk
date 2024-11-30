; -------------------------------------------------------------------------------
; Folder selection window
; -------------------------------------------------------------------------------
; SelectCategory() {
;   global window := Gui("AlwaysOnTop")
;   window.SetFont("s10", "Bahnschrift")
;   window.AddText(, "Select category")
;   categories := [] ; Create a new array to hold the names
;   for category in twitterData { ; Loop through each object in the array and add the 'name' property to the 'names' array
;     categories.Push(category.name)
;   }
;   selection := ""
;   listbox := window.AddListBox("r" categories.Length " Choose1 w200", categories)
;   listbox.OnEvent("DoubleClick", (*) => (
;     selection := listbox.Text
;     window.Hide()))
;   button := window.AddButton("Default w80", "OK")
;   button.OnEvent("Click", (*) => (
;     selection := listbox.Text
;     window.Hide()))
;   window.Show()
;   WinWaitClose(window)
;   result := {}
;   for element in twitterData {
;     if (element.name == selection) {
;       result := element
;       break
;     }
;   }

;   return result
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