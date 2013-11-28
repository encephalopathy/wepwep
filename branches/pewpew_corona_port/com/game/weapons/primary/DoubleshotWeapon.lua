require "com.game.weapons.primary.SingleshotWeapon"
Doubleshot = Singleshot:subclass("Doubleshot")

local BULLET_SEPERATION_DIST = 7


function Doubleshot:init (sceneGroup, isPlayerOwned, rateOfFire, bulletSpeed, imgSrc, energyCost, bulletType, bulletWidth, bulletHeight, bulletSeperationDistance, soundHandle, numberOfWaves, delayBetweenWaves)
   
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

   if numberOfWaves == nil then
      self.numberOfWaves = 3
   else
      self.numberOfWaves = numberOfWaves
   end
   
   if delayBetweenWaves == nil then
      self.delayBetweenWaves = 5
   else
      self.delayBetweenWaves = delayBetweenWaves
   end
   
	self.waveCounter = 0
	self.delayCounter = 0

end



function Doubleshot:fire(player)

	self.super.super:fire()
	if not self:willFire() then return false end
	local bullet = self:getNextShot()
	local bullet2 = self:getNextShot()

	if bullet and bullet2 then
	
		if self.waveCounter <= self.numberOfWaves and self.delayCounter == 0 then
	
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
			
			if self.numberOfWaves > 0 then
					self.waveCounter = self.waveCounter + 1
			end
			
		elseif self.waveCounter > self.numberOfWaves and self.delayCounter <= self.delayBetweenWaves then
			self.delayCounter = self.delayCounter + 1
		elseif self.waveCounter > self.numberOfWaves and self.delayCounter > self.delayBetweenWaves then
			self.waveCounter = 0
			self.delayCounter = 0
		end			
			
		return bullet, bullet2
	end
	
	return true
	
end

return Doubleshot