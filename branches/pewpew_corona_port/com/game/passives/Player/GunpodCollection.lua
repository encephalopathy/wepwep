require "com.game.passives.Player.GunpodSingle"

GunpodCollection = Passive:subclass("GunpodCollection")

function GunpodCollection:init()
	self.collection = {}
end

function GunpodCollection:setOwner(objectRef, sceneGroup)
	assert(objectRef ~= nil, 'Did not equip an owner such as player or an enemy to this passive')
	self.objectRef = objectRef
	self.oldPositionX = self.objectRef.sprite.x
	self.oldPositionY = self.objectRef.sprite.y
	self.collection[1] = GunpodSingle:new(sceneGroup, "com/resources/art/sprites/rocket_01.png", self.oldPositionX - 80, self.oldPositionY) --left side
	self.collection[2] = GunpodSingle:new(sceneGroup, "com/resources/art/sprites/rocket_01.png", self.oldPositionX + 80, self.oldPositionY) --right side
	self.collection[1]:equipWeapon(sceneGroup)
	self.collection[2]:equipWeapon(sceneGroup)
end

function GunpodCollection: update()
	self.collection[1]:update(self.oldPositionX - 80, self.oldPositionY)
	self.collection[2]:update(self.oldPositionX + 80, self.oldPositionY)
	if self.objectRef.hasFired then
		self.collection[1].weapon:fire()
		self.collection[2].weapon:fire()
	end
	self.oldPositionX = self.objectRef.sprite.x
	self.oldPositionY = self.objectRef.sprite.y
end

return GunpodCollection