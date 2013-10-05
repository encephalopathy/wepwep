require "com.game.passives.Passive"
ExtraStartingHealth = Passive:subclass("ExtraStartingHealth")

local EXTRA_DEFAULT_VALUE = 1

function ExtraStartingHealth: init(objectRef, increaseAmount)
	assert(objectRef, "In Extra Starting Health passive, object reference is incorrect.")
	assert(objectRef["health"], "In Extra Starting Health passive, object reference does not have a health field.")
	if objectRef ~= nil then
		self.super:init(objectRef, "health")
		
		if increaseAmount == nil then
			increaseAmount = EXTRA_DEFAULT_VALUE
		end
		
		self.objectRef[self.fieldName] = self.objectRef[self.fieldName] + increaseAmount 
	end
end

return ExtraStartingHealth