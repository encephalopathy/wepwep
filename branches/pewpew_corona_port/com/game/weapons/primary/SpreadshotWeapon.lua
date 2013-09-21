require "com.game.weapons.Weapon"
require "com.game.weapons.Bullet"
Spreadshot = Weapon:subclass("Spreadshot")

function Spreadshot:init (sceneGroup, isPlayerOwned, rateOfFire, bulletSpeed, imgSrc, bulletType, bulletWidth, bulletHeight, numberOfShots, soundFX, firingAngle, numberOfArcs, angleBetweenArcs)

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
	  self.numberOfShots = 10--NUM_SHOTS
   end
   
   if firingAngle ~= nil then
     self.firingAngle = firingAngle
   else
     self.firingAngle = 90--FIRING_ANGLE
   end
   
   if numberOfArcs ~= nil then
     self.numberOfArcs = numberOfArcs
   else
     self.numberOfArcs = 2
   end
   
   if angleBetweenArcs ~= nil then
     self.angleBetweenArcs = angleBetweenArcs
   else
     self.angleBetweenArcs = 60
   end
   
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
function Spreadshot:calculateBulletVelocity(bullet)
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

--[[
	FUNCTION NAME: canFire
	
	DESCRIPTION: Determines if this weapon can fire or not based on how many fire attempts this weapon has performed
		         against its rate of fire.
	
	@RETURN: A boolean that determines if this gun can fire or not
]]--
--[[function Spreadshot:canFire()
	if self.rateOfFire - self.fireAttempts == 0 then
		self.fireAttempts = 0
		return true
	else
		return false
	end
end
]]--

function Spreadshot:fire (player)
   self.super:fire()
	if not self:canFire() then return end
	angleStep = self.firingAngle / ((self.numberOfShots - 1) / self.numberOfArcs)
	startAngle = (((self.firingAngle * self.numberOfArcs) + self.angleBetweenArcs) /2 + self.owner.sprite.rotation)

   local shots = {}
	if self.owner then
	   for i = 0, (self.numberOfShots - 1), 1 do
	      shots[i] = self:getNextShot()
		end
	end
       
	for i = 0, (self.numberOfShots - 1), 1 do
		local bullet = shots[i]
		  
		if (bullet == nil) then
			break
		end
		 
		local rotationAngle
		if (i < math.ceil((self.numberOfShots - 1) / self.numberOfArcs)) then
		   rotationAngle = math.rad(startAngle + (-i * angleStep))
      else
         rotationAngle = math.rad(startAngle + (-i * angleStep) - self.angleBetweenArcs)
      end
		self:calibrateMuzzleFlare(self.muzzleLocation.x, self.muzzleLocation.y, self.owner, bullet, rotationAngle)
         
      local bulletVelocity = self:calculateBulletVelocity(bullet, self.owner)
		bullet:fire(bulletVelocity.x, bulletVelocity.y)
		self:playFiringSound(self.soundFX)
   end 
end 

return Spreadshot