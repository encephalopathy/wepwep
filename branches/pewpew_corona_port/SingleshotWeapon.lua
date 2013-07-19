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

--[[
	FUNCTION NAME: calibrateMuzzleFlare
	
	DESCRIPTION: Responsible for moving the object to the x and y location in the world
	
	PARAMETERS:
		@muzzleLocX: The location of the x coordinate of the muzzle of the gun.
		@muzzleLocY: The location of the y coordinate of the muzzle of the gun.
		@bullet: The bullet that is to be fired by the gun.
		@rotationAngle: An angle defined in radians that determines the rotation of the gun tip.
	@RETURN: bullet
]]--
function Singleshot:calibrateMuzzleFlare(muzzleLocX, muzzleLocY, bullet, rotationAngle)
	if rotationAngle ~= 0 then	
		--[[To rotate the vector locally, we multipy it by a rotation matrix around the origin(Top-left hand of the screen) then 
			translate the rotated vector back to the its local origin, the location where that particular vector was located at.
		]]--
		muzzleLocX = muzzleLocX + muzzleLocX * math.cos(rotationAngle) - muzzleLocY * math.sin(rotationAngle)
		muzzleLocY = muzzleLocY + muzzleLocY * math.cos(rotationAngle) + muzzleLocX * math.sin(rotationAngle)
	end
	bullet.sprite.rotation = math.deg(rotationAngle)
	bullet.sprite.x = self.owner.sprite.x + muzzleLocX
	bullet.sprite.y = self.owner.sprite.y + muzzleLocY
end

function Singleshot:calculateBulletVelocity(rotationAngle)
	return { x = self.bulletSpeed * -math.sin(rotationAngle), y = self.bulletSpeed * math.cos(rotationAngle) }
end

function Singleshot:fire(player)
	self.super:fire()
	
	if self:canFire() then
		
		local bullet = self:getNextShot()
		if bullet then  --you are allowed to shoot
			local rotationAngle = math.rad(self.owner.sprite.rotation)
			
			self:calibrateMuzzleFlare(self.muzzleLocation.x, self.muzzleLocation.y, bullet, rotationAngle)
			local bulletVelocity = self:calculateBulletVelocity(rotationAngle)
			bullet:fire(bulletVelocity.x, bulletVelocity.y)
			--powah stuff
			--player.powah = player.powah - self.energyCost
			
			--SFX stuff
			
			playSoundFX("sounds/soundfx/laser.ogg")
			--singleShotSFX:play()
		end
	end
	
end