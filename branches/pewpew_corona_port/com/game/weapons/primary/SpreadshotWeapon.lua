require "com.game.weapons.Weapon"
require "com.game.weapons.Bullet"
Spreadshot = Weapon:subclass("Spreadshot")

function Spreadshot:init (sceneGroup, isPlayerOwned, rateOfFire, bulletSpeed, numberOfWaves, delayBetweenWaves, imgSrc, energyCost, bulletType, bulletWidth, bulletHeight, soundHandle, numberOfShots, firingAngle, numberOfArcs, angleBetweenArcs)

	if rateOfFire ~= nil then
		self.rateOfFire = rateOfFire
	else
		self.rateOfFire = 35
	end
	
	if imgSrc ~= nil then
		imgSrc = "com/resources/art/sprites/bullet_06.png"
	end

	if energyCost == nil then
	  	energyCost = 20
   	end
	
	if soundHandle == nil then
		--print("THE SOUNDFX IS NIL; USE THE DEFAULT!!")
		soundHandle = "Spreadshot"
		--print("soundFX:"..soundFX)
   	end
	
   	self.super:init(sceneGroup, isPlayerOwned, imgSrc, rateOfFire, energyCost, bulletType, 	bulletWidth, bulletHeight, soundHandle)
   	if bulletSpeed ~= nil then
	  	self.bulletSpeed = bulletSpeed
   	else
	  	self.bulletSpeed = -200
   	end
   
   	if numberOfShots ~= nil then
	  	self.numberOfShots = numberOfShots
   	else
	  	self.numberOfShots = 5
   	end
   
   	if firingAngle ~= nil then
     	self.firingAngle = firingAngle
   	else
     	self.firingAngle = 45
   	end
   
   	if numberOfArcs ~= nil then
     	self.numberOfArcs = numberOfArcs
   	else
     	self.numberOfArcs = 1
   	end
   
   	if angleBetweenArcs ~= nil then
     	self.angleBetweenArcs = angleBetweenArcs
   	else
     	self.angleBetweenArcs = 15
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

   	if startRotation == nil then
   		self.startRotation = 0
   	else
   		self.startRotation = startRotation
   	end
   
	self.waveCounter = 0
	self.delayCounter = 0

end

function Spreadshot:fire (player)
   	self.super:fire()
	if not self:willFire() then return false end
	local angleStep = self.firingAngle / ((self.numberOfShots) / self.numberOfArcs)
	local shotsPerArc = math.ceil((self.numberOfShots) / self.numberOfArcs)
	local startAngle = ((self.firingAngle * self.numberOfArcs) + (self.angleBetweenArcs * (self.numberOfArcs - 1)) + angleStep) /2 + self.owner.sprite.rotation + self.startRotation

   	local shots = {}
	if self.owner then
	   	for i = 1, (self.numberOfShots), 1 do
	      	shots[i] = self:getNextShot()
		end
	end

   	if self.waveCounter <= self.numberOfWaves and self.delayCounter == 0 then
		for i = 1, (self.numberOfShots), 1 do
			local bullet = shots[i]
		  
			if (bullet == nil) then
				break
			end
		
			local rotationAngle = math.rad(startAngle - (i * angleStep) - ((math.ceil(i / shotsPerArc) - 1) * self.angleBetweenArcs))
			self:calibrateMuzzleFlare(self.muzzleLocation.x, self.muzzleLocation.y, self.owner, bullet, rotationAngle)
         
	      	local bulletVelocity = self:calculateBulletVelocity(bullet, rotationAngle, self.bulletSpeed)

	       	if not self.isPlayerOwned then
		   		bullet.sprite.rotation = bullet.sprite.rotation + 180
		   		bulletVelocity.x = bulletVelocity.x * -1
	   	   	end

		   	bullet:fire(bulletVelocity.x, bulletVelocity.y)
	   	end 
   
	   	if self.isPlayerOwned == true and Player:made(self.owner) then
			--print("PLAYER OWNED. FIRE SOUNDS")
			self:playFiringSound(self.soundFX) --call to play sound for weapons
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

return Spreadshot