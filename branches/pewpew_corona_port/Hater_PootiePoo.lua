require("Hater")
--[[
	This is a speific type of enemy, it moves at regular speed with a regular shot.
	It is intended to move in a curve from the top of the screen to one of the sides
	It always shoots directly at the player at a fixed interval.
]]--

Hater_PootiePoo = Hater:subclass("Hater_PootiePoo")

function Hater_PootiePoo:init(sceneGroup, imgSrc, x, y, rotation, width, height, shipPieces)
	self.super:init(sceneGroup, imgSrc, x, y, rotation, width, height, 
	{"sprites/enemy_06_piece_01.png",
	 "sprites/enemy_06_piece_02.png",
	 "sprites/enemy_06_piece_03.png",
	 "sprites/enemy_06_piece_04.png",
	 "sprites/enemy_06_piece_05.png"
	 }
	)
	--Copy Paste these fields if you plan on using them in the collision function
	self.directionx = math.random(-2,2)
	self.directiony = math.random(1,4)
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF THE FILE.
	self.sprite.objRef = self 
	self.health = 1
	self.maxHealth = 1
	self.step = 0
end

function Hater_PootiePoo:equipRig(sceneGroup)
	self:equip(self.primaryWeapons, Singleshot, sceneGroup, 15, {0, 30})
end

function Hater_PootiePoo:move(x, y)
	--[[
		I want this enemy to fly in one direction
		then about halfway down to switch 
		horizontal direction
		so like it goes from right to left or left to right
		This just starts them off in a single direction though
	]]--
	--self:move(math.sin(self.time*4*math.pi/400)*2,3)
	--print("LOLOLOLOL")
	--if self.alive == true then
		--self:fire()						
	--end
	self.sprite.x = self.sprite.x + x
	self.sprite.y = self.sprite.y + y
	
end

function Hater_PootiePoo:update()
	self.super:update()
   if (self.isFrozen) then
      return
   end
   if self.alive then
	self:move(self.directionx,self.directiony)
	self.step = self.step + 1
	if (self.step % 90 == 30 ) then
		self:fire()						
	end
   end
end

