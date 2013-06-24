--[[
--
-- RapaNui
--
-- by Ymobe ltd  (http://ymobe.co.uk)
--
-- LICENSE:
--
-- RapaNui uses the Common Public Attribution License Version 1.0 (CPAL) http://www.opensource.org/licenses/cpal_1.0.
-- CPAL is an Open Source Initiative approved
-- license based on the Mozilla Public License, with the added requirement that you attribute
-- Moai (http://getmoai.com/) and RapaNui in the credits of your program.
]]




--[[
	  
	  SCENES MUST HAVE 
	  1)a equipMenu where all instances are inserted
	  2)onCreate function in which we create everything
	  3)onEnd function in which we clean the instance

]] --

EquipMenu = {}

local storyboard = require( "storyboard" )
local equipMenu = storyboard.newScene()

local widget = require "widget"


--init Scene
function EquipMenu:createScene()
    --add things to equipMenu
	local background = display.createImageRect("sprites/sheet_metal.png", 240, 480)

	background:sendToBottom()
	
	local text1 = RNFactory.createText("Dollaz : " .. mainInventory.dollaz, { size = 25, top = 5, left = 5, width = 200, height = 50 })
	text1:setTextColor(15, 40, 20)
	equipMenu:insert(text1)
	
	local ammoText = RNFactory.createText("Ammo :" .. mainInventory.SecondaryWeapons[1].ammo .. " left", { size = 25, top = 5, left = 305, width = 200, height = 50 })
	ammoText:setTextColor(15, 40, 20)
	equipMenu:insert(ammoText)
	
	rect = RNFactory.createRect(00, 0, 480, 750, { rgb = { 20, 70, 10 } })
	rect:setAlpha(0.01)
	--equipMenu:insert(rect)
	
	weaponRect = RNFactory.createRect(30, 150, 150, 450, { rgb = {30, 20, 10 } })
	weaponRect:setAlpha(0.9)
	--equipMenu:insert(weaponRect)
	
	subWeaponRect = RNFactory.createRect(280, 150, 150, 450, { rgb = {10, 30, 20 } })
	subWeaponRect:setAlpha(0.9)
	--equipMenu:insert(subWeaponRect)
	
	local equipText = RNFactory.createBitmapText("EQUIP MENU", {
        parentGroup = equipMenu,
        image = "images/kromasky.png",
        charcodes = " ABCDEFGHIJKLMNOPQRSTUVWXYZ/0123456789:;?!\"%',.",
        top = 55,
        left = 10,
        charWidth = 16,
        charHeight = 16
    })
	equipText.x = 150
	equipText.y = 65
	equipMenu:insert(equipText)
	
	local mainText = RNFactory.createBitmapText("MAIN WEAPONS", {
        parentGroup = equipMenu,
        image = "images/kromasky.png",
        charcodes = " ABCDEFGHIJKLMNOPQRSTUVWXYZ/0123456789:;?!\"%',.",
        top = 55,
        left = 10,
        charWidth = 16,
        charHeight = 16
    })
	mainText.x = 30
	mainText.y = 130
	equipMenu:insert(mainText)
	
	local subText = RNFactory.createBitmapText("SUB WEAPONS", {
        parentGroup = equipMenu,
        image = "images/kromasky.png",
        charcodes = " ABCDEFGHIJKLMNOPQRSTUVWXYZ/0123456789:;?!\"%',.",
        top = 55,
        left = 10,
        charWidth = 16,
        charHeight = 16
    })
	subText.x = 280
	subText.y = 130
	equipMenu:insert(subText)
	
	    regularshot = RNFactory.createButton("images/button-plain.png",

        {
            text = "Regular",
            parentGroup = equipMenu,
            imageOver = "images/button-over.png",
            font = "dwarves.TTF",
            top = 160,
            left = 50,
            size = 16,
            width = 200,
            height = 50,
            onTouchUp = regular
        })
		
		spreadshot = RNFactory.createButton("images/button-plain.png",

        {
            text = "Spread",
            parentGroup = equipMenu,
            imageOver = "images/button-over.png",
            font = "dwarves.TTF",
            top = 260,
            left = 50,
            size = 16,
            width = 200,
            height = 50,
            onTouchUp = spread
        })
		
		sineshot = RNFactory.createButton("images/button-plain.png",
        {
            text = "Sine",
            parentGroup = equipMenu,
            imageOver = "images/button-over.png",
            font = "dwarves.TTF",
            top = 360,
            left = 50,
            size = 16,
            width = 200,
            height = 50,
            onTouchUp = sine
        })
		
		doubleshot = RNFactory.createButton("images/button-plain.png",
        {
            text = "Double",
            parentGroup = equipMenu,
            imageOver = "images/button-over.png",
            font = "dwarves.TTF",
            top = 460,
            left = 50,
            size = 16,
            width = 200,
            height = 50,
            onTouchUp = double
        })
		
		homingshot = RNFactory.createButton("images/button-plain.png",
        {
            text = "Homing",
            parentGroup = equipMenu,
            imageOver = "images/button-over.png",
            font = "dwarves.TTF",
            top = 560,
            left = 50,
            size = 16,
            width = 200,
            height = 50,
            onTouchUp = homing
        })
		
		subBomb = RNFactory.createButton("images/button-plain.png",
        {
            text = "Bombs",
            parentGroup = equipMenu,
            imageOver = "images/button-over.png",
            font = "dwarves.TTF",
            top = 180,
            left = 300,
            size = 16,
            width = 200,
            height = 50,
            onTouchUp = bomb
        })
		
		subRocket = RNFactory.createButton("images/button-plain.png",
        {
            text = "Rockets",
            parentGroup = equipMenu,
            imageOver = "images/button-over.png",
            font = "dwarves.TTF",
            top = 300,
            left = 300,
            size = 16,
            width = 200,
            height = 50,
            onTouchUp = rocket
        })
		
		subFreezeMissile = RNFactory.createButton("images/button-plain.png",
        {
            text = "Freeze Missile",
            parentGroup = equipMenu,
            imageOver = "images/button-over.png",
            font = "dwarves.TTF",
            top = 420,
            left = 300,
            size = 16,
            width = 200,
            height = 50,
            onTouchUp = freeze
        })

    local button3 = RNFactory.createButton("images/button-plain.png",

        {
            text = "Back",
            parentGroup = equipMenu,
            imageOver = "images/button-over.png",
            font = "dwarves.TTF",
            top = 650,
            left = 190,
            size = 16,
            width = 200,
            height = 50,
            onTouchUp = back
        })
		
	highlightWeaponRect = RNFactory.createRect(280, 150, 110, 90, { rgb = {30, 130, 90 } })
	highlightWeaponRect:setAlpha(0.9)
	
	highlightSubWeaponRect = RNFactory.createRect(280, 150, 110, 90, { rgb = {130, 30, 90 } })
	highlightSubWeaponRect:setAlpha(0.9)
		
	--if the music IS NOT PLAYING then
	--this check needs to be here to make sure that when you come back here,
	--it doesn't start the music over again
	--if equipBGMPlaying == false then 
	--	equipBGM:play()
	--	equipBGMPlaying = true
	--end

	setThingsUp()
    return equipMenu
