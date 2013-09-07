require "com.game.weapons.secondary.StandardMissile"

FreezeMissile = StandardMissile:subclass("FreezeMissile")

local DEFAULT_FREEZE_TIME = 2

function FreezeMissile:init (sceneGroup, isPlayerMissile, imgSrc, frozenDuration, damage)
   self.super:init(sceneGroup, isPlayerMissile, imgSrc, damage)
   self.freezeTime = DEFAULT_FREEZE_TIME or frozenDuration
end

function FreezeMissile:recycle(bullet)
	if bullet == nil then
		self.super:recycle(self)
	else
		self.super:recycle(bullet)
	end
end