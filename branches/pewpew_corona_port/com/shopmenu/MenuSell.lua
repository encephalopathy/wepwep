-----------------------------------------------------------------------------------------
--
-- MenuSell.lua
--
-----------------------------------------------------------------------------------------
require "com.Utility"
require "com.Inventory"
require "com.managers.BGM"

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- include Corona's "widget" library
local widget = require "widget"

--------------------------------------------

-- forward declarations and other locals
local regularButton, sineButton, doubleButton, homingButton, spreadButton, yesButton, noButton, okButton, backButton
local weapon, dollaztext, confirmText, denyText, sellText

-- 'onRelease' event listeners
local function back()	
	-- go to menu
	storyboard.gotoScene( "com.shopmenu.MenuStore", "fade", 500 )
	return true	-- indicates successful touch
end

function yes(event)
    if (weapon == "regular") then
		mainInventory:lock(1)
		mainInventory.dollaz = mainInventory.dollaz + regularButton.cost/2	
    end
  
    if (weapon == "spread") then
		mainInventory:lock(2)
		mainInventory.dollaz = mainInventory.dollaz + spreadButton.cost/2	
    end
  
    if (weapon == "sine") then
		mainInventory:lock(3)
		mainInventory.dollaz = mainInventory.dollaz + sineButton.cost/2		
    end
  
    if (weapon == "double") then
		mainInventory:lock(5)
		mainInventory.dollaz = mainInventory.dollaz + doubleButton.cost/2	
    end
  
    if (weapon == "homing") then
		mainInventory:lock(4)
		mainInventory.dollaz = mainInventory.dollaz + homingButton.cost/2		
	end		

	setThingsUp() 
end

function no(event)
	setThingsUp()
end

function ok(event)
	setThingsUp()		
end

function confirmPurchase(weapon1)
	pauseScreen.x = 0
    weaponno = -1
    weaponcost = 0

 if (weapon1 == "regular") then
	weapon = "regular"
	weaponno = 1
    weaponcost = regularButton.cost
  end
  
  if (weapon1 == "spread") then
	weapon = "spread"
	weaponno = 2
    weaponcost = spreadButton.cost
  end
  
  if (weapon1 == "sine") then
	 weapon = "sine"
     weaponno = 3
     weaponcost = sineButton.cost
  end 
  if (weapon1 == "double") then
	weapon = "double"
	weaponno = 5
    weaponcost = doubleButton.cost
  end
  
  if (weapon1 == "homing") then
	weapon = "homing"
	weaponno = 4
    weaponcost = homingButton.cost
  end
		
	if not(mainInventory.equippedWeapon == weaponno) then

		yesButton.x = display.contentWidth * 0.3
		
		noButton.x = display.contentWidth * 0.7		
		
		confirmText.text = "Sell ".. weapon .. " for " .. weaponcost/2 .. " dollaz?"
		confirmText.x = display.contentWidth * 0.3
	else
		okButton.x = display.contentWidth * 0.5
		denyText.x = display.contentWidth * 0.5		
	end
	sendAway()
end

function regular(event)
	 confirmPurchase("regular")
end

function spread(event)
	confirmPurchase("spread")
end

function sine(event)
	confirmPurchase("sine")
end

function double(event)
	confirmPurchase("double")
end

function homing(event)
	confirmPurchase("homing")
end


function sendAway()
	regularButton.x = 5000 
	spreadButton.x = 5000
    sineButton.x = 5000 
	doubleButton.x = 5000 
	homingButton.x = 5000 
	backButton.x = 5000

end

function setThingsUp()
	if not mainInventory.permission[1] then regularButton.x = 5000
	else regularButton.x = display.contentWidth * 0.3 end
	if not mainInventory.permission[2] then spreadButton.x = 5000 
	else spreadButton.x = display.contentWidth * 0.3 end
	if not mainInventory.permission[3] then sineButton.x = 5000 
	else sineButton.x = display.contentWidth * 0.3 end
	if not mainInventory.permission[5] then doubleButton.x = 5000 
	else doubleButton.x = display.contentWidth * 0.3 end
	if not mainInventory.permission[4] then homingButton.x = 5000 
	else homingButton.x = display.contentWidth * 0.3 end
	--if not mainInventory.permission[6] then end
	--if not mainInventory.permission[7] then end
	backButton.x = display.contentWidth * 0.5

	dollaztext.text = "Dollaz : " .. mainInventory.dollaz

	okButton.x = 3000		
	yesButton.x = 3000		
	noButton.x = 3000
	pauseScreen.x = 4000	
	confirmText.x = 2000	
	denyText.x = 2000
end


