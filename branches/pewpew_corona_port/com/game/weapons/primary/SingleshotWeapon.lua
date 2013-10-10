require "com.game.weapons.Weapon"
require "com.game.weapons.Bullet"
Singleshot = Weapon:subclass("Singleshot")


--[[
--	CLASS NAME: Singleshot
--
--	DESCRIPTION:  Fires one bullet in a given direction, firing speed is based on its rate of fire.
--	
--	FUNCTIONS:
--	@init: Creates a weapon and sets the fields required to fire the right bullets.
--	@calculateBulletVelocity: calculates the velocity of the bullet given the bullet's speed when fired by this gun and direction.
--  @fire: Fires the bullet based on the rotational offset of the owner.
]]--

--Default values if no bullet velocity and/or bullet speed or not passed through via constructor.
local DEFUALT_BULLET_VELOCITY = 200
local DEFAULT_RATE_OF_FIRE = 25

--[[
	CONSTRUCTOR:
	@sceneGroup: See inherit doc.
	@isPlayerOwned: See inherit doc.
	@rateOfFire: See inherit doc.. 
	@bulletSpeed: The given speed of the bullet when fired by this gun.  This speed is currently constant.
	@bulletWidth: See inherit doc.
	@bulletHeight: See inherit doc.
]]--
function Singleshot:init (sceneGroup, isPlayerOwned, rateOfFire, bulletSpeed, imgSrc, bulletType, bulletWidth, bulletHeight, soundFX)
   if rateOfFire == nil then
     rateOfFire = DEFAULT_RATE_OF_FIRE
   end
   
   if imgSrc == nil then
     imgSrc = "com/resources/art/sprites/bullet_02.png"
   end
   
   if soundFX == nil then
		--print("THE SOUNDFX IS NIL; USE THE DEFAULT!!")
		soundFX = "com/resources/music/soundfx/laser.ogg"
		--print("soundFX:"..soundFX)
   end
   
   self.super:init(sceneGroup, isPlayerOwned, imgSrc, rateOfFire, bulletType, bulletWidth, bulletHeight, soundFX)
   
   if bulletSpeed == nil then
		self.bulletSpeed = DEFUALT_BULLET_VELOCITY 
   else
		self.bulletSpeed = bulletSpeed
   end
   self.energyCost = 5
   
   --load it here with a string to sound file
end


--[[
	FUNCTION NAME: calculateBulletVelocity
	
	DESCRIPTION: Determines the velocity of the bullet based on the bullet speed and muzzle location 
				 relative to the ship's origin.
	PARAMETERS:
		@bullet: The bullet to fire.
	@RETURN: A Lua table that has the fields "x", the bullet's velocity in the x direction, 
			 and "y" the bullet's velocity in the y direction.
]]--
function Singleshot:calculateBulletVelocity(bullet, owner)
	--To calculate a bullet's velocity, we determine the distance first between the bullet and the ship.
	local firingMagnitude = distance(owner.sprite.x, owner.sprite.y, bullet.sprite.x, bullet.sprite.y)
	--We normalize the vector that points from the ship to the bullet.  This will give us the firing direction of bullet.
	--NOTE: We assume that the bullet has already undergone rotation.
	local firingDirectionX = (bullet.sprite.x - owner.sprite.x) / firingMagnitude
	local firingDirectionY = (bullet.sprite.y - owner.sprite.y) / firingMagnitude
	
	--We then fire the bullet in that direction previously computed by multiplying by bullet speed.
	--This will move the bullet at speed bulletSpeed, in the direction firingDirection.
	return { x = firingDirectionX * self.bulletSpeed, y = firingDirectionY * self.bulletSpeed }
end

--[[
	FUNCTION NAME: fire
	
	DESCRIPTION: Fires the bullet at the speed specified when the weapon was created, in the same direction the
				 owner of the weapon is pointing at.
	@RETURN: VOID
]]--
function Singleshot:fire()
	self.super:fire()
	if not self:canFire() then return end
	local bullet = self:getNextShot()
	if bullet then  --you are allowed to shoot
		local rotationAngle = math.rad(self.owner.sprite.rotation)
			
		self:calibrateMuzzleFlare(self.muzzleLocation.x, self.muzzleLocation.y, self.owner, bullet, rotationAngle)
		local bulletVelocity = self:calculateBulletVelocity(bullet, self.owner)
		bullet:fire(bulletVelocity.x, bulletVelocity.y)


		self:playFiringSound(self.soundFX) --call to play sound for weapons
		--self:adjustPowah()
	end	
end

return Singleshot
