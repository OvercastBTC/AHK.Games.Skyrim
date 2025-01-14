class SkyrimCommands {
    ; Command Categories
    static Categories := Map(
        "player", "Player Stats & Abilities",
        "items", "Items & Inventory",
        "world", "World & Environment",
        "quest", "Quests & Story",
        "npc", "NPCs & Characters", 
        "combat", "Combat & Abilities",
        "camera", "Camera & Display",
        "debug", "Debug & Testing"
    )

    ; Command Type Definitions
    static Types := Map(
        "toggle", "Toggle Command",
        "value", "Value Command", 
        "target", "Target Command",
        "spawn", "Spawn Command"
    )

    ; Main Commands Database
    static Commands := Map(
        ; Player Stats & Character
        "player.setav", {
            category: "player",
            type: "value",
            syntax: "player.setav <stat> <value>",
            desc: "Set player attribute/skill to specific value",
            params: Map(
                "stat", ["health", "magicka", "stamina", "onehanded", "twohanded", "marksman", "block",
                        "smithing", "heavyarmor", "lightarmor", "pickpocket", "lockpicking", "sneak",
                        "alchemy", "speech", "alteration", "conjuration", "destruction", "illusion", 
                        "restoration", "enchanting"],
                "value", "number"
            ),
            examples: [
                "player.setav health 1000",
                "player.setav onehanded 100"
            ]
        },

        "player.modav", {
            category: "player",
            type: "value", 
            syntax: "player.modav <stat> <value>",
            desc: "Modify player attribute/skill by amount",
            params: Map(
                "stat", ["health", "magicka", "stamina", "onehanded", "twohanded", "marksman", "block",
                        "smithing", "heavyarmor", "lightarmor", "pickpocket", "lockpicking", "sneak",
                        "alchemy", "speech", "alteration", "conjuration", "destruction", "illusion",
                        "restoration", "enchanting"],
                "value", "number"
            ),
            examples: [
                "player.modav health 500",
                "player.modav magicka 250"
            ]
        },

        ; Items & Inventory
        "player.additem", {
            category: "items",
            type: "value",
            syntax: "player.additem <code> <quantity>",
            desc: "Add items to player inventory",
            params: Map(
                "code", "item_id",
                "quantity", "number"
            ),
            examples: [
                "player.additem f 1000",  ; Add gold
                "player.additem 0001392B 10"  ; Add iron ingots
            ]
        },

        ; World & Environment Commands
        "set gamehour", {
            category: "world",
            type: "value",
            syntax: "set gamehour to <hour>",
            desc: "Set time of day",
            params: Map(
                "hour", "0-24"
            ),
            examples: [
                "set gamehour to 12",
                "set gamehour to 0"
            ]
        },

        ; Toggle Commands
        "tgm", {
            category: "debug",
            type: "toggle",
            syntax: "tgm",
            desc: "Toggle God Mode",
            examples: ["tgm"]
        },

        "tcl", {
            category: "debug",
            type: "toggle",
            syntax: "tcl",
            desc: "Toggle Collision/Noclip",
            examples: ["tcl"]
        },

        ; Teleport & Movement
        "coc", {
            category: "world",
            type: "value",
            syntax: "coc <LocationID>",
            desc: "Teleport to location",
            params: Map(
                "LocationID", ["WhiterunDragonsreach", "RiftenRaggedFlagon", "SolitudeBluePlace", 
                             "WindhelmPalace", "MarkarthKeep", "DawnstarExterior01"]
            ),
            examples: [
                "coc WhiterunDragonsreach",
                "coc RiftenRaggedFlagon"
            ]
        },

        ; Quest Commands
        "setstage", {
            category: "quest",
            type: "value",
            syntax: "setstage <QuestID> <stage>",
            desc: "Set quest progress stage",
            params: Map(
                "QuestID", "quest_id",
                "stage", "number"
            ),
            examples: [
                "setstage MQ101 100",
                "setstage MQ201 50"
            ]
        },

        ; NPC Commands
        "setessential", {
            category: "npc",
            type: "target",
            syntax: "setessential <BaseID> <flag>",
            desc: "Set NPC essential status (immortal)",
            params: Map(
                "BaseID", "npc_id",
                "flag", ["0", "1"]
            ),
            examples: [
                "setessential 00001A4D 1",
                "setessential 00001A4D 0"
            ]
        },

        ; Combat Commands
        "kill", {
            category: "combat",
            type: "target",
            syntax: "kill",
            desc: "Kill targeted NPC/creature",
            examples: ["kill"]
        },

        "killall", {
            category: "combat",
            type: "target",
            syntax: "killall",
            desc: "Kill all NPCs in area",
            examples: ["killall"]
        }
    )

    ; Helper Methods for GUI Integration
    static GetCategoryCommands(category) {
        categoryCommands := Map()
        for cmdName, cmdData in this.Commands {
            if (cmdData.category == category)
                categoryCommands[cmdName] := cmdData
        }
        return categoryCommands
    }

    static GetCommandsByType(type) {
        typeCommands := Map()
        for cmdName, cmdData in this.Commands {
            if (cmdData.type == type)
                typeCommands[cmdName] := cmdData
        }
        return typeCommands
    }

    static SearchCommands(searchTerm) {
        results := Map()
        for cmdName, cmdData in this.Commands {
            if (InStr(cmdName, searchTerm) || InStr(cmdData.desc, searchTerm))
                results[cmdName] := cmdData
        }
        return results
    }

    ; GUI Helper Methods
    static PopulateComboBox(ComboBox, dataSource) {
        items := []
        for key, value in dataSource {
            items.Push(key)
        }
        ComboBox.Add(items)
    }

    static PopulateListView(ListView, commands) {
        ListView.Delete()
        for cmdName, cmdData in commands {
            ListView.Add(, cmdName, cmdData.desc, cmdData.type)
        }
        ListView.ModifyCol()  ; Auto-size columns
    }

    ; Example Usage:
    /*
    ; Create GUI elements
    categoryCombo := gui.Add("ComboBox", "w200", SkyrimCommands.Categories)
    commandList := gui.Add("ListView", "w400 h300", ["Command", "Description", "Type"])

    ; Populate initial data
    SkyrimCommands.PopulateComboBox(categoryCombo, SkyrimCommands.Categories)
    
    ; Handle category selection
    categoryCombo.OnEvent("Change", (*) => 
        SkyrimCommands.PopulateListView(commandList, 
            SkyrimCommands.GetCategoryCommands(categoryCombo.Text))
    )
    */
}
