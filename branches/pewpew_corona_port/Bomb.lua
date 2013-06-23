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

function Bomb:onHit (you, collitor)

   if (you.isPlayerBomb and collitor.sprite.type == "Hater") then
      you.hasCollided = true
      you.haterHit = collitor
   end
   
   if (you.isFreezeMissile and collitor.sprite.type == "Hater") then
      you.hasCollided = true
      you.haterHit = collitor
      collitor.isFrozen = true
      collitor.freezeTimer = 0
   end
   
   if (you.isStandardMissile and collitor.sprite.type == "Hater") then
      collitor.health = collitor.health - MISSILE_DAMAGE
      you.hasCollided = true
   end

end