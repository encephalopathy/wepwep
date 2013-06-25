require("Weapon")

SineWave = Weapon:subclass("SineWave")

function SineWave:init (sceneGroup)

   self.super:init("sprites/bullet_05.png", sceneGroup)
   --self.soundPath = 'sineWave.ogg'
   --sineWaveShotSFX = MOAIUntzSound.new()
   --sineWaveShotSFX:load('sineWave.ogg')
   self.energyCost = 15
end


function SineWave:fire(player)

   bullet1 = self.super:fire()
   bullet2 = self.super:fire()

   bullet1.sprite.x = self.owner.sprite.x;
   bullet1.sprite.y = self.owner.sprite.y - 100

   bullet2.sprite.x = self.owner.sprite.x;
   bullet2.sprite.y = self.owner.sprite.y - 100

   bullet1.initialX = bullet1.sprite.x
   bullet1.initialY = bullet1.sprite.y

   bullet2.initialX = bullet2.sprite.x
   bullet2.initialY = bullet2.sprite.y

   -- add some shit to the bullet tables
   bullet1.isSine = true
   bullet2.isSine = true
   bullet1.time = 0
   bullet2.time = 0

   bullet1.amp = -50
   bullet2.amp = 50
   
   --powah stuff
   player.powah = player.powah - self.energyCost
   
   --SFX stuff
   sineWaveShotSFX:play()
   
end