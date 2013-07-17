require("MoveableObject")
require("ParticleManager")
require("ParticleEmitter")
require("Particle")
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
--function Ride:init(x, y, scaleX, scaleY, imgSrc, sceneGroup, shipPieces)
function Ride:init(sceneGroup, imgSrc, startX, startY, rotation, width, height, shipPieces, collisionFilter)
	self.super:init(sceneGroup, imgSrc, "dynamic", startX, startY, rotation, width, height, collisionFilter)
	self.health = 0
	self.powah = powah
	
	self:createExplosionSpriteSheet(sceneGroup, { width = 64, height = 64, numFrames = 16, sheetContentWidth = 256, sheetContentHeight = 256 } )
	self.particleEmitter = self:createShipPieceParticleEmitter(sceneGroup, shipPieces)
end

local function onExposion(event) 
	if ( event.phase == "began" ) then
		event.target.isVisible = true
	elseif ( event.phase == "ended" ) then
		print('Exploding')
		event.target.isVisible = false
	end
end

--[[
	FUNCTION NAME: createParticleAssets

	DESCRIPTION: Creates the particles that will be generated by this ride.
				 
	RETURN: VOID

--]]
function Ride:createExplosionSpriteSheet(sceneGroup, spriteSheetOptions)

	--creates an explosion particle effect by leveraging off of sprite sheets.
	local explosionSpriteSheet = graphics.newImageSheet("img/exp2.png", spriteSheetOptions )
	local spriteOptions = { name = "explosion", start = 1, count = 16, time = 1000, loopCount = 1 }
	local explosion = display.newSprite(explosionSpriteSheet, spriteOptions)
	explosion.x = 5000; explosion.y = 5000
	explosion.xScale = 3; explosion.yScale = 3
	explosion.isVisible = false
	explosion:addEventListener("sprite", self.afterExplosion)
	self.explosion = explosion
	--Variables for the exploding particles.
	
end

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
			local vx = v0x * math.cos(emitAngle / (2 * math.pi))
			local vy = v0y * math.sin(emitAngle / (2 * math.pi))
		
			local newParticle = Particle:new(sceneGroup, shipPieces[i], 50, 50, vx, vy, ax, ay, 15, 200)
			particleEmitter:add(newParticle)
		
			emitAngle = emitAngle + (75 / math.pi)
		end
		addParticleEmitter(particleEmitter)
	end
	return particleEmitter
end


function Ride:onHit(phase, collide)
	--self.super:onHit(event)
	--print(event.other)
	--if ( event.phase == "began" ) then
		--print( self.myName .. ": collision began with " .. event.other.myName )
		--print('Collided began')
	if self.health <= 0 then
		if phase == "ended" then
			self:die()
		end
	end
	
end

function Ride:die()
	self.alive = false
	self:explode()
end

function Ride:afterExplosion()
	if ( self.phase == "began" ) then
		self.target.isVisible = true
	elseif ( self.phase == "ended" ) then
		self.target.isVisible = false
	end
	
end

function tprint (tbl, indent)
  if not indent then indent = 0 end
  for k, v in pairs(tbl) do
    formatting = string.rep("  ", indent) .. k .. ": "
    if type(v) == "table" then
      print(formatting)
      tprint(v, indent+1)
    else
      print(formatting .. v)
    end
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

--[[ FUNCTION NAME: explode

	 DESCRIPTION: Creates an array of particles when ships are
	 destroyed.
	 
	 RETURN: VOID
]]--
function Ride:explode()
	if not self.explosion.isPlaying then
	
		--Makes the explosion appear on screen by translating it to the location of the exploded ship
		self.explosion.x = self.sprite.x; self.explosion.y = self.sprite.y;
		self.explosion:play()
		
		--Creates the particles that fly off the ship when a ship dies
		self.particleEmitter:updateLoc(self.sprite.x, self.sprite.y)
	    self.particleEmitter:start()
	end
end

--[[
	FUNCTION NAME: destroy
	
	DESCRIPTION: Destroys the Ride and garbage collects
	all bombs and heaters.
	
	RETURN: VOID
]]--
function Ride:destroy()
	self.bombs = nil
	self.heaters = nil
	removeParticleEmitter(self.particleEmitter)
	self.particleEmitter:destroy()
	self.particleEmitter = nil
	self.explosion:removeEventListener("sprite", self.afterExplosion)
	self.explosion = nil --[[Not sure if this garbage collects the explosion 
							because it is not added to the Scene group in Rappanui.
						]]--
	self.super:destroy()
end
