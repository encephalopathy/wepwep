require "com.game.weapons.Bullet"

StandardMissile = Bullet:subclass("StandardMissile")

function StandardMissile:init (sceneGroup, imgSrc, isPlayerMissile, width, height)
   self.super:init(sceneGroup, imgSrc or "com/resources/art/sprites/missile.png", isPlayerMissile, width, height)
   self.damage = damage or 3
end

function StandardMissile:recycle(bullet)
	print('RECYCLING STANDARD MISSILE')
	if bullet == nil then
		self.super:recycle(self)
	else
		self.super:recycle(bullet)
	end
end
