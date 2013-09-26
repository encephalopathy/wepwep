require "com.MoveableObject"
require "com.managers.ParticleManager"
require "com.particles.ParticleEmitter"
require "com.particles.Particle"


--[[
	CLASS NAME: Ride

	DESCRIPTION:  The base class for all ships in Shoot em' up PEW PEW.  All ships have a designated health and power amount.  Also,
	ships also have the ability to carry bombs and additional heaters ("Weapons").
	
	FUNCTIONS:
	@init: Gives the ride no bombs, heaters, health and power.
	@move: See inherit doc.
	@shoot Makes the ride shoot
	@destroy: Destroys the ship
]]--
Ride = MoveableObject:subclass("Ride")


--[[
	FUNCTION NAME: init
	
	DESCRIPTION: Initializes the Ride's parent class as well as gives the Ride the specified health and powah
	
	PARAMETERS:
		@see inherit doc.
	RETURN: VOID
]]--
function Ride:init(sceneGroup, imgSrc, startX, startY, rotation, width, height, shipPieces, collisionFilter)
	self.super:init(sceneGroup, imgSrc, "dynamic", startX, startY, rotation, width, height, collisionFilter)
	self.health = 0 --this variable represents the ride's current hp
	self.maxhealth = 0 --this variable represents its maximum possible (and starting) hp
	self.powah = powah
	self.defensePassives = {}
	--defense parameters
	self.armor = 0       --this reduces damage by exactly this amount
	self.shields = 1     --this divides total damage, before hitting the armor, by this amount
	
	--Creates the a sprite sheet for the explosion looks animation.  This is independent of the particles that spawn.
	self:createExplosionSpriteSheet({ width = 64, height = 64, numFrames = 16, sheetContentWidth = 256, sheetContentHeight = 256 } )
	--Creates the particle emitter that will spawn the ship pieces that fly around when a ship explodes.
	self.particleEmitter = self:createShipPieceParticleEmitter(sceneGroup, shipPieces)
end


function Ride:takeDamage(bullet)
	local finalDamage = 0;

	finalDamage = (bullet / self.shields) - self.armor
	
	if finalDamage <= 0 then finalDamage = 1 end
	
	self.health = self.health - finalDamage

end


--[[
--	FUNCTION NAME: createParticleAssets
--
--	DESCRIPTION: Creates the explosion animation that the play will see when a ship explodes.
--  NOTE: The explosion and frame count is hardcoded, will need to abstract it out if we decide to do
		  other explosios.
--	PARAMETERS:
--		@spriteSheetOptions: Used to create an image sheet in Corona that creates a Sprite sheet in Corona.
--	RETURN: VOID
--
--]]
function Ride:createExplosionSpriteSheet(spriteSheetOptions)

	--creates an explosion particle effect by leveraging off of sprite sheets. Refer to Corona Sprite Sheets tutorial
	--for references because this stuff is really confusing to explain simply.
	local explosionSpriteSheet = graphics.newImageSheet("com/resources/art/sprites/exp2.png", spriteSheetOptions )
	--Creates a 16 frame animation that starts at animation one, that loops once, and lasts for 1000 miliseconds.
	local spriteOptions = { name = "explosion", start = 1, count = 16, time = 1000, loopCount = 1 }
	--Creates the sprite sheet.
	local explosion = display.newSprite(explosionSpriteSheet, spriteOptions)
	--Creates the explosion location to be offscreen so we it doesn't get rendered in the scene.
	explosion.x = 5000; explosion.y = 5000
	--Increase the scale dimensions of the animation so we can see it on the screen.
	explosion.xScale = 3; explosion.yScale = 3
	--Makes sure we do not see the animation.
	explosion.isVisible = false
	--Adds an event listener the game knows when to animate the explosion at the right time.
	explosion:addEventListener("sprite", self.afterExplosion)
	--Keeps a reference to the explosion for animation purposes.
	self.explosion = explosion
	
end


