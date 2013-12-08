#! /usr/bin/lua

require 'Test.More'
require 'com.managers.LevelManager'

local function badInputTest()
	local badlevels = createGame('badfile')

	is(badlevels, nil, 'Passed loading a file that does not exist -----PASSED-----')
end

local function oneWave_OneTypeOfHater_Test(levelName)
	local haterSameTypeTest = setLevel(levelName)
	
	--Press the test game button without the use of a mouse.
	--See if haters appear.
	
end

local function allHaters_OneWave_Test()
	
end

local function allHaters_multipleWaves_Test()

end

local function mainLevelTest()
	haterLevelTest = createGame("com/game/levels/smokeTest.pew")
	isnt(haterTest, nil, 'Did not load the correct file in the Smoke Tester')
	
	oneWave_OneTypeOfHater_Test()
	
end

function runLevelManagerParseTest()
	plan(1)
	badInputTest()
	pass(1)
end