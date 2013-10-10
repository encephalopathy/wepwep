
local currentLevel
local waveNumber
local currentWaveNumber = 1
local ENEMY_THRESHOLD_TIME = 1000
local maximumEnemyTypeAmount
--Levels
	--Theme (Level Name)
		--Level (Level Number)
			--Wave (Time interval)
				--Enemy1
					--location
						--x
						--y
					--rotation
					--weapons
						--weapon 1
						--weapon 2
--Enemy2

function createGame(filename)
	local filePath = system.pathForFile( filename, system.ResourceDirectory )
	local file = io.open(filePath, "r")
	local enemy
	local levels = {}
	local currentLevelName
	
	--local currentLevelNumber
	local currentWave
	local enemyTypeAmountTable
	for line in file:lines(), 1 do
		--print('current line: ' .. line)
		for fieldType, field  in string.gmatch(line, "(%w+[%p*%w*]*)=(%w+%p*[%w+%p*]*)") do
			--print('fieldType: ' .. fieldType)
			--print('field: ' .. field)
			if fieldType == 'Name' then
				--Name; denotes the theme of the level
				--if levels[field] == nil then
				levels[field] = {}
				currentLevelName = field
				maximumEnemyTypeAmount = {}
				levels[field]['enemyFrequency'] = maximumEnemyTypeAmount
				--end
			elseif fieldType == 'Number' then
				--Number; denotes a level of a given theme
				levels[tonumber(field)] = levels[currentLevelName]
			elseif fieldType == 'Time' then
				--Wave
				--levels[currentLevelName][field]['enemies'] = {}
				--levels[currentLevelName][field] = field
				currentWave = {}
				enemyTypeAmountTable = {}
				table.insert(levels[currentLevelName], {Time=tonumber(field), Enemies=currentWave, EnemyTypeAmount = enemyTypeAmountTable})
			elseif fieldType == 'Type' then
				--Enemy creation
				enemy = {}
				enemy[fieldType] = field
				table.insert(currentWave, enemy)
			elseif fieldType == 'Location' then
				--Location
				 local i = string.find(field, ",")
				 x = string.sub(field, 1, (i-1))
				 y = string.sub(field, (i+1))
				 enemy.x = tonumber(x)
				 enemy.y = tonumber(y)
				 fitToResolution(enemy)
			elseif fieldType == 'Rotation' then
				enemy[fieldType] = tonumber(field)
			elseif fieldType == 'Weapons' then
				enemy[fieldType] = {}
				equipToHater(field, enemy, fieldType)
			elseif fieldType == 'Passives' then
				enemy[fieldType] = {}
				equipToHater(field, enemy, fieldType)
			else
				print('fieldType: ' .. fieldType)
				print('field: ' .. tostring(field))
				enemyTypeAmountTable[fieldType] = field
				
				
				--modulateEnemy(levels[currentLevel].Time, fieldType, field)
				
			end
		end
	end
	io.close()
	file = nil
	
	return levels
end

--[[
	Sets enemy x and y coordinates to fit with the resolution of the device
]]--
function fitToResolution(enemy)
	local blackBox = {width = 480, height = 800}
	enemy.x = (enemy.x*(display.contentWidth/blackBox.width))
	enemy.y = (enemy.y*(display.contentHeight/blackBox.height))
	--print("enemy.x: "..enemy.x.." enemy.y: "..enemy.y)
end

function equipToHater(line, enemy, fieldType)
	--print('line is:'..line)
	--print(enemy[fieldType])
	--print(line)
	--for equipment in string.gmatch(line, "%p*(%w+)%p*") do
	for equipment in string.gmatch(line, "[(%w)+.?]+") do
		--print('weapon is: ' .. equipment)
		table.insert(enemy[fieldType], equipment)
	end
end

function createNewHaterWave()
	local wave = currentLevel[currentWaveNumber]
	currentWaveNumber = currentWaveNumber+1
	return wave
end

--Will load the level by theme name.  May be able to load the level by the theme name and level number.
function setLevel(levelName)
	currentLevel = levels[levelName]
	currentWaveNumber = 1
	return currentLevel
end

levels = createGame('com/game/levels/test.pew')  
--[[
	These functions are strictly used for Debugging purposes. DO NOT TOUCH THESE!!! BRENT WILL BE TOTES MAD!
	
	...Seriously though, stay the hell away from these.
]]--
function printLevel(levels)
	for name, value in pairs (levels) do
		print('name is: '..name)
		printWave(value)
	end
end

function printHaterFrequency(value)
	for haterType, haterMaxAmount in pairs(value) do
		print('   '..haterType..':'..haterMaxAmount)
	end
end

function printWave(waves)
	for waveTime, waveValue in pairs (waves) do
		if waveTime == 'enemyFrequency' then
			printHaterFrequency(waveValue)
		else
			printTime(waveValue)
		end
	end
end

function printTime(times)
	for timeKey, waveTime in pairs (times) do
		if timeKey == 'Time' then
			print('   '..timeKey..':'..waveTime)
		elseif timeKey == 'Enemies' then
			printTableOfEnemies(waveTime)
		else
			printEnemyType(waveTime)
		end
	end
end

function printTableOfEnemies(enemies)
	for enemyName, enemy in pairs (enemies) do
		for property, propValue in pairs (enemy) do
			for key, value in pairs(propValue) do
				print(key)
				print(value)
			end
			if property == 'Weapons' then
				printWeapons(propValue)
			elseif property == 'Passives' then
				printWeapons(propValue)
			else
				print('     '..property..':'..propValue)
			end
		end
	end
end

function printEnemyType(enemyType)
	for enemyName, amount in pairs (enemyType) do
		print('   '..enemyName..':'..amount)
	end
end

function printWeapons(enemy)
	for weaponKey, weaponValue in pairs (enemy) do
		print('         '..weaponKey..':'..weaponValue)
	end
end

--print('!!!DEBUG LOOP!!!') 
--printLevel(levels)