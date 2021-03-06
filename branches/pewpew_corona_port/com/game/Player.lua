require "com.Ride"

--TO DO: PLAYER_MAXHEALTH, PLAYER_MAXPOWAH, etc. will later be dependent on what ship and what passives
PLAYER_MAXHEALTH = 100

PLAYER_MAXPOWAH = 100
PLAYER_POWAH_REGENERATION_RATE = 1

--For testing
--require("SingleshotWeapon")

require "com.game.weapons.primary.DoubleshotWeapon"
require "com.game.weapons.primary.SpreadshotWeapon"
require "com.game.weapons.primary.HomingShotWeapon"
require "com.game.weapons.secondary.GrenadeLauncher"
require "com.game.weapons.primary.SineWaveWeapon"
require "com.game.weapons.secondary.StandardMissile"
require "com.game.weapons.primary.BackshotWeapon"
require "com.game.weapons.primary.CircleshotWeapon"
require "com.game.weapons.primary.SpiralStraightshotWeapon"
require "com.game.weapons.primary.SpiralCurveshotWeapon"
require "com.game.weapons.primary.RandomshotWeapon"
require "com.managers.AIDirector"
require "com.game.passives.Passive"
require "com.game.passives.Player.ExtraStartingHealth"
require "com.game.passives.Player.HealthRegen"
require "com.game.collectibles.Collectible"
require "com.game.passives.Player.GunpodCollection"
require "com.game.passives.Player.GunpodSingle"
require "com.game.passives.Player.NRGRegen"
require "com.game.passives.Player.HealthUponScrapPickUp"
require "com.game.passives.Player.PassiveShield"
require "com.game.passives.Player.ShieldCollection"
require "com.game.weapons.secondary.ActivatableShield"

--[[
	CLASS NAME: Player
	
	DESCRIPTION: The only ship that the user controls throughout the whole game.
	
	FUNCTIONS:
	@init: initializes all values within Player's super class.  Also, moves
	@move: moves the player to the location x and y in the world
	@onHit: Collision Event Handler function that is evoked when the player has collided with
	another object.
]]--

Player = Ride:subclass("Player")


--[[
	FUNCTION NAME: init

	DESCRIPTION: Initializes the player's parent classes and resets the player collision event handler
	function to only collide with Haters or other bullets.
	
	FUNCTIONS:
	@init: Constructor for the Player class.  Does the same thing as its parent class.
	@move: Moves the player to the location specified by its parameters: x and y
	@onHit: Collision Event Handler function gets envoked when a collision has occured.
	The player will lose 1 health if hit by an enemy or by a bullet.
	@THE REST... inherit doc.
	
	RETURN: VOID
]]--

--player values set in game.lua
function Player:init(sceneGroup, imgSrc, x, y, aabStartX, aabStartY, boundingScaleX, boundingScaleY, rotation, width, height)
	assert(width ~= nil)
	assert(height ~= nil)
	
	local half_W = width * boundingScaleX
	local half_H = height * boundingScaleY
	
	local boundingBoxVerticies = {-half_W + aabStartX, -half_H + aabStartY, half_W + aabStartX, -half_H + aabStartY,
	 half_W + aabStartX, half_H + aabStartY, -half_W + aabStartX, half_H + aabStartY}
	
	self.super:init(sceneGroup, imgSrc, x, y, rotation, width, height, 
	{"com/resources/art/sprites/player_piece_01.png", 
	"com/resources/art/sprites/player_piece_02.png", 
	"com/resources/art/sprites/player_piece_03.png", 
	"com/resources/art/sprites/player_piece_04.png",
	"com/resources/art/sprites/player_piece_05.png"},
	{ categoryBits = 1, maskBits = 26}, boundingBoxVerticies) 

	
	self.maxhealth = PLAYER_MAXHEALTH
	self.health = PLAYER_MAXHEALTH
	
	self.powah = PLAYER_MAXPOWAH
	
	self.isFiring = true
	self.swapColor = false
	
	self.secondaryWeapons = {}
	
	Runtime:addEventListener("touch", self.touch)
	Runtime:addEventListener("fireSecondary", self)
	self.x0 = 0
	self.y0 = 0
    self.prevX = 0
    self.prevY = 0
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF THE INIT FUNCTION
	
	self.hasFired = false
	
	--self:equipDebug(sceneGroup)
	Player.player = self
	self:setPlayerType()
	--Player.MAX_MOVEMENT_X = self.width / 2
	--Player.MAX_MOVEMENT_Y = self.height / 2
end


function Player:setPlayerType()
	self.type = "player"
	self.sprite.objRef = self
end


local function clampPlayerMovement(currentSpeed)
	local MAX_SPEED = 30
	if currentSpeed > MAX_SPEED then 
		return MAX_SPEED
	elseif currentSpeed < - MAX_SPEED then
		return -MAX_SPEED
	else
		return currentSpeed
	end
end


