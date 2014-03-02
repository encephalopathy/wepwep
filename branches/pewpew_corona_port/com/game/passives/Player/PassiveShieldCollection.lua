require "com.game.passives.Player.PassiveShield"

 PassiveShieldCollection= Passive:subclass("PassiveShieldCollection")

 function PassiveShieldCollection:init(spriteImage, shieldType)
 	self.collection = {}
 	self.spriteImage = spriteImage
 	self.shieldType = shieldType
 end

 function PassiveShieldCollection:setOwner(objectRef, sceneGroup)
 	assert(objectRef ~= nil, 'PassiveShieldCollection: Did not equip an owner such as player or an enemy to this passive')
 	assert(sceneGroup ~=nil, "PassiveShieldCollection: sceneGroup is nil")
 	self.objectRef = objectRef
 	self.oldPositionX = self.objectRef.sprite.x
	self.oldPositionY = self.objectRef.sprite.y
	print("self.sizeX & Y is", self.sizeX, self.sizeY)
	self.collection[1] = self.shieldType:new(sceneGroup, self.spriteImage, self.objectRef, self.objectRef.sprite.width + 100, self.objectRef.sprite.height + 100)
 end

 function PassiveShieldCollection:update()
 	self.collection[1]:update(self.oldPositionX, self.oldPositionY)
 	self.oldPositionX = self.objectRef.sprite.x
 	self.oldPositionY = self.objectRef.sprite.y
 end

 function PassiveShieldCollection:clear()
	for i = 1, #self.collection, 1 do
		self.collection[i]:destroy()
	end
 end

 return PassiveShieldCollection