require "com.game.weapons.Weapon"
require "com.game.weapons.primary.HomingBullet"

Homingshot = Weapon:subclass("Homingshot")

function Homingshot:init (sceneGroup, isPlayerOwned, rateOfFire, bulletSpeed, imgSrc, energyCost, bulletType, bulletWidth, bulletHeight, rotationSpeed, trackTime, soundHandle)
	if rateOfFire == nil then
	 rateOfFire = 25
	end
	
	if imgSrc == nil then
		imgSrc = "com/resources/art/sprites/bullet_04.png"
	end
	
	if energyCost == nil then
	  energyCost = 30
   end
	
	if bulletType == nil then
		bulletType = HomingBullet
	end

	if soundHandle == nil then
		--print("THE SOUNDFX IS NIL; USE THE DEFAULT!!")
		soundHandle = "Homingshot"
		--print("soundFX:"..soundFX)
	end
	
   self.super:init(sceneGroup, isPlayerOwned, imgSrc, rateOfFire, energyCost, bulletType, bulletWidth, bulletHeight, soundHandle)
   --self.soundPath = 'homingShot.ogg'
   --homingShotSFX = MOAIUntzSound.new()
   --homingShotSFX:load('homingShot.ogg')
   self.trackTime = trackTime
   self.bulletSpeed = bulletSpeed
end

function Homingshot:setTargets(targets)
	self.targets = targets
end

function Homingshot:fire()

   self.super:fire()
   
   if not self:willFire() then return false end
	local bullet = self:getNextShot()
		if bullet then
			local rotationAngle = math.rad(self.owner.sprite.rotation)
			self:calibrateMuzzleFlare(self.muzzleLocation.x, self.muzzleLocation.y, self.owner, bullet, rotationAngle)
			bullet.hasTarget = false
			bullet.target = nil
			bullet.targets = self.targets
			bullet.sprite.rotation = self.owner.sprite.rotation
			bullet:fire(math.abs(self.bulletSpeed))
			
			if self.isPlayerOwned == true then
				--print("PLAYER OWNED. FIRE SOUNDS")
				self:playFiringSound() --call to play sound for weapons
			end
			
		end
   
   return true

end

return Homingshot
