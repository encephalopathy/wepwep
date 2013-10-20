-----------------------------------------------------------------------------------------
--
-- EquipMenu.lua
--
-----------------------------------------------------------------------------------------
require "com.Utility"
require "com.Inventory"
require "org.Object"
require "org.Queue"

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- include Corona's "widget" library
local widget = require "widget"

--------------------------------------------

-- forward declarations and other locals
local regularButton, sineButton, doubleButton, homingButton, spreadButton,
		bombsButton, rocketsButton, freezeButton, backButton, nextWeapon, 
		prevWeapon
		
local weaponIndex = 0
		
local carousel1, carousel2, carousel3, carousel4, carousel5

local weaponCarousel = {}

local carouselButton

-- 'onRelease' event listener for newGameButton
local function back()	
	-- go to menu
	storyboard.gotoScene( "com.mainmenu.MainMenu", "fade", 500 )
	return true	-- indicates successful touch
end

-- Function to handle button events
local function handleButtonEvent( event )
    local phase = event.phase 

    if "ended" == phase then
        print( "You pressed and released a button!" )
    end
end

local function equipWeapon(weaponNumber)
	--mainInventory:equipOneWeapon(1)
	mainInventory:equipOneWeapon(weaponNumber)
		--setThingsUp()
end

local function spread(event)
	--mainInventory:equipOneWeapon(2)
	equipOneWeapon(weaponNumber)
		setThingsUp()
end

local function sine(event)
	mainInventory:equipOneWeapon(3)
	
		setThingsUp()
end

local function double(event)
	mainInventory:equipOneWeapon(5)
		setThingsUp()
end

local function homing(event)
	mainInventory:equipOneWeapon(4)
		setThingsUp()
end

local function bombs(event)
	mainInventory:addSecondaryWeapon('Bomb')
		setThingsUp()
end

local function rockets(event)
	mainInventory:addSecondaryWeapon('Missile')
		setThingsUp()
end

local function freeze(event)
	mainInventory:addSecondaryWeapon('Freeze')
		setThingsUp()
end

local function nextWep(event)
	if(weaponIndex == weaponCarousel.last) then weaponIndex = weaponCarousel.first 
	else weaponIndex = weaponIndex + 1
	end
	setupWepCarousel()
end

local function prevWep(event)
	if(weaponIndex == weaponCarousel.first) then weaponIndex = weaponCarousel.last 
	else weaponIndex = weaponIndex - 1
	end
	setupWepCarousel()
end