end

function setThingsUp()
	if not mainInventory.permission[1] then regularshot.x = 5000 end
	if not mainInventory.permission[2] then spreadshot.x = 5000 end
	if not mainInventory.permission[3] then sineshot.x = 5000 end
	if not mainInventory.permission[5] then doubleshot.x = 5000 end
	if not mainInventory.permission[4] then homingshot.x = 5000 end
	if not mainInventory.permission[6] then end
	if not mainInventory.permission[7] then end	
	
	if (mainInventory.equippedWeapon == 1) 
	then 
		highlightWeaponRect.x = regularshot.x
		highlightWeaponRect.y = regularshot.y 
	end
	if (mainInventory.equippedWeapon == 2) 
	then  
		highlightWeaponRect.x = spreadshot.x
		highlightWeaponRect.y = spreadshot.y 
	end
	if (mainInventory.equippedWeapon == 3) 
	then  
		highlightWeaponRect.x = sineshot.x
		highlightWeaponRect.y = sineshot.y 
	end
	if (mainInventory.equippedWeapon == 5) 
	then  
		highlightWeaponRect.x = doubleshot.x
		highlightWeaponRect.y = doubleshot.y 
	end
	if (mainInventory.equippedWeapon == 4) 
	then  
		highlightWeaponRect.x = homingshot.x
		highlightWeaponRect.y = homingshot.y 
	end
	
	if (mainInventory.equippedSecondaryWeapon == 1) 
	then  
		highlightSubWeaponRect.x = subBomb.x
		highlightSubWeaponRect.y = subBomb.y
	end
	if (mainInventory.equippedSecondaryWeapon == 2) 
	then  
		highlightSubWeaponRect.x = subFreezeMissile.x
		highlightSubWeaponRect.y = subFreezeMissile.y
	end
	if (mainInventory.equippedSecondaryWeapon == 3) 
	then  
		highlightSubWeaponRect.x = subRocket.x
		highlightSubWeaponRect.y = subRocket.y
	end
	--highlightSubWeaponRect:bringToFront()
	--highlightWeaponRect:bringToFront()
end

function regular(event)
	mainInventory:equipOneWeapon(1)
		setThingsUp()
end

function spread(event)
	mainInventory:equipOneWeapon(2)
		setThingsUp()
end

function sine(event)
	mainInventory:equipOneWeapon(3)
		setThingsUp()
end

function double(event)
	mainInventory:equipOneWeapon(5)
		setThingsUp()
end

function homing(event)
	mainInventory:equipOneWeapon(4)
		setThingsUp()
end

function bomb(event)
	mainInventory:selectSecondaryWeapon(1)
		setThingsUp()
end

function rocket(event)
	mainInventory:selectSecondaryWeapon(3)
		setThingsUp()
end

function freeze(event)
	mainInventory:selectSecondaryWeapon(2)
		setThingsUp()
end


function back(event) --go back to the MainMenu
	--print('Please work')
    if not director:isTransitioning() then
		equipBGM:stop()
		equipBGMPlaying = false
        director:showScene("MainMenu", "crossfade")
    end
end


function EquipMenu.onEnd()
    for i = 1, table.getn(equipMenu.displayObjects), 1 do
        equipMenu.displayObjects[1]:remove();
    end
end


return EquipMenu