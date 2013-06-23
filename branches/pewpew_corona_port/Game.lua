require("GameConstants")
require("Queue")
--require("rapanui-sdk/RNPhysics")
--[[
	Game Class:
	Responsible for managing all managers of the game.
	width: 600
	height: 800
	
]]

Game = {}

--I PUT THIS SHIT HERE!!! YOU CAN'T STOP THE RAWK HAWK!!!
	--this is the only audio things ever!!!!!
MOAIUntzSystem.initialize(44100, 1000) --set up the sound the for MOAI because counting frames is for straight up G's!!!S

MOAIUntzSystem.setVolume(1) --set the initial volume
volumeValue = MOAIUntzSystem.getVolume() --get the volume you shit
	
--creates a generic sound that can be used by other things that are in the Game screen
sound = MOAIUntzSound.new()

local sceneGroup = RNGroup:new()

--[[local gameLogic = RNThread.new();
gameLogic.addEnterFrame(updateHaters);
gameLogic.addEnterFrame(updateBackground);
]]--

RNThread = new 

function createBoss()
	local newBoss = nil
	if currentLevel == level0 then
		newBoss = Hater_BIGBOSSU:new(-100000, -10000, 0.8, 0.8, "sprites/boss_01.png", sceneGroup)
	end
	if currentLevel == level1 then
		newBoss = Hater_FIRECROTCH(-10000, -10000, 0.8, 0.8, "sprites/boss_02.png", sceneGroup)
	end
	if currentLevel == level2 then
		newBoss = Hater_LIGHTBIKE(-10000, -10000, 0.8, 0.8, "sprites/boss_03.png", sceneGroup)
	end
	
	return newBoss
end

function fireSecondaryWeapon(event)
	player:fireSecondaryWeapon()
end

function createSecondaryFireButton()
	fireSubButton = RNFactory.createButton("sprites/sub_unpressed.png", {
		--text = "Fire Subweapon",
		imageOver = "sprites/sub_pressed.png",
		top = 550,
		left = 200,
		size = 16,
		width = 100,
		height = 50,
		--onTouchDown = button1TouchDown,
		onTouchUp = fireSecondaryWeapon,
		font = "arial-rounded.TTF"
	})
	sceneGroup:insert(fireSubButton)
end

--Updates the background so it loops in a continuous cycle
function updateBackground()
	background.y = background.y + 1
	if background.y >= 750 then
		background.y = 0
	end
end

function createHealthBar()
	local healthWidgetScreenLoc = HEALTH_BAR_REGISTRATION_X_LOC - PLAYER_HEALTHBAR_MAX / 2
	local healthWidgetScreenYLoc = 15
	local healthWidgetWidth = 20
	healthWidget = RNFactory.createRect(healthWidgetScreenLoc, healthWidgetScreenYLoc, PLAYER_HEALTHBAR_MAX, healthWidgetWidth, { rgb = {0, 255, 0} } )
	sceneGroup:insert(healthWidget)
end

function createPowahBar()
	local powahBarScreenYLoc = POWAH_BAR_REGISTRATION_Y_LOC - PLAYER_MAXPOWAH / 2
	local powahBarScreenXLoc = 7
	local powahBarHeight = 100
	powahBar = RNFactory.createRect(powahBarScreenXLoc, powahBarScreenYLoc, 20, PLAYER_POWAHBAR_MAX, { rgb = {0, 0, 255} })
	sceneGroup:insert(powahBar)
end

--Displays a green health bar at the top of the screen.
function displayHealth()
	healthWidget.scaleX = (player.health / PLAYER_MAXHEALTH)
	if oldScaleX ~= healthWidget.scaleX then
		healthWidget.x = HEALTH_BAR_REGISTRATION_X_LOC - ((1-healthWidget.scaleX) * PLAYER_HEALTHBAR_MAX) / 2
		if healthWidget.scaleX >= 0.3 and healthWidget.scaleX <= 0.6 then
			healthWidget:setPenColor(255, 255, 0)
		end
		else if healthWidget.scaleX <= 0.3 then
			healthWidget:setPenColor(255, 0, 0)
		end
	end
	
	oldScaleX = healthWidget.scaleX
