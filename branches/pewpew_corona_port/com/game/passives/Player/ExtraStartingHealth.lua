require "com.game.passives.Passive"
ExtraStartingHealth = Passive:subclass("ExtraStartingHealth")

local EXTRA_DEFAULT_VALUE = 1

function ExtraStartingHealth: init(increaseAmount)
	self.super:init("health")
		
	if increaseAmount == nil then
		print('SET DEFAULT STARTING HEALTH')
		self.increaseAmount = EXTRA_DEFAULT_VALUE
	else
		self.increaseAmount = increaseAmount
	end
end

function ExtraStartingHealth:setOwner(objectRef)
	self.super:setOwner(objectRef)
	print('fieldName in this object: ' .. self.fieldName)
	print('fieldName in this object: ' .. self.increaseAmount)
	self.objectRef[self.fieldName] = self.objectRef[self.fieldName] + self.increaseAmount 
end

return ExtraStartingHealth