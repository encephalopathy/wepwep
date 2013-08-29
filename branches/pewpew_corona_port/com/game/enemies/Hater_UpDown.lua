require "com.game.enemies.Hater"

--[[
	Moves down to the bottom of the screen and then moves back up to the top.
]]--

Hater_UpDown = Hater:subclass("Hater_UpDown")

switched = false

function Hater_UpDown:init(sceneGroup)
	self.super:init(sceneGroup, "sprites/enemy_06.png", 0, 0, 0, 100, 100, 
	{"com/resources/art/sprites/enemy_06_piece_01.png", 
	"com/resources/art/sprites/enemy_06_piece_02.png", 
	"com/resources/art/sprites/enemy_06_piece_03.png", 
	"com/resources/art/sprites/enemy_06_piece_04.png", 
	"com/resources/art/sprites/enemy_06_piece_05.png"})
	--Copy Paste these fields if you plan on using them in the collision function
	
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF THE FILE.
	self.sprite.objRef = self 
	self.health = 10
	self.maxHealth = 10
	self.movedown = true
end

function Hater_UpDown:initMuzzleLocations()
	self.muzzleLocations = {{x = 0, y = 100}}
end

function Hater_UpDown:move(x, y)
	--[[
		I want this enemy to fly in one direction
		then about halfway down to switch 
		horizontal direction
		so like it goes from right to left or left to right
		This just starts them off in a single direction though
	]]--
	--self:move(math.sin(self.time*4*math.pi/400)*2,3)
	--print("LOLOLOLOL")
	self.sprite.x = self.sprite.x + x
	self.sprite.y = self.sprite.y + y
	
end

function Hater_UpDown:update(player)
	self.super:update()
   if (self.isFrozen) then
      return
   end
   if self.alive then
	if self.sprite.y > 300 then
		self.movedown = false
	end
	if self.sprite.y < 10 then
		self.movedown = true
	end
	if self.movedown then
		self:move(0,1)
	else
		self:move(0,-1)
	end
	if self.alive == true then
		self:fire()						
	end
   end
end

--Used to return the file path of a hater
function Hater_UpDown:__tostring()
	return 'com.game.enemies.Hater_UpDown'
end

return Hater_UpDown









