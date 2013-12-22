require "com.game.passives.Player.GunpodSingle"

GunpodCollection = Passive:subclass("GunpodCollection")

function GunpodCollection:init()
end

function Passive:setOwner(objectRef, sceneGroup)
	assert(objectRef ~= nil, 'Did not equip an owner such as player or an enemy to this passive')
	self.objectRef = objectRef
	self.collection = {}
	self.collection[1] = GunpodSingle:new(sceneGroup, "com/resources/art/sprites/rocket_01.png", objectRef.sprite.x - 25, objectRef.sprite.y) --left side
	self.collection[2] = GunpodSingle:new(sceneGroup, "com/resources/art/sprites/rocket_01.png", objectRef.sprite.x + 25, objectRef.sprite.y) --right side
	self.collection[1]:equipWeapon(sceneGroup)
	self.collection[2]:equipWeapon(sceneGroup)
end

function GunpodCollection: update()
	self.collection[1]:update(self.objectRef.sprite.x - 25, self.objectRef.sprite.y)
	self.collection[2]:update(self.objectRef.sprite.x + 25, self.objectRef.sprite.y)
	if self.objectRef.hasFired then
		self.collection[1].weapon:fire()
		self.collection[2].weapon:fire()
	end
end

return GunpodCollection