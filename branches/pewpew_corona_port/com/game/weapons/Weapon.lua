require "org.Object"
require "org.Queue"
require "com.Utility"
require "com.managers.BulletManager"
require "com.game.weapons.primary.SineWaveBullet"
require "com.game.weapons.primary.HomingBullet"

Weapon = Object:subclass("Weapon")

--[[
--	CLASS NAME: Weapon
--
--	DESCRIPTION:  The base class for all weapons in Shoot Em' Up! PEW PEW!!  Weapons are responsible for shooting bullets,
				  they do not care about what bullets they fire and do not need to update them.  They only need to make sure
				  bullets spawn in the right place and shoot in the right direction.
	
--	FUNCTIONS:
--	@init: Creates a weapon and sets the fields required to fire the right bullets.
--	@move: See inherit doc.
--	@equip: Equips this weapon to the passed in owner variable.
--	@setMuzzleLocation: initializes the spawn location for bullets that are shot by this weapon.
--	@canFire: Determines whether this weapon can fire or not.
--  @calibrateMuzzleFlare: Transforms the bullet spawned at the correct location if the owner of the weapon ever rotates.
--  @getNextShot: Returns a bullet from the BulletManager to fire. Will only do this if this weapon can fire.
--  @fire: Fires this weapon if able, the weapon will only fire based on its rate of fire.
--  @adjustPowah: Decrements powah based on energy cost to fire this weapon.
--  @playFiringSound: Plays the firing sound whenever this weapon is fired. 
--	@destroy: Destroys the ship
--	
--	DEPRECATED( OR WILL BE AFTER SOME REFACTORING LATER DUE TO BULLETMANAGER )
--  @load: Loads all the bullets into a bullet Queue called ammo, owned locally by weapon, that holds bullets to fire.
--		   Also has the optional argument to set the muzzelFlareLocation.
--	@unload: Unloads all the bullets shot by this weapon and stored by this weapon.
--	@checkBullets: Determines if any of the bullets fired by this weapon need to be occlussion culled off screen.
--	@cacheAmmoIfOutOfBounds: Occlussion Culls the fired bullets off screen.
]]--

--[[
	CONSTRUCTOR:
	@sceneGroup: The object that is used to add the sprite to scene.  See Corona Docs concerning groups/storyboard.
	@isPlayerOwned: variable that determines if this weapon is owned by the player.
	@imgSrc: The image of the bullet that will be shot by the weapon.
	@rateOfFire: Rate of fire of this Weapon, the rate of fire is based on the number of frames. 
	@classType: Dependency injection that determines what bullet should be fired.
	@bulletWidth: Width of the bullet fired by this weapon in DPI.
	@bulletHeight: Height of the bullet fired by this weapon in DPI.
]]--
function Weapon:init(sceneGroup, isPlayerOwned, imgSrc, rateOfFire, energyCost, classType, bulletWidth, bulletHeight, soundHandle)

	-- These 3 variables will be deprecated after the Bullet Manager is done.
    self.isLoaded = false --Determines if the weapon has been loaded with animation.  Should only be set in the load function.
	self.ammo = Queue.new()	--Magazine or clip that holds ammo that has not been fired by this weapon yet.
	self.firedAmmo = Queue.new() --A queue that holds ammo that has been fired by this weapon.
	
	--variable that determines if this weapon is owned by the player
	self.isPlayerOwned = isPlayerOwned
	
	--The image of the bullet that will be shot by the weapon.
	self.imgSrc = imgSrc
	
	--Scenegroup of the current level being played.  See groups/storyboard in Corona for more references.
    self.sceneGroup = sceneGroup
	
	--Rate of fire of this Weapon, the rate of fire is based on the number of frames. 
	self.rateOfFire = rateOfFire
	
	--amount energy that the weapon uses per shot
	self.energyCost = energyCost
	
	--Keeps track of how many times this weapon has fired.  This is incremented whenever fire() is called.
	self.fireAttempts = 0
	
	--The bullet's width and height when fired by this gun.
	self.bulletWidth = bulletWidth
	self.bulletHeight = bulletHeight
	
	--loading the soundFX for the weapon
	--local loadedAudioFile = audio.loadSound(soundFX)
	self.soundHandle = soundHandle
	
	--[[This is something a little weird and probably something you have not seen before, we can pass the class dynamically 
	    instantiate the type of object as long as we know the class definition.  For instance, suppose I pass up a 
		SineWaveBullet up the Constructor, if we include the defintion of it via the require, then we can dyanmically
		dispatch the class name by holding a reference to the class declaration. ]]--
		
	if classType == nil then
		self.ammoType = Bullet
	else
		self.ammoType = classType
	end
	
	--Needs to be set before weapon can be used, this field is commented out because
	--we can create it dynamically in Lua later.  One of the magic tricks in Lua.
	--self.owner = nil 
