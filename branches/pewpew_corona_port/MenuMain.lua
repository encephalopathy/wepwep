--[[
	  
	  SCENES MUST HAVE 
	  1)a sceneGroup where all instances are inserted
	  2)onCreate function in which we create everything
	  3)onEnd function in which we clean the instance

]] --

MainMenu = {}

local sceneGroup = RNGroup:new()


--init Scene
function MainMenu.onCreate()
    --add things to sceneGroup
	local background = RNFactory.createImage("sprites/splash_main_menu.png", { parentGroup = sceneGroup }); background.x = 240; background.y = 380; background.scaleX=1; background.scaleY=1;
	--local background = display.newImage()
		
	    local continuebutton = RNFactory.createButton("images/button-plain.png",
        {
            text = "Continue Game",
            parentGroup = sceneGroup,
            imageOver = "images/button-over.png",
            font = "dwarves.TTF",
            top = 450,
            left = 80,
            size = 16,
            width = 200,
            height = 50,
            onTouchUp = continueGame
        })

    local newgamebutton = RNFactory.createButton("images/button-plain.png",

        {
            text = "New Game",
            parentGroup = sceneGroup,
            imageOver = "images/button-over.png",
            font = "dwarves.TTF",
            top = 450,
            left = 280,
            size = 16,
            width = 200,
            height = 100,
            onTouchUp = newGame
        })
		
		local storebutton = RNFactory.createButton("images/button-plain.png",
        {
            text = "Weapon Shop",
            parentGroup = sceneGroup,
            imageOver = "images/button-over.png",
            font = "dwarves.TTF",
            top = 600,
            left = 80,
            size = 16,
            width = 200,
            height = 150,
            onTouchUp = store
        })
		
	
		
		local equipbutton = RNFactory.createButton("images/button-plain.png",
        {
            text = "Equip Ride",
            parentGroup = sceneGroup,
            imageOver = "images/button-over.png",
            font = "dwarves.TTF",
            top = 600,
            left = 280,
            size = 16,
            width = 200,
            height = 200,
            onTouchUp = equip
        })

	mainMenuBGM:play()
	--doesn't need a check because this will always need to be playing
	
	mainMenuSound = MOAIUntzSound.new()
	enterGamePath = "enterGame.ogg"
	enterStorePath = "enterStore.ogg"
	enterEquipRide = "enterEquip.ogg"
	
    return sceneGroup
end



function newGame(event)
	--print('Please work')
    if not director:isTransitioning() then
		mainMenuBGM:stop() --stop the BGM for the main menu
		mainMenuSound:load(enterGamePath)
		mainMenuSound:play()
        director:showScene("Game", "crossfade")
    end
end

function continueGame(event)
	--print('Please work')
    if not director:isTransitioning() then
		mainMenuBGM:stop() --stop the BGM for the main menu
		mainMenuSound:load(enterGamePath)
		mainMenuSound:play()
        director:showScene("Game", "crossfade")
    end
end

function store(event)
	--print('Please work')
    if not director:isTransitioning() then
		mainMenuBGM:stop() --stop the BGM for the main menu
		mainMenuSound:load(enterStorePath)
		mainMenuSound:play()
        director:showScene("StoreMenu", "crossfade")
    end
end

function equip(event)
	--print('Please work')
    if not director:isTransitioning() then
		mainMenuBGM:stop() --stop the BGM for the main menu
		mainMenuSound:load(enterEquipRide)
		mainMenuSound:play()
        director:showScene("EquipMenu", "crossfade")
    end
end

function MainMenu.onEnd()
    for i = 1, table.getn(sceneGroup.displayObjects), 1 do
        sceneGroup.displayObjects[1]:remove();
    end
	--backgroundmusic:stop()
end


return MainMenu