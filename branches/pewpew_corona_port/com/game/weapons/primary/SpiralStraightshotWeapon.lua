require "com.game.weapons.Weapon"
require "com.game.weapons.Bullet"
SpiralStraightshot = Weapon:subclass("SpiralStraightshot")

function SpiralStraightshot:init (sceneGroup, isPlayerOwned, rateOfFire, bulletSpeed, imgSrc, energyCost, bulletType, bulletWidth, bulletHeight, soundHandle, numberOfShots)

	if rateOfFire ~= nil then
		self.rateOfFire = rateOfFire
	else
		self.rateOfFire = 15
	end
	
	if imgSrc ~= nil then
		self.imgSrc = imgSrc
	else
		self.imgSrc = "com/resources/art/sprites/bullet_06.png"
	end

	if soundHandle == nil then
		--print("THE SOUNDFX IS NIL; USE THE DEFAULT!!")
		soundHandle = "SpiralStraightshot"
		--print("soundFX:"..soundFX)
   end
	
   self.super:init(sceneGroup, isPlayerOwned, imgSrc, rateOfFire, energyCost, bulletType ,bulletWidth, bulletHeight, soundHandle)
   if bulletSpeed ~= nil then
	  self.bulletSpeed = bulletSpeed
   else
	  self.bulletSpeed = -200
   end
   
   if numberOfShots ~= nil then
	  self.numberOfShots = numberOfShots
   else
	  self.numberOfShots = 15--NUM_SHOTS
   end
   
   self.shotIterator = 0
   
   self.energyCost = 20
end

function SpiralStraightshot:fire (player)
   self.super:fire()
	if not self:willFire() then return false end
	   local angleStep = 360 / (self.numberOfShots)
       
	   if (self.shotIterator > self.numberOfShots - 1) then 
	      self.shotIterator = 0
	   end
	   
	   local bullet = self:getNextShot()
	   if (bullet == nil) then
	      return
	   end
		 
      local rotationAngle = math.rad(-self.shotIterator * angleStep)
	   self:calibrateMuzzleFlare(self.muzzleLocation.x, self.muzzleLocation.y, self.owner, bullet, rotationAngle)
          
      local bulletVelocity = self:calculateBulletVelocity(bullet, rotationAngle, self.bulletSpeed)
	   bullet:fire(bulletVelocity.x, bulletVelocity.y)
	   if self.isPlayerOwned == true then
			--print("PLAYER OWNED. FIRE SOUNDS")
			self:playFiringSound() --call to play sound for weapons
		end
      self.shotIterator = self.shotIterator + 1
	  
	  return true
	  
end 

return SpiralStraightshot