-----------------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
-- 
-- NOTE: Code outside of listener functions (below) will only be executed once,
--		 unless storyboard.removeScene() is called.
-- 
-----------------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	
	
	-- display a background image
	local background = display.newImageRect( "com/resources/art/background/sheet_metal.png", display.contentWidth, display.contentHeight )
	background:setReferencePoint( display.TopLeftReferencePoint )
	background.x, background.y = 0, 0

	pauseScreen = display.newImageRect( "com/resources/art/background/background-green.png", display.contentWidth, display.contentHeight )
	pauseScreen:setReferencePoint( display.TopLeftReferencePoint )
	pauseScreen.x, pauseScreen.y = 0, 0
	pauseScreen.alpha = 0.55

	-- create a widget button (which will loads level1.lua on release)
	local centerOfScreenX = display.contentWidth*0.5
	
	--display.newText( string, left, top, font, size )
	 dollaztext = display.newText( "Dollaz : " .. mainInventory.dollaz, display.contentWidth * 0.1, display.contentHeight * 0.05, native.systemFont, 25 )
	local ammotext = display.newText( "Ammo :" .. mainInventory.SecondaryWeapons[1].ammoAmount, display.contentWidth * 0.7, display.contentHeight * 0.05, native.systemFont, 25 )
	local selltext = display.newText( "SELL MENU",  display.contentWidth * 0.35,  display.contentHeight * 0.1, native.systemFont, 25 )
	 confirmText = display.newText( "...",  display.contentWidth * 0.5,  display.contentHeight * 0.3, native.systemFont, 25 )
	 denyText = display.newText( "That weapon is equipped and cannot be sold.",  display.contentWidth * 0.25,  display.contentHeight * 0.3, native.systemFont, 25 )



    regularButton = createBttn(widget, display, "Regular - " .. (250/2), display.contentWidth * 0.3, 
		display.contentHeight * 0.3, regular)
    sineButton = createBttn(widget, display, "Sine - " .. (1000/2), display.contentWidth * 0.3, 
		display.contentHeight * 0.4, sine)
	doubleButton = createBttn(widget, display, "Double - " .. (500/2), display.contentWidth * 0.3, 
		display.contentHeight * 0.5, double)
	homingButton = createBttn(widget, display, "Homing - " .. (350/2), display.contentWidth * 0.3, 
		display.contentHeight * 0.6, homing)
	spreadButton = createBttn(widget, display, "Spread - " .. (800/2), display.contentWidth * 0.3, 
		display.contentHeight * 0.7, spread)

	regularButton.cost = 250
	spreadButton.cost = 1000
	sineButton.cost = 500
	doubleButton.cost = 350
	homingButton.cost = 800
 
    yesButton = createBttn(widget, display, "Yes", display.contentWidth * 0.35, 
		display.contentHeight * 0.4, yes)
	noButton = createBttn(widget, display, "No", display.contentWidth * 0.65, 
		display.contentHeight * 0.4, no)
	okButton = createBttn(widget, display, "Ok", display.contentWidth * 0.7, 
		display.contentHeight * 0.5, ok)

	backButton = createBttn(widget, display, "Back", display.contentWidth * 0.5, 
		display.contentHeight * 0.9, back)


	group:insert( background )
	group:insert( pauseScreen )
	
	group:insert( dollaztext )
	group:insert( ammotext )
	group:insert( selltext )
	group:insert( confirmText )
	group:insert( denyText )

	group:insert( regularButton )
	group:insert( sineButton )
	group:insert( doubleButton )
	group:insert( spreadButton )
	group:insert( homingButton )

	group:insert( yesButton )
	group:insert( noButton )
	group:insert( okButton )

	group:insert( backButton )

	setThingsUp()
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	-- INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	-- INSERT code here (e.g. stop timers, remove listenets, unload sounds, etc.)
	
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
	
	if backButton then
		backButton:removeSelf()	-- widgets must be manually removed
		backButton = nil
	end
	
	if regularButton then
		regularButton:removeSelf()
		regularButton = nil
	end

	if sineButton then
		sineButton:removeSelf()
		sineButton = nil
	end
	if doubleButton then
		doubleButton:removeSelf()
		doubleButton = nil
	end
	if spreadButton then
		spreadButton:removeSelf()
		spreadButton = nil
	end
	if homingButton then
		homingButton:removeSelf()
		homingButton = nil
	end
	if yesButton then
		bombsButton:removeSelf()
		bombsButton = nil
	end
	if noButton then
		rocketsButton:removeSelf()
		rocketsButton = nil
	end
	if okButton then
		freezeButton:removeSelf()
		freezeButton = nil
	end
end

-----------------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
-----------------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched whenever before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-----------------------------------------------------------------------------------------

return scene