require "com.game.weapons.primary.SingleshotWeapon"
require "com.game.weapons.secondary.Bomb"

GrenadeLauncher = Singleshot:subclass("GrenadeLauncher")

local DEFAULT_DETONATION_TIME = 25
local DEFAULT_EXPLOSION_RADIUS = 448
local DEFAULT_RATE_OF_FIRE = 25

function GrenadeLauncher:init (sceneGroup, isPlayerOwned, rateOfFire, bulletSpeed, imgSrc, bulletType, targets, detonationTime, explosionRadius, soundFX)
   if rateOfFire == nil then
     rateOfFire = DEFAULT_RATE_OF_FIRE
   end
   
   if soundFX == nil then
		print("THE SOUNDFX IS NIL; USE THE DEFAULT!!")
		soundFX = "com/resources/music/soundfx/laser.ogg"
		print("soundFX:"..soundFX)
   end
   
   if bulletType == nil then
     bulletType = Bomb
   end
   
   if explosionRadius == nil then
      explosionRadius = DEFAULT_EXPLOSION_RADIUS
   end
   
   if imgSrc == nil then
	 imgSrc = "com/resources/art/sprites/bomb.png"
   end
   
   self.super:init(sceneGroup, isPlayerOwned, rateOfFire, bulletSpeed, 0, 0, imgSrc, 0, bulletType, 50, 50, soundFX)
   
   if bulletSpeed == nil then
		self.bulletSpeed = DEFUALT_BULLET_VELOCITY 
   else
		self.bulletSpeed = bulletSpeed
   end
   
   if detonationTime == nil then
		self.detonationTime = DEFAULT_DETONATION_TIME
	else
		self.detonationTime = detonationTime
	end
	
   self.explosionRadius = explosionRadius
   self.energyCost = 5
   self.targets = targets
end

function GrenadeLauncher:fire()
	self.super.super:fire()
	if not self:willFire() then return false end
	local bullet = self:getNextShot()
	if bullet then
		local rotationAngle = math.rad(self.owner.sprite.rotation)
			
		self:calibrateMuzzleFlare(self.muzzleLocation.x, self.muzzleLocation.y, self.owner, bullet, rotationAngle)
		local bulletVelocity = self:calculateBulletVelocity(bullet, rotationAngle, self.bulletSpeed)
		bullet:fire(bulletVelocity.x, bulletVelocity.y)
		bullet.detonationTime = self.detonationTime
		bullet.targets = self.targets
		bullet.explosionRadius = self.explosionRadius
		self:playFiringSound(self.soundFX) --call to play sound for weapons
	end
	
	return true
	
end

function GrenadeLauncher:recycle(bullet)
	if bullet == nil then
		self.super:recycle(self)
	else
		self.super:recycle(bullet)
	end
end

return GrenadeLauncher