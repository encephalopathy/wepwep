require("Object")

--[[
	CLASS NAME: MoveableObject
	
	DESCRIPTION: Is the base class for all subclasses that require physics or movement.
	This class is responsible for creating all BOX2D fixtures, bodies, bitmasks, and bitfilters
	for collision in the game.
	
	FUNCTIONS:
	@init: Constructor for the game
	@move: Moves the object given world coordinates x and y
	@destroy: Destructor for the class, removes the MOAIProp ("sprite"), fixture, and body of the object
--]]

MoveableObject = newclass("MoveableObject")

function MoveableObject:init(sceneGroup, imgSrc, bodyType, startX, startY, rotation, width, height, collisionFilter)
	local sprite
	if startX == nil then
	 startX = 0
	end
	
	if startY == nil then
	 startY = 0
	end
	
	if width == nil or height == nil then
		sprite = display.newImage(imgSrc)
		sprite.x, sprite.y = startX, startY
	else
		sprite = display.newImageRect(imgSrc, width, height)
		sprite.width, sprite.height = width, height
		sprite.x, sprite.y = startX, startY
	end
	
	if rotation ~= nil then
		sprite.rotation = rotation
	else
		sprite.rotation = 0
	end
	
	if bodyType ~= nil then
		physics.addBody(sprite, bodyType, {density = 0, filter = collisionFilter})
		--physics.setDrawMode( "debug" )
		physics.setDrawMode( "hybrid" )
		if bodyType == "dynamic" then
			sprite.isSensor = true
		end
	end
	self.sprite = sprite
	
	if sceneGroup ~= nil then
		sceneGroup:insert( sprite )
	end
	self.alive = true
	
	self.sprite.collision = self.collision
	self.sprite:addEventListener("collision", self.sprite)
	
end
--[[
	FUNCTION NAME: move
	
	DESCRIPTION: Responsible for moving the object to the x and y location in the world
	
	PARAMETERS:
		@x: X coordinate of the new location where the this object will move to.
		@y: Y coordinate of the new location where the this object will move to.
	@RETURN: void
]]--
function MoveableObject:move(x, y)
	self.sprite.x = x
	self.sprite.y = y
end

--[[
	FUNCTION NAME: onHit
	
	DESCRIPTION: Handles object collision.  This function is called when this object collides
	with another Moveable Object.
	PARAMETERS:
		@fix1: The fixture for this object when a collision has occurred.
		@fix2: The fixture for the Moveable Object that collided with this object.
		@arbiter: Arbiter used to determine in which direction did this object collided with the collide.
	@RETURN: void
]]--

function MoveableObject:collision(event)
	self.objRef:onHit(event.phase, event.other.objRef)
end

function MoveableObject:onHit(phase, collide)
	
end

--[[
	FUNCTION NAME: destroy
	
	DESCRIPTION: Base destructor for all moveable objects.  Responsible for removing the sprite
	texture, and all objects related from BOX2D from this object.
	
	@RETURN: VOID
]]--
function MoveableObject:destroy()
	if (self) then
		self.sprite:removeEventListener("collision", self.sprite)
		self.sprite.collision = nil
		self.sprite:removeSelf()
		self.objRef = nil
		self.sprite = nil
	end
end