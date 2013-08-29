require "com.MoveableObject"
require "com.managers.CollectableHeap"
Collectable = MoveableObject:subclass("Collectable")

function Collectable:init(sceneGroup, imgSrc, startX, startY, rotation, width, height, isPlayerCollectible, value)
    local collisionFilter

    --Bitmasks the appropiate flags so that collision detection is checked against certain Box2D bodies.
	if isPlayerCollectible == true then
		collisionFilter = { categoryBits = 8, maskBits = 13}
	else
        collisionFilter = { categoryBits = 4, maskBits = 14}
	end
	self.super:init(sceneGroup, imgSrc, "kinematic", startX, startY, rotation, width, height, collisionFilter)
	self.imgSrc = imgSrc
	
	-- default class name
	self.className = "Collectible"
	
	--A flag that determines if the collectible is on the screen and moving.
	self.alive = false
	
    --A value that determines the amount of something that is returned
    if value ~= nil then
        self.value = value
    else
        self.value = 0
    end
    
	--Does the player own this collectible.
	self.isPlayerCollectible = isPlayerCollectible
	
	--This an object reference to this object from a Corona sprite.  This is need for collision detection to work.
	self.sprite.objRef = self
end

--function Collectable:update()
    
--end

--Collectable:virtual("update")