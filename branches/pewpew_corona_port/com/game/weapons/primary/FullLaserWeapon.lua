require "com.game.weapons.Weapon"
require "com.game.weapons.Bullet"
FullLaser = Weapon:subclass("FullLaser")

function FullLaser:init (sceneGroup, isPlayerOwned, rateOfFire, bulletSpeed, numberOfWaves, delayBetweenWaves, imgSrc, energyCost, bulletType, bulletWidth, bulletHeight, soundHandle, numberOfShots, firingAngle, numberOfArcs, angleBetweenArcs)
	
   self.super:init(sceneGroup, isPlayerOwned, imgSrc, rateOfFire, energyCost, bulletType, bulletWidth, bulletHeight, soundHandle)
   
function FullLaser:calculateBulletVelocity(bullet)

end

function FullLaser:fire (player)
   self.super:fire()
	
	return true
	
end

return FullLaser