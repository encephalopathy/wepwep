require "com.game.weapons.Weapon"
require "com.game.weapons.Bullet"
Backshot = Weapon:subclass("Backshot")

function Backshot:init (sceneGroup, isPlayerOwned, rateOfFire, bulletSpeed, imgSrc, energyCost, bulletType, bulletWidth, bulletHeight, soundHandle, numberOfShots, firingAngle)

	if rateOfFire ~= nil then
		self.rateOfFire = rateOfFire
	else
		self.rateOfFire = 35
	end
	
	if imgSrc == nil then
		imgSrc = "com/resources/art/sprites/bullet_06.png"
	end

	if energyCost == nil then
	  energyCost = 15
    end
	
	if soundHandle == nil then
		--print("THE SOUNDFX IS NIL; USE THE DEFAULT!!")
		soundHandle = "Backshot"
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
	   	self.numberOfShots = 7--NUM_SHOTS
   	end
   
   	if firingAngle ~= nil then
      	self.firingAngle = firingAngle
   	else
      	self.firingAngle = 45--FIRING_ANGLE
   	end

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
	if not self:willFire() then return false end
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
         	local bulletVelocity = self:calculateBulletVelocity(bullet, rotationAngle, self.bulletSpeed)

			if not self.isPlayerOwned then
		   		bullet.sprite.rotation = bullet.sprite.rotation + 180
		   		bulletVelocity.x = bulletVelocity.x * -1
	   	   	end

		   	bullet:fire(bulletVelocity.x, bulletVelocity.y)
		end 
		
		for i = 0, (numberOfBackwardShots - 1), 1 do
		   	local bullet = backwardShots[i]
		   	if (bullet == nil) then
	         	break
		   	end
		  
		   	local rotationAngle = math.rad(backwardStartAngle + (-i * backwardAngleStep) + 180)
		   	self:calibrateMuzzleFlare(self.muzzleLocation.x, self.muzzleLocation.y, self.owner, bullet, rotationAngle)
		   	local bulletVelocity = self:calculateBulletVelocity(bullet, rotationAngle, self.bulletSpeed)

			if not self.isPlayerOwned then
		   		bullet.sprite.rotation = bullet.sprite.rotation + 180
		   		bulletVelocity.x = bulletVelocity.x * -1
	   	   	end

		   	bullet:fire(bulletVelocity.x, bulletVelocity.y)
		   
		end
		
		if self.isPlayerOwned == true and Player:made(self.owner) then
			--print("PLAYER OWNED. FIRE SOUNDS")
			self:playFiringSound() --call to play sound for weapons
		end

		return true
		
end 

return Backshot