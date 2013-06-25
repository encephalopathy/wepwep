require("Object")
require("Queue")
Weapon = Object:subclass("Weapon")

function Weapon:init(sceneGroup, imgSrc, rateOfFire)
    self.isLoaded = false
	self.ammo = Queue.new()
	self.imgSrc = imgSrc
    self.sceneGroup = sceneGroup
	self.rateOfFire = rateOfFire
	self.fireAttempts = 0
	self.owner = nil --Needs to be set before weapon can be used
end

function Weapon:load(amount, sceneGroup)

   if (not isLoaded) then
   	for i = 1, amount, 1 do
	   	Queue.insertFront(self.ammo, Bullet:new(sceneGroup, self.imgSrc, true, 5000, 5000, 0, 50, 50))
   	end
   end
   self.isLoaded = true
end

function Weapon:unload()
	while self.ammo.size > 0 do
		local ammo = Queue.removeBack(self.ammo)
		ammo:destroy()
	end
end


--[[
Consolidation of functions that need to check on bullets every frame.
This way we only have to loop through the bullet array once
--]]
function Weapon:checkBullets(haterList)
   bulletList = self.ammo
   for i = bulletList.first, bulletList.last, 1 do
      local bullet = bulletList[i]
      
      -- Check for bullets on sine wave path
      if (bullet.isSine) then
         moveSineBullet(bullet)
      end
      
      -- Check for bullets that are out of bounds
      cacheAmmoIfOutofBounds(bullet)
      
      -- Check for homing bullets
      if (bullet.isHoming) then
         moveHomingBullet(bullet, haterList)
      end
      
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

function cacheAmmoIfOutofBounds(bullet)
   if (bullet.sprite.y >= 650  or bullet.sprite.y <=  -50 or bullet.sprite.x >= 850 or 
       bullet.sprite.x <= -50 or bullet.alive == false) then
      --Location 5000, 5000 is the registration spawn point of all bullets
      bullet.sprite.x = 5000
      bullet.sprite.y = 5000
      bullet.alive = false
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
	--local ammo = nil
	--[[if numberOfShots > 0 then
		local ammoClip = {}
		while numberOfShots > 0 do
			ammo = getNextShot()
			if ammo == nil then 
				break 
			end
			table.insert(ammoClip, ammo)
			numberOfShots = numberOfShots - 1
		end
		return ammoClip
	end]]--
	
	if self.ammo.size > 0 then
		local ammo = Queue.removeBack(self.ammo) 
		self.fireAttempts = self.fireAttempts + 1
		if ammo.alive == false then
			ammo.alive = true
			Queue.insertFront(self.ammo, ammo)
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