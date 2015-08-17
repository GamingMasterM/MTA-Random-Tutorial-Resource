--//
--||  PROJECT	: MTA Lua video tutorials
--||  AUTHOR	: MasterM
--||  DATE		: August 2013 up to now
--\\

--Tutorial #1 - Basics

gate = createObject(985,2423.3,-1658.5,13.4,0,0,90)

function gateAuf()
moveObject(gate,3000,2423.3,-1650.8,13.4)
end
addCommandHandler("auf",gateAuf)


function gateZu()
moveObject(gate,3000,2423.2,-1658.5,13.4)
end
addCommandHandler("zu",gateZu)

--Tutorial #2 - ein reales Tor

schutz = createObject(2930,1584.2,-1637.9,15,0,0,270.7)
gate2 = createObject(3055,1588.5,-1637.8,14.6,0,0,0)
gateMoved = false
gateMoves = false

function funktion()
if gateMoves == false then
	if gateMoved == false then
	moveObject(gate2,3000,1588.5,-1637.8,16.5,90,0,0,"InOutQuad")
	gateMoved = true
	gateMoves = true
	setTimer(gateCheck,16000,1)
	BlinkLight()
		setTimer(function() 	moveObject(gate2,3000,1588.5,-1637.8,14.6,-90,0,0,"InOutQuad")
								gateMoved = false
								gateMoves = true
								end,13000,1)
	end
end
end
addCommandHandler("gate",funktion)


function gateCheck()
gateMoves = false
end

--OffCamera-Scripting

LED = createMarker(1582.2,-1632.9,16.8,"corona",0.5,255,216,0,0)
BlinkCount = 0
function BlinkLight()
	if BlinkCount < 13 then
	setMarkerColor(LED,255,216,0,255)
	setTimer(BlinkStop,500,1)
	BlinkCount = BlinkCount + 1
		else
		BlinkCount = 0
	end
end

function BlinkStop()
setMarkerColor(LED,255,216,0,0)
setTimer(BlinkLight,500,1)
end

--Tutorial #3 - 

SchrankenMarker = createMarker(1545,-1627,12.5,"cylinder",7,255,255,255,0)
Schranke = createObject(2920,1544.7,-1630.8,13.1,270,180,180)
SchrankeMove = false
SchrankeOben = false 

function SchrankenControl()
	if SchrankeMove == false then
		if SchrankeOben == false then
		moveObject(Schranke,3000,1544.7,-1630.8,13.1,-90,0,0,"InOutQuad")
		SchrankeOben = true
		SchrankeMove = true
			setTimer(SchrankenCheck,3000,1)
			setTimer(function()	if SchrankeOben == true then
								moveObject(Schranke,5000,1544.7,-1630.8,13.1,90,0,0,"OutBounce")
								SchrankeOben = false
								SchrankeMove = true
									setTimer(SchrankenCheck,5000,1)
								end
							end,5000,1)
			else
		moveObject(Schranke,5000,1544.7,-1630.8,13.1,90,0,0,"OutBounce")
		SchrankeOben = false
		SchrankeMove = true
			setTimer(SchrankenCheck,5000,1)
		end
	end
	
end

function SchrankenCheck()
SchrankeMove = false
end

addEventHandler("onMarkerHit",SchrankenMarker,SchrankenControl)
addEventHandler("onMarkerLeave",SchrankenMarker,SchrankenControl)


--sinnvolle Nutzung von Tabellen für Fahrzeuge

Fahrzeugtabelle = {
[1] = createVehicle(452, 140.4017, -1929.921, 0, 0, 0, 135),--Speeder
[2] = createVehicle(452, 140.117, -1921.176, 0, 0, 0, 135),--Speeder
[3] = createVehicle(452, 139.8325, -1912.43, 0, 0, 0, 134.995),--Speeder
[4] = createVehicle(453, 137.1959, -1881.642, 0, 0, 0, 90),--Reefer
[5] = createVehicle(454, 137.7789, -1901.178, 0, 0, 0, 90),--Tropic
[6] = createVehicle(454, 137.9363, -1891.868, 0, 0, 0, 90),--Tropic
[7] = createVehicle(539, 166.9626, -1891.364, 0, 0, 0, 217.063),--Vortex
[8] = createVehicle(573, 159.3734, -1876.721, 4.60849, 0, 0, 0),--Dune
[9] = createVehicle(495, 168.6302, -1859.529, 3.83618, 0, 0, 290.161),--Sandking
[10] = createVehicle(424, 171.6313, -1864.687, 2.9768, 0, 0, 321.457),--BF
[11] = createVehicle(424, 176.059, -1864.815, 2.9768, 0, 0, 321.455),--BF
[12] = createVehicle(568, 167.9432, -1853.906, 3.40077, 0, 0, 258.612),--Bandito
}




