require("Hater")

--[[
	This is a speific type of enemy, it moves at regular speed with a regular shot.
	It is intended to move in a curve from the top of the screen to one of the sides
	It always shoots directly at the player at a fixed interval.
]]--

Hater_FatBoy = Hater:subclass("Hater_FatBoy")

switched = false

function Hater_FatBoy:init(sceneGroup, imgSrc, x, y, rotation, width, height)
	self.super:init(sceneGroup, imgSrc, x, y, rotation, width, height,
	{"sprites/enemy_01_piece_01.png", "sprites/enemy_01_piece_02.png", "sprites/enemy_01_piece_03.png", 
	"sprites/enemy_01_piece_04.png", "sprites/enemy_01_piece_05.png"})
	--Copy Paste these fields if you plan on using them in the collision function
	
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF THE FILE.
	self.sprite.objRef = self 
	self.health = 5
	self.maxHealth = 5
end

function Hater_FatBoy:move(x, y)
	--self:move(math.sin(self.time*4*math.pi/400)*2,3)
	--print("LOLOLOLOL")
	self.sprite.x = self.sprite.x + x
	self.sprite.y = self.sprite.y + y
	
end

function Hater_FatBoy:update(player)
	self.super:update()
	if (step % 90 == 0 and self.alive == true) 
		then
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











