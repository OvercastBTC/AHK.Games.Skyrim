﻿#Requires AutoHotkey v2.0+
#SingleInstance Force
SetWorkingDir('C:\Users\Overcast\AppData\Local\Programs\AutoHotkey\v2\AHK.Projects.v2\Skyrim')
; SendMode("Event")
; SetKeyDelay(1, 50)
#Requires AutoHotkey v2.0+
; #Include <Includes\Basic>
#Include ../../Lib/Includes/Basic.ahk
#Include ../../Lib/System/Paths.ahk
#Include SkyrimCommander.ahk

/**
 * @link https://www.autohotkey.com/docs/v2/KeyList.htm#Controller
 */

; Development hotkeys
#HotIf WinActive(A_ScriptName)
~^s::Reload()
#HotIf


#HotIf WinActive('ahk_exe SkyrimSE.exe')
Joy6::{
	if GetKeyState('{Joy6 Down}'){
		if GetKeyState('{Joy5 Down}'){
			buyorsell()
		}
	}
}

#/::buyorsell()
buyorsell(){
	Key.SendSC('{Enter}')
	Sleep(100)
	; Send('{PgDn 7}')
	Key.SendSC('{Home}')
	Sleep(100)
	Key.SendSC('{Enter}')
}


^Esc::Reload

#HotIf


; Major Cities
:X*C1B0:goto whiterun::SendCommand("coc Whiterun")
:X*C1B0:goto solitude::SendCommand("coc Solitude")
:X*C1B0:goto windhelm::SendCommand("coc Windhelm")
:X*C1B0:goto riften::SendCommand("coc RiftenOrigin")
:X*C1B0:goto markarth::SendCommand("coc MarkarthOrigin")
:X*C1B0:goto falkreath::SendCommand("coc FalkreathExterior01")
:X*C1B0:goto morthal::SendCommand("coc MorthalExterior01")
:X*C1B0:goto dawnstar::SendCommand("coc DawnstarExterior01")
:X*C1B0:goto winterhold::SendCommand("coc WinterholdCollegeArcanaeum")

; Player Homes
:X*C1B0:goto breezehome::SendCommand("coc WhiterunBreezehome")
:X*C1B0:goto proudspire::SendCommand("coc SolitudeProudspireManor")
:X*C1B0:goto vlindrel::SendCommand("coc MarkarthVlindrelHall")
:X*C1B0:goto hjerim::SendCommand("coc WindhelmHjerim")
:X*C1B0:goto honeyside::SendCommand("coc RiftenHoneyside")

; Hearthfire Homes
:X*C1B0:goto lakeview::SendCommand("coc BYOHHouse1Exterior")
:X*C1B0:goto windstad::SendCommand("coc BYOHHouse2Exterior")
:X*C1B0:goto heljarchen::SendCommand("coc BYOHHouse3Exterior")

; Whiterun Locations
:X*C1B0:goto whiterun forge::SendCommand("coc WhiterunForge")
:X*C1B0:goto dragonsreach::SendCommand("coc WhiterunDragonsreach")
:X*C1B0:goto bannered mare::SendCommand("coc WhiterunBanneredMare")
:X*C1B0:goto whiterun temple::SendCommand("coc WhiterunTempleOfKynareth")
:X*C1B0:goto jorrvaskr::SendCommand("coc JorrvaskrExterior")
:X*C1B0:goforge::
:X*C1B0:go forge::
:X*C1B0:goto forge::SendCommand("player.moveto 0300c64b") 				;! Lakeview Manor - forge
:X*C1B0:go sleep::
:X*C1B0:goto sleep::
:X*C1B0:goto bed::SendCommand("player.moveto 030050de") 				;! Lakeview Manor - bed
:X*C1B0:goto enc::SendCommand("player.moveto 0300b568") 				;! Lakeview Manor - enchanter

:X*C1B0:go home::
:X*C1B0:go out::SendCommand("coc BYOHHouse1Exterior") 		;! Lakeview Manor


; Crafting Materials 
:X*C1B0:add iron::addMats("5ACE4")
:X*C1B0:add steel::addMats("5ACE5")
:X*C1B0:add silver::addMats("5ACE3")
:X*C1B0:add dwarven::addMats("DB8A2")
:X*C1B0:add ebony::addMats("5AD9D")

