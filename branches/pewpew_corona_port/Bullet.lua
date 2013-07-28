require("MoveableObject")
--[[
	Bullet Class
	DESCRIPTION: Is the base class for any bullet generated in shoot em' up PEW PEW.  When bullets
	collide with other Moveable objects besides other bullets, they are destroyed.
	
	FUNCTIONS:
	@init: Constructor for the Bullet class.  Responsible for initializing all parameters in its parent
	classes as well as sets up a new collision event handler function for this object.
	@move: moves the bullet at a linear velocity (x,y)
	@onHit: Collision event handler function used by Bullet.  This function is called when the bullet has collided
	with a Moveable Object that is not a bullet.  In addition, it will destory this bullet if 
	this function is called.
--]]
Bullet = MoveableObject:subclass("Bullet")

--[[
	FUNCTION NAME: init
	
	DESCRIPTION: Same as inherit doc but sets the sprite texture to location (0, 0) so that the sprite texture
	moves relative with its BOX2D body.  Also sets up the collision event handler function for this class.
	
	PARAMETERS:
		@See inherit doc
	RETURN: VOID
]]--

function Bullet:init(sceneGroup, imgSrc, isPlayerBullet, startX, startY, rotation, width, height)
	local collisionFilter
	if isPlayerBullet == true then
		collisionFilter = { categoryBits = 4, maskBits = 14}
	else
		collisionFilter = { categoryBits = 8, maskBits = 13}
	end
	self.super:init(sceneGroup, imgSrc, "kinematic", startX, startY, rotation, width, height, collisionFilter)
	self.imgSrc = imgSrc
	self.alive = false
	self.damage = 1
	self.isPlayerBullet = isPlayerBullet
	self.sprite.objRef = self
end

--[[
FUNCTION NAME: move

DESCRIPTION: moves the bullet at the given linear velocity = sqrt(x^2 + y^2) towards the (x, y) direction.

PARAMETERS:
	@x: The distance the bullet will move in the x direction
	@y: The distance the bullet will move in the y direction
RETURN: VOID
]]--

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

--[[

FUNCTION NAME: onHit

DESCRIPTION: Destroys the bullet when it has collided with another bullet.
PARAMETERS: 
	@See inherit doc
RETURN: VOID
]]--
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
	--self.bulletList[self] = nil
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
Bullet:virtual("recycle")