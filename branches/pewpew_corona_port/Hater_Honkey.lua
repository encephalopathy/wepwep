require("Hater")
require("SingleshotWeapon")
--[[
	This is a speific type of enemy, it moves at regular speed with a regular shot.
	It is intended to move in a curve from the top of the screen to one of the sides
	It always shoots directly at the player at a fixed interval.
]]--

Hater_Honkey = Hater:subclass("Hater_Honkey")

switched = false

function Hater_Honkey:init(sceneGroup, imgSrc, x, y, rotation, width, height)
	self.super:init(sceneGroup, imgSrc, x, y, rotation, width, height)
	--Copy Paste these fields if you plan on using them in the collision function
	
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF THE FILE.
	self.sprite.objRef = self 
	self.health = 1
	self.maxHealth = 1
end

function Hater_Honkey:equipRig(sceneGroup)
	self:equip(self.primaryWeapons, Singleshot, sceneGroup, 15, {0, 30})
end

function Hater_Honkey:move(x, y)
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

function Hater_Honkey:update()
	self.super:update()
	
	
   if (self.isFrozen) then
      return
   end
   if self.alive then
	self:move(0,3)
	--if (step % 90 == 0 and self.alive == true) then
	if self.alive == true then
		self:fire()						
	end					
	--end
   end
end