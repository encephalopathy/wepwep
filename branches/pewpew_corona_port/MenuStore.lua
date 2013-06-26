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

StoreMenu = {}

local sceneGroup = RNGroup:new()


--init Scene
function StoreMenu.onCreate()
    --add things to sceneGroup
local background = RNFactory.createImage("sprites/sheet_metal.png", { parentGroup = sceneGroup }); background.x = 240; background.y = 420; background.scaleX=2; background.scaleY=3;

	    local button1 = RNFactory.createButton("images/button-plain.png",

        {
            text = "Buy Menu",
            parentGroup = sceneGroup,
            imageOver = "images/button-over.png",
            font = "dwarves.TTF",
            top = 150,
            left = 80,
            size = 16,
            width = 200,
            height = 250,
            onTouchUp = buyMenu
        })
	
	    local button2 = RNFactory.createButton("images/button-plain.png",

        {
            text = "Sell Menu",
            parentGroup = sceneGroup,
            imageOver = "images/button-over.png",
            font = "dwarves.TTF",
            top = 150,
            left = 280,
            size = 16,
            width = 200,
            height = 250,
            onTouchUp = sellMenu
        })
	

    local button3 = RNFactory.createButton("images/button-plain.png",

        {
            text = "Back to Main Menu",
            parentGroup = sceneGroup,
            imageOver = "images/button-over.png",
            font = "dwarves.TTF",
            top = 580,
            left = 185,
            size = 16,
            width = 200,
            height = 50,
            onTouchUp = mainMenu
        })
		
		
	local equipText = RNFactory.createBitmapText("MAIN STORE", {
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
		
        --if the music IS NOT PLAYING then
		--this check needs to be here to make sure that when you come back here,
		--it doesn't start the music over again
		if storeBGMPlaying == false then 
			storeBGM:play()
			storeBGMPlaying = true
		end
		
    return sceneGroup
end



function mainMenu(event)
	--print('Please work')
    if not director:isTransitioning() then
		storeBGM:stop() --putting this here will stop the music when you hit the Main Menu button
		storeBGMPlaying = false
        director:showScene("MainMenu", "crossfade")
    end
end

function buyMenu(event)
	--print('Please work')
    if not director:isTransitioning() then
        director:showScene("BuyMenu", "crossfade")
    end
end

function sellMenu(event)
	--print('Please work')
    if not director:isTransitioning() then
        director:showScene("SellMenu", "crossfade")
    end
end


function StoreMenu.onEnd()
    for i = 1, table.getn(sceneGroup.displayObjects), 1 do
        sceneGroup.displayObjects[1]:remove();
    end
end


return StoreMenu