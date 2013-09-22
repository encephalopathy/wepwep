require "com.game.weapons.Weapon"
require "com.game.weapons.Bullet"
Backshot = Weapon:subclass("Backshot")

function Backshot:init (sceneGroup, isPlayerOwned, rateOfFire, bulletSpeed, imgSrc, bulletType, bulletWidth, bulletHeight, numberOfShots, firingAngle, soundFX)

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

	if soundFX ~= nil then
		self.soundFX = soundFX
	else
		--print("THE SOUNDFX IS NIL; USE THE DEFAULT!!")
		self.soundFX = "com/resources/music/soundfx/shotgun.ogg"
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
	  self.numberOfShots = 7--NUM_SHOTS
   end
   
   self.numberOfForwardShots = math.floor(self.numberOfShots*2/3)
   --print("number of forward shots is", self.numberOfForwardShots)
   self.numberOfBackwardShots = math.ceil(self.numberOfShots/3)
   --print("number of backward shots is", self.numberOfBackwardShots)
   
   if firingAngle ~= nil then
     self.firingAngle = firingAngle
   else
     self.firingAngle = 45--FIRING_ANGLE
   end
   
   self.forwardFiringAngle = math.floor(self.firingAngle*2/3)
   self.backwardFiringAngle = math.ceil(self.firingAngle/3)
   
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
	if not self:canFire() then return end
	   if (self.numberOfForwardShots == 1) then
	      forwardAngleStep = 0
	   else
	      forwardAngleStep = self.forwardFiringAngle / (self.numberOfForwardShots - 1)
	   end
	   --print("forward Angle step is", forwardAngleStep)
	   if (self.numberOfBackwardShots == 1) then
	      backwardAngleStep = 0
	   else
	      backwardAngleStep = self.backwardFiringAngle / (self.numberOfBackwardShots - 1)
	   end
	   --print("backward Angle step is", backwardAngleStep)
	   forwardStartAngle = (self.forwardFiringAngle/2 + self.owner.sprite.rotation)
	   --print("forward start angle is", forwardStartAngle)
	   backwardStartAngle = (self.backwardFiringAngle/2 + self.owner.sprite.rotation)
	   --print("backward start angle is", backwardStartAngle)

       local forwardShots = {}
       local backwardShots = {}
	   if self.owner then
		  for i = 0, (self.numberOfForwardShots - 1), 1 do
			 forwardShots[i] = self:getNextShot()
			 --print("forwardShots[",i,"] = ", forwardShots[i])
		  end
		  for i = 0, (self.numberOfBackwardShots - 1), 1 do
		     backwardShots[i] = self:getNextShot()
		     --print("backwardShots[",i,"] = ", backwardShots[i])
		  end
	   end
       
	   for i = 0, (self.numberOfForwardShots - 1), 1 do
		  local bullet = forwardShots[i]
		  
		  if (bullet == nil) then
			 break
		  end
		 
          local rotationAngle = math.rad(forwardStartAngle + (-i * forwardAngleStep))
          --print("rotation angle is ", rotationAngle)
		  self:calibrateMuzzleFlare(self.muzzleLocation.x, self.muzzleLocation.y, self.owner, bullet, rotationAngle)
          local bulletVelocity = self:calculateBulletVelocity(bullet, self.owner)
		  bullet:fire(bulletVelocity.x, bulletVelocity.y)
		  self:playFiringSound(self.soundFX)
		end 
		
		for i = 0, (self.numberOfBackwardShots - 1), 1 do
		  local bullet = backwardShots[i]
		  
		  if (bullet == nil) then
		     break
		  end
		  
		  local rotationAngle = math.rad(backwardStartAngle + (-i * backwardAngleStep) + 180)
		  --print("rotation angle is ", rotationAngle)
		  self:calibrateMuzzleFlare(self.muzzleLocation.x, self.muzzleLocation.y, self.owner, bullet, rotationAngle)
		  local bulletVelocity = self:calculateBulletVelocity(bullet, self.owner)
		  bullet:fire(bulletVelocity.x, bulletVelocity.y)
		  self:playFiringSound(self.soundFX)
		end

end 

return Backshot