require "com.game.weapons.Weapon"
require "com.game.weapons.Bullet"
Spreadshot = Weapon:subclass("Spreadshot")

NUM_SHOTS = 5
FIRING_ANGLE = 60 -- total spread so the bullets will range from 0 degrees to 60 degrees
BETWEEN = 3 -- space between bullets

function Spreadshot:init (sceneGroup, isPlayerOwned, rateofFire, bulletSpeed, bulletType, bulletWidth, bulletHeight, numberOfShots, firingAngle)

	if rateOfFire == nil then
		rateOfFire = 35
	end
	
	if imgSrc == nil then
		imgSrc = "com/resources/art/sprites/bullet_06.png"
	end

   self.super:init(sceneGroup, isPlayerOwned, imgSrc, rateOfFire, bulletType, bulletWidth, bulletHeight)
   if bulletSpeed ~= nil then
	  self.bulletSpeed = bulletSpeed
   else
	  self.bulletSpeed = -200
   end
   
   if numberOfShots ~= nil then
	  self.numberOfShots = NUM_SHOTS
   else
	  self.numberOfShots = NUM_SHOTS
   end
   
   if firingAngle ~= nil then
     self.firingAngle = firingAngle
   else
     self.firingAngle = FIRING_ANGLE
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

function Spreadshot:fire (player)
    self.super:fire()
	if not self:canFire() then return end
    --local bullet = self:getNextShot()
	--if bullet then
	   angleStep = self.firingAngle / (self.numberOfShots - 1)
	   --speed = self.bulletSpeed
	   startAngle = (self.firingAngle/2 + self.owner.sprite.rotation)
       
       --print("number of shots is ", self.numberOfShots)

       local shots = {}
	   if self.owner then
		  for i = 0, (self.numberOfShots - 1), 1 do
			 shots[i] = self:getNextShot()
             --print("shots[",i,"] = ", shots[i])
		  end
	   end
       
	   for i = 0, (self.numberOfShots - 1), 1 do
		  local bullet = shots[i]
		  
		  --print("in loop, i = ", i)
		  
		  if (bullet == nil) then
			 --print("bullet == nil")
			 break
		  end
		 
          local rotationAngle = math.rad(startAngle + (-i * angleStep))
		  --xVelocity = speed * math.cos(math.rad(angle))
		  --yVelocity = math.abs(speed * math.sin(math.rad(angle)))
		  
		  --rotate = math.atan(xVelocity/yVelocity)
		  --bullet.sprite.rotation = (-math.deg(rotate)) 
          --local rotationAngle = math.rad(self.owner.sprite.rotation)
          --local rotationAngle = (math.rad(rotate))
		  --print("rotationAngle calculated")
		  self:calibrateMuzzleFlare(self.muzzleLocation.x, self.muzzleLocation.y, self.owner, bullet, rotationAngle)
          
		  --print("muzzle flare calibrated")
          local bulletVelocity = self:calculateBulletVelocity(bullet, self.owner)
		  --print("velocity calculated")
		  bullet:fire(bulletVelocity.x, bulletVelocity.y)
          --print("bullet fired")
		  
          --return bullet
          
		end 

   --end
   
   --return bullet
   --powah stuff
   --player.powah = player.powah - self.energyCost
   
   --SFX stuff
   --spreadShotSFX:play()

end 

return Spreadshot