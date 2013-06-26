require("Ride")

--For testing
--require("SingleshotWeapon")
require("DoubleshotWeapon")
--require("ParticleEmitter")
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
thisplayer = nil

function Player:init(sceneGroup, imgSrc, x, y, rotation, width, height)
	self.super:init(sceneGroup, imgSrc, x, y, rotation, width, height) 
	self.health = 10
	self.powah = 100
	self.sprite.weapon = Singleshot:new(sceneGroup)
	self.sprite.weapon:load(100, sceneGroup)
	self.bombs = {}
	self.heaters = {}
	self.isFiring = false
	self.sprite.type = "player"
	self.sprite.weapon.owner = self.sprite
	self.sprite:addEventListener("touch", self)
    Runtime:addEventListener("touch", screenTouched)
	--self.sprite:addEventListener("enterFrame", self.enterFrame)
	--playerHitSFX = MOAIUntzSound.new()
	--playerHitSFX:load('playerHit.ogg')
	
	--playerDeathSFX = MOAIUntzSound.new()
	--playerDeathSFX:load('playerDeath.ogg')
	self.x0 = 0
	self.y0 = 0
    self.prevX = 0
    self.prevY = 0
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF THE INIT FUNCTION
	self.sprite.objRef = self
	thisplayer = self
end

function screenTouched(event, player)
		print("omg you touch player")
	--local touchTarget = event.target
	local phase = event.phase
    if(thisplayer.isFiring) then thisplayer:fire() end
	
	if phase == "began" then
		thisplayer.isFiring = true
		--local parent = touchTarget.parent
		--parent:insert(touchTarget)
		--display.getCurrentStage():setFocus(touchTarget)
		
		--touchTarget.isFocus = true

	--elseif touchTarget.isFocus then
		elseif phase == "moved" then
			
			thisplayer.x0 = event.x - thisplayer.prevX
			thisplayer.y0 = event.y - thisplayer.prevY
			if(thisplayer.x0 > 30) then thisplayer.x0 = 30 end
			if(thisplayer.x0 < -30) then thisplayer.x0 = -30 end		
			if(thisplayer.y0 > 30) then thisplayer.y0 = 30 end
			if(thisplayer.y0 < -30) then thisplayer.y0 = -30 end

			if (thisplayer.sprite.x + thisplayer.x0 < display.contentWidth-30 
				and thisplayer.sprite.x + thisplayer.x0 > 20 ) then
				thisplayer.sprite.x = thisplayer.sprite.x + thisplayer.x0
			end
			if(thisplayer.sprite.y + thisplayer.y0 < display.contentHeight-30 
				and thisplayer.sprite.y + thisplayer.y0 > 20 )then
				thisplayer.sprite.y = thisplayer.sprite.y + thisplayer.y0
			end
		elseif phase == "ended" or phase == "cancelled" then
			thisplayer.isFiring = false
			--display.getCurrentStage():setFocus(nil)
			--touchTarget.isFocus = false
		end
	--end
	thisplayer.prevX = event.x
	thisplayer.prevY = event.y
end


--[[
	FUNCTION NAME: move
	
	DESCRIPTION: moves the player to the specified x and y location in the world if the player
	is alive.
	
	PARAMETERS:
		@x: x location of where the player is going to move to.
		@y: y location of where the player is going to move to.
]]--
function Player:touch(event)
	print("omg you touch player")
	local touchTarget = event.target
	local phase = event.phase

	
	if phase == "began" then
		local parent = touchTarget.parent
		parent:insert(touchTarget)
		display.getCurrentStage():setFocus(touchTarget)
		
		touchTarget.isFocus = true
		touchTarget.x0 = event.x - touchTarget.x
		touchTarget.y0 = event.y - touchTarget.y
	elseif touchTarget.isFocus then
		if phase == "moved" then
			touchTarget.x = event.x - touchTarget.x0
			touchTarget.y = event.y - touchTarget.y0
		elseif phase == "ended" or phase == "cancelled" then
			display.getCurrentStage():setFocus(nil)
			touchTarget.isFocus = false
		end
	end
	
	return true
end

function Player:enterFrame(event)
	--self:fire()
end


function Player:fire()
	if self.alive ~= false then
		self.sprite.weapon:fire(self)
	end
end

function Player:fireSecondaryWeapon()
	if self.alive ~= false then
		--self.secondaryWeapon:fire()
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

function Player:__toString()
	return "Player"
end


function Player:onHit(you, collitor)
	if you.alive == true then
		print('I am in this function')
		if not collitor.isPlayerBullet  then
			you.health = you.health - 1
			--sound:load(self.soundPathHit) --got hit by a dude
			--[[if (you.health <= 0) then
				--sound:load(self.soundPathDeath) 
				--got the deadness
				playerDeathSFX:play()
				you.alive = false
				you:explode()
			else
				playerHitSFX:play()
			end]]--
		end
	end
	
end