require("Hater")
require("SingleshotWeapon")
--[[
	The basic of the basic. Enemy will move straight down on the screen and then move out of view
	Your everyday normal guy kind of enemy.
]]--

Hater_Normal = Hater:subclass("Hater_Normal")

switched = false

function Hater_Normal:init(sceneGroup)
	self.super:init(sceneGroup, "sprites/enemy_02.png", 0, 0, 0, 100, 100)
	--Copy Paste these fields if you plan on using them in the collision function
	
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF THE FILE.
	self.sprite.objRef = self 
	self.health = 1
	self.maxHealth = 1
end

function Hater_Normal:equipRig(sceneGroup)
	self:equip(self.primaryWeapons, Singleshot, sceneGroup, 15, {0, 30})
end

function Hater_Normal:move(x, y)

	self.sprite.y = self.sprite.y + y
	
end

function Hater_Normal:update()
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

return Hater_Normal