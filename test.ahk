
#Requires Autohotkey v2
;AutoGUI creator: Alguimist autohotkey.com/boards/viewtopic.php?f=64&t=89901
;AHKv2converter creator: github.com/mmikeww/AHK-v2-script-converter
;EasyAutoGUI-AHKv2 github.com/samfisherirl/Easy-Auto-GUI-for-AHK-v2

if A_LineFile = A_ScriptFullPath && !A_IsCompiled
{
	myGui := Constructor()
	myGui.Show("w216 h166")
}

Constructor()
{	
	myGui := Gui()
	LV_ := myGui.Add("ListView", "x8 y8 w200 h150", ["ListView"])
	LV_.Add(,"Sample1")
	LV_.OnEvent("DoubleClick", LV_DoubleClick)
	myGui.OnEvent('Close', (*) => ExitApp())
	myGui.Title := "Window"
	
	LV_DoubleClick(LV, RowNum)
	{
		if not RowNum
			return
		ToolTip(LV.GetText(RowNum), 77, 277)
		SetTimer () => ToolTip(), -3000
	}
	
	return myGui
}