function setupWepCarousel()
	--send away the old
	carousel1.x, carousel1.y = 200, 5000
	carousel2.x, carousel2.y = 200, 5000
	carousel3.x, carousel3.y = 200, 5000
	carousel4.x, carousel4.y = 200, 5000
	carousel5.x, carousel5.y = 200, 5000	
	
	--set-up the new
	weaponCarousel[weaponIndex].x, weaponCarousel[weaponIndex].y  = display.contentWidth * 0.5, display.contentHeight * 0.8
	
	if(weaponIndex == weaponCarousel.first) then 
	weaponCarousel[weaponCarousel.last].x, weaponCarousel[weaponCarousel.last].y = display.contentWidth * 0.3, display.contentHeight * 0.8
	weaponCarousel[weaponIndex + 1].x, weaponCarousel[weaponIndex + 1].y = display.contentWidth * 0.7, display.contentHeight * 0.8	
	
	elseif (weaponIndex == weaponCarousel.last) then 
	weaponCarousel[weaponIndex - 1].x, weaponCarousel[weaponIndex - 1].y = display.contentWidth * 0.3, display.contentHeight * 0.8
	weaponCarousel[weaponCarousel.first].x, weaponCarousel[weaponCarousel.first].y = display.contentWidth * 0.7, display.contentHeight * 0.8	
	
	else  
	weaponCarousel[weaponIndex - 1].x, weaponCarousel[weaponIndex - 1].y = display.contentWidth * 0.3, display.contentHeight * 0.8
	weaponCarousel[weaponIndex + 1].x, weaponCarousel[weaponIndex + 1].y = display.contentWidth * 0.7, display.contentHeight * 0.8	
	end
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
	
	weaponCarousel = Queue.new()

	-- display a background image
	local background = display.newImageRect("com/resources/art/background/sheet_metal.png",
	                                        display.contentWidth, display.contentHeight )

	background:setReferencePoint(display.TopLeftReferencePoint)
	background.x, background.y = 0, 0
	
	local bgRect = display.newRect(0, 0, display.contentWidth, display.contentHeight)
	bgRect:setFillColor(20, 70, 10, 130)
		
	--[[
	addSecondaryWeapon('Bomb')
	equipOneWeapon(weaponNumber) for primary weaons
	removeSecondaryWeapon(weaponName) for remvoing a secondary weapon
	--]]	
	
	carousel1 = widget.newButton
	{
		width = display.contentWidth/10,
		height = display.contentHeight/10,
		defaultFile = "com/resources/art/sprites/bomb_01.png",
		overFile = "com/resources/art/sprites/bomb_01.png",
		id = "button_1",
		label = "1",
		onEvent = equipWeapon(1),
	}				--= display.newImageRect("com/resources/art/sprites/bomb_01.png",
					--display.contentWidth/10, display.contentHeight/10 )
	carousel2 = widget.newButton
	{
		width = display.contentWidth/10,
		height = display.contentHeight/10,
		defaultFile = "com/resources/art/sprites/bomb_02.png",
		overFile = "com/resources/art/sprites/bomb_02.png",
		id = "button_2",
		label = "2",
		onEvent = equipWeapon(2),
	}
	carousel3= widget.newButton
	{
		width = display.contentWidth/10,
		height = display.contentHeight/10,
		defaultFile = "com/resources/art/sprites/bomb_03.png",
		overFile = "com/resources/art/sprites/bomb_03.png",
		id = "button_3",
		label = "3",
		onEvent = equipWeapon(3),
	}
	carousel4 = widget.newButton
	{
		width = display.contentWidth/10,
		height = display.contentHeight/10,
		defaultFile = "com/resources/art/sprites/bomb_04.png",
		overFile = "com/resources/art/sprites/bomb_04.png",
		id = "button_4",
		label = "4",
		onEvent = equipWeapon(4),
	}	
	carousel5 = widget.newButton
	{
		width = display.contentWidth/10,
		height = display.contentHeight/10,
		defaultFile = "com/resources/art/sprites/bomb_05.png",
		overFile = "com/resources/art/sprites/bomb_05.png",
		id = "button_5",
		label = "5",
		onEvent = equipWeapon(5),
	}	
	
	carousel1.x, carousel1.y = 200, 5000
	carousel2.x, carousel2.y = 200, 5000
	carousel3.x, carousel3.y = 200, 5000
	carousel4.x, carousel4.y = 200, 5000
	carousel5.x, carousel5.y = 200, 5000	
	
	Queue.insertFront(weaponCarousel, carousel5)
	Queue.insertFront(weaponCarousel, carousel4)
	Queue.insertFront(weaponCarousel, carousel3)
	Queue.insertFront(weaponCarousel, carousel2)
	Queue.insertFront(weaponCarousel, carousel1)
	
	weaponIndex = weaponCarousel.first
	
	--display.newText( string, left, top, font, size )
	local dollaztext = display.newText( "Dollaz : " .. mainInventory.dollaz, display.contentWidth * 0.1, display.contentHeight * 0.05, native.systemFont, 25 )
	local ammotext = display.newText( "Ammo :" .. mainInventory.SecondaryWeapons['Bomb'].ammoAmount, display.contentWidth * 0.7, display.contentHeight * 0.05, native.systemFont, 25 )
	local equiptext = display.newText( "EQUIP MENU",  display.contentWidth * 0.35,  display.contentHeight * 0.1, native.systemFont, 25 )
	local maintext = display.newText( "MAIN WEAPONS",  display.contentWidth * 0.1,  display.contentHeight * 0.2, native.systemFont, 25 )
	local subtext = display.newText( "SUB WEAPONS",  display.contentWidth * 0.55,  display.contentHeight * 0.2, native.systemFont, 25 )


    -- create the widget buttons
	local centerOfScreenX = display.contentWidth*0.5
	
    regularButton = createBttn(widget, display, "Regular", display.contentWidth * 0.3, 
		display.contentHeight * 0.3, regular)
    sineButton = createBttn(widget, display, "Sine", display.contentWidth * 0.3, 
		display.contentHeight * 0.4, sine)
	doubleButton = createBttn(widget, display, "Double", display.contentWidth * 0.3, 
		display.contentHeight * 0.5, double)
	homingButton = createBttn(widget, display, "Homing", display.contentWidth * 0.3, 
		display.contentHeight * 0.6, homing)
	spreadButton = createBttn(widget, display, "Spread", display.contentWidth * 0.3, 
		display.contentHeight * 0.7, spread)

 
    bombsButton = createBttn(widget, display, "Bombs", display.contentWidth * 0.7, 
		display.contentHeight * 0.3, bombs)
	rocketsButton = createBttn(widget, display, "Rockets", display.contentWidth * 0.7, 
		display.contentHeight * 0.4, rockets)
	freezeButton = createBttn(widget, display, "Freeze", display.contentWidth * 0.7, 
		display.contentHeight * 0.5, freeze)

	backButton = createBttn(widget, display, "Back", display.contentWidth * 0.5, 
		display.contentHeight * 0.9, back)

	prevWeapon = createBttn(widget, display, "<", display.contentWidth * 0.1, 
		display.contentHeight * 0.8, prevWep)
		
	nextWeapon = createBttn(widget, display, ">", display.contentWidth * 0.9, 
		display.contentHeight * 0.8, nextWep)
	
	--playButton:setReferencePoint( display.CenterReferencePoint )
	--playButton.x = display.contentWidth*0.5
	--playButton.y = display.contentHeight - 125
	
	-- all display objects must be inserted into group
	
	--group:insert( titleLogo )
	
	--bgRect:setStrokeColor(20, 70, 10, 130)

	highlightWeaponRect = display.newRect(180, 150, 150, 50)
	highlightWeaponRect:setFillColor(30, 130, 130, 150)
	--highlightWeaponRect:setStrokeColor(30, 130, 90, 230)

	highlightSubWeaponRect = display.newRect(280, 150, 150, 50)
	highlightSubWeaponRect:setFillColor(180, 70, 50, 150)
	--highlightSubWeaponRect:setStrokeColor(130, 30, 90, 230)

	group:insert( background )
	group:insert( bgRect )
	
	group:insert( dollaztext )
	group:insert( ammotext )
	group:insert( equiptext )
	group:insert( maintext )
	group:insert( subtext )

	group:insert( regularButton )
	group:insert( sineButton )
	group:insert( doubleButton )
	group:insert( spreadButton )
	group:insert( homingButton )

	group:insert( bombsButton )
	group:insert( rocketsButton )
	group:insert( freezeButton )

	group:insert( backButton )

	group:insert( highlightWeaponRect )
	group:insert( highlightSubWeaponRect )
	
	group:insert( carousel1 )
	group:insert( carousel2 )
	group:insert( carousel3 )
	group:insert( carousel4 )
	group:insert( carousel5 )
	
	group:insert( nextWeapon )
	group:insert( prevWeapon )
		
	setupWepCarousel()
	--setThingsUp()