:X*C1B0:add glass::addMats('03005a69')
:X*C1B0:add orichalcum::addMats("5AD99")
:X*C1B0:add moonstone::addMats("5AD9E")
:X*C1B0:add malachite::addMats("5AD9F")
:X*C1B0:add corundum::addMats("5AD93")
:X*C1B0:add quicksilver::addMats("5AD9C")

; Special Materials
:X*C1B0:add dragonscale::addMats("3ada3", 50)
:X*C1B0:add dragonbone::addMats("3ada4", 50)
:X*C1B0:add daedra hearts::addMats("3ad80", 50)
:X*C1B0:add leather::addMats("DB5D2")
:X*C1B0:add strips::addMats("800E4")
:X*C1B0:add ingots::AddAllIngots()
:X*C1B0:add forge::AddAllForge()

; House Building Materials
:X*C1B0:add clay::addMats("03003043")
:X*C1B0:add stone::addMats("0300306c")
:X*C1B0:add logs::
:X*C1B0:add lumber::addMats("0300300e")
:X*C1B0:add nails::addMats("300f")
:X*C1B0:add hinges::addMats("03003011")
:X*C1B0:add locks::addMats("03003012")
:X*C1B0:add slaughterfish s::addMats("3ad80", 50) ; Slaughterfish scales
:X*C1B0:add amulets::{
	addMats("c8911", 1) ; Amulet of Akatosh
	Send('{Enter}')
	Sleep(100)
	addMats("cc848", 1) ; Amulet of Arkay
	Send('{Enter}')
	Sleep(100)
	addMats("c8915", 1) ; Amulet of Dibella
	Send('{Enter}')
	Sleep(100)
	addMats("c8917", 1) ; Amulet of Julianos
	Send('{Enter}')
	Sleep(100)
	; ---------------------------------------------------------------------------
	addMats("c8919", 1) ; Amulet of Kynareth
	Send('{Enter}')
	Sleep(100)
	addMats("68523", 1) ; Flawless Sapphire
	Send('{Enter}')
	Sleep(100)
	; ---------------------------------------------------------------------------
	addMats("c891b", 1) ; Amulet of Mara
	Send('{Enter}')
	Sleep(100)
	addMats("cc844", 1) ; Amulet of Stendarr
	Send('{Enter}')
	Sleep(100)
	addMats("878bb", 1) ; Amulet of Zenithar
	Send('{Enter}')
}
:X*C1B0:add kynareth::(addMats("c8919", 1),Send('{Enter}'), Sleep(100), addMats('68523', 10), Send('{Enter}')) ; Amulet of Kynareth & Flawless Sapphire
:X*C1B0:add flawless sapphire::
:X*C1B0:add fsapphire::
:X*C1B0:add sapphire.f::(addMats('68523', 10), Send('{Enter}')) ; Flawless Sapphire
:X*C1B0:add stendarr::(addMats("c89cc", 1), Send('{Enter}')) ; Amulet of Stendarr

; Extra
:X*C1B0:add gold::addMats('f', 1000000)
:X*C1B0:add slaughterfish e::addMats("7e8c5", 50) ; Slaughterfish eggs

; Ore hotstrings
:X*C1B0:o.iron::AddMaterial(Materials.Ores["iron"])
:X*C1B0:o.steel::AddMaterial(Materials.Ores["steel"])
:X*C1B0:o.silver::AddMaterial(Materials.Ores["silver"])
:X*C1B0:o.dwarven::AddMaterial(Materials.Ores["dwarven"])
:X*C1B0:o.ebony::AddMaterial(Materials.Ores["ebony"])
:X*C1B0:o.orichalcum::AddMaterial(Materials.Ores["orichalcum"])
:X*C1B0:o.moonstone::AddMaterial(Materials.Ores["moonstone"])
:X*C1B0:o.malachite::AddMaterial(Materials.Ores["malachite"])
:X*C1B0:o.corundum::AddMaterial(Materials.Ores["corundum"])
:X*C1B0:o.quicksilver::AddMaterial(Materials.Ores["quicksilver"])
:X*C1B0:o.stalhrim::AddMaterial(Materials.Ores['stalhrim'])

