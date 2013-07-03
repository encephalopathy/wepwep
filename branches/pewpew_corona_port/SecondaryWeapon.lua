SecondaryWeapon = Object:subclass("SecondaryWeapon")

function SecondaryWeapon:init(imgSrc)
   self.bombList = Queue.new()
   self.bulletType = bulletType
   self.imgSrc = imgSrc
   self.owner = nil --Needs to be set before weapon can be used
   self.ammo = 0
end

-- check for ammo and subtract one if we can fire
function SecondaryWeapon:canFire ()
   if (self.ammo <= 0) then
      return false
   end
   self.ammo = self.ammo - 1
   return true
end

function SecondaryWeapon:unload()
	while self.bombList.size > 0 do
		local bomb = Queue.removeBack(self.bombList)
		bomb:destroy()
	end
end

function SecondaryWeapon:checkBombs(haterList)

   for i = self.bombList.first, self.bombList.last, 1 do
      local bomb = self.bombList[i]
      
      if (bomb.isStandardBomb) then
         handleStandardBomb(bomb, haterList)
      end
      
      if (bomb.isFreezeMissile) then
         handleFreezeMissile(bomb, haterList)
      end
      
      if (bomb.isStandardMissile) then
         handleStandardMissile(bomb)
      end
      
   end

end

function SecondaryWeapon:getNewBomb(bombType)

   for i = self.bombList.first, self.bombList.last, 1 do
      local bomb = self.bombList[i]
      if (bomb.sprite.x >= 10000 and bomb.type == bombType) then
         return bomb
      end
   end
   
   return nil
end

function handleStandardBomb (bomb, haterList)

   if (bomb.hasCollided == true) then
      doStandardExplosion (bomb, haterList)
   end

   bomb.time = bomb.time + 1
   if (bomb.time >= 100) then
      doStandardExplosion (bomb, haterList)
   end

end

function distance (x1, y1, x2, y2)
   return math.sqrt(math.pow(x1-x2, 2) + math.pow(y1-y2, 2))
end

function haterDistanceFromPoint (point, hater)
   return distance (point.x, point.y, hater.sprite.x, hater.sprite.y)
end

BOMB_DAMAGE = 3
EXPLOSIO_RADIUS = 25
function doStandardExplosion (bomb, haterList)
   point = {}
   point.x = bomb.sprite.x
   point.y = bomb.sprite.y
   for hater1 in pairs(haterList) do
      if (haterDistanceFromPoint(point, hater1) < bomb.explosionRadius) then
         --print ("damage haters")
         hater1.health = hater1.health - BOMB_DAMAGE
      end
   end
   bomb.sprite.x = 10000 + math.random(0, 10000)
   local muzzleFlare  = RNFactory.createAnim("img/exp2.png", 64, 64, point.x, point.y, 2, 2)
   muzzleFlare.frame = 0
   muzzleFlare:newSequence("fire", {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16}, 24, 1, 
                           function()
                              muzzleFlare.visible = false
                              muzzleFlare:stop()
                           end)
	muzzleFlare:play("fire")
   
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

function handleFreezeMissile(bullet, haterList)
   
   if (bullet.hasCollided) then
      bullet.sprite.x = 10000 + math.random(0, 10000)
      return
   end

   if (bullet.hater == nil and bullet.hasTarget == false) then
      assignClosestHater(bullet, haterList)
      bullet.hasTarget = true
   end
   
   currX, currY = bullet.sprite:getLinearVelocity()
   if (bullet.hater == nil or currY == 0) then
      bullet:fire (0, -MISSILE_VELOCITY)
      return
   end
   
   if (bullet.sprite.y < bullet.hater.sprite.y) then
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
   
   triRatio = MISSILE_VELOCITY / math.sqrt(math.pow(xDiff, 2) + math.pow(yDiff, 2))
   
   xVel = xDiff * triRatio
   yVel = yDiff * triRatio
   
   rotate = math.atan(xVel/yVel)
   bullet.sprite.rotation = (-math.deg(rotate))
   
   bullet:fire (xVel, yVel)
end

function handleStandardMissile (bomb)

   if (bomb.hasCollided) then
      bomb.sprite.x = 10000 + math.random(0, 10000)
   end

end
