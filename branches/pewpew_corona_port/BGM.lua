--Check what platform we are running this sample on
--[[if system.getInfo( "platformName" ) == "Android" then
	platform = "Android"
elseif system.getInfo( "platformName" ) == "Mac OS X" then
	platform = "Mac"
elseif system.getInfo( "platformName" ) == "Win" then
	platform = "Win"
else
	platform = "IOS"
end

local supportedAudio = {
	["Mac"] = { extensions = { ".aac", ".aif", ".caf", ".wav", ".mp3", ".ogg" } },
	["IOS"] = { extensions = { ".aac", ".aif", ".caf", ".wav", ".mp3" } },
	["Win"] = { extensions = { ".wav", ".mp3", ".ogg" } },
	["Android"] = { extensions = { ".wav", ".mp3", ".ogg" } },
}

local loadTypes = {
	["sound"] = { extensions = { ".aac", ".aif", ".caf", ".wav" } },
	["stream"] = { extensions = { ".mp3", ".ogg" } },
}]]--

local platform
--local loopTypes = { 'bgm' : -1, 'soundfx' : 1 }
local bgmMusicChannel = 1
local soundFxStack = 2

local currentBGMPlaying = nil

function playBGM(file, fadeInTime, onComplete)
	if fadeInTime == nil then
		fadeInTime = 500
	end
	
	currentBGMPlaying = audio.loadStream(file)
	currentBGMPlaying = audio.play(file, { channel = bgmMusicChannel, loops = loopTypes['bgm'], fadein = fadeInTime })
end

function pauseBGM()

end

function stopBGM()

end

function printCurrentBGMPlaying()
	print (currentBGMPlaying.name)
end

function playSoundFX(file, duration, fadein, onComplete)

end


--BGM for the main menu
audio.load('menuBackMusic.ogg')
mainMenuBGM:setLooping(true)

--BGM for the game
gameBGM = MOAIUntzSound.new()
gameBGM:load('gameBackMusic.ogg')
gameBGM:setLooping(true)

--BGM for the shop
storeBGM = MOAIUntzSound.new()
storeBGM:load('shopMusic.ogg')
storeBGM:setLooping(true)
storeBGMPlaying = false

--BGM for the equip screen
equipBGM = MOAIUntzSound.new()
equipBGM:load('equipMusic.ogg')
equipBGM:setLooping(true)
equipBGMPlaying = false