end


function displayPowah()
	powahBar.scaleY = (player.powah / PLAYER_MAXPOWAH)
	if oldScaleY ~= powahBar.scaleY then
		powahBar.y = POWAH_BAR_REGISTRATION_Y_LOC - (powahBar.scaleY * PLAYER_POWAHBAR_MAX) / 2
	end
		oldScaleY = powahBar.scaleY
end


function createHealthText()
	healthText = RNFactory.createBitmapText("HEALTH", {
        parentGroup = sceneGroup,
        image = "images/kromasky.png",
        charcodes = " ABCDEFGHIJKLMNOPQRSTUVWXYZ/0123456789:;?!\"%',.",
        top = 10,
        left = 150,
        charWidth = 16,
        charHeight = 16
    })
	
	sceneGroup:insert(healthText)
end

function createAmmoText()
   ammoText = RNFactory.createText("SUB 0", {
      parentGroup = sceneGroup,
      size = 25,
      top = 450,
      left = 340,
      width = 200,
      height = 50
   })
   sceneGroup:insert(ammoText)
end

function displayAmmoText()
   if (player.secondaryWeapon) then
      ammoText.text = "SUB " .. player.secondaryWeapon.ammo
   end
end

function createPowahText()
	powahText = RNFactory.createBitmapText("POWAH", {
        parentGroup = sceneGroup,
        image = "images/kromasky.png",
        charcodes = " ABCDEFGHIJKLMNOPQRSTUVWXYZ/0123456789:;?!\"%',.",
        top = 510,
        left = 3,
        charWidth = 16,
        charHeight = 16
    })
	
	sceneGroup:insert(powahText)
end
--[[
	FUNCTION NAME: createHaterList

	Description: Creates a list of haters that are placed off screen and will be put on screen
	when called to.
]]--
function createHaterList()
	local temp = nil
	for i = 1, 10, 1 do
		temp = Hater_Honkey:new(-1000 + i * 300, -1000, 0.25, 0.25, "sprites/enemy_02.png", sceneGroup)
		Queue.insertFront(haterHonkeyOutofViewList, temp)
	end
	
	for i = 1, 10, 1 do
		temp = Hater_Cracka:new(-2000 + i * 300, -2000, 0.25, 0.25, "sprites/enemy_03.png", sceneGroup)
		Queue.insertFront(haterCrackaOutofViewList, temp)
	end
	
	for i = 1, 10, 1 do
		temp = Hater_SkimMilk:new(-3000 + i * 300, -3000, 0.25, 0.25, "sprites/enemy_05.png", sceneGroup)
		Queue.insertFront(haterSkimMilkOutofViewList, temp)
	end
	
	for i = 1, 10, 1 do
		temp = Hater_TheFuzz:new(-4000 + i * 300, -4000, 0.15, 0.15, "sprites/enemy_03.png", sceneGroup)
		Queue.insertFront(haterTheFuzzOutofViewList, temp)
	end
	
	for i = 1, 10, 1 do
		temp = Hater_Pig:new(-5000 + i * 300, -5000, 0.25, 0.25, "sprites/enemy_04.png", sceneGroup)
		Queue.insertFront(haterPigOutofViewList, temp)
	end
	
	for i = 1, 10, 1 do
		temp = Hater_FatBoy:new(-6000 + i * 300, -6000, 0.25, 0.25, "sprites/enemy_01.png", sceneGroup)
		Queue.insertFront(haterFatBoyOutofViewList, temp)
	end
	
	
	for i = 1, 10, 1 do
		temp = Hater_Redneck:new(-7000 + i * 300, -7000, 0.75, 0.75, "sprites/enemy_08.png", sceneGroup)
		Queue.insertFront(haterRedneckOutofViewList, temp)
	end	
