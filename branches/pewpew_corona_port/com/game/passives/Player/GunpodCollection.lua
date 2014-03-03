require "com.game.passives.Player.GunpodSingle"

GunpodCollection = Passive:subclass("GunpodCollection")

function GunpodCollection:init(isActivatable, gunpodType, spriteImage, separationDistanceFromOwnerX, separationDistanceFromOwnerY, weaponType, ...)
	self.super:init(nil, isActivatable)
	self.collection = {}
	self.gunpodType = gunpodType
	self.spriteImage = spriteImage
	self.separationDistanceFromOwnerX = separationDistanceFromOwnerX
	self.separationDistanceFromOwnerY = separationDistanceFromOwnerY
	self.weaponType = weaponType
	self.weaponArguments = arg
end

function GunpodCollection:setOwner(objectRef, sceneGroup)
	assert(objectRef ~= nil, 'GunpodCollection: Did not equip an owner such as player or an enemy to this passive')
	self.objectRef = objectRef
	self.oldPositionX = self.objectRef.sprite.x
	self.oldPositionY = self.objectRef.sprite.y
	self.collection[1] = self.gunpodType:new(sceneGroup, self.spriteImage, self.oldPositionX - self.separationDistanceFromOwnerX, self.oldPositionY + self.separationDistanceFromOwnerY)
	self.collection[2] = self.gunpodType:new(sceneGroup, self.spriteImage, self.oldPositionX + self.separationDistanceFromOwnerX, self.oldPositionY + self.separationDistanceFromOwnerY)
	self.collection[1]:equipWeapon(sceneGroup, self.objectRef.haterList, self.weaponType, unpack(self.weaponArguments))
	self.collection[2]:equipWeapon(sceneGroup, self.objectRef.haterList, self.weaponType, unpack(self.weaponArguments))
end

function GunpodCollection:update()
	self.collection[1]:update(self.oldPositionX - self.separationDistanceFromOwnerX, self.oldPositionY + self.separationDistanceFromOwnerY)
	self.collection[2]:update(self.oldPositionX + self.separationDistanceFromOwnerX, self.oldPositionY + self.separationDistanceFromOwnerY)
	if self.objectRef.hasFired and self.objectRef ~= nil then
		self.collection[1].weapon:fire()
		self.collection[2].weapon:fire()
	end
	self.oldPositionX = self.objectRef.sprite.x
	self.oldPositionY = self.objectRef.sprite.y
end

function GunpodCollection:clear()
	for i = 1, #self.collection, 1 do
		self.collection[i]:destroy()
	end
end

return GunpodCollection