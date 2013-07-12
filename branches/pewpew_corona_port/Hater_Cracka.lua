require("Hater")

--[[
	This is a speific type of enemy, it moves at regular speed with a regular shot.
	It is intended to move in a curve from the top of the screen to one of the sides
	It always shoots directly at the player at a fixed interval.
]]--

Hater_Cracka = Hater:subclass("Hater_Cracka")

switched = false

function Hater_Cracka:init(sceneGroup, imgSrc, x, y, rotation, width, height, shipPieces)
	self.super:init(sceneGroup, imgSrc, x, y, rotation, width, height, 
	{"sprites/enemy_03_piece_01.png",
	 "sprites/enemy_03_piece_02.png",
	 "sprites/enemy_03_piece_03.png",
	 "sprites/enemy_03_piece_04.png",
	 "sprites/enemy_03_piece_05.png"
	 }
	)
	--Copy Paste these fields if you plan on using them in the collision function
	
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF THE FILE.
	self.sprite.objRef = self 
	self.health = 1
	self.maxHealth = 1
end

function Hater_Cracka:move(x, y)
	--[[
		I want this enemy to fly in one direction
		then about halfway down to switch 
		horizontal direction
		so like it goes from right to left or left to right
		This just starts them off in a single direction though
	]]--
	--self:move(math.sin(self.time*4*math.pi/400)*2,3)
	--print("LOLOLOLOL")
	if (step % 90 == 0 and self.alive == true) then
			self:fire()						
	end
	self.sprite.x = self.sprite.x + math.sin(self.time*4*math.pi/400)*2
	self.sprite.y = self.sprite.y + y
	
end

function Hater_Cracka:update()
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