end

function moveHaterToTopOfScreen(inViewList, outOfViewList, xLoc)
	--print("moving hater to screen")
	if outOfViewList.size > 0 then
		--10 columns in the level editor
		local hater = Queue.removeBack(outOfViewList)
		hater.sprite.x = (xLoc - 1) * hater.sprite.originalWidth
		hater.sprite.y = -200
		Queue.insertFront(inViewList, hater)
		haterList[hater] = hater
	end
end

function moveHaterOffScreen(hater)
	if Hater_Honkey:made(hater) then
		Queue.insertFront(haterHonkeyOutofViewList, hater)
		hater.sprite.x = -3000 + haterHonkeyInViewList.size * 300
		hater.sprite.y = -1000
	elseif Hater_Cracka:made(hater) then
		Queue.insertFront(haterCrackaOutofViewList, hater)
		hater.sprite.x = -2000 + haterCrackaInViewList.size * 300
		hater.sprite.y = -2000
	elseif Hater_SkimMilk:made(hater) then
		Queue.insertFront(haterSkimMilkOutofViewList, hater)
		hater.sprite.x = -3000 + haterSkimMilkInViewList.size * 300
		hater.sprite.y = -3000
	elseif Hater_TheFuzz:made(hater) then
		Queue.insertFront(haterTheFuzzOutofViewList, hater)
		hater.sprite.x = -4000 + haterTheFuzzInViewList.size * 300
		hater.sprite.y = -4000
	elseif Hater_Pig:made(hater) then
		Queue.insertFront(haterPigOutofViewList, hater)
		hater.sprite.x = -5000 + haterPigInViewList.size * 300
		hater.sprite.y = -5000
	elseif Hater_FatBoy:made(hater) then
		Queue.insertFront(haterFatBoyOutofViewList, hater)
		hater.sprite.x = -6000 + haterFatBoyInViewList.size * 300
		hater.sprite.y = -2000
	elseif Hater_Redneck:made(hater) then
		Queue.insertFront(haterRedneckOutofViewList, hater)
		hater.sprite.x = -4000 + haterRedneckInViewList.size * 300
		hater.sprite.y = -3000
	elseif Hater_BIGBOSSU:made(hater) then
		hater.sprite.x = -10000
		hater.sprite.y = -10000
	end
	
	haterList[hater] = nil
end

function updateHaters(step)
	if step % 30 == 0 then
		local wave = createNewHaterSet(currentLevel)
		
		if wave ~= nil then
			for i = 1, #wave, 1 do
				local haterId = wave[i]
				if haterId == 1 then
					moveHaterToTopOfScreen(haterHonkeyInViewList, haterHonkeyOutofViewList, i)
				elseif haterId == 2 then
					moveHaterToTopOfScreen(haterCrackaInViewList, haterCrackaOutofViewList, i)
				elseif haterId == 3 then
					moveHaterToTopOfScreen(haterSkimMilkInViewList, haterSkimMilkOutofViewList, i)
				elseif haterId == 4 then
					moveHaterToTopOfScreen(haterPigInViewList, haterPigOutofViewList, i)
				elseif haterId == 5 then
					moveHaterToTopOfScreen(haterTheFuzzInViewList, haterTheFuzzOutofViewList, i)
				elseif haterId == 6 then
					boss.sprite.x = 120
					boss.sprite.y = -100
					haterList[boss] = boss
				elseif haterId == 7 then
					moveHaterToTopOfScreen(haterFatBoyInViewList, haterFatBoyOutofViewList, i)
				elseif haterId == 8 then
					moveHaterToTopOfScreen(haterRedneckInViewList, haterRedneckOutofViewList, i)
				end
			end
		else
			playerWon = true
		end
	end
	
	local enemeiesOnScreen = true
	for enemy1 in pairs (haterList) do
		enemiesOnScreen = false
		haterList[enemy1]:update(player)
		if not enemy1.alive then
			moveHaterOffScreen(enemy1)
		end
	end
	if playerWon and enemiesOnScreen then
		director:showScene("MainMenu", "fade")
	end
