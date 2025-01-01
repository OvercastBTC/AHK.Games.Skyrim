#Requires AutoHotkey v2+
#Include ../../Lib/Includes/Basic.ahk
#Include ../../Lib/System/Paths.ahk

class SkyrimCommander {
	static instance := ""
	config := Map()
	guiSC := ""
	
	__New() {
		if SkyrimCommander.instance
			Error("SkyrimCommander is a singleton. Use SkyrimCommander.GetInstance()")
			
		this.LoadConfig()
		this.InitializeGUI()
		this.SetupHotstrings()
		SkyrimCommander.instance := this
		this.guiSC.Show()
	}
	
	static GetInstance() {
		if !SkyrimCommander.instance
			SkyrimCommander.instance := SkyrimCommander()
		return SkyrimCommander.instance
	}
	
	LoadConfig() {
		try {
			; Load locations
			locFile := A_ScriptDir "\config\locations.json"
			if FileExist(locFile) {
				fileContent := FileRead(locFile)
				this.config.Set("locations", cJson.Parse(fileContent).locations)  ; Note the .locations
			} else {
				MsgBox("Location config file not found: " locFile)
			}
			
			; Load quests
			questFile := A_ScriptDir "\config\quests.json"
			if FileExist(questFile) {
				fileContent := FileRead(questFile)
				this.config.Set("quests", cJson.Parse(fileContent).quests)  ; Note the .quests
			} else {
				MsgBox("Quest config file not found: " questFile)
			}
		} catch as err {
			ErrorLogger.Log({
				message: "Failed to load configuration",
				error: err.Message,
				stack: err.Stack
			})
		}
	}
	
	InitializeGUI() {
		this.guiSC := Gui("+Resize +MinSize400x300", "Skyrim Commander")
		
		; Apply dark mode and styling
		this.guiSC.DarkMode()
		this.guiSC.MakeFontNicer(14)
		this.guiSC.NeverFocusWindow()
		
		; Add command input
		this.guiSC.AddText("w200", "Command:")
		this.cmdInput := this.guiSC.AddEdit("w400")
		
		; Add results view
		this.results := this.guiSC.AddListView("w600 h400", ["Command", "Description", "Code"])
		
		; Add quick buttons
		this.btnLocations := this.guiSC.AddButton("w200", "Locations")
		this.btnLocations.OnEvent("Click", (*) => this.ShowLocations())

		this.btnQuests := this.guiSC.AddButton("w200", "Quests")
		this.btnQuests.OnEvent("Click", (*) => this.ShowQuests())

		this.btnHelp := this.guiSC.AddButton("w200", "Help")
		this.btnHelp.OnEvent("Click", (*) => this.ShowHelp())
		
		; Setup events
		this.cmdInput.OnEvent("Change", (*) => this.HandleCommandInput())
		this.results.OnEvent("DoubleClick", (*) => this.ExecuteCommand())

		this.guiSC.Show('AutoSize')
	}
	
	SetupHotstrings() {
		; Location hotstrings
		if this.config.Has("locations") {
			locationData := this.config["locations"]
			if locationData.Has("codes") && locationData.Has("aliases") {
				for location, data in locationData.codes {
					if locationData.aliases.Has(location) {
						for alias in locationData.aliases[location] {
							cleanAlias := RegExReplace(alias, "\s+", "")
							Hotstring(":*:" cleanAlias, this.CreateLocationCallback(location))
						}
					}
				}
			}
		}
		
		; Quest hotstrings
		if this.config.Has("quests") {
			questData := this.config["quests"]
			if questData.Has("data") && questData.Has("aliases") {
				for quest, data in questData.data {
					if questData.aliases.Has(quest) {
						for alias in questData.aliases[quest] {
							cleanAlias := RegExReplace(alias, "\s+", "")
							Hotstring(":*:" cleanAlias, this.CreateQuestCallback(quest))
						}
					}
				}
			}
		}
	}

	CreateLocationCallback(location) {
		return (*) => this.TeleportToLocation(location)
	}

	CreateQuestCallback(quest) {
		return (*) => this.ShowQuestStages(quest)
	}
	
	ShowLocations() {
		if !this.config.Has("locations")
			return
			
		this.results.Delete()
		locationData := this.config["locations"]
		if locationData.Has("codes") {
			for location, data in locationData.codes {
				for subLoc, code in data {
					this.results.Add(,
						"coc " code,
						location " - " subLoc,
						code)
				}
			}
		}
	}
	
	ShowQuests() {
		if !this.config.Has("quests")
			return
			
		this.results.Delete()
		questData := this.config["quests"]
		if questData.Has("data") {
			for quest, data in questData.data {
				for stage, desc in data.stages {
					this.results.Add(,
						"setstage " data.id " " stage,
						desc,
						data.id)
				}
			}
		}
	}

	TeleportToLocation(location) {
		if !WinActive("ahk_exe SkyrimSE.exe")
			return
			
		if this.config.locations.codes.HasOwnProp(location) {
			code := this.config.locations.codes[location].main
			this.SendConsoleCommand("coc " code)
		}
	}
	
	ShowQuestStages(quest) {
		if !this.config.quests.data.HasOwnProp(quest)
			return
			
		questData := this.config.quests.data[quest]
		this.results.Delete()
		
		for stage, desc in questData.stages {
			this.results.Add(, 
				"setstage " questData.id " " stage,
				desc,
				questData.id)
		}
		
		this.guiSC.Show()
	}
	
	SendConsoleCommand(cmd) {
		Clip.BI(1)
		if !WinActive("ahk_exe SkyrimSE.exe"){
			return
		}
		Sleep(100)
		key.SendSC(key.shiftdown key.home key.shiftup)
		Sleep(100)

		key.SendSC(cmd)
		Sleep(500)
		cmd := ''
		Clip.BI(0)
	}
	
	HandleCommandInput() {
		input := this.cmdInput.Value
		if (input = "")
			return
			
		; Parse command
		if RegExMatch(input, "i)^(goto|quest)\s+(.+?)(?:\s+(\d+))?$", &match) {
			type := match[1]
			name := match[2]
			stage := match[3]
			
			this.results.Delete()
			
			if (type = "goto")
				this.ShowLocationMatches(name)
			else if (type = "quest")
				this.ShowQuestMatches(name, stage)
		}
	}
	
	ShowLocationMatches(search) {
		for location, data in this.config.locations.codes {
			if InStr(location, search, true) {
				for subLoc, code in data {
					this.results.Add(,
						"coc " code,
						location " - " subLoc,
						code)
				}
			}
		}
	}
	
	ShowQuestMatches(search, stage := "") {
		for quest, data in this.config.quests.data {
			if InStr(quest, search, true) {
				if stage && data.stages.Has(stage) {
					this.results.Add(,
						"setstage " data.id " " stage,
						data.stages[stage],
						data.id)
				} else {
					for stageNum, desc in data.stages {
						this.results.Add(,
							"setstage " data.id " " stageNum,
							desc,
							data.id)
					}
				}
			}
		}
	}
	
	ExecuteCommand() {
		if (row := this.results.GetNext()) {
			cmd := this.results.GetText(row, 1)
			this.SendConsoleCommand(cmd)
		}
	}
	
	ShowHelp() {
		helpText := "
		(
		Command Format:
		goto <location> - Teleport to location
		quest <name> [stage] - Show or set quest stage
		
		Examples:
		goto whiterun
		quest diplomatic immunity
		quest diplomatic immunity 50
		
		Double click any result to execute the command.
		)"
		
		MsgBox(helpText, "Skyrim Commander Help")
	}
}
