require "com.Ride"
require "org.Queue"
require "com.game.weapons.secondary.FreezeMissile"

local DEFAULT_HATER_POOL_LOCATION = 11133377

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
	
	
	if x == nil or x == 0 then
		x = DEFAULT_HATER_POOL_LOCATION
	end
	
	if y == nil or y == 0 then
		y = DEFAULT_HATER_POOL_LOCATION
	end
	
	self.super:init(sceneGroup, imgSrc, x, y, rotation, width, height, shipPieces, { categoryBits = 2, maskBits = 7 } )

	--self.sceneGroup = sceneGroup --wanted to give Hater a reference to the sceneGroup; took out since it wasn't needed
	
	self.health = 1
	self.maxHealth = 1
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF EVERY INIT FILE
	self.type = "Hater"
	
	self.time = 0
	self.weapon = nil
    self.isFrozen = false
    self.freezeTimer = 0
	
	self.shipSpriteComponents = display.newGroup()
	self.shipComponenets = Queue.new()
	
	self.primaryWeapons = {}
	self.secondaryWeapons = {}
	self.muzzleLocations = {}
	self:initMuzzleLocations()
	self.sprite.objRef = self
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
			--print("weapon[i]: "..weapons[i])
			assert(require(weapons[i]), 'Cannot find the weapon to create: ' .. weapons[i] .. 'in AIDirector')
			self:equip(self.primaryWeapons,require(weapons[i]), sceneGroup, 30, self.muzzleLocations[i])
		end
	end
	if passives ~= nil then
		for i = 1, #passives, 1 do
			--print("passives[i]: "..passives[i])
			assert(require(passives[i]), 'Cannot find the passive to create: ' .. passives[i] .. 'in AIDirector')
			table.insert(self.defensePassives, require(passives[i])(self))
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
   
   
   if (self.isFrozen and self.alive) then
	  print('IN HATERS UPDATE')
	  print(self.health)
	  print(self.isFrozen)
	  print(self.freezeTimer)
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
	if phase == 'began' then
		if self.alive and collide.isPlayerBullet then
			Runtime:dispatchEvent({name = "playSound", soundHandle = 'Hater_onHit'})
			self.health = self.health - collide.damage
			
			if FreezeMissile:made(collide) then
				self.isFrozen = true
				self.freezeTimer = collide.freezeDuration
			end
			
			if self.health <= 0 then
				self:die()
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
	end
	self.super:onHit(phase, collide)
end


function Hater:die() --TODO: have these Runtime:dispatchEvent as sceneGroup events
	print("YOU HAVE KILLED A HATER!!!")
	Runtime:dispatchEvent({name = "playSound", soundHandle = 'Hater_die'})
	Runtime:dispatchEvent({name = "spawnCollectible", target = "ScrapPickUp", position =  {x = self.sprite.x + 1, y = self.sprite.y + 1}})
	--mainInventory.dollaz = mainInventory.dollaz + (3 * self.maxHealth)
	--print("dispatchEvent Hater.lua addScore")
	Runtime:dispatchEvent({name = "addScore", score = (3*self.maxHealth)})
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
	--self.sceneGroup = nil --trying to solve scoreManager issue of not listening to events
end

--used to take in group
function Hater:respawn()
	-- if group ~= nil then
		-- group:insert(self.sprite)
	-- end
	self.time = 0
	self.health = self.maxHealth
	self.alive = true
	self.isFrozen = false
	self.freezeTimer = 0
end

Hater:virtual("equipRig")
Hater:virtual("initMuzzleLocations")
