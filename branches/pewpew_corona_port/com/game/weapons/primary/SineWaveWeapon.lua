require "com.game.weapons.Weapon"

SineWave = Weapon:subclass("SineWave")

function SineWave:init (sceneGroup, isPlayerOwned, rateOfFire, bulletSpeed, bulletWidth, bulletHeight,soundHandle)
   
   if soundFX == nil then
		--print("THE SOUNDFX IS NIL; USE THE DEFAULT!!")
		soundHandle = "SineWave"
		--print("soundFX:"..soundFX)
   end
   
   self.super:init(sceneGroup, isPlayerOwned, "com/resources/art/sprites/bullet_05.png", 50, SineWaveBullet, bulletWidth, bulletHeight,soundHandle)

   self.energyCost = 15
end

function SineWave:fire(player)
	
   --if self:canFire() then
	   local bullet1 = self:getNextShot()
	   local bullet2 = self:getNextShot()
	   
	   local rotationAngle = math.rad(self.owner.sprite.rotation)
	   local muzzleLocX = self.muzzleLocation.x
	   local muzzleLocY = self.muzzleLocation.y
		
		
	   self:calibrateMuzzleFlare(muzzleLocX, muzzleLocY, self.owner, bullet1, rotationAngle)
	   self:calibrateMuzzleFlare(muzzleLocX, muzzleLocY, self.owner, bullet2, rotationAngle)

	   bullet1.initialX = bullet1.sprite.x
	   bullet1.initialY = bullet1.sprite.y
	   bullet1.rotation = self.owner.sprite.rotation

	   bullet2.initialX = bullet2.sprite.x
	   bullet2.initialY = bullet2.sprite.y
	   bullet2.rotation = self.owner.sprite.rotation

	   -- add some shit to the bullet tables
	   --bullet1.isSine = true
	   --bullet2.isSine = true
	   bullet1.time = 0
	   bullet2.time = 0
	   
	   bullet1:fire()
	   bullet2:fire()
	   
	   if self.isPlayerOwned == true then
			--print("PLAYER OWNED. FIRE SOUNDS")
			self:playFiringSound() --call to play sound for weapons
		end
	   
	   bullet1.amp = -50
	   bullet2.amp = 50	   
	--end
   
   --powah stuff
   --player.powah = player.powah - self.energyCost
   
   self.super:fire()
   
   --SFX stuff
   --sineWaveShotSFX:play()
   
end

return SineWave