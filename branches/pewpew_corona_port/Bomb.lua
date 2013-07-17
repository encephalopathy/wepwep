Bomb = MoveableObject:subclass("Bomb")

MISSILE_DAMAGE = 5

function Bomb:init(x, y, scaleX, scaleY, imgSrc, sceneGroup, isPlayerBomb)

   self.super:init(x, y, scaleX, scaleY, imgSrc, "kinematic", sceneGroup)
   self.alive = false
   self.damage = 1
   self.isPlayerBomb = isPlayerBomb
   self.sprite.objRef = self

end

function Bomb:fire(x, y)
   self.sprite:setLinearVelocity(x, y)
   self.owner = owner
end

function Bomb:onHit (phase, collide)

   if (self.isPlayerBomb and collide.type == "Hater") then
      self.hasCollided = true
      self.haterHit = collitor
   end
   
   if (self.isFreezeMissile and collide.type == "Hater") then
      self.hasCollided = true
      self.haterHit = collitor
      collide.isFrozen = true
      collide.freezeTimer = 0
   end
   
   if (self.isStandardMissile and collide.type == "Hater") then
      collide.health = collide.health - MISSILE_DAMAGE
      self.hasCollided = true
   end

end