require "org.Queue"
require "com.game.enemies.Hater"

--TODO: Add sceneGroups for ground enemies
AIDirector = {}

local haterList = {}

local allHatersInView = {}

--The enemies that spawn when a wave is generated based on its spawn time.
local enemiesToSpawn

--A Corona timer used to determine when the next wave should appear on screen.
local spawnClock 
--local haterGroup = display.newGroup()

haterPootiePooInViewList = nil
haterPootiePooOutofViewList = nil

--forward declaration
local setSpawnClock = nil

local function createHaterList(currentLevel, player)
	assert(currentLevel ~= nil, 'current level is nil, make sure the correct level is being loaded from LevelManager.')
	assert(player ~= nil, 'player is nil, player was not passed in from AIDirector')
	haterCreationInfo = currentLevel.enemyFrequency
	
	local haterGroup = AIDirector.haterGroup
	
	for haterType, haterAmount in pairs(haterCreationInfo) do
		if haterList[haterType] == nil then
			haterList[haterType] = {}
			haterList[haterType].outOfView = Queue.new()
			haterList[haterType].inView = Queue.new()
		end
		for i = 1, haterAmount, 1 do
			local newHater = require(haterType):new(haterGroup, player, 
										haterList[haterType].inView, haterList[haterType].outOfView,
										haterList)
			newHater.sprite.isBodyActive = false
			newHater.sprite.isVisible = false
			Queue.insertFront(haterList[haterType].outOfView, newHater)
		end
	end
end

local function spawnHater(enemies)
	if enemies ~= nil then
		for enemyIndex, enemyContext in pairs (enemies) do
			local enemyInView = Queue.removeBack(haterList[enemyContext.Type].outOfView)
			enemyInView.sprite.isBodyActive = true
			enemyInView.sprite.isVisible = true
			Queue.insertFront(haterList[enemyContext.Type].inView, enemyInView)
			enemyInView.sprite.x = enemyContext.x
			enemyInView.sprite.y = enemyContext.y
			enemyInView.sprite.rotation = enemyContext.Rotation
			enemyInView:equipRig(haterGroup, enemyContext.Weapons, enemyContext.Passives)
			allHatersInView[enemyInView] = enemyInView
		end
	else
		playerWon = true
		enemyTimer = nil
	end

	setSpawnClock()
	return true
end

--A closure used to spawn the haters on screen.  Needed to have Corona's
--peformWithDelay be reset whenever we get to a new wave.
local function spawnWave()
	spawnHater(enemiesToSpawn)
end

setSpawnClock = function()
	local wave = createNewHaterWave()
	if wave == nil then
		return 
	end
	enemiesToSpawn = wave.Enemies
	spawnClock = timer.performWithDelay(wave.Time * 1000, spawnWave, 1)
	return true
end

local function moveHaterOffScreen(hater)
	Queue.removeObject(haterList[tostring(hater)].inView, hater) --pulled out of inView
	hater.sprite.x = 5000
	hater.sprite.y = 5000
	hater.sprite.isVisible = false
	allHatersInView[hater] = nil
	Queue.insertFront(haterList[tostring(hater)].outOfView, hater) --placed in to outOfView
end

local function emptyHaterList(groupOfHaters)
	while groupOfHaters.size > 0 do
		local hater = Queue.removeBack(groupOfHaters)
		--if hater ~= nil then
			hater:destroy()
			hater = nil
		--end
	end
end

local function updateHaters()
	local enemeiesOnScreen = true
	for haterType,haterGroupOfSameType in pairs (haterList) do
		for i = haterGroupOfSameType.inView.first, haterGroupOfSameType.inView.last, 1 do
			local enemy = haterGroupOfSameType.inView[i]
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

function AIDirector.create(sceneGroup)
	AIDirector.haterGroup = display.newGroup()
	
	sceneGroup:insert(AIDirector.haterGroup)
	AIDirector.haterList = allHatersInView
end

function AIDirector.initialize(player, currentLevel)
	createHaterList(currentLevel, player)
	
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
	for haterType, queues in pairs (haterList) do
		emptyHaterList(queues.inView)
		emptyHaterList(queues.outOfView)
	end
	
	for haterKey, hater in pairs(allHatersInView) do
		haterKey = nil
	end
	spawnClock = nil
	AIDirector.active = false
	
	
end
