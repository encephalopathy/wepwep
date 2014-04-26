require "com.game.passives.Player.PassiveShield"
require "com.game.weapons.secondary.ActivatableShield"

ShieldCollection = Passive:subclass("ShieldCollection")

function ShieldCollection:init(isActivatable, spriteImage, shieldType, shieldHealth)
	self.super:init(nil, isActivatable)
 	self.shieldCollection = {}
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
	self.shieldCollection = self.shieldType:new(sceneGroup, self.spriteImage, self.objectRef, self.objectRef.sprite.width + 100, self.objectRef.sprite.height + 100, self.shieldHealth)
end

function ShieldCollection:update()
	--TODO make this work with other shield variants
	if self.isActivatable == true then
		if self.objectRef.defensePassives['com/resources/art/sprites/shop_splash_images/PassiveShield.png'] == nil then
			self.shieldCollection:update(self.PositionX, self.PositionY)
		elseif self.objectRef.defensePassives['com/resources/art/sprites/shop_splash_images/PassiveShield.png'].shieldCollection.health <= 0 then
			self.shieldCollection:update(self.PositionX, self.PositionY)
		end
	else
		self.shieldCollection:update(self.PositionX, self.PositionY)
	end
 	self.PositionX = self.objectRef.sprite.x
 	self.PositionY = self.objectRef.sprite.y
end

function ShieldCollection:clear()
	self.shieldCollection:destroy()
end

function ShieldCollection:activate()
	self.super:activate()
	if self.isActivatable == true then
 		self.shieldCollection:activate(self.PositionX, self.PositionY)
 	end
end

return ShieldCollection