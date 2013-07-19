require("Weapon")
require("Bullet")
Singleshot = Weapon:subclass("Singleshot")

local BULLET_VELOCITY = 200

function Singleshot:init (sceneGroup, rateOfFire, bulletVelocity)
   if rateOfFire == nil then
     rateOfFire = 25
   end
   
   self.super:init(sceneGroup, "sprites/bullet_02.png", rateOfFire)
   
   if bulletVelocity == nil then
		self.originalBulletVelocity = BULLET_VELOCITY 
   else
		self.bulletVelocity = bulletVelocity
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

function Singleshot:calibrateMuzzleFlare(ammo, rotationAngle)
	local muzzleLocX = self.muzzleLocation.x
	local muzzleLocY = self.muzzleLocation.y
	if rotationAngle ~= 0 then	
		muzzleLocX = muzzleLocX * math.cos(math.rad(rotationAngle)) - muzzleLocX * math.sin(math.rad(rotationAngle))
		muzzleLocY = muzzleLocY * math.sin(math.rad(rotationAngle)) + muzzleLocY * math.cos(math.rad(rotationAngle))
	end
	
	ammo.sprite.x = self.owner.sprite.x + muzzleLocX
	ammo.sprite.y = self.owner.sprite.y + muzzleLocY
	return ammo
end

function Singleshot:fire(player)
	self.super:fire()
	
	if self:canFire() then
		
		local ammo = self:getNextShot()
		if ammo then  --you are allowed to shoot
			
			--ammo.sprite.x = self.owner.sprite.x + self.muzzleLocation.x
			--ammo.sprite.y = self.owner.sprite.y + self.muzzleLocation.y
			local rotationAngle = self.owner.sprite.rotation
			
			ammo.sprite.x = self.owner.sprite.x + self.muzzleLocation.x
			ammo.sprite.y = self.owner.sprite.y + self.muzzleLocation.y
			
			--print(self.owner.sprite.rotation)
			--local unitHeight = (height/math.sqrt(width*width+height*height))
			--ammo.sprite.rotation = (180/math.pi) * math.acos(unitHeight)
			local xVelocity = self.bulletVelocity * math.sin(math.rad(rotationAngle))
			local yVelocity = self.bulletVelocity * math.cos(math.rad(rotationAngle))
			
			--print('xVelocity ' .. xVelocity)
			--print('yVelocity ' .. yVelocity)
			--local test = math.sqrt(xVelocity*xVelocity + yVelocity*yVelocity)
			ammo:fire(xVelocity, yVelocity)
			--powah stuff
			--player.powah = player.powah - self.energyCost
			
			--SFX stuff
			
			playSoundFX("sounds/soundfx/laser.ogg")
			--singleShotSFX:play()
		end
	end
	
end