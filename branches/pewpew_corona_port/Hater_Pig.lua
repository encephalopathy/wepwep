require("Hater")

--[[
	This is a speific type of enemy, it moves at regular speed with a regular shot.
	It is intended to move in a curve from the top of the screen to one of the sides
	It always shoots directly at the player at a fixed interval.
]]--

Hater_Pig = Hater:subclass("Hater_Pig")

switched = false

function Hater_Pig:init(x, y, scaleX, scaleY, imgSrc, sceneGroup)
	self.super:init(x, y, scaleX, scaleY, imgSrc, sceneGroup, 
	{"sprites/enemy_04_piece_01.png", "sprites/enemy_04_piece_02.png", "sprites/enemy_04_piece_03.png", 
	"sprites/enemy_04_piece_04.png", "sprites/enemy_04_piece_05"})
	--Copy Paste these fields if you plan on using them in the collision function
	
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF THE FILE.
	self.sprite.objRef = self 
	self.health = 10
	self.maxHealth = 10
	self.movedown = true
end

function Hater_Pig:move(x, y)
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

function Hater_Pig:update(player)
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
	if (step % 90 == 0 ) then
		self:fire()						
	end
   end
end











