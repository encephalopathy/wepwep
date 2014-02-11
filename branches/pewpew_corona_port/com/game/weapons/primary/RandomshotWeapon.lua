require "com.game.weapons.Weapon"
require "com.game.weapons.Bullet"
Randomshot = Weapon:subclass("Randomshot")

function Randomshot:init (sceneGroup, isPlayerOwned, rateOfFire, bulletSpeed, imgSrc, energyCost, bulletType, bulletWidth, bulletHeight, soundHandle, maxNumberOfShots, firingAngle, numberOfWaves, delayBetweenWaves)

	if rateOfFire ~= nil then
		self.rateOfFire = rateOfFire
	else
		self.rateOfFire = 35
	end
	
	if imgSrc ~= nil then
		self.imgSrc = imgSrc
	else
		self.imgSrc = "com/resources/art/sprites/bullet_06.png"
	end

	if soundHandle == nil then
		--print("THE SOUNDFX IS NIL; USE THE DEFAULT!!")
		soundHandle = "Randomshot"
		--print("soundFX:"..soundFX)
   end
   
	--print("width is ", bulletWidth, "and height is ", bulletHeight)
   self.super:init(sceneGroup, isPlayerOwned, imgSrc, rateOfFire, energyCost, bulletType ,bulletWidth, bulletHeight, soundHandle)
   if bulletSpeed ~= nil then
	  self.bulletSpeed = bulletSpeed
   else
	  self.bulletSpeed = -200
   end
   
   if maxNumberOfShots ~= nil then
      self.maxNumberOfShots = math.random(maxNumberOfShots)
   else
      self.maxNumberOfShots = math.random(10)
   end
   
   if firingAngle ~= nil then
     self.firingAngle = firingAngle
   else
     self.firingAngle = 45
   end
   
   if numberOfWaves == nil then
      self.numberOfWaves = 3
   else
      self.numberOfWaves = numberOfWaves
   end
   
   if delayBetweenWaves == nil then
      self.delayBetweenWaves = 5
   else
      self.delayBetweenWaves = delayBetweenWaves
   end
   
	self.waveCounter = 0
	self.delayCounter = 0
   
   self.energyCost = 20
end

function Randomshot:fire (player)
   self.super:fire()
	if not self:willFire() then return false end
	local startAngle = self.firingAngle / 2 + self.owner.sprite.rotation

   local shots = {}
	if self.owner then
	   for i = 1, (self.maxNumberOfShots), 1 do
	      shots[i] = self:getNextShot()
		end
	end
       
   if self.waveCounter <= self.numberOfWaves and self.delayCounter == 0 then
       
		for i = 1, (math.random(self.maxNumberOfShots)), 1 do
			local bullet = shots[i]
		  
			if (bullet == nil) then
				break
			end
		
			local rotationAngle = (math.rad(startAngle - math.random(self.firingAngle)))
			self:calibrateMuzzleFlare(self.muzzleLocation.x, self.muzzleLocation.y, self.owner, bullet, rotationAngle)
         
         local bulletVelocity = self:calculateBulletVelocity(bullet, rotationAngle, self.bulletSpeed)
		   bullet:fire(bulletVelocity.x, bulletVelocity.y)
      end 
   
      if self.isPlayerOwned == true then
			--print("PLAYER OWNED. FIRE SOUNDS")
			self:playFiringSound() --call to play sound for weapons
		end
		
		if self.numberOfWaves > 0 then
			self.waveCounter = self.waveCounter + 1
		end	
		
	elseif self.waveCounter > self.numberOfWaves and self.delayCounter <= self.delayBetweenWaves then
		self.delayCounter = self.delayCounter + 1
	elseif self.waveCounter > self.numberOfWaves and self.delayCounter > self.delayBetweenWaves then
		self.waveCounter = 0
		self.delayCounter = 0
	end
	
	return true
	
end 

return Randomshot