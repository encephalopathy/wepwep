require("Queue")
require("Hater_Cracka")
require("Hater_Honkey")
require("Hater_SkimMilk")
require("Hater_Pig")
require("Hater_FatBoy")
require("Hater_TheFuzz")
require("Hater_Redneck")

AIDirector = {}

local haterList = {}

local haterSkimMilkInViewList = nil
local haterSkimMilkOutofViewList = nil

local haterCrackaInViewList = nil
local haterCrackaOutofViewList = nil

local haterHonkeyInViewList = nil
local haterHonkeyOutofViewList = nil
	
local haterPigInViewList = nil
local haterPigOutofViewList = nil
	
local haterTheFuzzInViewList = nil
local haterTheFuzzOutofViewList = nil
	
local haterFatBoyInViewList = nil
local haterFatBoyOutofViewList = nil
	
local haterRedneckInViewList = nil
local haterRedneckOutofViewList = nil

local function createHaterList(currentLevel, player)

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

	local temp = nil
	for i = 1, 10, 1 do
		temp = Hater_Honkey:new(sceneGroup, "sprites/enemy_02.png", -1000 + i * 300, -1000, 0, 100, 100)
		Queue.insertFront(haterHonkeyOutofViewList, temp)
	end
	
	
	for i = 1, 10, 1 do
		temp = Hater_Cracka:new(sceneGroup, "sprites/enemy_03.png", -2000 + i * 300, -2000, 0, 100, 100)
		Queue.insertFront(haterCrackaOutofViewList, temp)
	end
	
	for i = 1, 10, 1 do
		temp = Hater_SkimMilk:new(sceneGroup, "sprites/enemy_05.png", -3000 + i * 300, -3000, 0, 100, 100)
		Queue.insertFront(haterSkimMilkOutofViewList, temp)
	end
	
	for i = 1, 10, 1 do
		temp = Hater_TheFuzz:new(sceneGroup, "sprites/enemy_03.png", -4000 + i * 300, -4000, 0, 100, 100, player)
		Queue.insertFront(haterTheFuzzOutofViewList, temp)
	end
	
	for i = 1, 10, 1 do
		temp = Hater_Pig:new(sceneGroup, "sprites/enemy_04.png", -5000 + i * 300, -5000, 0, 100, 100)
		Queue.insertFront(haterPigOutofViewList, temp)
	end
	
	for i = 1, 10, 1 do
		temp = Hater_FatBoy:new(sceneGroup, "sprites/enemy_01.png", -6000 + i * 300, -6000, 0, 100, 100)
		Queue.insertFront(haterFatBoyOutofViewList, temp)
	end
	
	
	for i = 1, 10, 1 do
		temp = Hater_Redneck:new(sceneGroup,  "sprites/enemy_08.png", -7000 + i * 300, -7000, 0, 100, 100)
		Queue.insertFront(haterRedneckOutofViewList, temp)
	end
end

local function moveHaterToTopOfScreen(inViewList, outOfViewList, xLoc)
	--print("moving hater to screen")
	if outOfViewList.size > 0 then
		--10 columns in the level editor
		local hater = Queue.removeBack(outOfViewList)
		hater.sprite.x = (xLoc - 1) * hater.sprite.width
		hater.sprite.y = -200
		Queue.insertFront(inViewList, hater)
		haterList[hater] = hater
	end
end

--[[
	Zack put your shit here, this is when haters spawn, you can get rid 
	of the timer function in AIDirector.initialize if you want to.
--]]
local function spawnHater(event)
		local wave = createNewHaterSet(AIDirector.currentLevel)
		
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
			enemyTimer = nil
		end
	return true
end

local function moveHaterOffScreen(hater)
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

local function updateHaters()
	local enemeiesOnScreen = true
	for enemy1 in pairs (haterList) do
		enemiesOnScreen = false
		haterList[enemy1]:update(AIDirector.player)
		if not enemy1.alive then
			moveHaterOffScreen(enemy1)
		end
	end
	if playerWon and enemiesOnScreen then
		--director:showScene("MainMenu", "fade")
	end
end

function AIDirector.initialize(player, currentLevel)
	createHaterList(currentLevel, player)
	AIDirector.haterList = haterList
	if player ~= nil then
		AIDirector.player = player
	else
		print('Player was not initialized in AIDirector')
	end
	if currentLevel ~= nil then 
		AIDirector.currentLevel = currentLevel
	else
		print('Did not initialize the current level for the AI Director to use')
	end
	local haterTimer = timer.performWithDelay(30, spawnHater, 0)
end

function AIDirector.update()
	updateHaters()
end

function AIDirector.pause()
	timer.pause(haterTimer)
end

function AIDirector.resume()
	timer.resume(haterTimer)
end

function AIDirector.deactivate()
	Runtime:removeEventListener("enterFrame", AIDirector.update)
end

Runtime:addEventListener("enterFrame", AIDirector.update)


