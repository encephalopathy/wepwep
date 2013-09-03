require "com.game.weapons.Weapon"
require "com.game.weapons.primary.HomingBullet"

HomingShot = Weapon:subclass("HomingShot")

function HomingShot:init (sceneGroup, isPlayerOwned, rateOfFire, bulletSpeed, imgSrc, bulletType, bulletWidth, bulletHeight, rotationSpeed, trackTime, soundFX)
	--[[
	if soundFX == nil then --if no pre-defined sound, set as the default
		print("THE SOUNDFX IS NIL; USE THE DEFAULT!!")
		soundFX = "com/resources/music/soundfx/homingShot.ogg"
		print("soundFX:"..soundFX)
   end
	]]
	if bulletType == nil then
		bulletType = HomingBullet
	end
	
	if imgSrc == nil then
		imgSrc = "com/resources/art/sprites/bullet_04.png"
	end
	
   self.super:init(sceneGroup, isPlayerOwned, imgSrc, 25, bulletType, bulletWidth, bulletHeight, soundFX)
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
			
			--self:playFiringSound(self.soundFX)
		end
   
   --end

end

return HomingShot
