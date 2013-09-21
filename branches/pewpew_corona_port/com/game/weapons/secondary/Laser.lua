require "com.game.weapons.Bullet"

Laser = MoveableObject:subclass("Laser")

function Laser:init (sceneGroup, imgSrc, isPlayerMissile, width, height)
   self.super:init(sceneGroup, imgSrc or "com/resources/art/sprites/laserDefault.png", isPlayerMissile, width, height)
   self.damage = damage or 3
end

function Laser:recycle(bullet)
	if bullet == nil then
		self.super:recycle(self)
	else
		self.super:recycle(bullet)
	end
end