end

function Weapon:setAmmoAmount(number)
	local maxAmmoAmount = number
	self.ammoAmount = maxAmmoAmount
	self.maxAmmoAmount = maxAmmoAmount
end

--[[
	FUNCTION NAME: equip
	
	DESCRIPTION: equips the weapon to a specific owner.
	
	PARAMETERS:
		@owner: The owner that will hold this weapon.
	@RETURN: VOID
]]--
function Weapon:equip(owner)
	owner.weapon = self
end

--[[
	FUNCTION NAME: setMuzzleLocation
	
	DESCRIPTION: Responsible for determining which direction the ship will fire from.  This coordinate system
				 to determine this is based on the cartesian coordinate system where the origin is located
				 at the center of the sprite(self.owner) holding this weapon.
	PARAMETERS:
		@spawnVector: The direction in which a bullet from this gun spawns.  If no vector is given, the origin is choosen as
					  the bullet's spawn location.
	@RETURN: VOID
]]--
function Weapon:setMuzzleLocation(spawnVector)
	-- for key, value in pairs(spawnVector) do
		-- print('key: ' .. tostring(key) .. ' value: ' .. tostring(value))
	-- end
	if spawnVector ~= nil then
		--self.muzzleLocation = { x = spawnVector[1], y = spawnVector[2], magnitude = math.sqrt(spawnVector[1]*spawnVector[1] + spawnVector[2]*spawnVector[2]) }
		self.muzzleLocation = spawnVector
		self.muzzleLocation.magnitude = math.sqrt((spawnVector.x * spawnVector.x) + (spawnVector.y * spawnVector.y))
	else
		self.muzzleLocation = { x = 0, y = 0, magnitude = 1 }
	end
end


--[[
	FUNCTION NAME: unload
	
	DESCRIPTION: Unloads all bullets from the ammo that has been fired and is on the screen and the ammo
				 that can be fired later.  THIS WILL BE DEPRECIATED AFTER BULLET MANAGER IS FINISHED!!!!
	@RETURN: VOID
]]--
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
This way we only have to loop through the bullet array once.  WILL BE DEPRECATED AND MOVED
TO THE BULLET MANAGER.
--]]
function Weapon:checkBullets()
   
   local bulletList = self.firedAmmo
   local shotsFired = bulletList.size
   for i = 1, shotsFired, 1 do
      local bullet = Queue.removeBack(bulletList)
      
      -- Check for bullets that are out of bounds
      self:cacheAmmoIfOutofBounds(bullet)

   end
end


--[[
	WILL BE DEPRECATED... Culls the bullets if they were to ever fly off screen by storing them in a local bullet queue for later.
	This queue is called ammo. If the bullet is already on screen, it restores the bullet back in the firedAmmo queue meaning that
	the bullet has been fired and is on screen.
	@PAMETERS: Bullet to be oclussion culled.
]]--
function Weapon:cacheAmmoIfOutofBounds(bullet)
   if (bullet.sprite.y >= display.contentHeight  or bullet.sprite.y <=  -50 or bullet.sprite.x >= display.contentWidth or 
       bullet.sprite.x <= -50 or not bullet.alive) then
		
		--Recycles the bullet by moving it offscreen and storing it in a bullet queue. This is stored in BulletManager.
		if tostring(bullet) ~= 'Bullet' then
			print('Bullet to recylcle: ' .. tostring(bullet))
		end
		bullet:recycle()
		
	  Queue.insertFront(self.ammo, bullet)
	else
	  Queue.insertFront(self.firedAmmo, bullet)
	end
end

--[[
	FUNCTION NAME: canFire
	
	DESCRIPTION: Determines if this weapon can fire or not based on how many fire attempts this weapon has performed
		         against its rate of fire.
	
	@RETURN: A boolean that determines if this gun can fire or not
]]--
function Weapon:canFire()
	if self.rateOfFire - self.fireAttempts == 0 then
		return true
	else
		return false
	end
