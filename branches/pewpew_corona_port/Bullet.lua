require("MoveableObject")

Bullet = MoveableObject:subclass("Bullet")



function Bullet:init(sceneGroup, imgSrc, isPlayerBullet, startX, startY, rotation, width, height)
	local collisionFilter
	
	--Bitmasks the appropiate flags so that collision detection is checked against certain Box2D bodies.
	if isPlayerBullet == true then
		collisionFilter = { categoryBits = 4, maskBits = 14}
	else
		collisionFilter = { categoryBits = 8, maskBits = 13}
	end
	self.super:init(sceneGroup, imgSrc, "kinematic", startX, startY, rotation, width, height, collisionFilter)
	self.imgSrc = imgSrc
	
	-- default class name
	self.className = "bullet"
	
	--A flag that determines if the bullet is on the screen and moving.
	self.alive = false
	
	--The amount of damage this bullet does.
	self.damage = 1
	
	--Does the player own this bullet.
	self.isPlayerBullet = isPlayerBullet
	
	--This an object reference to this object from a Corona sprite.  This is need for collision detection to work.
	self.sprite.objRef = self
end

function Bullet:fire(x, y)
	self.sprite:setLinearVelocity(x, y)
	self.alive = true
end

function Bullet:move(x, y)
	self.super:move(x, y)
end

function Bullet:__toString()
	return "Bullet"
end

function Bullet:onHit(phase, collitor)
	if phase == "began" and self.alive then
		if not collitor.type == "player" and self.isPlayerBullet then
			if self.alive then
				self.alive = false
			end
		end

		if collitor.type == "player" and not self.isPlayerBullet then
			if self.alive then
				self.alive = false
			end
		end
		
		if self.isPlayerBullet and collitor.type == "Hater" then
			if self.alive then
				self.alive = false
			end
		end
	elseif phase == "ended" and not self.alive then
		self:recycle()
	end
end

function Bullet:recycle()
	self.sprite.x = 5000
    self.sprite.y = 5000
	local offScreen = { name = "offScreen", bullet = self }
	Runtime:dispatchEvent(offScreen)
end

function Bullet:destroy()
	self.super:destroy()
end

Bullet:virtual("update")