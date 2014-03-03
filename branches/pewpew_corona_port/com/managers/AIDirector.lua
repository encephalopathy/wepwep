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

local bossSpawn = false
local levelBoss

-- scene managment api, dictates game scene transition
local storyboard = require( "storyboard" )

--forward declaration
local setSpawnClock = nil

local function createHater(haterList, haterType)
	if haterList[haterType] == nil then
		haterList[haterType] = {}
		haterList[haterType].outOfView = Queue.new()
		haterList[haterType].inView = Queue.new()
	end
	local newHater = require(haterType):new(AIDirector.haterGroup, AIDirector.player, 
										haterList[haterType].inView, haterList[haterType].outOfView,
										haterList, allHatersInView)
	-- newHater.sprite.isBodyActive = false
	-- newHater.sprite.isVisible = false
	return newHater
end

function AIDirector.spawnHater(enemyType, spawnX, spawnY, rotation, weapons, passives)
	local enemyInView = nil
	if haterList[haterType] == nil then
		haterList[haterType] = {}
		haterList[haterType].outOfView = Queue.new()
		haterList[haterType].inView = Queue.new()
	else
		enemyInView = Queue.removeBack(haterList[enemyContext.Type].outOfView)
	end
	
	if enemyInView == nil then
		enemyInView = createHater(haterList, enemyContext.Type)
	end
	enemyInView.sprite.isBodyActive = true
	enemyInView.sprite.isVisible = true
	Queue.insertFront(haterList[enemyContext.Type].inView, enemyInView)
	enemyInView.sprite.x = enemyContext.x
	enemyInView.sprite.y = enemyContext.y
	enemyInView.sprite.rotation = enemyContext.Rotation
	enemyInView:equipRig(haterGroup, enemyContext.Weapons, enemyContext.Passives)
	allHatersInView[enemyInView] = enemyInView
end

local function spawnHater(enemies)
	--count is a variable that goes up each time you add a hater to the inView queue. IT IS FOR DEBUGGING!
	--local count = 0
		for enemyIndex, enemyContext in pairs (enemies) do
			-- for key,value in pairs(enemyContext) do
				-- print("enemyContext key: "..tostring(key).." enemyContext value: "..tostring(value))
			-- end
			local haterType = enemyContext.Type
			--if a boss, set boss alive to be true
			
			--checks to see if the boss is the next enemy to be spawned
			local startIndex = 1
			local currentIndex = 1
			for currentIndex = 1,  string.len(tostring(haterType)) do
				if haterType:sub(currentIndex,currentIndex) == '.' then
					local thing = haterType:sub(startIndex, currentIndex-1)
					if thing == "bosses" then
						bossSpawn = true
						--print("AIDirector_spawnHater_bossSpawn: "..tostring(bossSpawn))
					else
						startIndex = currentIndex+1
					end
				end
			end
				
			local enemyInView = nil
			if haterList[haterType] == nil then
				--haterList[haterType] = {}
				--haterList[haterType].outOfView = Queue.new()
				--haterList[haterType].inView = Queue.new()
				enemyInView = createHater(haterList, enemyContext.Type)
			else
				
				if haterList[enemyContext.Type].outOfView.size > 0 then
					enemyInView = Queue.removeBack(haterList[enemyContext.Type].outOfView)
					enemyInView:respawn()
				else
					enemyInView = require(haterType):new(AIDirector.haterGroup, AIDirector.player, 
										haterList[haterType].inView, haterList[haterType].outOfView,
										haterList, allHatersInView)
				enemyInView.sprite.isBodyActive = false
				enemyInView.sprite.isVisible = false
				end
			end
			enemyInView.sprite.isBodyActive = true
			enemyInView.sprite.isVisible = true
			--print("enemyInView.health: "..enemyInView.health)
			Queue.insertFront(haterList[enemyContext.Type].inView, enemyInView)
			--count = count + 1
			--print(count)
			enemyInView.sprite.x = enemyContext.x
			enemyInView.sprite.y = enemyContext.y
			enemyInView.sprite.rotation = enemyContext.Rotation
			enemyInView:equipRig(haterGroup, enemyContext.Weapons, enemyContext.Passives)
			if bossSpawn == true then
				levelBoss = enemyInView
			end
			allHatersInView[enemyInView] = enemyInView
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
	hater.weapon = {}
	hater.primaryWeapons = {}
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
	for haterType,haterGroupOfSameType in pairs (haterList) do
		for i = haterGroupOfSameType.inView.first, haterGroupOfSameType.inView.last, 1 do
			local enemy = haterGroupOfSameType.inView[i]
			enemy:update(AIDirector.player)
			if not enemy.alive then
				moveHaterOffScreen(enemy)
			end
		end
	end
	if bossSpawn == true then
		if levelBoss.alive == false then
			storyboard.gotoScene("com.mainmenu.MainMenu", "fade", 500)
		end
	end
end

function AIDirector.create(sceneGroup)
	AIDirector.haterGroup = display.newGroup()
	
	sceneGroup:insert(AIDirector.haterGroup)
	AIDirector.haterList = allHatersInView
end

function AIDirector.initialize(player, currentLevel)
	--createHaterList(currentLevel, player)
	
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
	--spawnClock = nil
	timer.cancel(spawnClock)
	bossSpawn = false
	levelBoss = nil
	
	for haterKey in pairs(allHatersInView) do
		allHatersInView[haterKey] = nil
	end
	
	for haterType, queues in pairs (haterList) do
		emptyHaterList(queues.inView)
		emptyHaterList(queues.outOfView)
	end
	
	AIDirector.active = false
	
end
