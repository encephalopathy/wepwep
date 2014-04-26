require "com.game.enemies.Hater"
--[[
	This enemy moves down the screen in a sine wave path. It moves off the screen once it reachs 
	the bottom.
]]--

Hater_SineWave = Hater:subclass("Hater_SineWave")

function Hater_SineWave:init(sceneGroup, player)
	self.super:init(sceneGroup, "com/resources/art/sprites/enemy_04.png", 0, 0, 0, 75, 75, 
	{"com/resources/art/sprites/enemy_04_piece_01.png",
	 "com/resources/art/sprites/enemy_04_piece_02.png",
	 "com/resources/art/sprites/enemy_04_piece_03.png",
	 "com/resources/art/sprites/enemy_04_piece_04.png",
	 "com/resources/art/sprites/enemy_04_piece_05.png"}, player)
	--Copy Paste these fields if you plan on using them in the collision function
	
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF THE FILE.
	self.sprite.objRef = self 
	self.health = 1
	self.maxHealth = 1
end

function Hater_SineWave:initMuzzleLocations()
	self.muzzleLocations = {{x = 0, y = 100}}
end

function Hater_SineWave:move(x, y)
	--[[
		I want this enemy to fly in one direction
		then about halfway down to switch 
		horizontal direction
		so like it goes from right to left or left to right
		This just starts them off in a single direction though
	]]--
	--self:move(math.sin(self.time*4*math.pi/400)*2,3)
	--print("LOLOLOLOL")
	if self.alive == true then
		self:fire()						
	end
	self.sprite.x = self.sprite.x + math.sin(self.time*4*math.pi/400)*2
	self.sprite.y = self.sprite.y + y
	
end

function Hater_SineWave:update()
	self.super:update()
   if (self.isFrozen) then
      return
   end
   if self.alive then
	self:move(0,3)
	if (step % 90 == 0 ) then
		self:fire()						
	end
   end
end

--Used to return the file path of a hater
function Hater_SineWave:__tostring()
	return 'com.game.enemies.Hater_SineWave'
end

return Hater_SineWave