require "com.Ride"
require "org.Queue"
require "com.game.weapons.secondary.FreezeMissile"
--[[
	CLASS NAME: Hater
	
	DESCRIPTION: The base class for all Hater classes.  All Haters have 1 life and can collide with player
	bulletsOutOfView, player bombs, and the player himself.
	
	FUNCTIONS:
	@init: Initializes all variables for the player.  For a further description on what the variables
	are, see inherit doc.
	@move: Gives the Hater a velocity vector that points towards (x, y)
	@destroy: Destroys the Hater.
]]--
Hater = Ride:subclass("Hater")

function Hater:init(sceneGroup, imgSrc, x, y, rotation, width, height, shipPieces)  --put the initial sound and load it here
	if shipPieces == nil then
		shipPieces = {"com/resources/art/sprites/enemy_02_piece_01.png", "com/resources/art/sprites/enemy_02_piece_02.png", "com/resources/art/sprites/enemy_02_piece_03.png", 
	"com/resources/art/sprites/enemy_02_piece_04.png", "com/resources/art/sprites/enemy_02_piece_01.png"}
	end

	self.super:init(sceneGroup, imgSrc, x, y, rotation, width, height, shipPieces, { categoryBits = 2, maskBits = 7 } )
	
	self.health = 1
	self.maxHealth = 1
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF EVERY INIT FILE
	self.type = "Hater"
	self.sprite.objRef = self
	self.time = 0
	self.weapon = nil
    self.isFrozen = false
    self.freezeTimer = 0
	
	self.shipSpriteComponents = display.newGroup()
	self.shipComponenets = Queue.new()
	
	self.primaryWeapons = {}
	self.secondaryWeapons = {}
	self.defensePassives = {}
	self.muzzleLocations = {}
	self:initMuzzleLocations()
	--haterDeathSFX = MOAIUntzSound.new()
	--haterDeathSFX:load('enemyDeath.ogg')
end


--[[
	FUNCTION NAME: move
	
	DESCRIPTION: Moves the Hater in the direction (x, y) with a speed of sqrt (x^2 + y^2).
	
	PARAMETERS:
		@x: x component of the velocity vector applied to the Hater.
		@y: y component of the velocity vector applied to the Hater.
	
	RETURN: VOID
]]--
function Hater:move(x, y)
	self.sprite.x = self.sprite.x + x
	self.sprite.y = self.sprite.y + y
end

function Hater:fire()
    --haters shoot 30 units in front of them at a speed of 400
	for i = 1, #self.primaryWeapons , 1 do
		--print('Hater firing weapon')
		self.primaryWeapons[i]:fire()
	end
	
	--Fire secondary weapons
	--[[for i = 1, #self.secondaryWeapons, 1
		self.secondaryWeapons[i]:fire()
	end]]--
end

function Hater:equip(collection, itemClass, sceneGroup, amount, muzzleLocation)
	local newItem = itemClass:new(sceneGroup, false, 90, 400)
	collection[#collection + 1] = newItem
	if amount ~= nil then
		if not usingBulletManagerBullets then
			newItem:load(amount, sceneGroup, muzzleLocation, false)
		end
		newItem:setMuzzleLocation(muzzleLocation)
	end
	newItem.owner = self
end


function Hater:equipRig(sceneGroup, weapons, passives)
	
	if weapons ~= nil then
		for i = 1, #weapons, 1 do
			self:equip(self.primaryWeapons,require(weapons[i]), sceneGroup, 30, self.muzzleLocations[i])
		end
	end
	if passives ~= nil then
		for i = 1, #passives, 1 do
			table.insert(self.defensePassives, require(passives[i])())
		end
	end
end


--Temporary function, will go away when bullets can update themselves.
function Hater:cullBulletsOffScreen()
	for i = 1, #self.primaryWeapons, 1 do
		self.primaryWeapons[i].checkBullets()
	end
end

function Hater:update()
	self.time = self.time + 1
   
   if (self.health <= 0) then
      self.alive = false
      self:explode()
   end
   
   if (self.isFrozen) then
      self.freezeTimer = self.freezeTimer + 1
      if (self.freezeTimer >= 1000) then
         self.isFrozen = false
      end
   end
   
   --ALL THE BULLETS!
   --self.weapon:checkBullets()
   self:cullBulletsOffScreen()
   --[[local length = self.bulletsInView.size
	local newInViewQueue = Queue.new()
	while self.bulletsInView.size > 0 do
		local bullet = Queue.removeBack(self.bulletsInView)
		if bullet.sprite.y >= 800 or bullet.sprite.y <= 50 or bullet.sprite.x >= 500 or bullet.sprite.x <= 50 or bullet.alive == false then
			bullet.sprite.x = 5000
			bullet.sprite.y = 5000
			bullet.alive = false
			Queue.insertFront(self.bulletsOutOfView, bullet)
		else
			Queue.insertFront(newInViewQueue, bullet)
		end
	end
	self.bulletsInView = newInViewQueue]]--
	
	
	if self.alive and self.sprite then		
		if (self.sprite.y >=  850 ) then
			self.alive = false
			return
		end
	end
	--self.particleEmitter:updateLoc(self.sprite.x, self.sprite.y)
end

--[[
	FUNCTION NAME: onHit
	
	DESCRIPTION: Collision Event Handler Function that is evoked when the Hater has collided
	with the Player's bullet, bomb, or the player himself.
	
	PARAMETERS:
		@fix1: This current Hater's fixture.
		@fix2: The fixture that this Hater has collided with.
	
	RETURN: VOID
]]--

--function Hater:onHit(you, collide)
function Hater:onHit(phase, collide)
	if self.alive and collide.isPlayerBullet then
		self.health = self.health - collide.damage
		
		if FreezeMissile:made(collide) then
			self.isFrozen = true
			self.freezeTimer = collide.freezeDuration
		end
		--sound:load(self.soundPath)
		--haterDeathSFX:play()
		--this is the check to say you are dead; place the sound here to make it work
		--later when weapons do different damage, you can make a check for a hit or a death
		--for now, only a death sound will be played.
		--print('Colliding with player bullet')
	end
   
	if self.alive and collide.type == "player" then
		self.health = 0
		
	end
	self.super:onHit(phase, collide)
end

function Hater:die()
	self.super:die()
	mainInventory.dollaz = mainInventory.dollaz + 3 * self.maxHealth
end

--[[
	FUNCTION NAME: destroy
	
	DESCRIPTION: Destroys all contents of the Hater.
	
	RETURN: VOID
]]--
function Hater:destroy()
	
	if(self) then 
		self.super:destroy()
	end
	--self.haterList[self] = nil
	
end

function Hater:respawn(group)
	if group ~= nil then
		group:insert(self.sprite)
	end
	self.time = 0
	self.health = self.maxHealth
	self.isFrozen = false
	self.freezeTimer = 0
end

Hater:virtual("initMuzzleLocations")