end


--[[
	FUNCTION NAME: createBulletList

	Description: Creates a list of haters that are placed off screen and will be put on screen
	when called to.
]]--



function Game.onCreate()
	--Constants and shit
	
	pauseGame = false;
	cannotFire = false;
	
	BACKGROUND_WIDTH = 400
	BACKGROUND_HEIGHT = 0

	enemySpawnRate = 50
	
	screenWidth = 480
	screenHeight = 750

	haterList = {}

	haterSkimMilkInViewList = Queue.new()
	haterSkimMilkOutofViewList = Queue.new()

	haterCrackaInViewList = Queue.new()
	haterCrackaOutofViewList = Queue.new()

	haterHonkeyInViewList = Queue.new()
	haterHonkeyOutofViewList = Queue.new()
	
	haterPigInViewList = Queue.new()
	haterPigOutofViewList = Queue.new()
	
	haterTheFuzzInViewList = Queue.new()
	haterTheFuzzOutofViewList = Queue.new()
	
	haterFatBoyInViewList = Queue.new()
	haterFatBoyOutofViewList = Queue.new()
	
	haterRedneckInViewList = Queue.new()
	haterRedneckOutofViewList = Queue.new()
	--instance of the game
	
	playerbulletnumber = 1
	--level number of the game
	currentLevel = setLevel(currentLevelNumber)
	--currentLevelNumber = currentLevelNumber + 1

	expolisionList = {}

	playerWon = false

	maxPlayerLevel = 0
	step = 0
	
	player = nil
	
	background = RNFactory.createImage('sprites/bg_spacesm.png')
	
	
	background.x = 225
	background.y = 0
	
	background.scaleX = 2.1
	--background.scaleY = 2
	
	sceneGroup:insert(background)
	
	
	RNPhysics.setCollisions("begin")
	RNPhysics.start()
	
	player = Player:new(200, 600, 0.3, 0.3, "sprites/player_01.png", sceneGroup)
	
	dollazText = RNFactory.createText("Dollaz : " .. mainInventory.dollaz, { size = 25, top = 10, left = 10, width = 200, height = 25 })
	
	
	dollazText.x = -25
	dollazText.y = 5
	
	RNPhysics.setGravity(0, 0)
	
	-- Inventory instantiation, I moved this because it needs to be global
	mainInventory:equip(player, sceneGroup)
   mainInventory:equipSecondaryWeapon(player, sceneGroup)
	boss = createBoss()
	createHaterList()
	
	sceneGroup:insert(dollazText)
	RNPhysics.addEventListener("collision", onCollide)
		
	pauseButton = RNFactory.createButton("sprites/pause_pressed.png", {
		--text = "||", --pause
		imageOver = "sprites/pause_unpressed.png",
		top = 650,
		left = 10,
		size = 50,
		width = 50,
		height = 50,
		--onTouchDown = button1TouchDown,
		onTouchUp = pauseButtonUP,
		font = "arial-rounded.TTF"
	})
	
	createSecondaryFireButton()
	
	autoFireOnButton = RNFactory.createButton("sprites/fire_off_unpressed.png", {
		--text = "AutoFire is OFF", --pause
		imageOver = "sprites/fire_off_pressed.png",
		top = 650,
		left = 10,
		size = 12,
		width = 50,
		height = 50,
		--onTouchDown = button1TouchDown,
		onTouchUp = autoFireOn,
		font = "arial-rounded.TTF"
	})	
	
		autoFireOffButton = RNFactory.createButton("sprites/fire_on_unpressed.png", {
		--text = "AutoFire is ON", --pause
		imageOver = "sprites/fire_on_pressed.png",
		top = 650,
		left = 10,
		size = 12,
		width = 50,
		height = 50,
		--onTouchDown = button1TouchDown,
		onTouchUp = autoFireOff,
		font = "arial-rounded.TTF"
	})	
	
		sceneGroup:insert(autoFireOnButton)
		sceneGroup:insert(autoFireOffButton)
	
	autoFireOffButton.x = 40
	autoFireOnButton.x = 4000
	autoFireOffButton.y = 670
	autoFireOnButton.y = 670
	
	pauseScreen = RNFactory.createImage("images/background-green.png")
	pauseScreen.x = 400
	pauseScreen.y = 0
	pauseScreen.scaleX = 3.5
	pauseScreen.scaleY = 5.5
	sceneGroup:insert(pauseScreen)
	
	resumeButton = RNFactory.createButton("sprites/play_unpressed.png", {
		--text = "Resume Game",
		imageOver = "sprites/play_pressed.png",
		top = 300,
		left = 100,
		size = 16,
		width = 50,
		height = 50,
		--onTouchDown = button1TouchDown,
		onTouchUp = resumeButtonUP,
		font = "arial-rounded.TTF"
	})
	
	quitButton= RNFactory.createButton("sprites/backtomenu_unpressed.png", {
		--text = "Quit",
		imageOver = "sprites/backtomenu_pressed.png",
		top = 650,
		left = 200,
		width = 50,
		height = 50,
		--onTouchDown = button1TouchDown,
		onTouchUp = button1UP,
		font = "arial-rounded.TTF"
	})
	
	
	text1 = RNFactory.createBitmapText("PAUSED", {
        parentGroup = sceneGroup,
        image = "images/kromasky.png",
        charcodes = " ABCDEFGHIJKLMNOPQRSTUVWXYZ/0123456789:;?!\"%',.",
        top = 55,
        left = 10,
        charWidth = 16,
        charHeight = 16
    })

	sceneGroup:insert(quitButton)
	sceneGroup:insert(pauseButton)
	sceneGroup:insert(resumeButton)
	sceneGroup:insert(text1)
	
	MOAIUntzSystem.initialize(44100, 1000) --set up the sound the for MOAI because counting frames is for straight up G's!!!S

	MOAIUntzSystem.setVolume(1) --set the initial volume
	volumeValue = MOAIUntzSystem.getVolume() --get the volume you shit
	
	--sets up the background music to be played
	--backgroundmusic:load("gameBackMusic.ogg")
	--backgroundmusic:play()
	gameBGM:play()
	
	createHealthBar()
	createPowahBar()
	
	updateFunc = RNListeners:addEventListener("enterFrame", update)
	touchFunc = RNListeners:addEventListener("touch", onTouchEvent)
	

	
	createHealthText()
    createAmmoText()
	createPowahText()
	return sceneGroup
