-----------------------------------------------------------------------------------------
--
-- MenuStore.lua
--
-----------------------------------------------------------------------------------------
require("Inventory")
require("Utility")
require("BGM")

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- include Corona's "widget" library
local widget = require "widget"

--------------------------------------------

-- forward declarations and other locals
local buyButton, sellButton, backButton

-- 'onRelease' event listener for newGameButton
local function onBuyButtonRelease()
	-- go to level1.lua scene
	storyboard.gotoScene( "MenuBuy", "fade", 500 )
	return true	-- indicates successful touch
end

local function onSellButtonRelease()
	storyboard.gotoScene("MenuSell", "fade", 500)
	return true
end

local function onBackButtonRelease()
    audio.stop()
	storyboard.gotoScene("menu", "fade", 500)
	return true
end

local function onDefaultRelease()
	print('hello this button does not do anything')
	return true
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
	local background = display.newImageRect( "sprites/sheet_metal.png", display.contentWidth, display.contentHeight )
	background:setReferencePoint( display.TopLeftReferencePoint )
	background.x, background.y = 0, 0
	
	-- create/position logo/title image on upper-half of the screen
	--local titleLogo = display.newImageRect( "logo.png", 264, 42 )
	--titleLogo:setReferencePoint( display.CenterReferencePoint )
	--titleLogo.x = display.contentWidth * 0.5
	--titleLogo.y = 100
	
	-- create a widget button (which will loads level1.lua on release)
	local centerOfScreenX = display.contentWidth*0.5
	
	buyButton = createBttn(widget, display, "Buy", display.contentWidth*0.25, 
		display.contentHeight*0.4, onBuyButtonRelease)
	sellButton = createBttn(widget, display, "Sell", display.contentWidth*0.75,
		display.contentHeight*0.4, onSellButtonRelease)
	backButton = createBttn(widget, display, "Back", centerOfScreenX, 
		display.contentHeight *0.7, onBackButtonRelease)
	
	--playButton:setReferencePoint( display.CenterReferencePoint )
	--playButton.x = display.contentWidth*0.5
	--playButton.y = display.contentHeight - 125
	
	-- all display objects must be inserted into group
	
	--group:insert( titleLogo )
	group:insert( background )
	group:insert( buyButton )
	group:insert( sellButton )
	group:insert( backButton )
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	playBGM("/sounds/bgmusic/shopMusic.ogg")
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

	if buyButton then
		buyButton:removeSelf()	-- widgets must be manually removed
		buyButton = nil
	end

	if sellButton then
		sellButton:removeSelf()
		sellButton = nil
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