for i = 1 , #Fahrzeugtabelle, 1 do
setVehicleColor(Fahrzeugtabelle[i],0,0,0,0)
setVehiclePlateText(Fahrzeugtabelle[i],"Test "..i)
toggleVehicleRespawn(Fahrzeugtabelle[i],true)
setVehicleIdleRespawnDelay(Fahrzeugtabelle[i],1000)

addEventHandler("onVehicleRespawn",Fahrzeugtabelle[i],function()
setVehicleEngineState(Fahrzeugtabelle[i],false)
setVehicleOverrideLights(Fahrzeugtabelle[i],0,0,0,0)
end)

end




function explodeMyVehs()
	for i = 1 , #Fahrzeugtabelle, 1 do
	blowVehicle(Fahrzeugtabelle[i])
	end
end
addCommandHandler("explode",explodeMyVehs)



   
--Tabellen als Wertetabellen

Teleportmarker = {
--MarkerX, MarkerY, MarkerZ, MarkerInt, MarkerTpX, MarkerTpY, MarkerTpZ, MarkerTpInt,
[1] = "554.564453125 , -1631.798828125, 17.214496612549, 0, 457.0478515625 , -88.6884765625, 999.5546875, 4",-- unten außen
[2] = "460.5400390625 , -88.6875, 999.5546875, 4, 550.41796875 , -1631.9384765625, 17.142120361328, 0",-- innen nach unten
[3] = "597.05859375 , -1637.6220703125, 28.061487197876, 0, 445.9521484375 , -81.6083984375, 999.5546875, 4", -- außen nach innen hinter theke
[4] = "449.2392578125 , -79.46484375, 999.5546875, 4, 598.802734375 , -1637.8408203125, 28.061487197876, 0",--innen nach oben
}


for i = 1, #Teleportmarker, 1 do
local x, y, z, int, toX, toY, toZ, toInt = gettok(Teleportmarker[i],1,","), gettok(Teleportmarker[i],2,","), gettok(Teleportmarker[i],3,","), gettok(Teleportmarker[i],4,","), gettok(Teleportmarker[i],5,","), gettok(Teleportmarker[i],6,","), gettok(Teleportmarker[i],7,","), gettok(Teleportmarker[i],8,",")
local Marker = createMarker(x, y, z+1.2, "arrow", 2, 200, 200, 0, 200)
setElementInterior(Marker, int)
addEventHandler("onMarkerHit",Marker,function(hitElement)
if getPedOccupiedVehicle(hitElement) then return end
fadeCamera(hitElement,false)
	setTimer(function()
		setElementPosition(hitElement,toX, toY, toZ)
		setElementInterior(hitElement,toInt)
		fadeCamera(hitElement,true)
		end,1000,1)
end)
end


--verschiedenes vom User-CP
addEvent("giveMeArmor",true)
addEventHandler("giveMeArmor",getRootElement(),function(player)
setPedArmor(player,999)
end)

addEvent("ouputTextFromGlobalText",true)
addEventHandler("ouputTextFromGlobalText",getRootElement(),function(player,text)
	outputChatBox("[GLOBAL] "..getPlayerName(player)..": "..text,getRootElement(),200,200,0)
end)


--Passworttor
local Passwort = "1234"
local pwGate = createObject(16773,-1770.6,984,26,0,0,270)
local pad = createObject(2886,-1772,977.5,24.1,0,0,237)
local isGateOpen = false

