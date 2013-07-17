require("Ride")
require("Queue")
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
		shipPieces = {"sprites/enemy_02_piece_01.png", "sprites/enemy_02_piece_02.png", "sprites/enemy_02_piece_03.png", 
	"sprites/enemy_02_piece_04.png", "sprites/enemy_02_piece_01.png"}
	end

	self.super:init(sceneGroup, imgSrc, x, y, rotation, width, height, shipPieces, { categoryBits = 2, maskBits = 7 } )
	self.bulletsOutOfView = Queue.new()
	for i = 1, 4, 1 do
		Queue.insertFront(self.bulletsOutOfView, Bullet:new(sceneGroup, "img/bullet.png", false, 4000 + math.random(10,440), 4000+ math.random(50,350)))
	end
	self.bulletsInView = Queue.new()
	self.health = 1
	self.maxHealth = 1
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF EVERY INIT FILE
	self.type = "Hater"
	self.sprite.objRef = self
	self.time = 0
	self.weapon = nil
   self.isFrozen = false
   self.freezeTimer = 0
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

function Hater:test()
	print('I am a hater')
end

function Hater:fire()
	if self.alive == true then
		local newBullet = Queue.removeBack(self.bulletsOutOfView)
		newBullet:move(self.sprite.x, self.sprite.y + 30)
		newBullet:fire(0, 400)
		newBullet.alive = true
		Queue.insertFront(self.bulletsInView, newBullet)
	end
end

function Hater:cull(event)

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
   
   local length = self.bulletsInView.size
	--[[for i = self.bulletsInView.first, self.bulletsInView.last, 1 do 					
		if self.bulletsInView[i].sprite.y >= 800  or self.bulletsInView[i].sprite.y <=  -50 or self.bulletsInView[i].sprite.x >= 500 or self.bulletsInView[i].sprite.x <= -50 or self.bulletsInView[i].alive == false
			then
				--Location 5000, 5000 is the registration spawn point of all bulletsOutOfView
				local bullet = Queue.remove(self.bulletsInView, i) --Need to program this
				bullet.sprite.x = 5000
				bullet.sprite.y = 5000
				bullet.alive = false
				Queue.insertFront(self.bulletsOutOfView, bullet)
			end	

	end]]--
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
	self.bulletsInView = newInViewQueue
	
	
	if self.alive == true then  
					
		if (self.sprite.y >=  850 and self.alive ) 
			then
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
		self.health = self.health - 1
		--sound:load(self.soundPath)
		--haterDeathSFX:play()
		--this is the check to say you are dead; place the sound here to make it work
		--later when weapons do different damage, you can make a check for a hit or a death
		--for now, only a death sound will be played.
	end
   
	if self.alive and collide.type == "player" then
		self.health = self.health - 1
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