function Player:equipDebug(sceneGroup) 
	--sceneGroup, playerOwned, rateOfFire, bulletSpeed
	self.weapon = Singleshot:new(sceneGroup, true, 25, 200)
	--self.weapon = Randomshot:new(sceneGroup, true, 25, 200)
	self.weapon.targets = AIDirector.haterList
	self.weapon:setMuzzleLocation({ x = 0, y = -100 })
	self.weapon.owner = self
	self.defensePassives[1] = PassiveShieldCollection:new("com/resources/art/sprites/bullet_03.png", PassiveShield)
	self.defensePassives[1]:setOwner(self, sceneGroup)
	--[[self.defensePassives[1] = ExtraStartingHealth:new()
	self.defensePassives[1]:setOwner(self)
	self.defensePassives[2] = HealthRegen:new()
	self.defensePassives[2]:setOwner(self)
	self.defensePassives[2] = HealthUponScrapPickUp:new()
	self.defensePassives[2]:setOwner(self)
	self.defensePassives[3] = GunpodCollection:new(GunpodSingle, "com/resources/art/sprites/rocket_01.png", 80, 0, Singleshot, true, 1, 200)
	self.defensePassives[3]:setOwner(self, sceneGroup)
	self.defensePassives[4] = NRGRegen:new()
	self.defensePassives[4]:setOwner(self)]]--
end

--[[
	FUNCTION NAME: move
	
	DESCRIPTION: moves the player to the specified x and y location in the world if the player
	is alive.
	
	PARAMETERS:
		@x: x location of where the player is going to move to.
		@y: y location of where the player is going to move to.
]]--
function Player.touch(event, player)
	local player = 	Player.static.player
	local playerSprite = player.sprite
	local phase = event.phase
	
	if phase == "began" then
		--player.isFiring = true
		elseif phase == "moved" then
			player.x0 = event.x - player.prevX
			player.y0 = event.y - player.prevY
			player.x0 = clampPlayerMovement(player.x0)
			player.y0 = clampPlayerMovement(player.y0)

			if (player.sprite.x + player.x0 < display.contentWidth-30
				and player.sprite.x + player.x0 > 30 ) then
				player.sprite.x = player.sprite.x + player.x0
			end
			if(player.sprite.y + player.y0 < display.contentHeight-30 
				and player.sprite.y + player.y0 > 30 )then
				player.sprite.y = player.sprite.y + player.y0
			end
		elseif phase == "ended" or phase == "cancelled" then
			--player.isFiring = false
		end
	player.prevX = event.x
	player.prevY = event.y
	--print('Player pos: ( ' .. playerSprite.x .. ', ' .. playerSprite.y .. ' )') 
end


function Player:regeneratePowah()
	if not self.isFiring and self.powah < PLAYER_MAXPOWAH then
		self.powah = self.powah + PLAYER_POWAH_REGENERATION_RATE
		if self.powah > PLAYER_MAXPOWAH then
			self.powah = 100
		end
	end
end


function Player:cullBulletsOffScreen()
	if self.weapon ~= nil then
		self.weapon:checkBullets()
	 end
	 --self.equippedSecondaryGameWeapon:checkBombs()
end


function Player:enterFrame(event)
	--self:fire()
end


function Player:fire()
	if self.alive ~= false then
	--print("Player Powah is: "..self.powah)
		if (self.powah - self.weapon.energyCost) >= 0 then
			self.hasFired = self.weapon:fire()
			if self.hasFired then
				self.weapon:adjustPowah(self)
			end
		else
			self.hasFired = false
		end
	end
end


function Player:fireSecondaryWeapon()
	if self.alive ~= false then
		--self.secondaryWeapon:fire()
	end
end

function Player:switchMode()
	if self.isFiring == false then
		self.isFiring = true
	else
		self.isFiring = false
		self.hasFired = false
	end
end

--[[
	FUNCTION NAME: onHit
	
	DESCRIPTION: Collision event handler function occurs when the player has collided
	with a Hater or a bullet.  The player loses health or powah based on what type of
	bullet or Hater has collided with the enemy.
	
	PARAMETERS:
		@fix1: The player's fixture
		@fix2: The fixture that the player has collided with.
		@arbiter: Holds data of where and the direction the collision has occurred.
	RETURN: VOID

]]--

function Player:__tostring()
	return "Player"
end

function Player:updatePassives()
	for passiveName, passive in pairs(self.defensePassives) do
		self.defensePassives[passiveName]:update()
	end
	--print("player's health is currently", self.health)
end

function Player:fireSecondary(event)
	local secondaryItem = self.secondaryWeapons[event.item]
	print('Using secondaryWeapon in Player:fireSecondary: ' .. tostring(secondaryItem))
	if Weapon:made(secondaryItem) then
		secondaryItem:fire()
		return
	end
	
	secondaryItem = self.defensePassives[event.item]
	if Passive:made(secondaryItem) then
		secondaryItem:activate()
		return
	else
		print('INVALID SECONDARY FIRING')
	end
end


--function Player:onHit(you, collitor)
function Player:onHit(phase, collide)
   if phase == "ended"  then
		--print('Colliding with player: ' .. tostring(collide))
		if self.alive == true then
			if not collide.isPlayerBullet and not Collectible:made(collide)  then
				self.health = self.health - 1
				--print("Player health:", self.health)
				if not self.swapColor then
					self.sprite:setFillColor(1,0.5,1)
					self.swapColor = true
				end
				
				Runtime:dispatchEvent({name = "playSound", soundHandle = 'Player_onHit'})
				if self.health <= 0 and not debugFlag then
					--sound:load(self.soundPathDeath) 
					--got the deadness
					--playerDeathSFX:play()
					self:die()
				end
			elseif not collide.isPlayerBullet and Collectible:made(collide) then
				for passiveName, passive in pairs(self.defensePassives) do
					if self.defensePassives[passiveName].pickupIncreaseAmount ~= nil then
						self.defensePassives[passiveName]:increaseHealth()
					end
				end
			end
		end
	end
end

