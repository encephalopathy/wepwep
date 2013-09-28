require "com.game.passives.Passive"
ExtraStartingHealth = Passive:subclass("ExtraStartingHealth")

function ExtraStartingHealth: init(objectRef, fieldName, increaseAmount)
	if fieldName ~= "health" then
		print("field specified for modification by Extra Starting Health Passive is not health but instead", fieldName)
		return
	else
		self.objectRef = objectRef
		self.fieldName = fieldName	
		self.objectRef[self.fieldName] = self.objectRef[self.fieldName] + increaseAmount 
	end
end

return ExtraStartingHealth