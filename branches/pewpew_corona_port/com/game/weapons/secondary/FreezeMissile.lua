require "com.game.weapons.secondary.StandardMissile"

FreezeMissile = StandardMissile:subclass("FreezeMissile")

local DEFAULT_FREEZE_TIME = 2

function FreezeMissile:init (sceneGroup, isPlayerMissile, imgSrc, frozenDuration, damage)
   self.super:init(sceneGroup, isPlayerMissile, imgSrc, damage)
   self.freezeTime = DEFAULT_FREEZE_TIME or frozenDuration
end

function FreezeMissile:onHit(phase, collitor)
	if phase == "began" and self.alive then
		if not collitor.type == "player" and self.isPlayerBullet then
			if self.alive then
				self:onCollision()
			end
		end

		if collitor.type == "player" and not self.isPlayerBullet then
			if self.alive then
				self:onCollision()
			end
		end
		
		if self.isPlayerBullet and collitor.type == "Hater" then
			if self.alive then
				print('Colliding with Hater')
				self:onCollision()
			end
		end
	end
end

function FreezeMissile:recycle(bullet)
	print('RECYCLING FREEZE MISSILE')
	if bullet == nil then
		self.super:recycle(self)
	else
		self.super:recycle(bullet)
	end
end