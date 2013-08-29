require "com.game.weapons.secondary.SecondaryWeapon"
require "com.game.weapons.secondary.Bomb"

MISSILE_VELOCITY = 100

FreezeMissile = SecondaryWeapon:subclass("FreezeMissile")

function FreezeMissile:init (fireCount, sceneGroup)

   self.super:init("img/missile.png", "img/exp2.png", sceneGroup)
   self.fireCount = fireCount
   self.sceneGroup = sceneGroup	
end

function FreezeMissile:fire (player)

   if (not self:canFire()) then
      return
   end

   local bomb = nil
   bomb = self:getNewBomb("freezeMissile")
   if (bomb == nil) then
      bomb = Bomb:new (-5000, -5000, 1, 1, "img/missile.png",
                       self.sceneGroup, true)
      Queue.insertFront(self.bombList, bomb)
   end
   bomb.type = "freezeMissile"
   bomb.hasCollided = false
   bomb.sprite.y = self.owner.sprite.y - 100
   bomb.sprite.x = self.owner.sprite.x
   bomb.time = 0
   bomb.hater = nil
   bomb.hasTarget = false
   bomb.isFreezeMissile = true
   bomb:fire(0, -MISSILE_VELOCITY)

end