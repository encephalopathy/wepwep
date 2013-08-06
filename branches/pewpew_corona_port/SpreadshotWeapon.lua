require("Weapon")

Spreadshot = Weapon:subclass("Spreadshot")

NUM_SHOTS = 5 --Default number of shots this gun fires.
FIRING_ANGLE = 60
BETWEEN = 3 -- space between bullets
BULLET_SIZEZ = 5

function Spreadshot:init (sceneGroup, rateofFire, bulletVelocity, numberOfShots, firingAngle)

	if rateOfFire == nil then
		rateOfFIre = 15
	end

   self.super:init(sceneGroup, "sprites/bullet_06.png", rateOfFire)
   if bulletVelocity ~= nil then
	  self.bulletVelocity = bulletVelocity
   else
	  self.bulletVelocity = -200
   end
   
   if numberOfShots ~= nil then
	  self.numberOfShots = numberOfShots
   else
	  self.numberOfShots = NUM_SHOTS
   end
   
   if firingAngle ~= nil then
     self.firingAngle = firingAngle
   else
     self.firingAngle = FIRING_ANGLE
   end
   
   self.energyCost = 20
end


function Spreadshot:fire (player)
	 self.super:fire()
	if self:canFire() then
	   angleStep = FIRING_ANGLE / (NUM_SHOTS - 1)
	   speed = BULLET_VELOCITY
	   startAngle = (180 - FIRING_ANGLE) / 2
	   
	   local shots = {}
	   if self.owner then
		  for i = 0, (NUM_SHOTS -1) do
			 shots[i] = self:getNextShot()
		  end
	   end

	   for i = 0, (NUM_SHOTS - 1) do
		  bullet = shots[i]
		  
		  if (bullet == nil) then
			 break
		  end
		  
		  bullet.sprite.y = self.owner.sprite.y - 100;
		  bullet.sprite.x = self.owner.sprite.x;
		  angle = startAngle + (i * angleStep)
		  xVelocity = speed * math.cos(math.rad(angle)) * -1
		  yVelocity = math.abs(speed * math.sin(math.rad(angle))) * -1
		  
		  rotate = math.atan(xVelocity/yVelocity)
		  bullet.sprite.rotation = (-math.deg(rotate))
		  
		  bullet:fire(xVelocity, yVelocity)
		end

   end
  
   --powah stuff
   --player.powah = player.powah - self.energyCost
   
   --SFX stuff
   --spreadShotSFX:play()

end 