; Special materials hotstrings
:X*C1B0:s.dragonscale::AddMaterial(Materials.SpecialMaterials["dragonscale"])
:X*C1B0:s.dragonbone::AddMaterial(Materials.SpecialMaterials["dragonbone"])
:X*C1B0:s.daedraheart::AddMaterial(Materials.SpecialMaterials["daedra_heart"])
:X*C1B0:add void::AddMaterial(Materials.SpecialMaterials["void_salts"])
:X*C1B0:s.voidsalts::AddMaterial(Materials.SpecialMaterials["void_salts"])
:X*C1B0:s.firesalts::AddMaterial(Materials.SpecialMaterials["fire_salts"])
:X*C1B0:s.frostsalts::AddMaterial(Materials.SpecialMaterials["frost_salts"])

; Add all materials hotstring
:X*C1B0:smithing.all::AddAllMaterials()

; Quest Helper
:X*C1B0:show quests::ShowQuestInfo()

SendCommand(cmd:='') {

	Sleep(100)

	Send('{sc2a down}{sc147}{sc2a Up}') 	; @hotkey shift & home 	(+home)
	Sleep(100)
	
	Clip.Send(cmd)
	Sleep(100)
	
	Send('{Enter}')
	Sleep(100)
	Send('~')
	Sleep(500)
}

addMats(code, defaultQty := 50) {

	qty := defaultQty
    
    cmd := "player.additem " code " " qty

    SendCommand(cmd)
}

AddAllIngots() {
    ingots := [
        "5ACE5",  ; Iron
        "5ACE4",  ; Steel
        "5ACE3",  ; Silver
        "DB8A2",  ; Dwarven
        "5AD9D",  ; Ebony
        "5AD99",  ; Orichalcum
        "5AD9E",  ; Moonstone
        "5AD9F",  ; Malachite
        "5AD93",  ; Corundum
        "5AD9C"   ; Quicksilver
    ]
    
    for code in ingots
        SendCommand("player.additem " code " 500")
}

AddAllForge() {
    AddAllIngots()
    SendCommand("player.additem 3AD5B 50")  ; Daedra Hearts
    SendCommand("player.additem DB5D2 500") ; Leather
    SendCommand("player.additem 800E4 500") ; Leather Strips
}

