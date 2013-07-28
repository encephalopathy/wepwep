require("Weapon")
require("Bullet")
Singleshot = Weapon:subclass("Singleshot")

local BULLET_VELOCITY = 200

function Singleshot:init (sceneGroup, isPlayerOwned, rateOfFire, bulletSpeed, bulletWidth, bulletHeight)
   if rateOfFire == nil then
     rateOfFire = 50
   end
   
   self.super:init(sceneGroup, isPlayerOwned, "sprites/bullet_02.png", rateOfFire, bulletWidth, bulletHeight)
   
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



function Singleshot:calculateBulletVelocity(bullet)
	local firingMagnitude = distance(self.owner.sprite.x, self.owner.sprite.y, bullet.sprite.x, bullet.sprite.y)
	local firingDirectionX = (bullet.sprite.x - self.owner.sprite.x) / firingMagnitude
	local firingDirectionY = (bullet.sprite.y - self.owner.sprite.y) / firingMagnitude
	return { x = firingDirectionX * self.bulletSpeed, y = firingDirectionY * self.bulletSpeed }
end

function Singleshot:fire()
	self.super:fire()
	--self.super:fire()
	
	--if self:canFire() then
	
	local bullet = self:getNextShot()
	if bullet then  --you are allowed to shoot
		
		local rotationAngle = math.rad(self.owner.sprite.rotation)
			
		self:calibrateMuzzleFlare(self.muzzleLocation.x, self.muzzleLocation.y, self.owner, bullet, rotationAngle)
		local bulletVelocity = self:calculateBulletVelocity(bullet)
		bullet:fire(bulletVelocity.x, bulletVelocity.y)
			--powah stuff
			--player.powah = player.powah - self.energyCost
			
			--SFX stuff
			
		playSoundFX("sounds/soundfx/laser.ogg")
			--singleShotSFX:play()
		--return bullet
	end
	--return nil
	--end
	
end