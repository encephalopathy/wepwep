require("SingleshotWeapon")
Doubleshot = Singleshot:subclass("Doubleshot")

BULLET_VELOCITY = 200

BULLET_SEPERATION_DIST = 7

function Doubleshot:init (sceneGroup)
   self.super:init(sceneGroup)
   --self.soundPath = 'doubleShot.ogg'
   --doubleShotSFX = MOAIUntzSound.new()
   --doubleShotSFX:load('doubleShot.ogg')
   self.energyCost = 10
end



function Doubleshot:fire (player)
	if self:canFire() then
		local ammo = self:getNextShot()
		local ammo2 = self:getNextShot()
		if ammo and ammo2 then
			ammo.sprite.y = self.owner.y - 100
			ammo.sprite.x = self.owner.x + BULLET_SEPERATION_DIST
			
			ammo2.sprite.y = self.owner.y - 100
			ammo2.sprite.x = self.owner.x - BULLET_SEPERATION_DIST
			ammo:fire(0, -BULLET_VELOCITY)
			ammo2:fire(0, -BULLET_VELOCITY)
			
			--powah stuff
			--player.powah = player.powah - self.energyCost
			
			--SFX stuff
			--doubleShotSFX:play()
		end
	end
	
	self.super.super:fire()
end