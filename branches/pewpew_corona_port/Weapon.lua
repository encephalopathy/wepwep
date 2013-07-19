require("Object")
require("Queue")
require("Utility")
require("SineWaveBullet")
Weapon = newclass("Weapon")

function Weapon:init(sceneGroup, imgSrc, rateOfFire, classType, ownerIsPlayer)
    self.isLoaded = false
	self.ammo = Queue.new()
	self.firedAmmo = Queue.new()
	self.imgSrc = imgSrc
    self.sceneGroup = sceneGroup
	self.rateOfFire = rateOfFire
	self.fireAttempts = 0
	self.ownerIsPlayer = ownerIsPlayer
	
	--[[This is something a little weird and probably something you have not seen before, we can pass the class dynamically 
	    instantiate the type of object as long as we know the class definition.  For instance, suppose I pass up a 
		SineWaveBullet up the Constructor, if we include the defintion of it via the require, then we can dyanmically
		dispatch the class name by holding a reference to the class declaration. ]]--
	if classType == nil then
		self.ammoType = Bullet
	else
		self.ammoType = classType
	end
	self.owner = nil --Needs to be set before weapon can be used
end

--Should eventually load from a static list of bullets, the type of Bullet SHOULD be specified by the weapon
function Weapon:load(amount, sceneGroup, spawnVector, isPlayerBullet, width, height)
   width = 50 or width
   height = 50 or height
   if (not self.isLoaded) then
   	for i = 1, amount, 1 do
	   	Queue.insertFront(self.ammo, self.ammoType:new(sceneGroup, self.imgSrc, isPlayerBullet, 5000, i*5000, 0, width, height))
   	end
   end
   self:setMuzzleLocation(spawnVector)
   self.isLoaded = true
end

function Weapon:equip(owner)
	owner.weapon = self
end

function Weapon:setMuzzleLocation(spawnVector)
	if spawnVector ~= nil then
		self.muzzleLocation = { x = spawnVector[1], y = spawnVector[2], magnitude = math.sqrt(spawnVector[1]*spawnVector[1] + spawnVector[2]*spawnVector[2]) }
	else
		self.muzzleLocation = { x = 0, y = 0, magnitude = 1 }
	end
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
      
      -- Check for bullets that are out of bounds
      self:cacheAmmoIfOutofBounds(bullet)
      -- Check for homing bullets
      --if (bullet.isHoming) then
      --   moveHomingBullet(bullet, haterList)
      --end
   end
end

function Weapon:cacheAmmoIfOutofBounds(bullet)
   if (bullet.sprite.y >= display.contentHeight  or bullet.sprite.y <=  -50 or bullet.sprite.x >= display.contentWidth or 
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

function Weapon:canFire()
	--print(self.ammo.size)
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