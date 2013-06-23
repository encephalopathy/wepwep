require("SingleshotWeapon")
Doubleshot = Singleshot:subclass("Doubleshot")

BULLET_VELOCITY = 200

BULLET_SEPERATION_DIST = 7

function Doubleshot:init (fireCount, sceneGroup)
   self.super:init(fireCount, sceneGroup)
   --self.soundPath = 'doubleShot.ogg'
   doubleShotSFX = MOAIUntzSound.new()
   doubleShotSFX:load('doubleShot.ogg')
   self.energyCost = 10
end



function Doubleshot:fire (player)
	if self.owner then
		local ammo = self.super.super:fire()
		local ammo2 = self.super.super:fire()
		if ammo and ammo2 then
			ammo.sprite.y = self.owner.sprite.y - 100
			ammo.sprite.x = self.owner.sprite.x	+ BULLET_SEPERATION_DIST
			
			ammo2.sprite.y = self.owner.sprite.y - 100
			ammo2.sprite.x = self.owner.sprite.x - BULLET_SEPERATION_DIST
			ammo:fire(0, -BULLET_VELOCITY)
			ammo2:fire(0, -BULLET_VELOCITY)
			
			--powah stuff
			player.powah = player.powah - self.energyCost
			
			--SFX stuff
			doubleShotSFX:play()
		end
	end
end