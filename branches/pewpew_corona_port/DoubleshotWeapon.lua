require("SingleshotWeapon")
Doubleshot = Singleshot:subclass("Doubleshot")

local BULLET_SEPERATION_DIST = 7

function Doubleshot:init (sceneGroup, rateOfFire, bulletVelocity, bulletSeperationDistance)
   self.super:init(sceneGroup, rateOfFire, bulletVelocity)
   
   if bulletSeperationDistance ~= nil then
	 self.bulletSeperationDistance = bulletSeperationDistance
   else
	 self.bulletSeperationDistance = BULLET_SEPERATION_DIST
   end
   --self.soundPath = 'doubleShot.ogg'
   --doubleShotSFX = MOAIUntzSound.new()
   --doubleShotSFX:load('doubleShot.ogg')
   self.energyCost = 10
end



function Doubleshot:fire (player)
	if self:canFire() then
		local ammo = self:getNextShot()
		local ammo2 = self:getNextShot()
		if ammo and ammo2 then
			ammo.sprite.y = self.owner.sprite.y + self.muzzleLocation.y
			ammo.sprite.x = self.owner.sprite.x + self.muzzleLocation.x + self.bulletSeperationDistance
			
			ammo2.sprite.y = self.owner.sprite.y + self.muzzleLocation.y
			ammo2.sprite.x = self.owner.sprite.x + self.muzzleLocation.x - self.bulletSeperationDistane
			ammo:fire(0, self.bulletVelocity)
			ammo2:fire(0, self.bulletVelocity)
			
			--powah stuff
			--player.powah = player.powah - self.energyCost
			
			--SFX stuff
			--doubleShotSFX:play()
		end
	end
	
	self.super.super:fire()
end