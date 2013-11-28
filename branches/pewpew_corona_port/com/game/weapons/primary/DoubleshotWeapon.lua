require "com.game.weapons.primary.SingleshotWeapon"
Doubleshot = Singleshot:subclass("Doubleshot")

local BULLET_SEPERATION_DIST = 7

function Doubleshot:init (sceneGroup, isPlayerOwned, rateOfFire, bulletSpeed, imgSrc, energyCost, bulletType, bulletWidth, bulletHeight, bulletSeperationDistance,soundHandle)
   
   if energyCost == nil then
	  energyCost = 10
   end
   
   if soundHandle == nil then --if no pre-defined sound, set as the default
		--print("THE SOUNDFX IS NIL; USE THE DEFAULT!!")
		soundHandle = "Doubleshot"
		--print("soundFX:"..soundFX)
   end
   
   self.super:init(sceneGroup, isPlayerOwned, rateOfFire, bulletSpeed, imgSrc, energyCost, bulletType, bulletWidth, bulletHeight,soundHandle)
   
   if bulletSeperationDistance ~= nil then
	 self.bulletSeperationDistance = bulletSeperationDistance
   else
	 self.bulletSeperationDistance = BULLET_SEPERATION_DIST
   end

end



function Doubleshot:fire(player)

	self.super.super:fire()
	if not self:canFire() then return end
	local bullet = self:getNextShot()
	local bullet2 = self:getNextShot()

	if bullet and bullet2 then
		local rotationAngle = math.rad(self.owner.sprite.rotation)
			
		self:calibrateMuzzleFlare(self.muzzleLocation.x + self.bulletSeperationDistance, self.muzzleLocation.y, self.owner, bullet, rotationAngle)
		self:calibrateMuzzleFlare(self.muzzleLocation.x - self.bulletSeperationDistance, self.muzzleLocation.y, self.owner, bullet2, rotationAngle)
			
		local bulletVelocity = self:calculateBulletVelocity(bullet, self.owner)
			
		bullet:fire(bulletVelocity.x, bulletVelocity.y)
		bullet2:fire(bulletVelocity.x, bulletVelocity.y)
		
		if self.isPlayerOwned == true then
			--print("PLAYER OWNED. FIRE SOUNDS")
			self:playFiringSound() --call to play sound for weapons
		end
			
		return bullet, bullet2
	end
	
	
end

return Doubleshot