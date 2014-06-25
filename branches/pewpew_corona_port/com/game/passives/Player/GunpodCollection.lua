require "com.game.passives.Player.GunpodSingle"

GunpodCollection = Passive:subclass("GunpodCollection")

function GunpodCollection:init(isActivatable, gunpodType, spriteImage, separationDistanceFromOwnerX, separationDistanceFromOwnerY, weaponType, ...)
	self.super:init(nil, isActivatable)
	self.gunpodCollection = {}
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
	self.gunpodCollection[1] = self.gunpodType:new(sceneGroup, self.spriteImage, self.oldPositionX - self.separationDistanceFromOwnerX, self.oldPositionY + self.separationDistanceFromOwnerY)
	self.gunpodCollection[2] = self.gunpodType:new(sceneGroup, self.spriteImage, self.oldPositionX + self.separationDistanceFromOwnerX, self.oldPositionY + self.separationDistanceFromOwnerY)
	self.gunpodCollection[1]:equipWeapon(sceneGroup, self.objectRef.haterList, self.weaponType, unpack(self.weaponArguments))
	self.gunpodCollection[2]:equipWeapon(sceneGroup, self.objectRef.haterList, self.weaponType, unpack(self.weaponArguments))
end

function GunpodCollection:update()
	self.gunpodCollection[1]:update(self.oldPositionX - self.separationDistanceFromOwnerX, self.oldPositionY + self.separationDistanceFromOwnerY)
	self.gunpodCollection[2]:update(self.oldPositionX + self.separationDistanceFromOwnerX, self.oldPositionY + self.separationDistanceFromOwnerY)
	if self.objectRef.hasFired and self.objectRef ~= nil then
		self.gunpodCollection[1].weapon:fire()
		self.gunpodCollection[2].weapon:fire()
	end
	self.oldPositionX = self.objectRef.sprite.x
	self.oldPositionY = self.objectRef.sprite.y
end

function GunpodCollection:clear()
	for i = 1, #self.gunpodCollection, 1 do
		self.gunpodCollection[i]:destroy()
	end
end

return GunpodCollection