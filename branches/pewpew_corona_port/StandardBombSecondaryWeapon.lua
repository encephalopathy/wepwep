require("SecondaryWeapon")
require("Bomb")

BOMB_VELOCITY = 100

StandardBomb = SecondaryWeapon:subclass("StandardBomb")

function StandardBomb:init (sceneGroup)
   self.super:init("img/bomb.png", sceneGroup)
   self.sceneGroup = sceneGroup
end

function StandardBomb:fire (player)

   if (not self:canFire()) then
      return
   end

   local bomb = nil
   bomb = self:getNewBomb("standardBomb")
   if (bomb == nil) then
      bomb = Bomb:new(-5000, -5000, .15, .15, "img/bomb.png", self.sceneGroup,
                       true)
      Queue.insertFront(self.bombList, bomb)
   end
   bomb.type = "standardBomb"
   bomb.time = 0
   bomb.hasCollided = false
   bomb.sprite.y = self.owner.sprite.y - 100
   bomb.sprite.x = self.owner.sprite.x
   bomb.explosionRadius = 150
   bomb.isStandardBomb = true
   bomb:fire(0, -BOMB_VELOCITY)
   

end

