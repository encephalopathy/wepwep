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
	@recycle: Moves the bullet off screen and stores this object in a queue that holds all of the off screen bullets in Bullet Manager.
	@fire: Fires the bullet in the given direction and speed.
	@destroy: See inherit doc.
	@update: An abstract method that needs to be created in any base class.  This is used to construct any abnormal bullet behavior.
--]]
Bullet = MoveableObject:subclass("Bullet")

--[[
	CONSTRUCTOR
	
	DESCRIPTION: Same as inherit doc but sets the sprite texture to location (0, 0) so that the sprite texture
	moves relative with its BOX2D body.  Also sets up the collision event handler function for this class.
	
	PARAMETERS:
		@isPlayerBullet: A flag to determine whether the bullet belong to the player or not.
		@See inherit doc
]]--

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
	
	--A flag that determines if the bullet is on the screen and moving.
	self.alive = false
	
	--The amount of damage this bullet does.
	self.damage = 1
	
	--Does the player own this bullet.
	self.isPlayerBullet = isPlayerBullet
	
	--This an object reference to this object from a Corona sprite.  This is need for collision detection to work.
	self.sprite.objRef = self
end

--[[
	FUNCTION NAME: fire

	DESCRIPTION: moves the bullet at the given linear velocity = sqrt(x^2 + y^2) towards the (x, y) direction.
				 The coordinates system in which this object moves is based upon the origin being at 
				 the top left of the screen.

	PARAMETERS:
		@x: The distance the bullet will move in the x direction.
		@y: The distance the bullet will move in the y direction.
	RETURN: VOID
]]--
function Bullet:fire(x, y)
	self.sprite:setLinearVelocity(x, y)
	self.alive = true
end

--[[
	FUNCTION NAME: move

	DESCRIPTION: Translates the bullet to the specified x and y location

	PARAMETERS:
		@x: x destination where the origin is the top left.
		@y: y destination where the origin is the top left.
	RETURN: VOID
]]--
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
end

--[[
	FUNCTION NAME: recycle

	DESCRIPTION: "Destroys" the by dispatching an event that culls this bullet in the BulletManager. 
	PARAMETERS: 
		@See inherit doc
	RETURN: VOID
]]--
function Bullet:recycle()
	self.sprite.x = 5000
    self.sprite.y = 5000
	local offScreen = { name = "offScreen", bullet = self }
	Runtime:dispatchEvent(offScreen)
end

--[[

	FUNCTION NAME: destroy

	DESCRIPTION: See inherit doc.
		@See inherit doc.
	RETURN: VOID
]]--
function Bullet:destroy()
	self.super:destroy()
end

--[[
	FUNCTION NAME: update

	DESCRIPTION: Updates the bullet for abnormal bullet behavior
	PARAMETERS: 
		@Variable amount, you decide.
	RETURN: VOID
]]--
Bullet:virtual("update")