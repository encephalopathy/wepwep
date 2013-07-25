require("Weapon")
require("HomingBullet")

HomingShot = Weapon:subclass("HomingShot")

function HomingShot:init (sceneGroup, rateOfFire, bulletSpeed, rotationSpeed, trackTime)

   self.super:init(sceneGroup, "sprites/bullet_04.png", 25, HomingBullet)
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
   
   --if self:canFire() then
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

   --bullet.sprite.x = self.owner.x + self.muzzleLocation.x
   --bullet.sprite.y = self.owner.y + self.muzzleLocation.y

   --bullet.isHoming = true

   --bullet.hater = nil
   
   --bullet.hasTarget = false

   --powah stuff
   --player.powah = player.powah - self.energyCost
   
   --SFX stuff
   --homingShotSFX:play()

end