end

function autoFireOn(event)
	autoFireOffButton.x = 40
	autoFireOnButton.x = 4000
	cannotFire = false;
end

function autoFireOff(event)
	autoFireOffButton.x = 4000
	autoFireOnButton.x = 40
	cannotFire = true;    
end

function button1UP(event)
    if not director:isTransitioning() then
        director:showScene("MainMenu", "fade")
    end
    player.needsReload = true
end

function pauseButtonUP(event)
    pauseGame = true
	RNPhysics.stop()
end

function resumeButtonUP(event)
    pauseGame = false
	world:start()
end



function Game.onEnd()
	healthWidget.visible = false
	powahBar.visible = false
	gameBGM:stop()  --stop the game screen music
	for i = 1, table.getn(sceneGroup.displayObjects), 1 do
       sceneGroup.displayObjects[1]:remove();
    end
	healthWidget = nil
	powahBar = nil
	RNListeners:removeEventListener("enterFrame", updateFunc)--
	RNListeners:removeEventListener("touch", touchFunc)
	mainInventory.equippedGameWeapon:unload()
   mainInventory.equippedSecondaryGameWeapon:unload()
	
	destroyParticleManager()
	
end

function onCollide(event)
	if (event.phase == "begin") then
		event.object1.objRef:onHit(event.object1.objRef, event.object2.objRef)
		event.object2.objRef:onHit(event.object2.objRef, event.object1.objRef)
	end
	
