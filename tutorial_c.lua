--//
--||  PROJECT	: MTA Lua video tutorials
--||  AUTHOR	: MasterM
--||  DATE		: August 2013 up to now
--\\


CP = {
    tab = {},
    staticimage = {},
    tabpanel = {},
    label = {},
    button = {},
    window = {}
}

local isCPShowing = false
local lp = getLocalPlayer()

addEventHandler("onClientResourceStart", resourceRoot,
function()
bindKey("F2","down",createCP_func)
bindKey("F3","down",createTestGridList_func)
bindKey("F4","down",createChatBox_func)
end)







function createCP_func()
if isCPShowing then 
				destroyElement(CP.window[1])  
				isCPShowing = false 
				return end
				
	isCPShowing = true
	showCursor(true)
        CP.window[1] = guiCreateWindow(412, 228, 475, 307, "                                                                    Control Panel                                                         [X]", false)
        guiWindowSetSizable(CP.window[1], false)
        guiSetAlpha(CP.window[1], 0.71)

        CP.tabpanel[1] = guiCreateTabPanel(0, 18, 475, 307, false, CP.window[1])

        CP.tab[1] = guiCreateTab("Spieler", CP.tabpanel[1])

        CP.staticimage[1] = guiCreateStaticImage(0, 0, 80, 80, ":Tut/Logo.png", false, CP.tab[1])
        CP.button[1] = guiCreateButton(90, 10, 355, 34, "Heilen", false, CP.tab[1])
        guiSetFont(CP.button[1], "default-bold-small")
        guiSetProperty(CP.button[1], "NormalTextColour", "FFAAAAAA")
        CP.button[2] = guiCreateButton(90, 46, 355, 34, "Weste geben", false, CP.tab[1])
        guiSetFont(CP.button[2], "default-bold-small")
        guiSetProperty(CP.button[2], "NormalTextColour", "FFAAAAAA")
        CP.label[1] = guiCreateLabel(10, 90, 435, 155, "Hier kannst du dich heilen und dir eine Schutzweste geben.", false, CP.tab[1])
        guiSetFont(CP.label[1], "sa-header")
        guiLabelSetHorizontalAlign(CP.label[1], "center", true)

        CP.tab[2] = guiCreateTab("Fahrzeug", CP.tabpanel[1])
		if not getPedOccupiedVehicle(lp) then guiSetEnabled(CP.tab[2],false) end
		
		
		
        CP.staticimage[2] = guiCreateStaticImage(0, 0, 80, 80, ":Tut/Logo.png", false, CP.tab[2])
        CP.button[3] = guiCreateButton(90, 10, 355, 34, "Fahrzeug reparieren", false, CP.tab[2])
        guiSetFont(CP.button[3], "default-bold-small")
        guiSetProperty(CP.button[3], "NormalTextColour", "FFAAAAAA")
        CP.button[4] = guiCreateButton(90, 46, 355, 34, "Fahrzeug drehen", false, CP.tab[2])
        guiSetFont(CP.button[4], "default-bold-small")
        guiSetProperty(CP.button[4], "NormalTextColour", "FFAAAAAA")
        CP.label[2] = guiCreateLabel(10, 90, 435, 155, "Hier kannst du dein Fahrzeug reparieren und es um 180° drehen.", false, CP.tab[2])
        guiSetFont(CP.label[2], "sa-header")
        guiLabelSetHorizontalAlign(CP.label[2], "center", true)  	
		
		addEventHandler("onClientGUIClick",CP.window[1],function(button)
		if button ~= "left" then return end
		destroyElement(CP.window[1])
		isCPShowing = false
		showCursor(false)
		end,false)
		
		addEventHandler("onClientGUIClick",CP.button[1],function(button)--Heilen
		if button ~= "left" then return end
		setElementHealth(lp,999)
		end,false)	

        addEventHandler("onClientGUIClick",CP.button[2],function(button)--Weste
		if button ~= "left" then return end
		triggerServerEvent("giveMeArmor",lp,lp)
		end,false)		
		
        addEventHandler("onClientGUIClick",CP.button[3],function(button)--reparieren
		if button ~= "left" then return end
		if not getPedOccupiedVehicle(lp) then return end
		fixVehicle(getPedOccupiedVehicle(lp))
		end,false)
		
        addEventHandler("onClientGUIClick",CP.button[4],function(button)--drehen
		if button ~= "left" then return end
		if not getPedOccupiedVehicle(lp) then return end
		local rx, ry, rz = getElementRotation(getPedOccupiedVehicle(lp))
		setElementRotation(getPedOccupiedVehicle(lp),rx,ry+180,rz)
		end,false)
		
		
		
		
		
end

--Fenster als ChatBox-Ersatz

CB = {
    tab = {},
    tabpanel = {},
    label = {},
    button = {},
    edit = {}
}

    function createChatBox_func()
