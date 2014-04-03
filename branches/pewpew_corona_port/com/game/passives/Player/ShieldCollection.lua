require "com.game.passives.Player.PassiveShield"
require "com.game.weapons.secondary.ActivatableShield"

ShieldCollection = Passive:subclass("ShieldCollection")

function ShieldCollection:init(isActivatable, spriteImage, shieldType, shieldHealth)
	self.super:init(nil, isActivatable)
 	self.collection = {}
 	self.spriteImage = spriteImage
 	self.shieldType = shieldType
 	self.shieldHealth = shieldHealth
end

function ShieldCollection:setOwner(objectRef, sceneGroup)
 	assert(objectRef ~= nil, 'ShieldCollection: Did not equip an owner such as player or an enemy to this passive')
 	assert(sceneGroup ~=nil, "ShieldCollection: sceneGroup is nil")
 	self.objectRef = objectRef
 	self.PositionX = self.objectRef.sprite.x
	self.PositionY = self.objectRef.sprite.y
	self.collection[1] = self.shieldType:new(sceneGroup, self.spriteImage, self.objectRef, self.objectRef.sprite.width + 100, self.objectRef.sprite.height + 100, self.shieldHealth)
end

function ShieldCollection:update()
 	self.collection[1]:update(self.PositionX, self.PositionY)
 	self.PositionX = self.objectRef.sprite.x
 	self.PositionY = self.objectRef.sprite.y
end

function ShieldCollection:clear()
	for i = 1, #self.collection, 1 do
		self.collection[i]:destroy()
	end
end

function ShieldCollection:activate()
	self.super:activate()
	if self.objectRef.defensePassives["com/resources/art/sprites/shop_splash_images/ActivatableShield.png"] ~= nil then
		self.collection[1]:activate()
	end
end

return ShieldCollection