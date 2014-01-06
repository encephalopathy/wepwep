require "com.game.enemies.Hater"

--[[
	Moves down to half screen and then remains at that position until destroyed.
]]--

Hater_MidScreen = Hater:subclass("Hater_MidScreen")

switched = false

function Hater_MidScreen:init(sceneGroup)
	self.super:init(sceneGroup, "com/resources/art/sprites/enemy_05.png", 0, 0, 0, 50, 50,
	{"com/resources/art/sprites/enemy_05_piece_01.png", 
	"com/resources/art/sprites/enemy_05_piece_02.png", 
	"com/resources/art/sprites/enemy_05_piece_03.png", 
	"com/resources/art/sprites/enemy_05_piece_04.png", 
	"com/resources/art/sprites/enemy_05_piece_05.png"})
	--Copy Paste these fields if you plan on using them in the collision function
	
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF THE FILE.
	self.sprite.objRef = self 
	self.health = 5
	self.maxHealth = 5
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
	if  self.sprite.y > 350 then
		return
	else
		self:move(0,3)
	end
end

--Used to return the file path of a hater
function Hater_MidScreen:__tostring()
	return 'com.game.enemies.Hater_MidScreen'
end

return Hater_MidScreen