ShowQuestInfo() {
    static questGui := 0

    ; If GUI already exists, just show it
    if (questGui && WinExist(questGui.Hwnd)) {
        questGui.Show()
        return
    }

    ; Create new GUI
    questGui := Gui("+AlwaysOnTop", "Skyrim Quest Information")
    questGui.DarkMode()
    questGui.MakeFontNicer(14)
    questGui.NeverFocusWindow()

    ; Add tabs for different quest types
    questTabs := questGui.Add("Tab3", "w800 h600", ["Main", "Civil War", "Guilds", "Daedric", "DLC"])

    ; Main Quest Tab
    questTabs.UseTab(1)
    questGui.Add("Text",, "Common Commands:")
    questGui.Add("Text",, "
    (
    player.moveto <RefID> - Teleport to NPC
    prid <RefID> + moveto player - Move NPC to you
    setstage <QuestID> <stage> - Set quest stage
    completequest <QuestID> - Complete entire quest
    showquesttargets - Show all current quest target IDs
    )")

    questGui.Add("Text",, "`nMain Quest Line:")
    questGui.Add("Text",, "
    (
    MQ101 - Unbound (Helgen)
        0 - Start
        100 - Follow Ralof/Hadvar
        200 - Exit Helgen
    
    MQ102 - Before the Storm
        0 - Go to Whiterun
        50 - Talk to Jarl
        100 - Complete

    MQ104 - Bleak Falls Barrow
        100 - Get Dragonstone
        150 - Return to Farengar
        200 - Complete

    MQ106 - The Way of the Voice
        50 - Travel to High Hrothgar
        100 - Meet the Greybeards
        150 - Learn Unrelenting Force
        200 - Complete

    MQ201 - Diplomatic Immunity
        0 - Talk to Delphine
        100 - Get Party Clothes
        200 - Complete Mission
    )")

    ; Civil War Tab
    questTabs.UseTab(2)
    questGui.Add("Text",, "Civil War Questline:")
    questGui.Add("Text",, "
    (
    CW01A - Join Stormcloaks
    CW01B - Join Imperials
        0 - Start
        100 - Complete Oath

    CW02A/B - Message to Whiterun
        0 - Deliver Message
        100 - Return to Leader

    CW03 - Battle for Whiterun
        100 - Start Battle
        200 - Complete Battle
    )")

    ; Guilds Tab
    questTabs.UseTab(3)
    questGui.Add("Text",, "Guild Quests:")
    questGui.Add("Text",, "
    (
    Companions:
    C00 - Take Up Arms
        0 - Join Companions
        20 - Complete Trial
        200 - Full Member

    Thieves Guild:
    TG01 - Taking Care of Business
        0 - Start
        100 - Complete Collections
    TG02 - Loud and Clear
        0 - Start Mission
        200 - Complete Mission

    Dark Brotherhood:
    DB01 - Sanctuary
        0 - Enter Sanctuary
        100 - Complete Initiation
    )")

    ; Daedric Tab
    questTabs.UseTab(4)
    questGui.Add("Text",, "Daedric Quests:")
    questGui.Add("Text",, "
    (
    DA01 - The Break of Dawn (Meridia)
        0 - Find Beacon
        100 - Complete Temple
    
    DA02 - The Black Star (Azura)
        0 - Start
        200 - Complete

    DA04 - Discerning the Transmundane (Hermaeus Mora)
        0 - Start Quest
        100 - Retrieve Blood
        200 - Complete
    )")

    ; DLC Tab
    questTabs.UseTab(5)
    questGui.Add("Text",, "DLC Quests:")
    questGui.Add("Text",, "
    (
    Dawnguard:
    DLC1VQ01 - Dawnguard
        0 - Join Dawnguard
        100 - Complete Training

    Dragonborn:
    DLC2MQ01 - Dragonborn
        0 - Start
        100 - Reach Solstheim
        200 - Complete First Quest

    Hearthfire:
    BYOHHouse1 - Lakeview Manor
    BYOHHouse2 - Windstad Manor
    BYOHHouse3 - Heljarchen Hall
        0 - Purchase Land
        100 - Complete Basic House
    )")

    questTabs.UseTab()  ; End tab section

    ; Add status bar
    questGui.Add("StatusBar",, "Double-click quest ID to copy to clipboard")

    ; Show the GUI
    questGui.Show()
}


; Constants for materials and their codes
class Materials {
	static Ores := Map(
		"iron", "5ACE5",
		"steel", "5ACE4",
		"silver", "5ACE3",
		"dwarven", "DB8A2",
		"ebony", "5AD9D",
		"orichalcum", "5AD99",
		"moonstone", "5AD9E",
		"malachite", "5AD9F",
		"corundum", "5AD93",
		"quicksilver", "5AD9C",
		'stalhrim', '401b06b'
	)
	
	static SpecialMaterials := Map(
		"dragonscale", "3ADA4",
		"dragonbone", "3ADA3",
		"daedra_heart", "3AD5B",
		"void_salts", "3ad60",
		"fire_salts", "3AD5E",
		"frost_salts", "3AD5F"
	)
}

; Location data structure
class Locations {
	static Cities := Map(
		"whiterun", Map(
			1, "BreezeHome",           ; Player house
			2, "Dragonsreach",         ; Keep
			3, "JorvaskrExterior",     ; Companions
			4, "Marketplace",          ; Market
			5, "Banneredmare"          ; Inn
		),
		"solitude", Map(
			1, "ProudspireManor",      ; Player house
			2, "BluePalace",           ; Keep
			3, "CastleDour",           ; Castle
			4, "Marketplace",          ; Market
			5, "Winkingskever"         ; Inn
		),
		"windhelm", Map(
			1, "HjerimInterior",       ; Player house
			2, "PalaceOfKings",        ; Keep
			3, "Marketplace",          ; Market
			4, "CandlehearthHall",     ; Inn
			5, "Docks"                 ; Docks
		)
	)
	
	static GetLocationNames(city) {
		if this.Cities.Has(city)
			return this.Cities[city]
		return Map()
	}
}


; Location hotstrings
; :X*C1:coc.::HandleLocationCommand()

; Functions
AddMaterial(code, quantity := "500") {
	BlockInput(true)
	key.SendSC('+{{Home}')
	A_Clipboard := "player.additem " code " " quantity
	Send("^v")
	BlockInput(false)
	Send("{Left " StrLen(quantity) "}{Shift Down}{Right " StrLen(quantity) "}{Shift Up}")
}

AddAllMaterials() {
	BlockInput(true)
	for code in Materials.Ores
		AddMaterial(code)
	for code in Materials.SpecialMaterials
		AddMaterial(code)
	BlockInput(false)
}