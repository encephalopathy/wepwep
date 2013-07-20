require("Weapon")

HomingShot = Weapon:subclass("HomingShot")

function HomingShot:init (sceneGroup)

   self.super:init("sprites/bullet_04.png", sceneGroup, 25)
   --self.soundPath = 'homingShot.ogg'
   --homingShotSFX = MOAIUntzSound.new()
   --homingShotSFX:load('homingShot.ogg')
   self.energyCost = 30
end

function HomingShot:fire()

   bullet = self.super:fire()


   bullet.sprite.x = self.owner.x + self.muzzleLocation.x
   bullet.sprite.y = self.owner.y + self.muzzleLocation.y

   bullet.isHoming = true

   bullet.hater = nil
   
   bullet.hasTarget = false
   
   --powah stuff
   --player.powah = player.powah - self.energyCost
   
   --SFX stuff
   --homingShotSFX:play()

end


