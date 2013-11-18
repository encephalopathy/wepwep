require "com.MoveableObject"

Collectible = MoveableObject:subclass("Collectible")

local DEFAULT_COLLECTIBLE_POOL_LOCATION = -10000

function Collectible:init(sceneGroup, imgSrc, startX, startY, rotation, width, height)
    local collisionFilter

    --Bitmasks the appropiate flags so that collision detection is checked against certain Box2D bodies.
	collisionFilter = { categoryBits = 16, maskBits = 1}
	
	if startX == nil then
		startX = DEFAULT_COLLECTIBLE_POOL_LOCATION
	end
	
	if startY == nil then
		startY = DEFAULT_COLLECTIBLE_POOL_LOCATION
	end
	
	self.super:init(sceneGroup, imgSrc, "dynamic", startX, startY, rotation, width, height, collisionFilter)
	
	--A flag that determines if the collectible is on the screen and moving.
	self.alive = false
	
    --A value that determines the amount of something that is returned
    if value ~= nil then
        self.value = value
    else
        self.value = 0
    end
	
	--Needs to be set
	self.effects = nil
    
	--self.sprite.isBodyActive = false
	self.sprite.isVisible = false
	self.sprite.isBodyActive = false
	
	self.sprite.x, self.sprite.y = -10000, -10000
	--Does the player own this collectible.
	
	--This an object reference to this object from a Corona sprite.  This is need for collision detection to work.
	self.sprite.objRef = self
end

function Collectible:onHit(phase, collide)
	if phase == "began" and self.alive then
		if self.alive then
			Runtime:dispatchEvent({name = "playSound", soundHandle = 'Collectible'})
			self:activateEffect(collide)
			self.alive = false
		end
	end
end

function Collectible:update(collectible)
	
end

function Collectible:spawn(spawnLocation, rotation)
	self.spawnLocation = spawnLocation
	self.alive = true
end

function Collectible:onSpawn()
	self.sprite.x = self.spawnLocation.x
	self.sprite.y = self.spawnLocation.y
	self.sprite.isVisible = true
	self.sprite.isBodyActive = true
end

Collectible:virtual("activateEffect")

return Collectible