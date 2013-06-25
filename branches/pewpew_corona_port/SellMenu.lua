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
	  1)a sceneGroup where all instances are inserted
	  2)onCreate function in which we create everything
	  3)onEnd function in which we clean the instance

]] --

SellMenu = {}

local sceneGroup = RNGroup:new()


--init Scene
function SellMenu.onCreate()
    --add things to sceneGroup
	
	weapon = ""
	
    local background = RNFactory.createImage("sprites/sheet_metal.png", { parentGroup = sceneGroup }); background.x = 240; background.y = 420; background.scaleX=2; background.scaleY=3;
	
	text1 = RNFactory.createText("Dollaz : " .. mainInventory.dollaz, { size = 25, top = 5, left = 5, parentGroup = sceneGroup, width = 200, height = 50 })
	sceneGroup:insert(text1)
	
	confirmText = RNFactory.createText("Buy " .. weapon .. " for 0 dollaz?", { size = 25, top = 5000, left = 5000, parentGroup = sceneGroup, width = 200, height = 50 })
	sceneGroup:insert(confirmText)
	
	denyText = RNFactory.createText("You cannot sell equipped weapons.", { size = 25, top = 2005, left = 2005, parentGroup = sceneGroup, width = 200, height = 50 })
	sceneGroup:insert(denyText)
	
		local equipText = RNFactory.createBitmapText("SELL MENU", {
        parentGroup = sceneGroup,
        image = "images/kromasky.png",
        charcodes = " ABCDEFGHIJKLMNOPQRSTUVWXYZ/0123456789:;?!\"%',.",
        top = 55,
        left = 10,
        charWidth = 16,
        charHeight = 16
    })
	equipText.x = 150
	equipText.y = 65
	sceneGroup:insert(equipText)
		
		pauseScreen = RNFactory.createImage("images/background-green.png")
		sceneGroup:insert(pauseScreen)	
		
	     regularshot = RNFactory.createButton("images/button-plain.png",
        {
            text = "Single Shot - 250",
            parentGroup = sceneGroup,
            imageOver = "images/button-over.png",
            font = "dwarves.TTF",
            top = 150,
            left = 10,
            size = 16,
            width = 200,
            height = 50,
            onTouchUp = confirmPurchaseRegular
        })
		regularshot.cost = 250
		
		 spreadshot = RNFactory.createButton("images/button-plain.png",

        {
            text = "Spread Shot - 1000",
            parentGroup = sceneGroup,
            imageOver = "images/button-over.png",
            font = "dwarves.TTF",
            top = 280,
            left = 10,
            size = 16,
            width = 200,
            height = 50,
            onTouchUp = confirmPurchaseSpread
        })
		spreadshot.cost = 1000
		
		 sineshot = RNFactory.createButton("images/button-plain.png",
        {
            text = "Sine Shot - 500",
            parentGroup = sceneGroup,
            imageOver = "images/button-over.png",
            font = "dwarves.TTF",
            top = 410,
            left = 10,
            size = 16,
            width = 200,
            height = 50,
            onTouchUp = confirmPurchaseSine
        })
		sineshot.cost = 500
		
				 doubleshot = RNFactory.createButton("images/button-plain.png",
        {
            text = "Double Shot - 350",
            parentGroup = sceneGroup,
            imageOver = "images/button-over.png",
            font = "dwarves.TTF",
            top = 150,
            left = 280,
            size = 16,
            width = 200,
            height = 50,
            onTouchUp = confirmPurchaseDouble
        })
		doubleshot.cost = 350
		
		 homingshot = RNFactory.createButton("images/button-plain.png",
        {
            text = "Homing Shot - 800",
            parentGroup = sceneGroup,
            imageOver = "images/button-over.png",
            font = "dwarves.TTF",
            top = 280,
            left = 280,
            size = 16,
            width = 200,
            height = 50,
            onTouchUp = confirmPurchaseHoming
        })
		homingshot.cost = 800

     button3 = RNFactory.createButton("images/button-plain.png",

        {
            text = "Back",
            parentGroup = sceneGroup,
            imageOver = "images/button-over.png",
            font = "dwarves.TTF",
            top = 600,
            left = 10,
            size = 16,
            width = 200,
            height = 50,
            onTouchUp = back
        })
		
		
		yesButton = RNFactory.createButton("images/button-plain.png",
        {
            text = "Yes",
            parentGroup = sceneGroup,
            imageOver = "images/button-over.png",
            font = "dwarves.TTF",
            top = 7000,
            left = 10,
            size = 16,
            width = 200,
            height = 50,
            onTouchUp = yes
        })
		
		noButton = RNFactory.createButton("images/button-plain.png",
        {
            text = "No",
            parentGroup = sceneGroup,
            imageOver = "images/button-over.png",
            font = "dwarves.TTF",
            top = 6000,
            left = 10,
            size = 16,
            width = 200,
            height = 50,
            onTouchUp = no
        })

		okButton = RNFactory.createButton("images/button-plain.png",
        {
            text = "Ok",
            parentGroup = sceneGroup,
            imageOver = "images/button-over.png",
            font = "dwarves.TTF",
            top = 5000,
            left = 10,
            size = 16,
            width = 200,
            height = 50,
            onTouchUp = ok
        })
	

	setThingsUp()
		
    return sceneGroup
