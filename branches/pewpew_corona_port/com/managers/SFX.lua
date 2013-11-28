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
	print(debugName)
	self.name = debugName
	print("creating table name:"..self.name)
	self.group = sceneGroup
	self.sfx = {}
	print("creating sound table")
	for soundType,soundInfo in pairs(infoTable) do
		print("soundType is : "..soundType)
		self.sfx[soundType] = {object = audio.loadSound(soundInfo.path), channel = soundInfo.channel, weight = soundInfo.weight}
	end
	audio.setVolume(0)
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
	if event.name == "playSound" then
		--print("event.handle "..event.soundHandle)
		if self.sfx[event.soundHandle] ~= nil then
			--print("type: "..type(self.sfx[event.soundHandle].object))
			--print("channel: "..self.sfx[event.soundHandle].channel)
			if(audio.isChannelPlaying(self.sfx[event.soundHandle].channel))then
				audio.stop(self.sfx[event.soundHandle].channel)
			end
			audio.play(self.sfx[event.soundHandle].object, {channel = self.sfx[event.soundHandle].channel})
			--print(audio.isChannelPlaying(self.sfx[event.soundHandle].channel))
		else
			--print("event.soundHandle was a nil value")
		end
		
	end
	
	return true
end

--stop
function SFX:stopSound(handle)
	print("INSIDE stopSound")
	if self.sfx[handle].objec ~= nil then
		audio.stop(self.sfx[handle].channel)
	else
		print("NO SUCH HANDLE EXISTS!")
	end
end

--dispose
function SFX:disposeSound()
	print("INSIDE disposeSound")
	for soundType, sound in pairs(self.sfx) do
		--print("type: "..type(self.sfx[soundType].object))
		if(audio.isChannelPlaying(self.sfx[soundType].channel)) then
			audio.stop(self.sfx[soundType].channel) --stop the channel
		end
		audio.dispose(self.sfx[soundType].object) --dispose of the sound via handle
		self.sfx[soundType] = nil --set element in the table to be nil
	end
	self.sfx = nil
	print("memory has been freed up")
end