end

function Weapon:willFire()
	local isFiring = self:canFire()
	if isFiring then
		self.fireAttempts = 0
	end
	return isFiring
end

--[[
	FUNCTION NAME: calibrateMuzzleFlare
	
	DESCRIPTION: Responsible for moving the object to the x and y location in the world
	
	PARAMETERS:
		@muzzleLocX: The location of the x coordinate of the muzzle of the gun.
		@muzzleLocY: The location of the y coordinate of the muzzle of the gun.
		@bullet: The bullet that is to be fired by the gun.
		@owner: The owner of the gun, we need to pass this field in so we know which ship is firing the gun.
		@rotationAngle: An angle defined in radians that determines the rotation of the gun tip.
	@RETURN: VOID
]]--
function Weapon:calibrateMuzzleFlare(muzzleLocX, muzzleLocY, owner, bullet, rotationAngle)
	if rotationAngle ~= 0 then	
		--[[To rotate the vector locally, we multipy it by a rotation matrix around the origin(Top-left hand of the screen) then 
			translate the rotated vector back to the its local origin, the location where that particular vector was located at.
		]]--
		local rotatedVector = rotate2DPoint(muzzleLocX, muzzleLocY, rotationAngle)
		muzzleLocX, muzzleLocY = muzzleLocX + rotatedVector.x, muzzleLocX + rotatedVector.y
	end
	
	--The rotation of the bullet must be converted back from radians to degrees because that is how Corona handles rotation.
	bullet.sprite.rotation = math.deg(rotationAngle)
	
	--trying to flip bullet, not working
	-- if(self.isPlayerOwned == true) then
		-- bullet.sprite.rotation = bullet.sprite.rotation + 180
	-- end
	
	--Offsets the bullets location to be in the direction of the muzzle Location relative to the ship's origin.
	bullet.sprite.x = owner.sprite.x + muzzleLocX
	bullet.sprite.y = owner.sprite.y + muzzleLocY
end


--[[
	FUNCTION NAME: getNextShot
	
	DESCRIPTION: Gets the next bullet to be fired from the Bullet Manager if able.
	
	PARAMETERS:
	@RETURN: VOID
]]--
function Weapon:getNextShot(numberOfShots)
	
	--if self:canFire() then
	local bullet
	if self.ammoAmount == nil or self.ammoAmount > 0 then
		bullet = bulletManager:getBullet (self.ammoType, self.imgSrc, self.isPlayerOwned, self.bulletWidth, self.bulletHeight)
		if self.ammoAmount ~= nil then
			self.ammoAmount = self.ammoAmount - 1
		end
	
		--We need to increment the fire attempts when we fire else we will be firing infintely.
		--self.fireAttempts = self.fireAttempts + 1
		--[[
			Puts the bullets in fire ammo queue signifying that this bullet has been fired.  Will be deprecated when
			Bullet Manager is done and tested correctly.
		]]--
		if bullet.alive == false then
			bullet.alive = true
			Queue.insertFront(self.firedAmmo, bullet)
			return bullet
		else
			return nil
		end
	end	
	--end
end


--[[
	FUNCTION NAME: fire
	
	DESCRIPTION: Attempts to fire this abstract gun.  Fire attempts is incremented signfying that this
				 weapon tried to fire this frame.

	@RETURN: VOID
]]--
function Weapon:fire()
	self.fireAttempts = self.fireAttempts + 1
end

--[[
	FUNCTION NAME: adjustPowah
	
	DESCRIPTION: Adjusts the powah consumption of the owner based on this weapon's powah cost.

	@RETURN: VOID
]]--
function Weapon:adjustPowah(owner)
	--print("self.energyCost: "..self.energyCost)
	if self.energyCost then
		owner.powah = owner.powah - self.energyCost
	end
end

--[[
	FUNCTION NAME: playFiringSound
	
	DESCRIPTION: Abstract method that will get called when the weapon has fired.

	@RETURN: VOID
]]--

--takes in the handle to the audio file
--audio.play the sound
function Weapon:playFiringSound()
	--print("audioObject: "..tostring(audioObject))
	Runtime:dispatchEvent({name = "playSound", soundHandle = self.soundHandle})

end