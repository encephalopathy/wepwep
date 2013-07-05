require("Weapon")

Spreadshot = Weapon:subclass("Spreadshot")

NUM_SHOTS = 5
FIRING_ANGLE = 60
BETWEEN = 3 -- space between bullets
BULLET_SIZEZ = 5

function Spreadshot:init (sceneGroup)

   self.super:init(sceneGroup, "sprites/bullet_06.png", 15)
   --self.fireCount = fireCount
   --self.soundPath = 'pew.ogg'
   --spreadShotSFX = MOAIUntzSound.new()
   --spreadShotSFX:load('pew.ogg')
   self.energyCost = 20
end


function Spreadshot:fire (player)
	if self:canFire() then
	   angleStep = FIRING_ANGLE / (NUM_SHOTS - 1)
	   speed = BULLET_VELOCITY
	   startAngle = (180 - FIRING_ANGLE) / 2
	   
	   shots = {}
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
   self.super:fire()
   --powah stuff
   --player.powah = player.powah - self.energyCost
   
   --SFX stuff
   --spreadShotSFX:play()

end 