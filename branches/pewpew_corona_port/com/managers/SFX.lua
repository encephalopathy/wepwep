--SFX.lua
--This module will manage all the sound effects for a given scene

--[[
Channels
In-Game
1: BGM
Enemy Death

2: WeaponFire(Primary and Secondary)
3: 
4: Collectible


rest of the sounds can be placed on the other open channels; these sounds will be constant and should have 
their own channels

Menus
1: BGM
2: EVERYTHING ELSE!!

Heavier weight is more important than light weight
]]--

require "org.Object"

SFX = Object:subclass("SFX")

--constructor
function SFX:init(sceneGroup, infoTable, debugName)
	--print(debugName)
	self.name = debugName
	--print("creating table name:"..self.name)
	self.group = sceneGroup
	self.sfx = {}
	--print("creating sound table")
	for soundType,soundInfo in pairs(infoTable) do
		--print("soundType is : "..soundType)
		--print(soundInfo.setting)
		self.sfx[soundType] = {object = audio.loadSound(soundInfo.path), channel = soundInfo.channel, setting = soundInfo.setting}
	end
end

function SFX:addListener()
	Runtime:addEventListener("playSound", self)
end

function SFX:removeListener()
	Runtime:removeEventListener("playSound", self)
end

--play
function SFX:playSound(event)
	--print("INSIDE playSound")
	--print("name: "..self.name)
	if muteOption ~= true then
		if event.name == "playSound" then 
			--print("event.handle "..event.soundHandle)
			if self.sfx[event.soundHandle] ~= nil then
				--print('event.soundHandle was not nil')
				if self.sfx[event.soundHandle].setting == 'R' then
					--print("type: "..type(self.sfx[event.soundHandle].object))
					--print("channel: "..self.sfx[event.soundHandle].channel)
					if(audio.isChannelPlaying(self.sfx[event.soundHandle].channel))then 
						audio.stop(self.sfx[event.soundHandle].channel)
					end 
					audio.play(self.sfx[event.soundHandle].object, {channel = self.sfx[event.soundHandle].channel})
					--print(audio.isChannelPlaying(self.sfx[event.soundHandle].channel))
				elseif self.sfx[event.soundHandle].setting == 'NR' then 
					--print("playing a setting = NR")
					if(audio.isChannelPlaying(self.sfx[event.soundHandle].channel)) then 
						return
					else 
						audio.play(self.sfx[event.soundHandle].object, {channel = self.sfx[event.soundHandle].channel})
					end
				elseif self.sfx[event.soundHandle].setting == 'NRML' then
					local freeChannel = audio.findFreeChannel()
					audio.play(self.sfx[event.soundHandle].object, {channel = freeChannel})
				end
			else
				print("event.soundHandle was a nil value")
			end
			
		end
	end
	
	return true
end

--stop
function SFX:stopSound(event)
	----print("INSIDE stopSound")
	if event.name == "stopSound"then
		if self.sfx[event.soundHandle].object ~= nil then
			--the sound handle you want to stop doesn't exist
			print("NO SUCH HANDLE EXISTS!")
		else
			audio.stop(self.sfx[event.soundHandle].channel)
		end
	end
	return
end

--dispose
function SFX:disposeSound()
	--print("INSIDE disposeSound")
	for soundType, sound in pairs(self.sfx) do
		--print("type: "..type(self.sfx[soundType].object))
		if(audio.isChannelPlaying(self.sfx[soundType].channel)) then
			audio.stop(self.sfx[soundType].channel) --stop the channel
		end
		audio.dispose(self.sfx[soundType].object) --dispose of the sound via handle
		self.sfx[soundType] = nil --set element in the table to be nil
	end
	self.sfx = nil
	--print("memory has been freed up")
end
