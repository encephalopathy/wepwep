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
		local bullet = self:getNextShot()
		local bullet2 = self:getNextShot()
		if bullet and bullet2 then
			 local rotationAngle = math.rad(self.owner.sprite.rotation)
			--bullet.sprite.x = self.owner.sprite.x + self.muzzleLocation.x + self.bulletSeperationDistance
			--bullet.sprite.y = self.owner.sprite.y + self.muzzleLocation.y
			
			self:calibrateMuzzleFlare(self.muzzleLocation.x + self.bulletSeperationDistance, self.muzzleLocation.y, self.owner, bullet, rotationAngle)
			self:calibrateMuzzleFlare(self.muzzleLocation.x - self.bulletSeperationDistance, self.muzzleLocation.y, self.owner, bullet2, rotationAngle)
			
			
			--bullet2.sprite.x = self.owner.sprite.x + self.muzzleLocation.x - self.bulletSeperationDistance
			--bullet2.sprite.y = self.owner.sprite.y + self.muzzleLocation.y
			
			local bulletVelocity = self:calculateBulletVelocity(rotationAngle)
			
			--bullet:fire(0, self.bulletVelocity)
			--bullet2:fire(0, self.bulletVelocity)
			bullet:fire(bulletVelocity.x, bulletVelocity.y)
			bullet2:fire(bulletVelocity.x, bulletVelocity.y)
			
			--powah stuff
			--player.powah = player.powah - self.energyCost
			
			--SFX stuff
			--doubleShotSFX:play()
		end
	end
	
	self.super.super:fire()
end