addEventHandler ( "onPlayerClick", getRootElement(),
	function ( button, state, clickedElement )
		if state == "down" then	
			if clickedElement and clickedElement == pad  then
				if getDistanceBetweenPoints3D ( -1772,977.5,24.1, getElementPosition ( source ) ) < 10  then		
					--function
					if isGateOpen then
					moveObject(pwGate,3000,-1770.6,984,26,0,0,0,"InOutQuad") 
					isGateOpen = false
					return end
					triggerClientEvent("OpenPWPad",source,Passwort)
				end
			end
		end
	end
)

addEvent("openPWDoor",true)
addEventHandler("openPWDoor",getRootElement(),function()
moveObject(pwGate,3000,-1770.6,984,16,0,0,0,"InOutQuad") 
isGateOpen = true
end)

-------------------------------------XML-Dateien-------------------------------------

function checkForXML()
	if not xmlLoadFile("infoicons.xml") then
	local infoxml = xmlCreateFile("infoicons.xml","Icons")
	xmlSaveFile(infoxml)
	xmlUnloadFile(infoxml)
	end
end
checkForXML()


function createPickups()
local infoxml = xmlLoadFile("infoicons.xml")
	for i, node in ipairs(xmlNodeGetChildren(infoxml)) do
	local x, y, z = xmlNodeGetAttribute(node,"PosX"), xmlNodeGetAttribute(node,"PosY"), xmlNodeGetAttribute(node,"PosZ")
	local header, text = xmlNodeGetAttribute(node,"Header"), xmlNodeGetAttribute(node,"Text")
	local rot, gruen, blau = xmlNodeGetAttribute(node,"FarbeRot"), xmlNodeGetAttribute(node,"FarbeGruen"), xmlNodeGetAttribute(node,"FarbeBlau")
	
	local pickup = createPickup(x,y,z,3,1239,1)
		addEventHandler("onPickupHit",pickup,function(hit)
		outputChatBox(header..": "..text,hit,tonumber(rot),tonumber(gruen),tonumber(blau))
		end)
	end
xmlUnloadFile(infoxml)
end
createPickups()

function insertToXML(player,cmd,header,text,rot,gruen,blau)
--XML
local x,y,z = getElementPosition(player)
local infoxml = xmlLoadFile("infoicons.xml")
local nNode = xmlCreateChild(infoxml,"Icon")
xmlNodeSetAttribute(nNode,"PosX",x)
xmlNodeSetAttribute(nNode,"PosY",y)
xmlNodeSetAttribute(nNode,"PosZ",z-0.5)
xmlNodeSetAttribute(nNode,"Header",string.gsub(header,"_"," "))
xmlNodeSetAttribute(nNode,"Text",string.gsub(text,"_"," "))
xmlNodeSetAttribute(nNode,"FarbeRot",rot)
xmlNodeSetAttribute(nNode,"FarbeGruen",gruen)
xmlNodeSetAttribute(nNode,"FarbeBlau",blau)
xmlSaveFile(infoxml)
xmlUnloadFile(infoxml)
--Welt
local pickup = createPickup(x,y,z-0.5,3,1239,1)
	addEventHandler("onPickupHit",pickup,function(hit)
	outputChatBox(string.gsub(header,"_"," ")..": "..string.gsub(text,"_"," "),hit,tonumber(rot),tonumber(gruen),tonumber(blau))
	end)
end
addCommandHandler("insert",insertToXML)



--XML Funktionen




--Aus Vio :D

local veh, fileData, handlingData, handlingDataNames, file
handlingDataNames = {}
	handlingDataNames["mass"] = true
	handlingDataNames["turnMass"] = true
	handlingDataNames["numberOfGears"] = true
	handlingDataNames["maxVelocity"] = true
	handlingDataNames["engineAcceleration"] = true
	handlingDataNames["engineInertia"] = true
	handlingDataNames["engineType"] = true
	handlingDataNames["brakeDeceleration"] = true
	handlingDataNames["collisionDamageMultiplier"] = true

fileData = "defaultVehicleHandlingData = {}"
file = fileCreate ( "handling_settings.lua" )
for i = 400, 611 do
	veh = createVehicle ( i, 0, 0, 0 )
	if isElement ( veh ) then
		handlingData = getVehicleHandling ( veh )
		
		fileData = fileData.."\n\tdefaultVehicleHandlingData["..i.."] = {}"
		
		for prop, index in pairs ( handlingDataNames ) do
			fileData = fileData.."\n\t\tdefaultVehicleHandlingData["..i.."][\""..prop.."\"] = "
			if type ( handlingData[prop] ) == "number" then
				fileData = fileData..handlingData[prop]
			else
				fileData = fileData.."\""..handlingData[prop].."\""
			end
		end
		
		fileData = fileData.."\n"
		
		destroyElement ( veh )
	end
