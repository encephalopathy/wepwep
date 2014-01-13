require "com.game.passives.Player.GunpodSingle"

GunpodCollection = Passive:subclass("GunpodCollection")

function GunpodCollection:init()
	self.collection = {}
end

function GunpodCollection:setOwner(objectRef, gunpodType, sceneGroup, spriteImage, separationDistanceFromOwnerX, separationDistanceFromOwnerY, haterList, weaponType, ...)
	assert(objectRef ~= nil, 'Did not equip an owner such as player or an enemy to this passive')
	self.objectRef = objectRef
	self.oldPositionX = self.objectRef.sprite.x
	self.oldPositionY = self.objectRef.sprite.y
	self.separationDistanceFromOwnerX = separationDistanceFromOwnerX
	self.separationDistanceFromOwnerY = separationDistanceFromOwnerY
	self.collection[1] = GunpodSingle:new(sceneGroup, spriteImage, self.oldPositionX - self.separationDistanceFromOwnerX, self.oldPositionY + self.separationDistanceFromOwnerY)
	self.collection[2] = GunpodSingle:new(sceneGroup, spriteImage, self.oldPositionX + separationDistanceFromOwnerX, self.oldPositionY + separationDistanceFromOwnerY)
	self.collection[1]:equipWeapon(sceneGroup, haterList, weaponType, unpack(arg))
	self.collection[2]:equipWeapon(sceneGroup, haterList, weaponType, unpack(arg))
end

function GunpodCollection: update()
	self.collection[1]:update(self.oldPositionX - self.separationDistanceFromOwnerX, self.oldPositionY + self.separationDistanceFromOwnerY)
	self.collection[2]:update(self.oldPositionX + self.separationDistanceFromOwnerX, self.oldPositionY + self.separationDistanceFromOwnerY)
	if self.objectRef.hasFired and self.objectRef ~= nil then
		self.collection[1].weapon:fire()
		self.collection[2].weapon:fire()
	end
	self.oldPositionX = self.objectRef.sprite.x
	self.oldPositionY = self.objectRef.sprite.y
end

function GunpodCollection:clear(sceneGroup)
	sceneGroup:remove(self.collection[1].sprite)
	sceneGroup:remove(self.collection[2].sprite)
	self.super:clear()
end

return GunpodCollection