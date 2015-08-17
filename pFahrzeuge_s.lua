
pFahrzeuge = {
--ID = Modell, Besitzer, [{PosX, PosY, PosZ}, {RotX, RotY, RotZ}, {Farbe1, Farbe2, Farbe3, Farbe4}, Kennzeichen
[1] = {["Modell"] = 411, ["Besitzer"] = "ADLER4BOSS", ["Position"] = {0,0,10}, ["Rotation"] = {0,0,0}, ["Farbe"] = {0,0,0,0}, ["Kennzeichen"] = "PRIVATE!"},

}

function createPrivateVehicles()
	for i = 1, #pFahrzeuge, 1 do
	local veh = pFahrzeuge
	local nFahrzeug = createVehicle(veh[i]["Modell"], veh[i]["Position"][1], veh[i]["Position"][2], veh[i]["Position"][3], veh[i]["Rotation"][1], veh[i]["Rotation"][2], veh[i]["Rotation"][3], veh[i]["Kennzeichen"])
	setVehicleColor(nFahrzeug, veh[i]["Farbe"][1], veh[i]["Farbe"][2], veh[i]["Farbe"][3], veh[i]["Farbe"][4])
	--createBlipAttachedTo(nFahrzeug)
		addEventHandler("onVehicleStartEnter",nFahrzeug,function(player)
			if getPlayerName(player) ~= veh[i]["Besitzer"] then
			cancelEvent()
			outputChatBox("Du darfst nicht mit dem Fahrzeug von "..veh[i]["Besitzer"].." fahren.",player,200,0,0)
			end
		end)

	end
--print("Es wurden "..#pFahrzeuge.." private Fahrzeuge gefunden")
end
createPrivateVehicles()


function respawnPrivateVehicles()
	for i = 1, #pFahrzeuge, 1 do
	local veh = pFahrzeuge
	local x, y, z = veh[i]["Position"][1], veh[i]["Position"][2], veh[i]["Position"][3]
	
	end
end






--[[
Daten auslesen ( nur in der for-Schleife möglich) - veh[index in der Tabelle]["Datensatz"]
EventHandler werden gleich mit erstellt. cancelEvent() lässt den Spieler nicht einsteigen
Die player-Variable kommt mit vom Event ( https://wiki.multitheftauto.com/wiki/OnVehicleStartEnter )





]]