end

function sendAway()
	regularshot.x = 5000 
	spreadshot.x = 5000
    sineshot.x = 5000 
	doubleshot.x = 5000 
	homingshot.x = 5000 
	button3.x = 1000

end

function setThingsUp()
	if not mainInventory.permission[1] then regularshot.x = 5000
	else regularshot.x = 200 end
	if not mainInventory.permission[2] then spreadshot.x = 5000 
	else spreadshot.x = 200 end
	if not mainInventory.permission[3] then sineshot.x = 5000 
	else sineshot.x = 200 end
	if not mainInventory.permission[5] then doubleshot.x = 5000 
	else doubleshot.x = 280 end
	if not mainInventory.permission[4] then homingshot.x = 5000 
	else homingshot.x = 280 end
	if not mainInventory.permission[6] then end
	if not mainInventory.permission[7] then end
	button3.x = 225
	pauseScreen.x = 4000
		pauseScreen.y = 900
		pauseScreen.scaleX = 2.5
		pauseScreen.scaleY = 5.5
		pauseScreen:setAlpha(0.3)	
end

function yes(event)

  if (weapon == "regular") then
	mainInventory:lock(1)
	regularshot.x = 5000
	mainInventory.dollaz = mainInventory.dollaz + regularshot.cost/2
	yesButton.x = 1000
	yesButton.y = 3000		
		
	noButton.x = 3000
	noButton.y = 3000		
  end
  
  if (weapon == "spread") then
	mainInventory:lock(2)
	spreadshot.x = 5000
	mainInventory.dollaz = mainInventory.dollaz + spreadshot.cost/2
	yesButton.x = 1000
	yesButton.y = 3000		
		
	noButton.x = 3000
	noButton.y = 3000		
  end
  
  if (weapon == "sine") then
	mainInventory:lock(3)
	sineshot.x = 5000
	mainInventory.dollaz = mainInventory.dollaz + sineshot.cost/2
	yesButton.x = 1000
	yesButton.y = 3000		
		
	noButton.x = 3000
	noButton.y = 3000		
  end
  
    if (weapon == "double") then
	mainInventory:lock(5)
	doubleshot.x = 5000
	mainInventory.dollaz = mainInventory.dollaz + doubleshot.cost/2
	yesButton.x = 1000
	yesButton.y = 3000		
		
	noButton.x = 3000
	noButton.y = 3000		
  end
  
    if (weapon == "homing") then
	mainInventory:lock(4)
	homingshot.x = 5000
	mainInventory.dollaz = mainInventory.dollaz + homingshot.cost/2
	yesButton.x = 1000
	yesButton.y = 3000		
		
	noButton.x = 3000
	noButton.y = 3000		
  end
  
		pauseScreen.x = 4000
		pauseScreen.y = 900
		pauseScreen.scaleX = 2.5
		pauseScreen.scaleY = 5.5
		pauseScreen:setAlpha(0.3)	
		
		confirmText.x = 2000
		confirmText.y = 2000	
		
		text1.text = "Dollaz : " .. mainInventory.dollaz
	setThingsUp()
  
end

function no(event)
yesButton.x = 1000
	yesButton.y = 3000		
		
	noButton.x = 3000
	noButton.y = 3000		
		pauseScreen.x = 4000
		pauseScreen.y = 900
		pauseScreen.scaleX = 2.5
		pauseScreen.scaleY = 5.5
		pauseScreen:setAlpha(0.3)	
		confirmText.x = 2000
		confirmText.y = 2000
			setThingsUp()
