require "com.game.passives.Passive"
HealthRegen = Passive:subclass("HealthRegen")

local DEFAULT_REGENVALUE = 1
local DEFAULT_COOLDOWN = 60

function HealthRegen: init(fieldName, regenValue, cooldown)
	self.super:init(fieldName)
	
	if regenValue == nil then
		self.regenValue = DEFAULT_REGENVALUE
	else
		self.regenValue = regenValue
	end
		
	if cooldown == nil then
		self.cooldown = DEFAULT_COOLDOWN
	else
		self.cooldown = cooldown
	end
		
	self.counter = 0
end

function HealthRegen:setOwner(objectRef)
	self.super:setOwner(objectRef)
end

function HealthRegen: update()

	if self.objectRef ~= nil and self.fieldName ~= nil then		
		if self.initialHealth == nil then
			self.initialHealth = self.objectRef[self.fieldName]
		end
		if self.objectRef[self.fieldName] < self.initialHealth then
			if self.counter == 0 then
				self.counter = step + self.cooldown
			end
			if self.counter == step then
				self.objectRef[self.fieldName] = self.objectRef[self.fieldName] + self.regenValue
				self.counter = 0
			end
		end
	end
end

return HealthRegen