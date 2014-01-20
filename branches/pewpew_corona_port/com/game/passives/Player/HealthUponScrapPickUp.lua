require "com.game.passives.Passive"

HealthUponScrapPickUp = Passive:subclass("HealthUponScrapPickUp")

local DEFAULT_INCREASE_AMOUNT = 1

function HealthUponScrapPickUp:init(increaseAmount)
	self.super:init("health")

	if increaseAmount == nil then
		print("SET DEFAULT STARTING HEALTH")
		self.increaseAmount = DEFAULT_INCREASE_AMOUNT
	else
		self.increaseAmount = increaseAmount
	end
end

function HealthUponScrapPickUp:setOwner(objectRef)
	print('SETTING OWNER HEALTH UPON SCRAP PICK UP')
	self.super:setOwner(objectRef)
end

function HealthUponScrapPickUp:increaseHealth()
	if math.random(0, 100) == 100 and self.objectRef[self.fieldName] < self.objectRef.maxhealth then
		self.objectRef[self.fieldName] = self.objectRef[self.fieldName] + self.increaseAmount
	end
end