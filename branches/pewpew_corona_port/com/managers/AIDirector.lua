require "org.Queue"
require "com.game.enemies.Hater"

--TODO: Add sceneGroups for ground enemies
AIDirector = {}

local haterList = {}

local allHatersInView = {}

local spawnClock 
--local haterGroup = display.newGroup()

haterPootiePooInViewList = nil
haterPootiePooOutofViewList = nil

--forward declaration
local function setSpawnClock()
end

local function createHaterList(currentLevel, player)
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
			Queue.insertFront(haterList[haterType].outOfView, newHater)
		end
	end
end

local function spawnHater(enemies)
	if enemies ~= nil then
		for enemyIndex, enemyContext in pairs (enemies) do
			--print('enemyContext: '..tostring(enemyContext))
			local enemyInView = Queue.removeBack(haterList[enemyContext.Type].outOfView)
			Queue.insertFront(haterList[enemyContext.Type].inView, enemyInView)
			enemyInView.sprite.x = enemyContext.x
			enemyInView.sprite.y = enemyContext.y
			enemyInView.sprite.rotation = enemyContext.Rotation
			enemyInView:equipRig(haterGroup, enemyContext.Weapons, enemyContext.Passives)
			--Still need to equip weapons to the enemyInView
			--Still need to scale x and y based on resolution of the screen
			allHatersInView[enemyInView] = enemyInView
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
