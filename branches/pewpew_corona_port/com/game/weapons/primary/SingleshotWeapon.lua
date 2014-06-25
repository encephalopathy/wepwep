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
local DEFUALT_BULLET_VELOCITY = 1000
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

function Singleshot:init (sceneGroup, isPlayerOwned, rateOfFire, bulletSpeed, numberOfWaves, delayBetweenWaves, imgSrc, energyCost, bulletType, bulletWidth, bulletHeight, soundHandle)
   if rateOfFire == nil then
     rateOfFire = DEFAULT_RATE_OF_FIRE
   end
   
   if imgSrc == nil then
     imgSrc = "com/resources/art/sprites/bullet_06.png"
   end
   
   if energyCost == nil then
	  energyCost = 1
   end
   
   if soundHandle == nil then
		--print("THE SOUNDFX IS NIL; USE THE DEFAULT!!")
		soundHandle = "Singleshot"
		--print("soundFX:"..soundFX)
   end
   
   self.super:init(sceneGroup, isPlayerOwned, imgSrc, rateOfFire, energyCost, bulletType, bulletWidth, bulletHeight, soundHandle)
   
   if bulletSpeed == nil then
		self.bulletSpeed = DEFUALT_BULLET_VELOCITY 
   else
		self.bulletSpeed = bulletSpeed
   end
  
   --these values are for haters to give them delay
   if numberOfWaves == nil then
      self.numberOfWaves = 0
   else
      self.numberOfWaves = numberOfWaves
   end
   
   if delayBetweenWaves == nil then
      self.delayBetweenWaves = 0
   else
      self.delayBetweenWaves = delayBetweenWaves
   end
   
	self.waveCounter = 0
	self.delayCounter = 0
   
   --load it here with a string to sound file
end

--[[
	FUNCTION NAME: fire
	
	DESCRIPTION: Fires the bullet at the speed specified when the weapon was created, in the same direction the
				 owner of the weapon is pointing at.
	@RETURN: VOID
]]--
function Singleshot:fire()
	self.super:fire()
	if not self:willFire() then return false end
	local bullet = self:getNextShot()
	if bullet then  --you are allowed to shoot

		--if self.isPlayerOwned == true then
			--print("PLAYER OWNED. FIRE SOUNDS")
			--self:playFiringSound(self.soundFX) --call to play sound for weapons
			if self.waveCounter <= self.numberOfWaves and self.delayCounter == 0 then
				local rotationAngle = math.rad(self.owner.sprite.rotation)
				self:calibrateMuzzleFlare(self.muzzleLocation.x, self.muzzleLocation.y, self.owner, bullet, rotationAngle)
				local bulletVelocity = self:calculateBulletVelocity(bullet, rotationAngle, self.bulletSpeed)
				--print(bullet.isPlayerBullet)
				if not self.isPlayerOwned then
		   			bullet.sprite.rotation = bullet.sprite.rotation + 180
		   			bulletVelocity.x = bulletVelocity.x * -1
	   	   		end
				bullet:fire(bulletVelocity.x, bulletVelocity.y)
				if self.isPlayerOwned == true and Player:made(self.owner) then
					self:playFiringSound()
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
		--end
	end	
	
	return true
end

return Singleshot