--[[
--	FUNCTION NAME: createParticleEmitter
--
--	DESCRIPTION: Creates the particles that will be generated by this ride.
--				 
--	RETURN: ParticleEmitter Object.  See ParticleEmitter.lua for details.
--
--]]
function Ride:createShipPieceParticleEmitter(sceneGroup, shipPieces)
	local v0x = 5
	local v0y = 5
	local ax = -0.0035
	local ay = -0.0035
	local emitTime = 20
	local emitAngle = 0
    
	local particleEmitter = ParticleEmitter:new(self.sprite.x, self.sprite.y, emitTime)
	if shipPieces ~= nil then
		for i = 1, #shipPieces, 1 do
			--[[
				The math here parameterizes a circle so that all particles move in a radial direction
				from the ship's center to the boundaries of the screen.
			]]--
			local vx = v0x * math.cos(emitAngle / (2 * math.pi))
			local vy = v0y * math.sin(emitAngle / (2 * math.pi))
		
			local newParticle = Particle:new(sceneGroup, shipPieces[i], 50, 50, vx, vy, ax, ay, 15, 200)
			particleEmitter:add(newParticle)
			
			--Angle offset so that particles are not all bunched up next to each other
			emitAngle = emitAngle + (75 / math.pi)
		end
		--Adds the particle emitter to the Particle manager.  See ParticleManager.lua
		addParticleEmitter(particleEmitter)
	end
	return particleEmitter
end


--[[
	FUNCTION NAME: onHit
	
	DESCRIPTION: Handles object collision.  Displays the explosion animation and makes the ship particles
				 appear on screen when the ship dies.
	PARAMETERS:
		@See inherit doc.
	@RETURN: void
]]--
function Ride:onHit(phase, collide)
	if self.health <= 0 then
		if phase == "ended" and self.alive then
			self:die()
		end
	end
	
end


--[[
	FUNCTION NAME: die
	
	DESCRIPTION: Handles object collision.  Displays the explosion animation and makes the ship particles
				 appear on screen when the ship dies.
	PARAMETERS:
		@See inherit doc.
	@RETURN: void
]]--
function Ride:die()
	self.alive = false
	self:explode()
end


--[[
	FUNCTION NAME: afterExplosion
	
	DESCRIPTION: Handles object collision.  Displays the explosion animation and makes the ship particles
				 appear on screen when the ship dies.
	PARAMETERS:
		@See inherit doc.
	@RETURN: void
]]--
function Ride:afterExplosion()
	if ( self.phase == "began" ) then
		self.target.isVisible = true
	elseif ( self.phase == "ended" ) then
		self.target.isVisible = false
	end
	
end


--[[
	FUNCTION NAME: move
	
	DESCRIPTION: Moves the ride to the desired x and y direction
	
	PARAMETERS:
		@see inherit doc.
	RETURN: VOID
--]]
function Ride:move(x, y)
	self.super:move(x, y)
end


--[[ 
    FUNCTION NAME: explode

    DESCRIPTION: Creates an array of particles when ships are
    destroyed.
	 
    RETURN: VOID
]]--
function Ride:explode()
	if not self.explosion.isPlaying then
		--Makes the explosion appear on screen by translating it to the location of the exploded ship.
		self.explosion.x = self.sprite.x; self.explosion.y = self.sprite.y;
		self.explosion:play()
		
		--Creates the particles that fly off the ship when a ship dies.
		self.particleEmitter:updateLoc(self.sprite.x, self.sprite.y)
	    self.particleEmitter:start()
	end
end


--[[
	FUNCTION NAME: destroy
	
	DESCRIPTION: Destroys the Ride and garbage collects
				 all bombs and heaters.  This also removes the particle emitters and
  			 explosion animation from the game.
	RETURN: VOID
]]--

function Ride:clean()
	self.particleEmitter:clean()
end

function Ride:destroy()
	self.particleEmitter = nil
	--'Temporary fix until I get this figured out'
	if self.explosion ~= nil then
		self.explosion:removeEventListener("sprite", self.afterExplosion)
		self.explosion:removeSelf()
		self.explosion = nil
	end
	self.super:destroy()
end