end
fileWrite ( file, fileData )
fileClose ( file )



--[[
function wantedLevel(player,cmd,wert)
setPlayerWantedLevel(player,tonumber(wert))
end
addCommandHandler("wanted",wantedLevel)



local Nametag = "GMM-"

function changeName()
	local pname = getPlayerName(source)
	setPlayerName(source,Nametag..""..pname)
end
addEventHandler ("onPlayerJoin", getRootElement(), changeName)





MSGs = {
[1] = {["Text"] = "Dies ist eine automatisch generierte Chatnachricht!", ["Farbe"] = {200,200,200} },
[2] = {["Text"] = "Diese ebenfalls, aber in einer anderen Farbe.", ["Farbe"] = {200,200,0} },
[3] = {["Text"] = "Bitte verlasse nun den Server!", ["Farbe"] = {200,0,0} },
[4] = {["Text"] = getPlayerName(getRandomPlayer()).." stinkt!", ["Farbe"] = {0,200,200} },
}

local MSGCounter = 1

function printMSGs()
local i = MSGCounter
outputChatBox(MSGs[i]["Text"],getRootElement(),MSGs[i]["Farbe"][1],MSGs[i]["Farbe"][2],MSGs[i]["Farbe"][3])
	if i == #MSGs then
	MSGCounter = 1 
	else
	MSGCounter = MSGCounter + 1
	end
end
setTimer(printMSGs,5000,-1)

]]



--//
--||		Serverdatum, Zeit
--\\



function getServerTime()
	local time = getRealTime()
	return ("%02d:%02d:%02d"):format(time.hour,time.minute,time.second)
end

function getServerDate()
	local time = getRealTime()
	return ("%02d. %02d. %s"):format(time.monthday,time.month+1,time.year+1900)
end

function isLeapYear(year)
    if year then year = math.floor(year)
    else year = getRealTime().year + 1900 end
    return ((year % 4 == 0 and year % 100 ~= 0) or year % 400 == 0)
end

function getTimestamp(year, month, day, hour, minute, second)
    -- initiate variables
    local monthseconds = { 2678400, 2419200, 2678400, 2592000, 2678400, 2592000, 2678400, 2678400, 2592000, 2678400, 2592000, 2678400 }
    local timestamp = 0
    local datetime = getRealTime()
    year, month, day = year or datetime.year + 1900, month or datetime.month + 1, day or datetime.monthday
    hour, minute, second = hour or datetime.hour, minute or datetime.minute, second or datetime.second
 
    -- calculate timestamp
    for i=1970, year-1 do timestamp = timestamp + (isLeapYear(i) and 31622400 or 31536000) end
    for i=1, month-1 do timestamp = timestamp + ((isLeapYear(year) and i == 2) and 2505600 or monthseconds[i]) end
    timestamp = timestamp + 86400 * (day - 1) + 3600 * hour + 60 * minute + second
 
    timestamp = timestamp - 3600 --GMT+1 compensation
    if datetime.isdst then timestamp = timestamp - 3600 end
 
    return timestamp
end


filepath = "Logs/Enterlog.log"




function logData(string)
	if not fileExists(filepath) then
		dataLog = fileCreate(filepath)
		outputChatBox("Datei erstellt")
	else
		dataLog = fileOpen(filepath)
		local size = fileGetSize(dataLog)
		fileSetPos(dataLog,size)
		outputChatBox("Datei geöffnet")
	end
	fileWrite(dataLog,string.."\n")
	fileClose(dataLog)
	outputChatBox("Text geloggt")
end


function sendDataToLog(player,seat)
	local stringToSend = ("[%s] %s ist in ein %s eingestiegen (Sitz %s)"):format(getTimestamp(), getPlayerName(player), getVehicleName(source), seat)
	return logData(stringToSend)
end
addEventHandler("onVehicleEnter",getRootElement(),sendDataToLog)








