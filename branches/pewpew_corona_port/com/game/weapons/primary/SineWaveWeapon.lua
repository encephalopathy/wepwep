require "com.game.weapons.Weapon"

SineWave = Weapon:subclass("SineWave")

function SineWave:init (sceneGroup, isPlayerOwned, rateOfFire, bulletSpeed, imgSrc, energyCost, bulletWidth, bulletHeight,soundHandle)
  if rateOfFire == nil then
	 rateOfFire = 50
  end
  
  if imgSrc == nil then
     imgSrc = "com/resources/art/sprites/bullet_05.png"
   end
   
   if energyCost == nil then
	  energyCost = 15
   end
   
   if soundHandle == nil then
		--print("THE SOUNDFX IS NIL; USE THE DEFAULT!!")
		soundHandle = "SineWave"
		--print("soundFX:"..soundFX)
   end
   
   self.super:init(sceneGroup, isPlayerOwned, imgSrc, rateOfFire, energyCost, SineWaveBullet, bulletWidth, bulletHeight,soundHandle)

end

function SineWave:fire(player)
	self.super:fire()
	
   if self:willFire() then
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
	   
	   if not self.isPlayerOwned then
		   bullet1.sprite.rotation = bullet1.sprite.rotation + 180
		   bullet2.sprite.rotation = bullet2.sprite.rotation + 180
	   end

	   bullet1.time = 0
	   bullet2.time = 0
	   
	   --print('Bullet 1')
	   bullet1:fire()
	   --print('Bullet 2')
	   bullet2:fire()
	   
	   if self.isPlayerOwned == true and Player:made(self.owner) then
			--print("PLAYER OWNED. FIRE SOUNDS")
			self:playFiringSound() --call to play sound for weapons
		end
	   
	   bullet1.amp = -50
	   bullet2.amp = 50

	   return true
		
	else
		return false
	end
end

return SineWave