end

function onTouchEvent(event)

	if player.alive and not pauseGame
	then
			if event.phase == "began" then
				--player:move(event.x, event.y) --we don't want the player jumping to a position
				player.isFiring = true;
			end

			if event.phase == "moved" then
			
			--relative touch movement
				moveX = (event.x - prevX)
				moveY = (event.y - prevY)
			--soften up the movement a bit to prevent touch screen weirdness
				if moveX > 20 then moveX = 20 end
				if moveX < -20 then moveX = -20 end
				if moveY > 20 then moveY = 20 end
				if moveY < -20 then moveY = -20 end
			--prevent the player from moving offscreen
				if (player.sprite.x + moveX > 450) or (player.sprite.x + moveX < 20) then moveX = 0 end
				if (player.sprite.y + moveY > 800) or (player.sprite.y + moveY < 20) then moveY = 0	end
			
				player:move(player.sprite.x + moveX, player.sprite.y + moveY)
				--print('Player\'s new loc')
				--print(event.x)
				--print(event.y)
			end
			if event.phase == "ended" then			
				player.isFiring = false;
			end
			
	end
	prevX = event.x
	prevY = event.y
end


function update(enterFrame)
--An updating main thread to keep track of moving props that require deletion at some point
--mainThread = MOAICoroutine.new() --changed from MOAIThread because MOAIThread is a bitch ass weiner. fo real.
--mainThread:run(self:executeGameLoop())

if not pauseGame then

	if not player.alive then
		player.sprite.x = 5000
		player.sprite.y = 5000
	end

	updateHaters(step)
	updateParticleEmitters()
	mainInventory:checkBullets(haterList)
	mainInventory:checkBombs(haterList)
	
	--[[if (step % 100 == 0) then
		player:fireSecondaryWeapon()
	end--]]
	
	if step % 20 == 0 and player.isFiring and not cannotFire and (player.powah - player.weapon.energyCost) > 0 then --firing check
		player:fire()
	elseif player.powah < 100 and step % 30 == 0 then --regeneration check
		player.powah = player.powah + 3
	end
	
	displayHealth()
	displayPowah()
   displayAmmoText()
	step = step + 1
	updateBackground()
	
		pauseScreen.x = 40000
		pauseScreen.y = 0
		
		resumeButton.x = 5500
        resumeButton.y = 1000
		
		quitButton.x = 6500
        quitButton.y = 1300
		
		fireSubButton.x = 40
		fireSubButton.y = 590
		
		pauseButton.x = 410
        pauseButton.y = 670
		
		if cannotFire then
			autoFireOffButton.x = 4000
			autoFireOnButton.x = 40
		else
			autoFireOffButton.x = 40
			autoFireOnButton.x = 4000
		end
		
		text1.x = 5500
        text1.y = 1000
		
		dollazText.text = "Dollaz : " .. mainInventory.dollaz
	
end
	if pauseGame then
		pauseScreen.x = 400
		pauseScreen.y = 0
		pauseScreen:setAlpha(0.3)
		
		pauseButton.x = 5500
        pauseButton.y = 1000
		fireSubButton.x = 8000
		
		autoFireOffButton.x = 4000
		autoFireOnButton.x = 4000
		
		resumeButton.x = 410
		resumeButton.y = 670
		quitButton.x = 250
        quitButton.y = 380
		
		text1.x = 200
        text1.y = 150
	end
	
end

return Game

