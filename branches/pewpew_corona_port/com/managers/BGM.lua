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

local loopTypes = { ["bgm"] = -1}
local bgmMusicChannel = 1
currentBGMPlaying = nil

function playBGM(file, fadeInTime, onComplete)
	if fadeInTime == nil then
		fadeInTime = 500
	end
	
	--if audio.isChannelPlaying(bgmMusicChannel) then
		--stopBGM()
	--end
	
	if file ~= nil then
		local loadedAudioFile = audio.loadStream(file)
		currentBGMPlaying = audio.play(loadedAudioFile, { channel = bgmMusicChannel, 
		loops = loopTypes['bgm'], fadein = fadeInTime })
	else
		print('Attempted to load a nil file in playBGM')
	end
end

function pauseBGM()
	if audio.isChannelPlaying(bgmMusicChannel) then
		audio.pause(bgmMusicChannel)
	end
end

function resumeBGM()
	if audio.isChannelPaused(bgmMusicChannel) then
		audio.resume(bgmMusicChannel){}
	end
end

function stopBGM()
	audio.stop(currentBGMPlaying)
end

function printCurrentBGMPlaying()
	print (currentBGMPlaying.name)
end

function playMultipleSounds(event)

end

local loadedAudioFile = audio.loadSound("com/resources/music/soundfx/laser.ogg")

