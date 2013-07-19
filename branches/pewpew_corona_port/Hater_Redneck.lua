require("Hater")

--[[
	This is a speific type of enemy, it moves at regular speed with a regular shot.
	It is intended to move in a curve from the top of the screen to one of the sides
	It always shoots directly at the player at a fixed interval.
]]--

Hater_Redneck = Hater:subclass("Hater_Redneck")

switched = false

function Hater_Redneck:init(sceneGroup, imgSrc, x, y, rotation, width, height, shipPieces)
	self.super:init(sceneGroup, imgSrc, x, y, rotation, width, height)
	--Copy Paste these fields if you plan on using them in the collision function
	
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF THE FILE.
	self.sprite.objRef = self 
	self.moveLeft = false
	self.moveRight = true
	self.health = 1
	self.maxHealth = 1
end

function Hater_Redneck:equipRig(sceneGroup)
	self:equip(self.primaryWeapons, Singleshot, sceneGroup, 15, {0, 30})
end

function Hater_Redneck:move(x, y)
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

function Hater_Redneck:update()
	self.super:update()
	if self.sprite.x > 400 then 
		self.moveRight = false
		self.moveLeft = true
	end
	
	if self.sprite.x < 40 then 
		self.moveRight = true
		self.moveLeft = false
	end
	
   if (self.isFrozen) then
      return
   end
	if self.sprite.y < 250 then
		self:move(0,3)
	elseif self.moveRight then
		self:move(5,0)
	elseif self.moveLeft then
		self:move(-5,0)
	else 
		self:move(2,0)
	end
	
	if self.alive == true then
		self:fire()						
	end
	
end










