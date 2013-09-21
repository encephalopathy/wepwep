require "com.game.weapons.secondary.SecondaryWeapon"
require "com.game.weapons.secondary.Bomb"

MISSILE_VELOCITY = 20

Laser = SecondaryWeapon:subclass("Laser")

function standardLaser:init (fireCount, sceneGroup)

   self.super:init("img/laserDefault.png", "img/laserDefault.png", sceneGroup)
   self.fireCount = fireCount
   self.sceneGroup = sceneGroup	
   
end

function standardLaser:fire (player)

   if (not self:canFire()) then
      return
   end

   local bomb = nil
   bomb = self:getNewBomb("standardLaser")
   if (bomb == nil) then
      bomb = Bomb:new (-5000, -5000, 1, 1, "img/laserDefault.png",
                       self.sceneGroup, true)
      Queue.insertFront(self.bombList, bomb)
   end
   bomb.type = "standardLaser"
   bomb.sprite.y = self.owner.sprite.y - 50
   bomb.sprite.x = self.owner.sprite.x
   bomb.hasCollided = false
   bomb.isStandardMissile = true
   bomb:fire(0, -3 * MISSILE_VELOCITY)

end