if isElement(CB.tabpanel[1]) then return end
	showCursor(true)
        CB.tabpanel[1] = guiCreateTabPanel(405, 262, 494, 220, false)
        guiSetAlpha(CB.tabpanel[1], 0.70)

        CB.tab[1] = guiCreateTab("Globale ChatBox", CB.tabpanel[1])

        CB.label[1] = guiCreateLabel(10, 10, 474, 72, "Tippe hier einen Text ein, und er wird an alle Spieler gesendet.\n\nWichtig: Du hast nur 100 Zeichen Platz!", false, CB.tab[1])
        guiSetFont(CB.label[1], "default-bold-small")
        guiLabelSetHorizontalAlign(CB.label[1], "center", false)
        CB.button[1] = guiCreateButton(10, 138, 232, 47, "Fenster schließen", false, CB.tab[1])
        guiSetFont(CB.button[1], "default-bold-small")
        guiSetProperty(CB.button[1], "NormalTextColour", "FFFFFFFF")
        CB.button[2] = guiCreateButton(252, 138, 232, 47, "Text ausgeben", false, CB.tab[1])
        guiSetFont(CB.button[2], "default-bold-small")
        guiSetProperty(CB.button[2], "NormalTextColour", "FFFFFFFF")
        CB.edit[1] = guiCreateEdit(10, 92, 474, 36, "Gebe hier deinen Text ein...", false, CB.tab[1])
        guiSetProperty(CB.edit[1], "NormalTextColour", "FE000000")    
        guiEditSetMaxLength(CB.edit[1],100)
	
	addEventHandler("onClientGUIClick",CB.edit[1],function()-- Text löschen
	guiSetText(CB.edit[1],"")
	end,false)
	addEventHandler("onClientGUIClick",CB.button[1],function()-- Schließen
	destroyElement(CB.tabpanel[1])
	showCursor(false)
	end,false)
	
	addEventHandler("onClientGUIClick",CB.button[2],function()-- Text ausgeben
	local text = guiGetText(CB.edit[1])
	if text == "Gebe hier deinen Text ein..." then return outputChatBox("Bitte gebe einen Text ein.",200,0,0) end
	triggerServerEvent("ouputTextFromGlobalText",lp,lp,text)
	destroyElement(CB.tabpanel[1])
	showCursor(false)
	end,false)
end



function createTestGridList_func ()
if isTestListeShowing then return end
showCursor(true)
isTestListeShowing = true
setElementFrozen(getLocalPlayer(),false)
	local testListe = guiCreateGridList ( 0.60, 0, 0.40, 0.40, true )
	guiSetAlpha(testListe,0.7)
	local icolumn = guiGridListAddColumn ( testListe, "ID", 0.1 )
	local fcolumn = guiGridListAddColumn ( testListe, "Fahrzeug", 0.20 )
	local xcolumn = guiGridListAddColumn ( testListe, "X-Position", 0.25 )
	local ycolumn = guiGridListAddColumn ( testListe, "Y-Position", 0.25 )
	local zcolumn = guiGridListAddColumn ( testListe, "Z-Position", 0.17 )
		for i, v in ipairs(getElementsByType("vehicle")) do
			local row = guiGridListAddRow ( testListe )
				local x,y,z = getElementPosition(v)
			guiGridListSetItemText ( testListe, row, icolumn,i, false, false )
			guiGridListSetItemText ( testListe, row, fcolumn, getVehicleName(v), false, false )
			guiGridListSetItemText ( testListe, row, xcolumn, x, false, false )
			guiGridListSetItemText ( testListe, row, ycolumn, y, false, false )
			guiGridListSetItemText ( testListe, row, zcolumn, z, false, false )
		end
	
	 addEventHandler( "onClientGUIClick", testListe, function()
		local ID = guiGridListGetItemText (testListe, guiGridListGetSelectedItem( testListe ),1)
		local Fahrzeug = guiGridListGetItemText (testListe, guiGridListGetSelectedItem( testListe ),2)
		local x = guiGridListGetItemText (testListe, guiGridListGetSelectedItem( testListe ),3)
		local y = guiGridListGetItemText (testListe, guiGridListGetSelectedItem( testListe ),4)
		local z = guiGridListGetItemText (testListe, guiGridListGetSelectedItem( testListe ),5)
			if guiGridListGetItemText(testListe, guiGridListGetSelectedItem( testListe ),1) ~= ("") then
			outputChatBox("Du hast dich zum "..Fahrzeug.." (ID "..ID..") geportet.")
			setElementPosition(getLocalPlayer(),x,y,z+2)
			destroyElement(testListe)
			showCursor(false)
			isTestListeShowing = false
				else
				destroyElement(testListe)
				showCursor(false)
				isTestListeShowing = false
			end
	 end, false )
	 
	 
end


bindKey("b","down",function()
showCursor(not isCursorShowing())
end)



-- Tor mit Keypad in SF
local isPWGuiShowing = false

PWPad = {
    button = {},
    window = {},
    label = {},
    edit = {}
}

function PWPad_func(Passwort)
					
if isPWGuiShowing then return end
showCursor(true)
-- GUI erstellen und einstellen
isPWGuiShowing = true
PWPad.window[1] = guiCreateWindow(190, 265, 190, 296, "Bitte PIN eingeben", false)
	guiWindowSetSizable(PWPad.window[1], false)
PWPad.button[1] = guiCreateButton(10, 49, 50, 49, "[1]", false, PWPad.window[1])
	guiSetFont(PWPad.button[1], "default-bold-small")
	guiSetProperty(PWPad.button[1], "NormalTextColour", "FFFFFEFE")	
PWPad.button[2] = guiCreateButton(70, 49, 50, 49, "[2]", false, PWPad.window[1])
	guiSetFont(PWPad.button[2], "default-bold-small")
	guiSetProperty(PWPad.button[2], "NormalTextColour", "FFFFFEFE")		
PWPad.button[3] = guiCreateButton(130, 49, 50, 49, "[3]", false, PWPad.window[1])
	guiSetFont(PWPad.button[3], "default-bold-small")
	guiSetProperty(PWPad.button[3], "NormalTextColour", "FFFFFEFE")	
PWPad.button[4] = guiCreateButton(10, 108, 50, 49, "[4]", false, PWPad.window[1])
	guiSetFont(PWPad.button[4], "default-bold-small")
	guiSetProperty(PWPad.button[4], "NormalTextColour", "FFFFFEFE")	
PWPad.button[5] = guiCreateButton(70, 108, 50, 49, "[5]", false, PWPad.window[1])
	guiSetFont(PWPad.button[5], "default-bold-small")
	guiSetProperty(PWPad.button[5], "NormalTextColour", "FFFFFEFE")		
