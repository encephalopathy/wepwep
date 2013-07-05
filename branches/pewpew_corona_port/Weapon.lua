require("Object")
require("Queue")
require("SineWaveBullet")
Weapon = newclass("Weapon")

function Weapon:init(sceneGroup, imgSrc, rateOfFire, classType)
    self.isLoaded = false
	self.ammo = Queue.new()
	self.firedAmmo = Queue.new()
	self.imgSrc = imgSrc
    self.sceneGroup = sceneGroup
	self.rateOfFire = rateOfFire
	self.fireAttempts = 0
	if classType == nil then
		self.ammoType = Bullet
	else
		self.ammoType = classType
	end
	
	self.owner = nil --Needs to be set before weapon can be used
end

function Weapon:load(amount, sceneGroup)

   if (not isLoaded) then
   	for i = 1, amount, 1 do
	   	Queue.insertFront(self.ammo, self.ammoType:new(sceneGroup, self.imgSrc, true, 5000, i*5000, 0, 50, 50))
   	end
   end
   self.isLoaded = true
end

function Weapon:unload()
	local ammo
	while self.firedAmmo.size > 0 do
		ammo = Queue.removeBack(self.fireAmmo)
		ammo:destroy()
	end

	while self.ammo.size > 0 do
		ammo = Queue.removeBack(self.ammo)
		ammo:destroy()
	end
end


--[[
Consolidation of functions that need to check on bullets every frame.
This way we only have to loop through the bullet array once
--]]
function Weapon:checkBullets()
   
   local bulletList = self.firedAmmo
   local shotsFired = bulletList.size
   for i = 1, shotsFired, 1 do
      local bullet = Queue.removeBack(bulletList)
      -- Check for bullets on sine wave path
      --if (bullet.isSine) then
      --   moveSineBullet(bullet)
      --end
      
      -- Check for bullets that are out of bounds
      self:cacheAmmoIfOutofBounds(bullet)
      
      -- Check for homing bullets
      --if (bullet.isHoming) then
      --   moveHomingBullet(bullet, haterList)
      --end
      
   end
end

function distance (x1, y1, x2, y2)
   return math.sqrt(math.pow(x1-x2, 2) + math.pow(y1-y2, 2))
end

function haterDistance (bullet, hater)
   return distance (bullet.sprite.x, bullet.sprite.y, hater.sprite.x, hater.sprite.y)
end

function assignClosestHater(bullet, haterList)
    local minDistance = -1
    for hater1 in pairs(haterList) do
       local currDistance = haterDistance (bullet, hater1)
       if ((minDistance == -1 or currDistance < minDistance) and 
            bullet.sprite.y > hater1.sprite.y) then
          minDistance = currDistance
          bullet.hater = hater1
       end
    end
end


function moveHomingBullet(bullet, haterList)
   if (bullet.hater == nil and bullet.hasTarget == false) then
      assignClosestHater(bullet, haterList)
      bullet.hasTarget = true
   end
   
   if (bullet.sprite.y < bullet.hater.sprite.y) then
      return
   end
   
   currX, currY = bullet.sprite:getLinearVelocity()
   if (bullet.hater == nil or currY == 0) then
      bullet:fire (0, -BULLET_VELOCITY)
      return
   end
   
   if (bullet.hater.health <= 0) then
      return
   end
   
   haterX = bullet.hater.sprite.x
   haterY = bullet.hater.sprite.y
   
   bulletX = bullet.sprite.x
   bulletY = bullet.sprite.y
   
   xDiff = haterX - bulletX
   yDiff = haterY - bulletY
   
   triRatio = BULLET_VELOCITY / math.sqrt(math.pow(xDiff, 2) + math.pow(yDiff, 2))
   
   xVel = xDiff * triRatio
   yVel = yDiff * triRatio
   
   bullet:fire (xVel, yVel)
   
end

function moveSineBullet(bullet)
   local speed = 5
   local newY = bullet.initialY - bullet.time * speed
   local newX = bullet.initialX + bullet.amp * math.sin(bullet.time * 4 * math.pi / 50)
   bullet:move(newX, newY)
   bullet.time = bullet.time + 1
end

function Weapon:cacheAmmoIfOutofBounds(bullet)
   if (bullet.sprite.y >= 650  or bullet.sprite.y <=  -50 or bullet.sprite.x >= 850 or 
       bullet.sprite.x <= -50 or not bullet.alive) then
      --Location 5000, 5000 is the registration spawn point of all bullets
      
	  --tprint(bullet.recycle, 5)
	  --if bullet.recycle ~= undefined then 
		bullet:recycle()
	  --end
	  Queue.insertFront(self.ammo, bullet)
   else
	  Queue.insertFront(self.firedAmmo, bullet)
   end
end

function tprint (tbl, indent)
  if not indent then indent = 0 end
  for k, v in pairs(tbl) do
    formatting = string.rep("  ", indent) .. k .. ": "
    if type(v) == "table" then
      print(formatting)
      tprint(v, indent+1)
    else
      print(formatting .. v)
    end
  end
end

function Weapon:debugPrintBulletList()
	for i = 1, 20, 1 do
		print('i: ' .. i)
		print(self.ammo[i].sprite)
		print('x: ' .. self.ammo[i].sprite.x)
		print('y: ' .. self.ammo[i].sprite.y)
	end
end

function Weapon:canFire()
	if self.rateOfFire - self.fireAttempts == 0 then
		self.fireAttempts = 0
		return true
	else
		return false
	end
end

function Weapon:getNextShot(numberOfShots)	
	if self.ammo.size > 0 then
		local ammo = Queue.removeBack(self.ammo) 
		self.fireAttempts = self.fireAttempts + 1
		if ammo.alive == false then
			ammo.alive = true
			Queue.insertFront(self.firedAmmo, ammo)
			return ammo
		else
			return nil
		end
	end
end

function Weapon:fire()
	--if self.owner then
		self.fireAttempts = self.fireAttempts + 1
	--end
end