end

function setThingsUp()
	if not mainInventory.permission[1] then regularButton.x = 5000 end
	if not mainInventory.permission[2] then spreadButton.x = 5000 end
	if not mainInventory.permission[3] then sineButton.x = 5000 end
	if not mainInventory.permission[5] then doubleButton.x = 5000 end
	if not mainInventory.permission[4] then homingButton.x = 5000 end
	if not mainInventory.permission[6] then end
	if not mainInventory.permission[7] then end	
	
	if (mainInventory.equippedWeapon == 1) 
	then 
		highlightWeaponRect.x = regularButton.x
		highlightWeaponRect.y = regularButton.y 
	end

	if (mainInventory.equippedWeapon == 2) 
	then  
		highlightWeaponRect.x = spreadButton.x
		highlightWeaponRect.y = spreadButton.y 
	end

	if (mainInventory.equippedWeapon == 3) 
	then  
		highlightWeaponRect.x = sineButton.x
		highlightWeaponRect.y = sineButton.y 
	end

	if (mainInventory.equippedWeapon == 5) 
	then  
		highlightWeaponRect.x = doubleButton.x
		highlightWeaponRect.y = doubleButton.y 
	end

	if (mainInventory.equippedWeapon == 4) 
	then  
		highlightWeaponRect.x = homingButton.x
		highlightWeaponRect.y = homingButton.y 
	end
	
	if (mainInventory.equippedSecondaryWeapon == 1) 
	then  
		highlightSubWeaponRect.x = bombsButton.x
		highlightSubWeaponRect.y = bombsButton.y
	end

	if (mainInventory.equippedSecondaryWeapon == 2) 
	then  
		highlightSubWeaponRect.x = freezeButton.x
		highlightSubWeaponRect.y = freezeButton.y
	end

	if (mainInventory.equippedSecondaryWeapon == 3) 
	then  
		highlightSubWeaponRect.x = rocketsButton.x
		highlightSubWeaponRect.y = rocketsButton.y
	end
	--highlightSubWeaponRect:bringToFront()
	--highlightWeaponRect:bringToFront()
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
	if bombsButton then
		bombsButton:removeSelf()
		bombsButton = nil
	end
	if rocketsButton then
		rocketsButton:removeSelf()
		rocketsButton = nil
	end
	if freezeButton then
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