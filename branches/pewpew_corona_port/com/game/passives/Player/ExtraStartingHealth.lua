require "com.game.passives.Passive"
ExtraStartingHealth = Passive:subclass("ExtraStartingHealth")

local EXTRA_DEFUALT_VALUE = 1

function ExtraStartingHealth: init(objectRef, increaseAmount)
	if objectRef ~= nil then
		self.super:init(objectRef, "health")
		
		if increaseAmount == nil then
			increaseAmount = EXTRA_DEFUALT_VALUE
		end
		
		self.objectRef[self.fieldName] = self.objectRef[self.fieldName] + increaseAmount 
	end
end

return ExtraStartingHealth