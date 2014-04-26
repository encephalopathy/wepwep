require "com.game.enemies.Hater"

--[[
	This is a speific type of enemy, it moves at regular speed with a regular shot.
	It is intended to move in a curve from the top of the screen to one of the sides
	It always shoots directly at the player at a fixed interval.
]]--

Hater_SpeedUp = Hater:subclass("Hater_SpeedUp")

switched = false

function Hater_SpeedUp:init(sceneGroup, player)
	self.super:init(sceneGroup, "com/resources/art/sprites/enemy_07.png", 0, 0, 0, 75, 75, 
	{"com/resources/art/sprites/enemy_07_piece_01.png", 
	"com/resources/art/sprites/enemy_07_piece_02.png", 
	"com/resources/art/sprites/enemy_07_piece_03.png", 
	"com/resources/art/sprites/enemy_07_piece_04.png", 
	"com/resources/art/sprites/enemy_07_piece_05.png"}, player)
	--Copy Paste these fields if you plan on using them in the collision function
	
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF THE FILE.
	self.sprite.objRef = self 
	self.health = 2
	self.maxHealth = 2
end

function Hater_SpeedUp:initMuzzleLocations()
	self.muzzleLocations = {{x = 0, y = 100}}
end

function Hater_SpeedUp:move(x, y)
	--[[
		I want this enemy to fly in one direction
		then about halfway down to switch 
		horizontal direction
		so like it goes from right to left or left to right
		This just starts them off in a single direction though
	]]--
	--self:move(math.sin(self.time*4*math.pi/400)*2,3)
	--print("LOLOLOLOL")
	self.sprite.y = self.sprite.y + y
	
end

function Hater_SpeedUp:update()
	self.super:update()
   if (self.isFrozen) then
      return
   end
   if self.alive == true then
	
		if self.sprite.y < 200 then
			self:move(0,2)
		else
			self:move(0,4)
		end
		if self.alive == true then
			self:fire()						
		end					
	end
end

--Used to return the file path of a hater
function Hater_SpeedUp:__tostring()
	return 'com.game.enemies.Hater_SpeedUp'
end

return Hater_SpeedUp