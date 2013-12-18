require "com.game.passives.Player.GunpodSingle"

GunpodCollection = Passive:subclass("GunpodCollection")

function GunpodCollection: init(fieldName, sceneGroup)
	self.super:init(fieldName)
	self.collection = {}
	self.collection[1] = GunpodSingle:new(sceneGroup, "com/resources/art/sprites/rocket_01.png", fieldName.sprite.x - 25, fieldName.sprite.y) --left side
	self.collection[2] = GunpodSingle:new(sceneGroup, "com/resources/art/sprites/rocket_01.png", fieldName.sprite.x + 25, fieldName.sprite.y) --right side
	self.collection[1]:equipWeapon(sceneGroup)
	self.collection[2]:equipWeapon(sceneGroup)
end

function GunpodCollection: update()
	self.collection[1]:update(self.fieldName.sprite.x - 25, self.fieldName.sprite.y)
	self.collection[2]:update(self.fieldName.sprite.x + 25, self.fieldName.sprite.y)
	if self.fieldName.hasFired then
		self.collection[1].weapon:fire()
		self.collection[2].weapon:fire()
	end
end

return GunpodCollection