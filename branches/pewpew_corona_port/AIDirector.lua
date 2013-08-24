require("Queue")
require("Hater_Cracka")
require("Hater_SkimMilk")
require("Hater_Pig")
require("Hater_FatBoy")
require("Hater_TheFuzz")
require("Hater_Redneck")
require("Hater_PooSlinger")
require("Hater_PootiePoo")

AIDirector = {}

local haterList = {}
local spawnClock 
--local haterGroup = display.newGroup()

--[[
local haterSkimMilkInViewList = Queue.new()
local haterSkimMilkOutofViewList = Queue.new()

local haterCrackaInViewList = Queue.new()
local haterCrackaOutofViewList = Queue.new()

local haterNormalInViewList = Queue.new()
local haterNormalOutofViewList = Queue.new()
	
local haterPigInViewList = Queue.new()
local haterPigOutofViewList = Queue.new()
	
local haterTheFuzzInViewList = Queue.new()
local haterTheFuzzOutofViewList = Queue.new()
	
local haterFatBoyInViewList = Queue.new()
local haterFatBoyOutofViewList = Queue.new()
	
local haterRedneckInViewList = Queue.new()
local haterRedneckOutofViewList = Queue.new()
]]--

local haterPooSlingerInViewList = nil
local haterPooSlingerOutofViewList = nil
	
haterPootiePooInViewList = nil
haterPootiePooOutofViewList = nil

--forward declaration
local function setSpawnClock()
end

local function createHaterList(haterGroup, currentLevel, player)
	haterCreationInfo = currentLevel.enemyFrequency
	
	for haterType, haterAmount in pairs(haterCreationInfo) do
		if haterList[haterType] == nil then
			haterList[haterType] = {}
			haterList[haterType].outOfView = Queue.new()
			haterList[haterType].inView = Queue.new()
		end
		print(haterList[haterType].inView)
		for i = 1, haterAmount, 1 do
			Queue.insertFront(haterList[haterType].outOfView, require(haterType):new(haterGroup))
		end
	end
end

local function spawnHater(enemies)
	print('DO I GET HERE? PLEASE?')
	--[[
	for key, value in pairs(event) do
		print('key is: '..key)
		print('value is: '..tostring(value))
	end
	]]--
		
	if enemies ~= nil then
		for enemyIndex, enemyContext in pairs (enemies) do
			print('enemyContext: '..tostring(enemyContext))
			local enemyInView = Queue.removeBack(haterList[enemyContext.Type].outOfView)
			Queue.insertFront(haterList[enemyContext.Type].inView, enemyInView)
			enemyInView.sprite.x = enemyContext.x
			enemyInView.sprite.y = enemyContext.y
			enemyInView.sprite.rotation = enemyContext.Rotation
			--Still need to equip weapons to the enemyInView
			--Still need to scale x and y based on resolution of the screen
		end
	else
		playerWon = true
		enemyTimer = nil
	end
	setSpawnClock()
	return true
end

local function setSpawnClock()
	local wave = createNewHaterWave()
	if wave == nil then
		return 
	end
	-- print('wave.Enemies is: '..tostring(wave.Enemies))
	-- print('wave.Time is: '..tostring(wave.Time))
	-- print('wave.Time type: '..type(wave.Time))
	spawnClock = timer.performWithDelay(wave.Time, spawnHater(wave.Enemies), 1)
end

local function moveHaterOffScreen(hater)
	Queue.removeObject(haterList[tostring(hater)].inView, hater) --pulled out of inView
	hater.sprite.x = 5000
	hater.sprite.y = 5000
	hater.sprite.isVisible = false
	Queue.insertFront(haterList[tostring(hater)].outOfView, hater) --placed in to outOfView
end

local function emptyHaterList(groupOfHaters)
	while groupOfHaters.size > 0 do
		local hater = Queue.removeBack(groupOfHaters)
		--if hater ~= nil then
			hater:destroy()
		--end
	end
end

local function updateHaters()
	local enemeiesOnScreen = true
	for haterType,haterGroupOfSameType in pairs (haterList) do
		--print(haterGroupOfSameType.inView.first)
		--print(haterGroupOfSameType.inView.last)
		for i = haterGroupOfSameType.inView.first, haterGroupOfSameType.inView.last, 1 do
			local enemy = haterGroupOfSameType.inView[i]
			--print('enemy x is: '..enemy.sprite.x)
			--print('enemy y is: '..enemy.sprite.y)
			enemiesOnScreen = false
			enemy:update(AIDirector.player)
			if not enemy.alive then
				moveHaterOffScreen(enemy)
			end
		end
	end
	if playerWon and enemiesOnScreen then
		--director:showScene("MainMenu", "fade")
	end
end

function AIDirector.initialize(sceneGroup, player, currentLevel)
	createHaterList(sceneGroup, currentLevel, player)
	AIDirector.haterList = haterList
	if player ~= nil then
		AIDirector.player = player
	else
		error('Player was not initialized in AIDirector')
	end
	if currentLevel ~= nil then 
		AIDirector.currentLevel = currentLevel
	else
		error('Did not initialize the current level for the AI Director to use')
	end
	AIDirector.active = true
	Runtime:addEventListener("enterFrame", AIDirector.update)
	setSpawnClock()
end

function AIDirector.update()
	if AIDirector.active then
		updateHaters()
	end
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

function AIDirector.uninitialize(sceneGroup)
	AIDirector.deactivate()
	for haterType, queues in pairs (haterList) do
		emptyHaterList(queues.inView)
		emptyHaterList(queues.outOfView)
	end
	spawnClock = nil
	AIDirector.active = false
end
