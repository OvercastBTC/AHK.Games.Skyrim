#Requires AutoHotkey v2.0
#SingleInstance Force
#Include SkyrimCommands.ahk

class SkyrimCheatGUI {
    VERSION := "1.0.0"
    CATEGORIES := ["Player Stats", "Items", "Spells", "Locations", "Quests", "Combat", "World", "Misc"]
    
    gui := {}
    controls := Map()
    isVisible := false
    commands := Map()
    searchResults := []
    hotkeyHandler := {}
    
    __New(key?, numTaps?) {
        ; Handle key parameter
        key := IsSet(key) ? key : "CapsLock"
        
        ; Handle numTaps parameter
        numTaps := IsSet(numTaps) && IsInteger(numTaps) && numTaps > 0 ? numTaps : 3
        
        ; Initialize CapsLock state if needed
        if (key = "CapsLock") {
            SetCapsLockState("Off")
        }
        
        ; Initialize GUI components
        try {
            this.CreateGUI()
            this.InitializeCommands()
            this.SetupHotkey(key, numTaps)
        } catch Error as err {
            if (key = "CapsLock") {
                SetCapsLockState("Off")
            }
            throw Error("Failed to initialize GUI: " err.Message)
        }
    }

    InitializeCommands() {
        this.commands := Map(
            "Player Stats", Map(
                "Set Health", Map(
                    "cmd", "player.setav health",
                    "desc", "Set player health",
                    "examples", ["player.setav health 1000"]
                ),
                "Set Magicka", Map(
                    "cmd", "player.setav magicka",
                    "desc", "Set player magicka",
                    "examples", ["player.setav magicka 500"]
                )
                ; Add more commands...
            )
        )
    }
    
    SetupHotkey(key, numTaps) {
        try {
            this.hotkeyHandler := MultiTapHandler(key, numTaps, 400, this.ToggleGUI.Bind(this), "Shift")
        } catch Error as err {
            if (key = "CapsLock") {
                SetCapsLockState("Off")
            }
            throw Error("Failed to create hotkey handler: " err.Message)
        }
    }
    
    ShowCommandDetails() {
        if (row := this.controls["results"].GetNext()) {
            cmd := this.controls["results"].GetText(row, 1)
            desc := this.controls["results"].GetText(row, 2)
            example := this.controls["results"].GetText(row, 3)
            
            details := "Command: " cmd "`n"
            details .= "Description: " desc "`n"
            details .= "Example: " example
            
            this.controls["details"].Value := details
        }
    }
    
    CreateGUI() {
        this.gui := Gui("+Resize +MinSize400x300", "Skyrim Console Commands v" this.VERSION)
        
        ; Add search and filter controls
        this.controls["search"] := this.gui.Add("Edit", "w200", "Search...")
        this.controls["search"].OnEvent("Change", this.SearchCommands.Bind(this))
        
        this.controls["category"] := this.gui.Add("DropDownList", "x+10 w150", this.CATEGORIES)
        this.controls["category"].OnEvent("Change", this.FilterByCategory.Bind(this))
        
        ; Add ListView for results
        this.controls["results"] := this.gui.Add("ListView", "xs w600 h400", ["Command", "Description", "Example"])
        this.controls["results"].OnEvent("DoubleClick", this.CopyCommand.Bind(this))
        
        ; Add details view
        this.controls["details"] := this.gui.Add("Edit", "xs w600 h100 ReadOnly", "Select a command to see details")
        
        ; Add status bar
        this.controls["status"] := this.gui.Add("StatusBar",, "Double-click command to copy to clipboard")
        
        ; Set up events
        this.gui.OnEvent("Close", this.ToggleGUI.Bind(this))
        this.gui.OnEvent("Escape", this.ToggleGUI.Bind(this))
        this.controls["results"].OnEvent("ItemSelect", this.ShowCommandDetails.Bind(this))
    }
    
    SearchCommands(*) {
        searchText := this.controls["search"].Value
        category := this.controls["category"].Text
        
        this.controls["results"].Delete()
        
        if this.commands.Has(category) {
            for cmdName, cmdData in this.commands[category] {
                if (searchText = "" || InStr(cmdName cmdData["desc"], searchText, true)) {
                    example := cmdData["examples"][1]
                    this.controls["results"].Add(, cmdData["cmd"], cmdData["desc"], example)
                }
            }
        }
        
        Loop this.controls["results"].GetCount("Column")
            this.controls["results"].ModifyCol(A_Index, "AutoHdr")
    }
    
    FilterByCategory(*) {
        this.SearchCommands()
    }
    
    CopyCommand(*) {
        if (row := this.controls["results"].GetNext()) {
            A_Clipboard := this.controls["results"].GetText(row, 1)
            this.controls["status"].Text := "Command copied to clipboard!"
            SetTimer(() => this.controls["status"].Text := "Double-click command to copy to clipboard", -2000)
        }
    }
    
    ToggleGUI(*) {
        try {
            if (this.isVisible) {
                this.gui.Hide()
                this.isVisible := false
            } else {
                this.gui.Show()
                this.isVisible := true
            }
        } catch Error as err {
            if (this.hotkeyHandler.key = "CapsLock") {
                SetCapsLockState("Off")
            }
            throw err
        }
    }
}

class MultiTapHandler {
    static instances := Map()
    
    key := ""
    taps := 0
    requiredTaps := 0
    timeout := 0
    lastTap := 0
    callback := {}
    modifier := ""
    
    __New(key, numTaps, timeoutMs, callbackFn, modifier := "") {
        this.key := RegExReplace(key, "[{}]", "")
        this.modifier := modifier
        this.requiredTaps := numTaps
        this.timeout := timeoutMs
        this.callback := callbackFn
        
        MultiTapHandler.instances[this.key] := this
        
        HotIf(*) => WinActive('ahk_exe SkyrimSE.exe')
        try {
            hotkeyStr := this.modifier ? this.modifier " & " this.key : this.key
            Hotkey(hotkeyStr, this.HandleTap.Bind(this))
        } catch Error as err {
            if (this.key = "CapsLock") {
                SetCapsLockState("Off")
            }
            throw Error("Failed to create hotkey: " err.Message)
        }
    }
    
    HandleTap(*) {
        currentTime := A_TickCount
        
        if (currentTime - this.lastTap > this.timeout) {
            this.taps := 0
        }
        
        this.taps++
        
        try {
            if (this.taps = this.requiredTaps) {
                this.callback.Call()
                this.taps := 0
            }
        } catch Error as err {
            if (this.key = "CapsLock") {
                SetCapsLockState("Off")
            }
            throw err
        }
        
        this.lastTap := currentTime
    }
    
    __Delete() {
        try {
            HotIf(*) => WinActive('ahk_exe SkyrimSE.exe')
            hotkeyStr := this.modifier ? this.modifier " & " this.key : this.key
            Hotkey(hotkeyStr, "Off")
        }
        if (this.key = "CapsLock") {
            SetCapsLockState("Off")
        }
        MultiTapHandler.instances.Delete(this.key)
    }
}

; Create instance of SkyrimCheatGUI when script runs
SkyrimCheatGUI()
