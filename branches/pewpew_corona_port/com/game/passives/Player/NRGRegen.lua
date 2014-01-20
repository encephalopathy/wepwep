require "com.game.passives.Passive"
NRGRegen = Passive:subclass("NRGRegen")

local DEFAULT_REGENVALUE = 3
local DEFAULT_COOLDOWN = 30

function NRGRegen:init(regenValue, cooldown)
	self.super:init("powah")

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

function NRGRegen:setOwner(objectRef)
	print('SETTING NRG REGEN')
	self.super:setOwner(objectRef)
end

function NRGRegen:update()
	if self.objectRef ~= nil and self.fieldName ~= nil then
		if self.initialNRG == nil then
			self.initialNRG = self.objectRef[self.fieldName]
		end
		if self.objectRef[self.fieldName] < self.initialNRG then
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

return NRGRegen