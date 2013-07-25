require("Weapon")
require("Bullet")
Singleshot = Weapon:subclass("Singleshot")

local BULLET_VELOCITY = 200

function Singleshot:init (sceneGroup, rateOfFire, bulletSpeed)
   if rateOfFire == nil then
     rateOfFire = 25
   end
   
   self.super:init(sceneGroup, "sprites/bullet_02.png", rateOfFire)
   
   if bulletSpeed == nil then
		self.bulletSpeed = BULLET_VELOCITY 
   else
		self.bulletSpeed = bulletSpeed
   end
   --self.soundPath = 'laser.ogg'
   --singleShotSFX = MOAIUntzSound.new()
   --singleShotSFX:load('laser.ogg')
   self.energyCost = 5
end

--[[function Singleshot:showMuzzleFlare()
	 local muzzleFlare  = RNFactory.createAnim("img/exp2.png", 64, 64, self.owner.sprite.x, self.owner.sprite.y - 50, 1, 1)
		muzzleFlare.frame = 0
		muzzleFlare:newSequence("explode", {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16}, 24, 1, function()
			muzzleFlare.visible = false
			muzzleFlare:stop()
		end)
	muzzleFlare:play("explode")
end]]--



function Singleshot:calculateBulletVelocity(rotationAngle)
	return { x = self.bulletSpeed * -math.sin(rotationAngle), y = self.bulletSpeed * math.cos(rotationAngle) }
end

function Singleshot:fireAmmo()
	--self.super:fire()
	
	--if self:canFire() then
		
	local bullet = self:getNextShot()
	if bullet then  --you are allowed to shoot
		local rotationAngle = math.rad(self.owner.sprite.rotation)
			
		self:calibrateMuzzleFlare(self.muzzleLocation.x, self.muzzleLocation.y, self.owner, bullet, rotationAngle)
		local bulletVelocity = self:calculateBulletVelocity(rotationAngle)
		bullet:fire(bulletVelocity.x, bulletVelocity.y)
			--powah stuff
			--player.powah = player.powah - self.energyCost
			
			--SFX stuff
			
		playSoundFX("sounds/soundfx/laser.ogg")
			--singleShotSFX:play()
		return bullet
	end
	return nil
	--end
	
end

function Singleshot:fireAmmo()
	print(self.owner)
	self.super:fire()
end