require "com.game.enemies.Hater"

--[[
	Moves down to half screen and then remains at that position until destroyed.
]]--

Hater_MidScreen = Hater:subclass("Hater_MidScreen")

--switched = false

function Hater_MidScreen:init(sceneGroup, player)
	self.super:init(sceneGroup, "com/resources/art/sprites/enemy_05.png", 0, 0, 0, 50, 50,
	{"com/resources/art/sprites/enemy_05_piece_01.png", 
	"com/resources/art/sprites/enemy_05_piece_02.png", 
	"com/resources/art/sprites/enemy_05_piece_03.png", 
	"com/resources/art/sprites/enemy_05_piece_04.png", 
	"com/resources/art/sprites/enemy_05_piece_05.png"}, player)
	--Copy Paste these fields if you plan on using them in the collision function
	
	
	self.health = 5
	self.maxHealth = 5
	self.midReached = false
	
	--timer related fields
	self.direction = 0
	self.waitTimer = 0
	self.ready = false
	
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF THE FILE.
	self.sprite.objRef = self 
end

function Hater_MidScreen:initMuzzleLocations()
	self.muzzleLocations = {{x = 0, y = 100}}
end

function Hater_MidScreen:move(x, y)
	--self:move(math.sin(self.time*4*math.pi/400)*2,3)
	--print("LOLOLOLOL")
	self.sprite.x = self.sprite.x + x
	self.sprite.y = self.sprite.y + y
	
end

function Hater_MidScreen:update(player)
	self.super:update()
	if self.alive == true then
		self:fire()						
	end
   if (self.isFrozen) then
      return
   end
   
   --check timer and increase until ready
   if self.midReached == true and self.waitTimer <= 100 then
		self.waitTimer = self.waitTimer + 1
	elseif self.waitTimer > 100 then
		self.ready = true
	end
	
	--check if the sprite has reached the mid-point of the screen
	if  self.sprite.y > 350 and self.midReached == false then
		self.midReached = true
		self:switch()
		return
	elseif self.midReached == false then
		self:move(0,3)
	elseif self.midReached == true and self.ready == true then
		if self.direction == 1 then
			self:move(-2,0)
		elseif self.direction == 2 then
			self:move(2,0)
		end
	
	end
end

--determine a direction for the sprite to move
function Hater_MidScreen:switch()
	if self.sprite.x <= (display.contentWidth/2) then
		self.direction = 1
	else
		self.direction = 2
	end
end

--Used to return the file path of a hater
function Hater_MidScreen:__tostring()
	return 'com.game.enemies.Hater_MidScreen'
end

return Hater_MidScreen









