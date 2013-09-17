require "com.game.weapons.Weapon"
require "com.game.weapons.Bullet"
SpiralStraightshot = Weapon:subclass("SpiralStraightshot")

--NUM_SHOTS = 5
--FIRING_ANGLE = 60 -- total spread so the bullets will range from 0 degrees to 60 degrees
--BETWEEN = 3 -- space between bullets

function SpiralStraightshot:init (sceneGroup, isPlayerOwned, rateofFire, bulletSpeed, imgSrc, bulletType, bulletWidth, bulletHeight, numberOfShots, soundFX)

	if rateOfFire == nil then
		rateOfFire = 15
	end
	
	if imgSrc == nil then
		imgSrc = "com/resources/art/sprites/bullet_06.png"
	end

	if soundFX == nil then
		--print("THE SOUNDFX IS NIL; USE THE DEFAULT!!")
		soundFX = "com/resources/music/soundfx/shotgun.ogg"
		--print("soundFX:"..soundFX)
   end
	
   self.super:init(sceneGroup, isPlayerOwned, imgSrc, rateOfFire, bulletType ,bulletWidth, bulletHeight, soundFX)
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

--[[+
	FUNCTION NAME: calculateBulletVelocity
	
	DESCRIPTION: Determines the velocity of the bullet based on the bullet speed and muzzle location 
				 relative to the ship's origin.
	PARAMETERS:
		@bullet: The bullet to fire.
	@RETURN: A Lua table that has the fields "x", the bullet's velocity in the x direction, 
			 and "y" the bullet's velocity in the y direction.
]]--
function SpiralStraightshot:calculateBulletVelocity(bullet)
	--To calculate a bullet's velocity, we determine the distance first between the bullet and the ship.
	local firingMagnitude = distance(self.owner.sprite.x, self.owner.sprite.y, bullet.sprite.x, bullet.sprite.y)
	--We normalize the vector that points from the ship to the bullet.  This will give us the firing direction of bullet.
	--NOTE: We assume that the bullet has already undergone rotation.
	local firingDirectionX = (bullet.sprite.x - self.owner.sprite.x) / firingMagnitude
	local firingDirectionY = (bullet.sprite.y - self.owner.sprite.y) / firingMagnitude
	
	--We then fire the bullet in that direction previously computed by multiplying by bullet speed.
	--This will move the bullet at speed bulletSpeed, in the direction firingDirection.
	return { x = firingDirectionX * self.bulletSpeed, y = firingDirectionY * self.bulletSpeed }
end

function SpiralStraightshot:fire (player)
    self.super:fire()
	if not self:canFire() then return end
	   angleStep = 360 / (self.numberOfShots)
       
	   if (self.shotIterator > self.numberOfShots - 1) then 
	      self.shotIterator = 0
	   end
	   
	   local bullet = self:getNextShot()
	   if (bullet == nil) then
	      return
	   end
		 
       local rotationAngle = math.rad((-self.shotIterator * angleStep))
	   self:calibrateMuzzleFlare(self.muzzleLocation.x, self.muzzleLocation.y, self.owner, bullet, rotationAngle)
          
       local bulletVelocity = self:calculateBulletVelocity(bullet, self.owner)
	   bullet:fire(bulletVelocity.x, bulletVelocity.y)
	   self:playFiringSound(self.soundFX)
       self.shotIterator = self.shotIterator + 1
end 

return SpiralStraightshot