PWPad.button[6] = guiCreateButton(130, 108, 50, 49, "[6]", false, PWPad.window[1])
	guiSetFont(PWPad.button[6], "default-bold-small")
	guiSetProperty(PWPad.button[6], "NormalTextColour", "FFFFFEFE")	
PWPad.button[7] = guiCreateButton(10, 167, 50, 49, "[7]", false, PWPad.window[1])
	guiSetFont(PWPad.button[7], "default-bold-small")
	guiSetProperty(PWPad.button[7], "NormalTextColour", "FFFFFEFE")
PWPad.button[8] = guiCreateButton(70, 167, 50, 49, "[8]", false, PWPad.window[1])
	guiSetFont(PWPad.button[8], "default-bold-small")
	guiSetProperty(PWPad.button[8], "NormalTextColour", "FFFFFEFE")	
PWPad.button[9] = guiCreateButton(130, 167, 50, 49, "[9]", false, PWPad.window[1])
	guiSetFont(PWPad.button[9], "default-bold-small")
	guiSetProperty(PWPad.button[9], "NormalTextColour", "FFFFFEFE")	
PWPad.button[10] = guiCreateButton(70, 234, 50, 49, "[0]", false, PWPad.window[1])
	guiSetFont(PWPad.button[10],"default-bold-small")
	guiSetProperty(PWPad.button[10], "NormalTextColour", "FFFFFEFE")	
PWPad.button[11] = guiCreateButton(10, 234, 50, 49, "[ESC]", false, PWPad.window[1])
	guiSetFont(PWPad.button[11], "clear-normal")
	guiSetProperty(PWPad.button[11], "NormalTextColour", "FFFD000B")	
PWPad.button[12] = guiCreateButton(131, 234, 49, 49, "[OK]", false, PWPad.window[1])
	guiSetFont(PWPad.button[12], "clear-normal")
	guiSetProperty(PWPad.button[12], "NormalTextColour", "FF6CFD01")	
PWPad.edit[1] = guiCreateEdit(61, 22, 119, 17, "", false, PWPad.window[1])
	guiEditSetReadOnly(PWPad.edit[1], true)	
PWPad.label[1] = guiCreateLabel(13, 24, 48, 15, "Eingabe", false, PWPad.window[1])
	guiSetFont(PWPad.label[1], "default-bold-small")	
PWPad.label[2] = guiCreateLabel(0, 216, 190, 15, "_____________________________________", false, PWPad.window[1])    
-- EventHandler
	for i = 1,10,1 do 
		addEventHandler("onClientGUIClick",PWPad.button[i],function()
		if i == 10 then i = 0 end
		guiSetText(PWPad.edit[1],tostring(guiGetText(PWPad.edit[1])..""..i))
		end,false)
	end
	addEventHandler("onClientGUIClick",PWPad.button[11],function()--ESC
	destroyElement(PWPad.window[1])
	isPWGuiShowing = false
	showCursor(false)
	end,false)
	addEventHandler("onClientGUIClick",PWPad.button[12],function()--OK
	local GUIPasswort = guiGetText(PWPad.edit[1])
		if GUIPasswort == Passwort then
		outputChatBox("Willkommen "..getPlayerName(lp),200,200,0)
		triggerServerEvent("openPWDoor",lp)
		else
		outputChatBox("Du hast den falschen Code eingegeben.",200,0,0)
		end
	destroyElement(PWPad.window[1])
	isPWGuiShowing = false
	showCursor(false)
	end,false)
end

addEvent("OpenPWPad",true)
addEventHandler("OpenPWPad",lp,PWPad_func,Passwort)




function drawMethEffect()
local sx, sy = guiGetScreenSize()
dxDrawRectangle(math.random(0,sx),math.random(0,sy),math.random(0,sx),math.random(0,sy),tocolor(math.random(0,255),math.random(0,255),math.random(0,255),math.random(0,255)),true)
dxDrawRectangle(math.random(0,sx),math.random(0,sy),math.random(0,sx),math.random(0,sy),tocolor(math.random(0,255),math.random(0,255),math.random(0,255),math.random(0,255)),true)
dxDrawRectangle(math.random(0,sx),math.random(0,sy),math.random(0,sx),math.random(0,sy),tocolor(math.random(0,255),math.random(0,255),math.random(0,255),math.random(0,255)),true)
dxDrawRectangle(math.random(0,sx),math.random(0,sy),math.random(0,sx),math.random(0,sy),tocolor(math.random(0,255),math.random(0,255),math.random(0,255),math.random(0,255)),true)
dxDrawRectangle(math.random(0,sx),math.random(0,sy),math.random(0,sx),math.random(0,sy),tocolor(math.random(0,255),math.random(0,255),math.random(0,255),math.random(0,255)),true)
end

function drawWeedEffect()
local sx, sy = guiGetScreenSize()
local farbe = math.random(0,255)
dxDrawRectangle(math.random(0,sx),math.random(0,sy),math.random(0,sx),math.random(0,sy),tocolor(farbe,farbe,farbe,math.random(0,100)),true)
dxDrawRectangle(math.random(0,sx),math.random(0,sy),math.random(0,sx),math.random(0,sy),tocolor(farbe,farbe,farbe,math.random(0,100)),true)
end


local isWeedEffect = false
local isMethEffect = false

addCommandHandler("weed",function()
if isMethEffect then return end
	if not isWeedEffect then 
	isWeedEffect = true
			addEventHandler("onClientRender",root,drawWeedEffect)

	else
	isWeedEffect = false
	removeEventHandler("onClientRender",root,drawWeedEffect)
	end
end)

