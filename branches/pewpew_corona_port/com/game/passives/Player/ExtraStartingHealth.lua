require "com.game.passives.Passive"
ExtraStartingHealth = Passive:subclass("ExtraStartingHealth")

function ExtraStartingHealth: init(objectRef, increaseAmount)
	if objectRef ~= nil then
		self.super:init(objectRef, "health")
		self.objectRef[self.fieldName] = self.objectRef[self.fieldName] + increaseAmount 
	end
end

return ExtraStartingHealth