end

function ok(event)
	okButton.x = 3000
	okButton.y = 3000		
		pauseScreen.x = 4000
		pauseScreen.y = 900
		pauseScreen.scaleX = 2.5
		pauseScreen.scaleY = 5.5
		pauseScreen:setAlpha(0.3)	
		denyText.x = 2000
		denyText.y = 2000
	setThingsUp()		
end

function confirmPurchaseRegular(event)
	pauseScreen.x = 400
	pauseScreen.y = 0
		pauseScreen:setAlpha(0.3)
		
	if not(mainInventory.equippedWeapon == 1) then

		yesButton.x = 100
		yesButton.y = 300		
		
		noButton.x = 400
		noButton.y = 300		
		
		weapon = "regular"
		
		confirmText.text = "Sell ".. weapon .. " for " .. regularshot.cost/2 .. " dollaz?"
		confirmText.x = 120
		confirmText.y = 120		
	else
		okButton.x = 200
		okButton.y = 300
		denyText.x = 120
		denyText.y = 120		
	end
	sendAway()
end

function confirmPurchaseSpread(event)
	pauseScreen.x = 400
	pauseScreen.y = 0
			pauseScreen:setAlpha(0.3)
	
	if not (mainInventory.equippedWeapon == 2) then
		yesButton.x = 100
		yesButton.y = 300		
		
		noButton.x = 300
		noButton.y = 300		
		
		weapon = "spread"
		
		confirmText.text = "Sell ".. weapon .. " for " .. spreadshot.cost/2 .. " dollaz?"
		confirmText.x = 200
		confirmText.y = 200		
	else
		okButton.x = 200
		okButton.y = 300
		denyText.x = 200
		denyText.y = 200		
	end
	sendAway()	
end

function confirmPurchaseSine(event)
	pauseScreen.x = 400
	pauseScreen.y = 0
			pauseScreen:setAlpha(0.3)
	
	if not (mainInventory.equippedWeapon == 3) then
		yesButton.x = 100
		yesButton.y = 300		
		
		noButton.x = 300
		noButton.y = 300		
		
		weapon = "sine"
		
		confirmText.text = "Sell ".. weapon .. " for " .. sineshot.cost/2 .. " dollaz?"
		confirmText.x = 200
		confirmText.y = 200		
	else
		okButton.x = 200
		okButton.y = 300
		denyText.x = 200
		denyText.y = 200		
	end
		sendAway()
end

function confirmPurchaseDouble(event)
	pauseScreen.x = 400
	pauseScreen.y = 0
			pauseScreen:setAlpha(0.3)
	
	if not (mainInventory.equippedWeapon == 3) then
		yesButton.x = 100
		yesButton.y = 300		
		
		noButton.x = 300
		noButton.y = 300		
		
		weapon = "double"
		
		confirmText.text = "Sell ".. weapon .. " for " .. doubleshot.cost/2 .. " dollaz?"
		confirmText.x = 200
		confirmText.y = 200		
	else
		okButton.x = 200
		okButton.y = 300
		denyText.x = 200
		denyText.y = 200		
	end
		sendAway()
end

function confirmPurchaseHoming(event)
	pauseScreen.x = 400
	pauseScreen.y = 0
			pauseScreen:setAlpha(0.3)
	
	if not (mainInventory.equippedWeapon == 3) then
		yesButton.x = 100
		yesButton.y = 300		
		
		noButton.x = 300
		noButton.y = 300		
		
		weapon = "homing"
		
		confirmText.text = "Sell ".. weapon .. " for " .. homingshot.cost/2 .. " dollaz?"
		confirmText.x = 200
		confirmText.y = 200		
	else
		okButton.x = 200
		okButton.y = 300
		denyText.x = 200
		denyText.y = 200		
	end
		sendAway()
end


function back(event)
	--print('Please work')
    if not director:isTransitioning() then
        director:showScene("StoreMenu", "crossfade")
    end
end


function SellMenu.onEnd()
    for i = 1, table.getn(sceneGroup.displayObjects), 1 do
        sceneGroup.displayObjects[1]:remove();
    end
end


return SellMenu