addCommandHandler("meth",function()
if isWeedEffect then return end
	if not isMethEffect then 
	isMethEffect = true
			addEventHandler("onClientRender",root,drawMethEffect)

	else
	isMethEffect = false
	removeEventHandler("onClientRender",root,drawMethEffect)
	end
end)
















local sx,sy = guiGetScreenSize()
local px,py = 1920,1080
local x,y =  (sx/px), (sy/py)
local money = getPlayerMoney(lp)
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        HUDTarget = dxCreateRenderTarget( 1920,1080, true )   	
    end
)


function drawCustomHUD()
	-- Variablen
	local stunde, minute = getTime()
		if minute < 10 then minute = tostring("0"..minute) end
		if stunde < 10 then stunde = tostring("0"..stunde) end
	local pgeld = getPlayerMoney(lp)
	local phit = 1234
	local weste = getPedArmor(lp)
	local leben = getElementHealth(lp)
	local sterne = getPlayerWantedLevel(lp)
	local atem = getPedOxygenLevel(lp)
	local waffe = getPedWeapon(lp)
	local ammo = getPedTotalAmmo(lp)
	local magazin = getPedAmmoInClip(lp)
	local level = 0
	-- Geldzeugs
				local geldlaenge = string.len(pgeld)
				local targetlaenge = 8-tonumber(geldlaenge)
				local nullen = ""
				for i = 1, targetlaenge, 1 do
				nullen = tostring(nullen.."0")
				end
				local geld = tostring(nullen..""..pgeld)
				
				local hitlaenge = string.len(phit)
				local targetlaenge = 10-tonumber(hitlaenge)
				local nullen = ""
				for i = 1, hitlaenge, 1 do
				nullen = tostring(nullen.."0")
				end
				local hit = tostring(nullen..""..phit)
	
	
