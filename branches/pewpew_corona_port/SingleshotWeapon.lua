require("Weapon")
require("Bullet")
Singleshot = Weapon:subclass("Singleshot")

NUM_SHOTS = 5
FIRING_ANGLE = 60
BULLET_VELOCITY = 200

function Singleshot:init (sceneGroup)
   self.super:init(sceneGroup, "sprites/bullet_02.png", 25)
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

function Singleshot:fire(player)
	self.super:fire()
	
	if self:canFire() then
		local ammo = self:getNextShot()
		
		if ammo then  --you are allowed to shoot
			ammo.sprite.y = self.owner.sprite.y - 100
			ammo.sprite.x = self.owner.sprite.x
			ammo:fire(0, -BULLET_VELOCITY)
			--powah stuff
			--player.powah = player.powah - self.energyCost
			
			--SFX stuff
			
			playSoundFX("sounds/soundfx/laser.ogg")
			--singleShotSFX:play()
		end
	end
	
end