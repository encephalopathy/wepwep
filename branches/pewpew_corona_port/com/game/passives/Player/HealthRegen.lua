require "com.game.passives.Passive"
HealthRegen = Passive:subclass("HealthRegen")

function HealthRegen: init(objectRef, fieldName)
	if fieldName ~= "health" then
		print("field specified for modification by Health Regen Passive is not health but instead", fieldName)
		return
	else
		self.objectRef = objectRef
		self.fieldName = fieldName
		self.initialHealth = self.objectRef[self.fieldName]
	end
end

function HealthRegen: update()
	if self.objectRef ~= nil and self.fieldName ~= nil then
		if self.objectRef[self.fieldName] < self.initialHealth then
			self.objectRef[self.fieldName] = self.objectRef[self.fieldName] + 1
		end
	end
end

return HealthRegen