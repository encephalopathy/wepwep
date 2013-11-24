require "com.game.weapons.Weapon"
require "com.game.weapons.Bullet"
SpiralCurveshot = Weapon:subclass("SpiralCurveshot")

function SpiralCurveshot:init (sceneGroup, isPlayerOwned, rateOfFire, bulletSpeed, imgSrc, bulletType, bulletWidth, bulletHeight, soundHandle, numberOfShots, startAngle, numberOfWaves, delayBetweenWaves)

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
		soundHandle = "SpiralCurveshot"
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
		self.numberOfShots = 15--NUM_SHOTS
   end
   
   if startAngle ~= nil then
      self.startAngle = startAngle
   else
      self.startAngle = 0
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
function SpiralCurveshot:calculateBulletVelocity(bullet)
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

function SpiralCurveshot:fire (player)
   self.super:fire()
	if not self:canFire() then return end
	local angleStep = 360 / (self.numberOfShots - 1)
	local rotationAngle

   --[[if self.startAngle == 360 then
      self.startAngle = 0
   end]]--
   
   local shots = {}
	if self.owner then
		for i = 0, (self.numberOfShots - 1), 1 do
		   shots[i] = self:getNextShot()
		end
	end

	if self.waveCounter <= self.numberOfWaves and self.delayCounter == 0 then
      for i = 0, (self.numberOfShots - 2), 1 do
			local bullet = shots[i]
			if (bullet == nil) then
				break
			end
		
         rotationAngle = math.rad((-i * angleStep) - self.startAngle)
			self:calibrateMuzzleFlare(self.muzzleLocation.x, self.muzzleLocation.y, self.owner, bullet, rotationAngle)
         local bulletVelocity = self:calculateBulletVelocity(bullet, self.owner)
			bullet:fire(bulletVelocity.x, bulletVelocity.y)
		
		end
		self.startAngle = self.startAngle + 7
	
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
end 

return SpiralCurveshot