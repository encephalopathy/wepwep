require("SecondaryWeapon")
require("Bomb")

MISSILE_VELOCITY = 100

StandardMissile = SecondaryWeapon:subclass("StandardMissile")

function StandardMissile:init (fireCount, sceneGroup)

   self.super:init("img/missile.png", "img/exp2.png", sceneGroup)
   self.fireCount = fireCount
   self.sceneGroup = sceneGroup	
   
end

function StandardMissile:fire (player)

   if (not self:canFire()) then
      return
   end

   local bomb = nil
   bomb = self:getNewBomb("standardMissile")
   if (bomb == nil) then
      bomb = Bomb:new (-5000, -5000, 1, 1, "img/missile.png",
                       self.sceneGroup, true)
      Queue.insertFront(self.bombList, bomb)
   end
   bomb.type = "standardMissile"
   bomb.sprite.y = self.owner.sprite.y - 100
   bomb.sprite.x = self.owner.sprite.x
   bomb.hasCollided = false
   bomb.isStandardMissile = true
   bomb:fire(0, -2 * MISSILE_VELOCITY)

end