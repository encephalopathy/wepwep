require "org.Object"

--[[
	CLASS NAME: MoveableObject
	
	DESCRIPTION: Is the base class for all subclasses that require physics or movement.
	This class is responsible for creating all BOX2D bodies and bitfilters
	for collision in the game.
	
	FUNCTIONS:
	@init: Constructor for the game
	@move: Moves the object given world coordinates x and y
	@collision: Utility function that gets called by the event listener created from Box2D.  Developers
				should not need to worry about this function in their subclasses.
	@onHit: Collision detection function that gets called when a collision has occurred between two MoveableObjects.
	@destroy: Destructor for the class, removes the sprite and all physics box2D properties.
--]]

MoveableObject = newclass("MoveableObject")


--[[
	CONSTRUCTOR:
	@sceneGroup: The object that is used to add the sprite to scene.  See Corona Docs concerning groups/storyboard.
	@imgSrc: The location of the image in which the sprite will be created from.
	@bodyType: Bodytype of the moveable objects, bullets have bodytype, kinematic, while ships have bodyType dynamic.
			   Particles do not have a body type so they don't collide with anything.
	@startX: Start location in the X direction for this object using the top left of the screen as the origin.
	@startY: Start location in the Y direction for this object using the top left of the screen as the origin.
	@rotation: Rotation of the object clockwise.  The reference angle starts in the X direction going right.
	@width: Width of the object in DPI.
	@height: Height of the object in DPI.
	@collisionFitlter: The collision mask for collision detection.  This determines which objects can collide with
	what.  For more information of how to set this up.  
	See: http://developer.coronalabs.com/forum/2010/10/25/collision-filters-helper-chart
]]--
function MoveableObject:init(sceneGroup, imgSrc, bodyType, startX, startY, rotation, width, height, collisionFilter)
	local sprite
	
	--Start location of the sprite is set to zero if not coordinates are given.
	if startX == nil then
	 startX = 0
	end
	
	if startY == nil then
	 startY = 0
	end
	
	--[[
		Creates a sprite by using the given image, 
		if no width and height fields are given, the width and height
		fields are given, a sprite is created with the dimensions the
		same as the image passed.
	]]--
	if width == nil or height == nil then
		sprite = display.newImage(imgSrc)
		if sprite == nil then
			error('Out of memory')
		end
		sprite.x, sprite.y = startX, startY
	else
		sprite = display.newImageRect(imgSrc, width, height)
		if sprite == nil then
			error('Out of memory')
		end
		sprite.width, sprite.height = width, height
		sprite.x, sprite.y = startX, startY
	end
	
	--Stores the value of the rotation of the object, if not rotation is given, it is set to zero.
	if rotation ~= nil then
		sprite.rotation = rotation
	else
		sprite.rotation = 0
	end
	
	--Creates a physics object from a sprite.
	if bodyType ~= nil then
		physics.addBody(sprite, bodyType, {density = 0, filter = collisionFilter})
		physics.setDrawMode( "hybrid" )
		--If the given object is not a bullet, it is given the type dynamic so that
		--bullets never collide with other bullets. Although this may change in the future.
		if bodyType == "dynamic" then
			sprite.isSensor = true
		end
	end
	
	--Stores a reference to the given sprite
	self.sprite = sprite
	
	--The scenegroup adds sprites to the scene so we can see them.  The scenegroup acts as the stack
	--so things that are added last appear on top of everything else.
	if sceneGroup ~= nil then
		sceneGroup:insert( sprite )
	end
	
	--Stores a value to determine wheter this object is alive or not.
	self.alive = true
	
	--Sets the target for which the collision will be called
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
	FUNCTION NAME: collision
	
	DESCRIPTION: Handles object collision.  This function is called when this object collides
	with another Moveable Object.
	PARAMETERS:
		@event: the collision event passed to this event listener.
	@RETURN: void
]]--
function MoveableObject:collision(event)
	self.objRef:onHit(event.phase, event.other.objRef)
end

--[[
	FUNCTION NAME: onHit
	
	DESCRIPTION: Handles object collision.  This function is called when this object collides
	with another Moveable Object.
	PARAMETERS:
		@phase: The phase in which the collision happens.  There are 2 phases, all of which are string values.
			-"began": The phase in which collision detection when two objects touch each other once and if two objects are touching
					  each other constantly.  This phase happens very VERY often.
			-"ended:" The phase in which collision has been resolved.  This only gets called once.
		@collide: The MoveableObject that this object is colliding or has collided with.
	@RETURN: void
]]--
function MoveableObject:onHit(phase, collide)
end

--[[
	FUNCTION NAME: destroy
	
	DESCRIPTION: Base destructor for all moveable objects.  Responsible for removing the sprite
	texture, and all objects related from BOX2D from this object.
	@RETURN: VOID
]]--
function MoveableObject:destroy()
	if (self.sprite) then
		self.sprite:removeEventListener("collision", self.sprite)
		self.sprite.collision = nil
		self.sprite:removeSelf()
		self.objRef = nil
		self.sprite = nil
	end
end