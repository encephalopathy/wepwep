require("Weapon")
require("HomingBullet")

HomingShot = Weapon:subclass("HomingShot")

function HomingShot:init (sceneGroup, isPlayerOwned, rateOfFire, bulletSpeed, bulletWidth, bulletHeight, rotationSpeed, trackTime)

   self.super:init(sceneGroup, isPlayerOwned, "sprites/bullet_04.png", 25, HomingBullet, bulletWidth, bulletHeight)
   --self.soundPath = 'homingShot.ogg'
   --homingShotSFX = MOAIUntzSound.new()
   --homingShotSFX:load('homingShot.ogg')
   self.energyCost = 30
   self.trackTime = trackTime
   self.bulletSpeed = bulletSpeed
end

function HomingShot:setTargets(targets)
	self.targets = targets
end

function HomingShot:fire()

   self.super:fire()
   
   if not self:canFire() then return end
	local bullet = self:getNextShot()
		if bullet then
			local rotationAngle = math.rad(self.owner.sprite.rotation)
			self:calibrateMuzzleFlare(self.muzzleLocation.x, self.muzzleLocation.y, self.owner, bullet, rotationAngle)
			bullet.hasTarget = false
			bullet.target = nil
			bullet.targets = self.targets
			bullet.sprite.rotation = self.owner.sprite.rotation
			bullet:fire(math.abs(self.bulletSpeed))
		end
   
   --end

end

return HomingShot
