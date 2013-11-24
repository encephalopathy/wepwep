require "com.game.weapons.Weapon"
require "com.game.weapons.Bullet"
Backshot = Weapon:subclass("Backshot")

function Backshot:init (sceneGroup, isPlayerOwned, rateOfFire, bulletSpeed, imgSrc, bulletType, bulletWidth, bulletHeight, soundHandle, numberOfShots, firingAngle)

	if rateOfFire ~= nil then
		self.rateOfFire = rateOfFire
	else
		self.rateOfFire = 35
	end
	
	if imgSrc ~= nil then
		self.imgSrc = imgSrc
	else
		self.imgSrc = "com/resources/art/sprites/bullet_06.png"
	end

	if soundHandle == nil then
		--print("THE SOUNDFX IS NIL; USE THE DEFAULT!!")
		soundHandle = "Backshot"
		--print("soundFX:"..soundFX)
   end
	
   self.super:init(sceneGroup, isPlayerOwned, imgSrc, rateOfFire, bulletType ,bulletWidth, bulletHeight, soundHandle)
   if bulletSpeed ~= nil then
	   self.bulletSpeed = bulletSpeed
   else
	   self.bulletSpeed = -200
   end
   
   if numberOfShots ~= nil then
	   self.numberOfShots = numberOfShots
   else
	   self.numberOfShots = 7--NUM_SHOTS
   end
   
   if firingAngle ~= nil then
      self.firingAngle = firingAngle
   else
      self.firingAngle = 45--FIRING_ANGLE
   end
   
   self.energyCost = 20
   
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

--[[+
	FUNCTION NAME: calculateBulletVelocity
	
	DESCRIPTION: Determines the velocity of the bullet based on the bullet speed and muzzle location 
				 relative to the ship's origin.
	PARAMETERS:
		@bullet: The bullet to fire.
	@RETURN: A Lua table that has the fields "x", the bullet's velocity in the x direction, 
			 and "y" the bullet's velocity in the y direction.
]]--
function Backshot:calculateBulletVelocity(bullet)
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

function Backshot:fire (player)
   self.super:fire()
   local numberOfForwardShots = math.floor(self.numberOfShots*2/3)
   local numberOfBackwardShots = math.ceil(self.numberOfShots/3)
   local forwardFiringAngle = math.floor(self.firingAngle*2/3)
   local backwardFiringAngle = math.ceil(self.firingAngle/3)
   local forwardAngleStep
   local backwardAngleStep
   local forwardStartAngle
   local backwardStartAngle
	if not self:canFire() then return end
	   if (numberOfForwardShots == 1) then
	      forwardAngleStep = 0
	   else
	      forwardAngleStep = forwardFiringAngle / (numberOfForwardShots - 1)
	   end
	   if (numberOfBackwardShots == 1) then
	      backwardAngleStep = 0
	   else
	      backwardAngleStep = backwardFiringAngle / (numberOfBackwardShots - 1)
	   end
	   forwardStartAngle = (forwardFiringAngle/2 + self.owner.sprite.rotation)
	   backwardStartAngle = (backwardFiringAngle/2 + self.owner.sprite.rotation)

      local forwardShots = {}
      local backwardShots = {}
	   if self.owner then
		   for i = 0, (numberOfForwardShots - 1), 1 do
			   forwardShots[i] = self:getNextShot()
		   end
		   for i = 0, (numberOfBackwardShots - 1), 1 do
		      backwardShots[i] = self:getNextShot()
		   end
	   end
      
	   for i = 0, (numberOfForwardShots - 1), 1 do
		   local bullet = forwardShots[i]
		   if (bullet == nil) then
			   break
		   end
		 
         local rotationAngle = math.rad(forwardStartAngle + (-i * forwardAngleStep))
		   self:calibrateMuzzleFlare(self.muzzleLocation.x, self.muzzleLocation.y, self.owner, bullet, rotationAngle)
         local bulletVelocity = self:calculateBulletVelocity(bullet, self.owner)
		   bullet:fire(bulletVelocity.x, bulletVelocity.y)
		end 
		
		for i = 0, (numberOfBackwardShots - 1), 1 do
		   local bullet = backwardShots[i]
		   if (bullet == nil) then
	         break
		   end
		  
		   local rotationAngle = math.rad(backwardStartAngle + (-i * backwardAngleStep) + 180)
		   self:calibrateMuzzleFlare(self.muzzleLocation.x, self.muzzleLocation.y, self.owner, bullet, rotationAngle)
		   local bulletVelocity = self:calculateBulletVelocity(bullet, self.owner)
		   bullet:fire(bulletVelocity.x, bulletVelocity.y)
		   
		end
		
		 if self.isPlayerOwned == true then
			--print("PLAYER OWNED. FIRE SOUNDS")
			self:playFiringSound() --call to play sound for weapons
		end

end 

return Backshot