-- Texte
dxSetRenderTarget( HUDTarget , true) 
dxSetBlendMode ( "modulate_add" )
	-- Geldanzeige
	local currentMoney = getPlayerMoney(lp)
		if currentMoney  ~= money then
			if currentMoney < money then -- Geld wird weniger
				local moneydiff = money-currentMoney
				local abzug = math.ceil(moneydiff/50)
				money = money-1
			else -- Geld wird mehr
				local moneydiff = currentMoney-money
				local abzug = math.ceil(moneydiff/50)
				money = money+1
			end
		end
        dxDrawText("$"..money, 1453, 223, 1853, 273, tocolor(0, 0, 0, 255), 3.00, "pricedown", "right", "center", false, false, false, false, false)-- postGUI 3. false
        dxDrawText("$"..money, 1453, 217, 1853, 267, tocolor(0, 0, 0, 255), 3.00, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText("$"..money, 1447, 223, 1847, 273, tocolor(0, 0, 0, 255), 3.00, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText("$"..money, 1447, 217, 1847, 267, tocolor(0, 0, 0, 255),3.00, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText("$"..money, 1450, 220, 1850, 270, tocolor(17, 75, 0, 255), 3.00, "pricedown", "right", "center", false, false, false, false, false)
	-- Kopfgeld
        dxDrawText("$"..hit, 1453, 293, 1853, 343, tocolor(0, 0, 0, 255), 3.00, "pricedown", "right", "center", false, false, false, false, false)-- postGUI 3. false
        dxDrawText("$"..hit, 1453, 287, 1853, 337, tocolor(0, 0, 0, 255), 3.00, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText("$"..hit, 1447, 293, 1847, 343, tocolor(0, 0, 0, 255), 3.00, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText("$"..hit, 1447, 287, 1847, 337, tocolor(0, 0, 0, 255), 3.00, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText("$"..hit, 1450, 290, 1850, 340, tocolor(150, 0, 0, 255), 3.00, "pricedown", "right", "center", false, false, false, false, false)
		-- Uhrzeit
        dxDrawText(stunde..":"..minute, 1653, 73, 1853, 123, tocolor(0, 0, 0, 255), 3.00, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(stunde..":"..minute, 1653, 67, 1853, 117, tocolor(0, 0, 0, 255), 3.00, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(stunde..":"..minute, 1647, 73, 1847, 123, tocolor(0, 0, 0, 255), 3.00, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(stunde..":"..minute, 1647, 67, 1847, 117, tocolor(0, 0, 0, 255), 3.00, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(stunde..":"..minute, 1650, 70, 1850, 120, tocolor(150, 150, 150, 255), 3.00, "pricedown", "center", "center", false, false, false, false, false)
		-- Level
	dxDrawText(level, 1273, 73, 1473, 123, tocolor(0, 0, 0, 255), 3.00, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText(level, 1273, 67, 1473, 117, tocolor(0, 0, 0, 255), 3.00, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText(level, 1267, 73, 1467, 123, tocolor(0, 0, 0, 255), 3.00, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText(level, 1267, 67, 1467, 117, tocolor(0, 0, 0, 255), 3.00, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText(level, 1270, 70, 1470, 120, tocolor(150, 150, 150, 255), 3.00, "pricedown", "right", "center", false, false, false, false, false)
		
		-- Munition und Magazin
		if waffe ~= 0 then -- keine Faust
			dxDrawText(magazin.." / "..ammo, 1517, 185, 1636, 201, tocolor(0, 0, 0, 255), 1.00, "pricedown", "right", "center", false, false, true, false, false)
			dxDrawText(magazin.." / "..ammo, 1517, 181, 1636, 197, tocolor(0, 0, 0, 255), 1.00, "pricedown", "right", "center", false, false, true, false, false)
			dxDrawText(magazin.." / "..ammo, 1513, 185, 1632, 201, tocolor(0, 0, 0, 255), 1.00, "pricedown", "right", "center", false, false, true, false, false)
			dxDrawText(magazin.." / "..ammo, 1513, 181, 1632, 197, tocolor(0, 0, 0, 255), 1.00, "pricedown", "right", "center", false, false, true, false, false)
			dxDrawText(magazin.." / "..ammo, 1515, 183, 1634, 199, tocolor(150, 150, 150, 255), 1.00, "pricedown", "right", "center", false, false, true, false, false)
		end
	-- 3 Balken (Schutzweste, Atemluft, Leben)
		-- Weste
		if weste > 0 then
			dxDrawRectangle(1650, 130, 200, 20, tocolor(0, 0, 0, 255), false)
			dxDrawRectangle(1653, 133, 194, 14, tocolor(150, 150, 150, 255), false)
			dxDrawRectangle(1653, 133, 194/100*weste, 14, tocolor(200, 200, 200, 255), false)	
		end
		-- Luft
		if isElementInWater(lp) or atem <= 1000 then
			dxDrawRectangle(1650, 160, 200, 20, tocolor(0, 0, 0, 255), false)
			dxDrawRectangle(1653, 163, 194, 14, tocolor(79, 141, 205, 255), false)	
				if atem <= 1000 then
				dxDrawRectangle(1653, 163, 194/1000*atem, 14, tocolor(129, 191, 255, 255), false)
				else
				dxDrawRectangle(1653, 163, 194, 14, tocolor(129, 191, 255, 255), false)
				end
		end	
		-- Leben
			dxDrawRectangle(1650, 190, 200, 20, tocolor(0, 0, 0, 255), false)
			dxDrawRectangle(1653, 193, 194, 14, tocolor(83, 0, 0, 255), false)	
			dxDrawRectangle(1653, 193, 194/100*leben, 14, tocolor(133, 0, 12, 255), false)
		-- Waffe 
			dxDrawImage ( 1500, 70, 140, 140, tostring("HUD/"..waffe..".png"))
dxSetRenderTarget() 
dxSetBlendMode ( "blend" )
end

function createCustomHUD()
dxDrawImage( 0,  0,  x*1920, y*1080, HUDTarget ) 
end


isHudEnabled = false
addCommandHandler("chud",function()
	if not isHudEnabled then
	isHudEnabled = true
	drawCustomHUD()
	addEventHandler("onClientRender", root, createCustomHUD)

		setPlayerHudComponentVisible("clock",false)
		setPlayerHudComponentVisible("breath",false)
		setPlayerHudComponentVisible("armour",false)
		setPlayerHudComponentVisible("health",false)
		setPlayerHudComponentVisible("money",false)
		setPlayerHudComponentVisible("wanted",false)
		setPlayerHudComponentVisible("weapon",false)
		setPlayerHudComponentVisible("ammo",false)

	else
	isHudEnabled = false
	removeEventHandler("onClientRender", root, createCustomHUD)
	
		setPlayerHudComponentVisible("clock",true)
		setPlayerHudComponentVisible("breath",true)
		setPlayerHudComponentVisible("armour",true)
		setPlayerHudComponentVisible("health",true)
		setPlayerHudComponentVisible("money",true)
		setPlayerHudComponentVisible("wanted",true)
		setPlayerHudComponentVisible("weapon",true)
		setPlayerHudComponentVisible("ammo",true)
		
	end
end)


setTimer(drawCustomHUD,60000,-1) -- Uhrzeit
addEventHandler("onClientPlayerDamage",lp,drawCustomHUD)
addEventHandler("onClientPlayerWeaponFire",lp,drawCustomHUD)
addEventHandler("onClientPlayerWeaponSwitch",lp,drawCustomHUD)
addEventHandler("onClientRestore",lp,drawCustomHUD)
addEventHandler("onClientRender",getRootElement(),drawCustomHUD)



local sx, sy = guiGetScreenSize(lp)
local blut = "Blood.png"
local tropfenanzahl = 1
local groesse = 1
local isEffect = false

function bloodyScreen(attacker, weapon, bodypart, loss)
if isEffect then return end
isEffect = true
local size = loss*2+math.random(0,100)
		local tropfen1 = guiCreateStaticImage(math.random(0,sx),math.random(0,sy),size,size,blut,false)
		local tropfen2 = guiCreateStaticImage(math.random(0,sx),math.random(0,sy),size,size,blut,false)
		local tropfen3 = guiCreateStaticImage(math.random(0,sx),math.random(0,sy),size,size,blut,false)
		local tropfen4 = guiCreateStaticImage(math.random(0,sx),math.random(0,sy),size,size,blut,false)
		local tropfen5 = guiCreateStaticImage(math.random(0,sx),math.random(0,sy),size,size,blut,false)
		local tropfen6 = guiCreateStaticImage(math.random(0,sx),math.random(0,sy),size,size,blut,false)
	bloodtimer = setTimer(function()
		if guiGetAlpha(tropfen1) > 0 then
			guiSetAlpha(tropfen1,guiGetAlpha(tropfen1)-0.05)
			guiSetAlpha(tropfen2,guiGetAlpha(tropfen2)-0.05)
			guiSetAlpha(tropfen3,guiGetAlpha(tropfen3)-0.05)
			guiSetAlpha(tropfen4,guiGetAlpha(tropfen1)-0.05)
			guiSetAlpha(tropfen5,guiGetAlpha(tropfen2)-0.05)
			guiSetAlpha(tropfen6,guiGetAlpha(tropfen3)-0.05)
		else
			killTimer(bloodtimer)
			isEffect = false
		end
	end,50,-1)
end
addEventHandler ( "onClientPlayerDamage", getLocalPlayer(), bloodyScreen )




RadioStationen = {
[1]  = {["Name"] = "Energy Sachsen", ["URL"] = "http://energyradio.de/sachsen", ["Beschreibung"] = "Moderne Musik" },
[2]  = {["Name"] = "Radio Eins", ["URL"] = "http://radioeins.de/live.m3u", ["Beschreibung"] = "vom Rundfunk Berlin-Brandenburg (rbb)" },
[3]  = {["Name"] = "Klassik Radio", ["URL"] = "http://edge.live.mp3.mdn.newmedia.nacamar.net/klassikradio96/livestream.mp3 ", ["Beschreibung"] = "Vielleicht hört es sich sogar wer an ;)" },
[4]  = {["Name"] = "MDR Info", ["URL"] = "http://avw.mdr.de/livestreams/mdr_info_live_128.m3u", ["Beschreibung"] = "Ich hab kein Plan was das ist!" },
}

local isAnyStream = false
local isRadioGuiOpen = false

RadioGUI = {
    edit = {},
    button = {},
    window = {},
    label = {},
    gridlist = {}
}

function radioStreams()
if isRadioGuiOpen then return end
isRadioGuiOpen = true
showCursor(true)
        RadioGUI.window[1] = guiCreateWindow(671, 355, 627, 321, "Radiostreams", false)
        guiWindowSetSizable(RadioGUI.window[1], false)

        RadioGUI.gridlist[1] = guiCreateGridList(10, 29, 607, 194, false, RadioGUI.window[1])
        ID = guiGridListAddColumn(RadioGUI.gridlist[1], "ID", 0.1)
        Name = guiGridListAddColumn(RadioGUI.gridlist[1], "Name des Streams", 0.3)
        Info = guiGridListAddColumn(RadioGUI.gridlist[1], "kurze Beschreibung", 0.6)
        RadioGUI.button[1] = guiCreateButton(10, 267, 197, 44, "Stream-URL abspielen:", false, RadioGUI.window[1])
        guiSetProperty(RadioGUI.button[1], "NormalTextColour", "FFAAAAAA")
        RadioGUI.edit[1] = guiCreateEdit(217, 267, 194, 44, "z.B. http://energyradio.de/sachsen", false, RadioGUI.window[1])
        RadioGUI.button[2] = guiCreateButton(421, 267, 196, 44, "Fenster schließen", false, RadioGUI.window[1])
        guiSetProperty(RadioGUI.button[2], "NormalTextColour", "FFAAAAAA")
        RadioGUI.label[1] = guiCreateLabel(10, 233, 607, 24, "Klicke auf einen Sender, um ihn ein/auszuschalten.", false, RadioGUI.window[1])
        guiSetFont(RadioGUI.label[1], "default-bold-small")
        guiLabelSetHorizontalAlign(RadioGUI.label[1], "center", false)
        guiLabelSetVerticalAlign(RadioGUI.label[1], "center")    
		
	for i=1, #RadioStationen, 1 do
				local row = guiGridListAddRow ( RadioGUI.gridlist[1] )
			guiGridListSetItemText ( RadioGUI.gridlist[1], row, ID,i, false, false )
			guiGridListSetItemText ( RadioGUI.gridlist[1], row, Name, RadioStationen[i]["Name"], false, false )
			guiGridListSetItemText ( RadioGUI.gridlist[1], row, Info,RadioStationen[i]["Beschreibung"] , false, false )
	end
	
	addEventHandler( "onClientGUIClick", RadioGUI.gridlist[1], function()
		local ID = guiGridListGetItemText (RadioGUI.gridlist[1], guiGridListGetSelectedItem( RadioGUI.gridlist[1] ),1)
			if ID ~= "" then
				if not isAnyStream then
					stream = playSound(RadioStationen[tonumber(ID)]["URL"])
					outputChatBox("Viel Spaß beim zuhören.",200,200,0)
					isAnyStream = true
					else
					stopSound(stream)
					outputChatBox("Stream gestoppt.",200,200,0)
					isAnyStream = false
				end
			end
	 end, false )
	 
	 addEventHandler("onClientGUIClick",RadioGUI.button[2],function()
	 destroyElement(RadioGUI.window[1])
	 isRadioGuiOpen = false
	 showCursor(false)
	 end,false)
	 
	 addEventHandler("onClientGUIClick",RadioGUI.button[1],function()
		 if isAnyStream then
		  stopSound(stream)
		  end
		 isAnyStream = true
		 outputChatBox("Viel Spaß beim zuhören.",200,200,0)
		 stream = playSound(guiGetText(RadioGUI.edit[1]))
	 end,false)
end
addCommandHandler("radio",radioStreams)



function dfhgoi()
local veh = getPedOccupiedVehicle(lp)
	local bx,by,bz = getVehicleComponentPosition(veh, "bump_rear_dummy")
	local rbx, rby, rbz = getVehicleComponentRotation(veh, "bump_rear_dummy")
	--local b = fxAddGunshot(bx,by,bz, rbx, rby, rbz)
	local dummy_r = createObject(1337,1,1,1)
	local dummy_l = createObject(1337,1,1,1)
	attachElements(dummy_r,veh,bx,by,bz, rbx, rby, rbz)
	attachElements(dummy_l,veh,-bx,by,bz, rbx, rby, rbz)
end
addCommandHandler("pos",dfhgoi)
	
	

local isLichtEditorOpen = false
local areBlinker = false
HQ_Panel = {
    tab = {},
    tabpanel = {},
    edit = {},
    button = {},
    label = {}
}
function showBlinkerGui()
if isLichtEditorOpen then showCursor(not isCursorShowing())return end
showCursor(true)
isLichtEditorOpen = true
        HQ_Panel.tabpanel[1] = guiCreateTabPanel(665, 334, 305, 226, false)
        guiSetAlpha(HQ_Panel.tabpanel[1], 0.70)

        HQ_Panel.tab[1] = guiCreateTab("Lichteditor", HQ_Panel.tabpanel[1])

        HQ_Panel.button[1] = guiCreateButton(10, 146, 137, 43, "Anbringen", false, HQ_Panel.tab[1])
        guiSetProperty(HQ_Panel.button[1], "NormalTextColour", "FFAAAAAA")
        HQ_Panel.button[2] = guiCreateButton(157, 146, 137, 43, "Code ausgeben", false, HQ_Panel.tab[1])
        guiSetProperty(HQ_Panel.button[2], "NormalTextColour", "FFAAAAAA")
        HQ_Panel.edit[1] = guiCreateEdit(92, 32, 61, 28, "vx", false, HQ_Panel.tab[1])
        HQ_Panel.edit[2] = guiCreateEdit(163, 32, 61, 28, "vy", false, HQ_Panel.tab[1])
        HQ_Panel.edit[3] = guiCreateEdit(234, 32, 61, 28, "vz", false, HQ_Panel.tab[1])
        HQ_Panel.edit[4] = guiCreateEdit(92, 70, 61, 28, "hx", false, HQ_Panel.tab[1])
        HQ_Panel.edit[5] = guiCreateEdit(163, 70, 61, 28, "hy", false, HQ_Panel.tab[1])
        HQ_Panel.edit[6] = guiCreateEdit(234, 70, 61, 28, "hz", false, HQ_Panel.tab[1])
        HQ_Panel.edit[7] = guiCreateEdit(92, 108, 61, 28, "rx", false, HQ_Panel.tab[1])
        HQ_Panel.edit[8] = guiCreateEdit(163, 108, 61, 28, "ry", false, HQ_Panel.tab[1])
        HQ_Panel.edit[9] = guiCreateEdit(234, 108, 61, 28, "rz", false, HQ_Panel.tab[1])
        HQ_Panel.label[1] = guiCreateLabel(94, 0, 59, 32, "- X -", false, HQ_Panel.tab[1])
        guiSetFont(HQ_Panel.label[1], "default-bold-small")
        guiLabelSetHorizontalAlign(HQ_Panel.label[1], "center", false)
        guiLabelSetVerticalAlign(HQ_Panel.label[1], "center")
        HQ_Panel.label[2] = guiCreateLabel(165, 0, 59, 32, "- Y -", false, HQ_Panel.tab[1])
        guiSetFont(HQ_Panel.label[2], "default-bold-small")
        guiLabelSetHorizontalAlign(HQ_Panel.label[2], "center", false)
        guiLabelSetVerticalAlign(HQ_Panel.label[2], "center")
        HQ_Panel.label[3] = guiCreateLabel(234, 0, 59, 32, "- Z -", false, HQ_Panel.tab[1])
        guiSetFont(HQ_Panel.label[3], "default-bold-small")
        guiLabelSetHorizontalAlign(HQ_Panel.label[3], "center", false)
        guiLabelSetVerticalAlign(HQ_Panel.label[3], "center")
        HQ_Panel.label[4] = guiCreateLabel(0, 32, 92, 28, "vorne Links", false, HQ_Panel.tab[1])
        guiSetFont(HQ_Panel.label[4], "default-bold-small")
        guiLabelSetHorizontalAlign(HQ_Panel.label[4], "center", false)
        guiLabelSetVerticalAlign(HQ_Panel.label[4], "center")
        HQ_Panel.label[5] = guiCreateLabel(0, 70, 92, 28, "hinten Links", false, HQ_Panel.tab[1])
        guiSetFont(HQ_Panel.label[5], "default-bold-small")
        guiLabelSetHorizontalAlign(HQ_Panel.label[5], "center", false)
        guiLabelSetVerticalAlign(HQ_Panel.label[5], "center")
        HQ_Panel.label[6] = guiCreateLabel(0, 108, 92, 28, "Rücklicht\nLinks", false, HQ_Panel.tab[1])
        guiSetFont(HQ_Panel.label[6], "default-bold-small")
        guiLabelSetHorizontalAlign(HQ_Panel.label[6], "center", false)
        guiLabelSetVerticalAlign(HQ_Panel.label[6], "center")

        HQ_Panel.tab[2] = guiCreateTab("[X]", HQ_Panel.tabpanel[1])  
	addEventHandler("onClientGUITabSwitched",getRootElement(),function()
		if source == HQ_Panel.tab[2] then
		destroyElement(HQ_Panel.tabpanel[1])
		isLichtEditorOpen = false
		showCursor(false)
		end
	end)
	
	addEventHandler("onClientGUIClick", HQ_Panel.button[1], function()
	local veh = getPedOccupiedVehicle(lp)
	if areBlinker then
		destroyElement(vornelinks)
		destroyElement(vornerechts)
		destroyElement(hintenlinks)
		destroyElement(hintenrechts)
		destroyElement(ruecklinks)
		destroyElement(rueckrechts)
		areBlinker = false
	end
	areBlinker = true
	vornelinks, vornerechts = createMarker(1,1,20,"corona",0.3, 255, 150, 0, 255), createMarker(1,1,20,"corona",0.3, 255, 150, 0, 255)
	hintenlinks, hintenrechts = createMarker(1,1,20,"corona",0.3, 255, 150, 0, 255), createMarker(1,1,20,"corona",0.3, 255, 150, 0, 255)
	ruecklinks, rueckrechts = createMarker(1,1,20,"corona",0.3, 255, 255, 255, 255), createMarker(1,1,20,"corona",0.3, 255, 255, 255, 255)
	attachElements(vornelinks,veh,tonumber(guiGetText(HQ_Panel.edit[1])),tonumber(guiGetText(HQ_Panel.edit[2])),tonumber(guiGetText(HQ_Panel.edit[3])))
	attachElements(vornerechts,veh,-tonumber(guiGetText(HQ_Panel.edit[1])),tonumber(guiGetText(HQ_Panel.edit[2])),tonumber(guiGetText(HQ_Panel.edit[3])))
	attachElements(hintenlinks,veh,tonumber(guiGetText(HQ_Panel.edit[4])),tonumber(guiGetText(HQ_Panel.edit[5])),tonumber(guiGetText(HQ_Panel.edit[6])))
	attachElements(hintenrechts,veh,-tonumber(guiGetText(HQ_Panel.edit[4])),tonumber(guiGetText(HQ_Panel.edit[5])),tonumber(guiGetText(HQ_Panel.edit[6])))
	attachElements(ruecklinks,veh,tonumber(guiGetText(HQ_Panel.edit[7])),tonumber(guiGetText(HQ_Panel.edit[8])),tonumber(guiGetText(HQ_Panel.edit[9])))
	attachElements(rueckrechts,veh,-tonumber(guiGetText(HQ_Panel.edit[7])),tonumber(guiGetText(HQ_Panel.edit[8])),tonumber(guiGetText(HQ_Panel.edit[9])))
	end,false)
	
	addEventHandler("onClientGUIClick", HQ_Panel.button[2], function()
	local veh = getPedOccupiedVehicle(lp)
	outputChatBox("['"..getVehicleName(veh).."'] = { {-"..guiGetText(HQ_Panel.edit[1])..", "..guiGetText(HQ_Panel.edit[2])..", "..guiGetText(HQ_Panel.edit[3]).."}, {-"..guiGetText(HQ_Panel.edit[4])..", "..guiGetText(HQ_Panel.edit[5])..", "..guiGetText(HQ_Panel.edit[6]).."}, {"..guiGetText(HQ_Panel.edit[7])..", "..guiGetText(HQ_Panel.edit[8])..", "..guiGetText(HQ_Panel.edit[9]).."} },")
	end, false)
end
addCommandHandler("bg",showBlinkerGui)



--[[
local sx,sy = guiGetScreenSize(lp)


local nameCol = createColSphere(0,0,0,25)
attachElements(nameCol,lp)
	addEventHandler("onClientRender",getRootElement(),function()
		for k,v in ipairs (getElementsWithinColShape(nameCol,"player")) do
			--if v ~= localPlayer then
		
				local lx,ly,lz = getPedBonePosition(lp,8)
				local x,y,z = getPedBonePosition(v,8)
				local cx, cy, cz = getCameraMatrix(lp)
				local diff = getDistanceBetweenPoints3D(x,y,z,cx,cy,cz)/3
	
				--if isLineOfSightClear(x,y,z,lx, ly, lz) == true then
					local x1,y1 = getScreenFromWorldPosition(x,y,z+0.5*diff)--Name
					local x2,y2 = getScreenFromWorldPosition(x,y,z+0.4*diff)--Armor
					local x3,y3 = getScreenFromWorldPosition(x,y,z+0.3*diff)--HP
					local veh = getPedOccupiedVehicle(v)
					if veh then
						if getVehicleController(veh)==v then
							local health = getElementHealth(veh)
							health = math.max(health - 250, 0)/750
							local p = -510*(health^2)
							local r,g = math.max(math.min(p + 255*health + 255, 255), 0), math.max(math.min(p + 765*health, 255), 0)
							
							dxDrawText(getPlayerName(v),x2,y2,x2,y2,tocolor(255,255,255,255),2,"sans","center")
							dxDrawRectangle(x3-150,y3,300,25, tocolor(0, 0, 0, 150)) --HP Bar Hintergrund schwarz
							dxDrawRectangle(x3-146,y3+4,292,17, tocolor(r, g, 0, 150)) --HP Bar Hintergrund dunkelrot
							dxDrawRectangle(x3-146,y3+4,292*health,17, tocolor(r, g, 0, 150))
						else
							dxDrawText(getPlayerName(v),x3,y3,x3,y3,tocolor(255,255,255,255),2,"sans","center")
						end
					else
						if x1 and y1 and x2 and y2 and x3 and y3 then
							dxDrawRectangle(x3-100,y3,200,25, tocolor(0, 0, 0, 150)) --HP Bar Hintergrund schwarz
							dxDrawRectangle(x3-96,y3+4,192,17, tocolor(150, 10, 10, 150)) --HP Bar Hintergrund dunkelrot
							dxDrawRectangle(x3-96,y3+4,192/100*getElementHealth(v),17, tocolor(200, 20, 20, 150))
							
							if getPedArmor(v) ~= 0 then
								dxDrawText(getPlayerName(v),x1,y1,x1,y1,tocolor(255,255,255,255),2,"sans","center")
								dxDrawRectangle(x2-100,y2,200,25, tocolor(0, 0, 0, 150)) --Armor Bar Hintergrund schwarz
								dxDrawRectangle(x2-96,y2+4,192,17, tocolor(150, 150, 150, 150)) --Armor Bar Hintergrund grau
								dxDrawRectangle(x2-96,y2+4,192/100*getPedArmor(v),17, tocolor(200, 200, 200, 150))
							else
								dxDrawText(getPlayerName(v),x2,y2,x2,y2,tocolor(255,255,255,255),2,"sans","center")
							end
							
						end
					end
				--end
			--end
		end
	end)
--]]





















local myTexture = dxCreateTexture("Coach.png")
if not myTexture then print("Konnte die Textur nicht erstellen!") end

addEventHandler("onClientResourceStart", resourceRoot, function()
  local shader = dxCreateShader("shader.fx")
	  if shader then
		dxSetShaderValue(shader, "Tex0", myTexture)
		engineApplyShaderToWorldTexture(shader, "coach92decals128")
	  end 
end)















setDevelopmentMode(true)


