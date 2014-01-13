require "com.Ride"

GunpodSingle = Ride:subclass("GunpodSingle")

function GunpodSingle: init(sceneGroup, imgSrc, x, y)
	if sceneGroup == nil then
		print("sceneGroup is nil in Gunpod Single")
	elseif imgSrc == nil then
		print("imgSrc is nil in Gunpod Single")
	elseif x == nil then
		print("x is nil in Gunpod Single")
	elseif y == nil then
		print("y is nil in Gunpod Single")
	end

	self.super:init(sceneGroup, imgSrc, x, y, rotation, 75, 75, { categoryBits = 1, maskBits = 0 })
	self.sprite.objRef = self
end

--[[
	FUNCTION NAME: onHit
	
	DESCRIPTION: Handles object collision.  Displays the explosion animation and makes the GunpodSingle particles
				 appear on screen when the ship dies.
	PARAMETERS:
		@See inherit doc.
	@RETURN: void
]]--
function GunpodSingle: onHit(phase, collide)
	--[[if self.health <= 0 then
		if phase == "ended" and self.alive then
			self:die()
		end
	end]]--
	--Nothing should happen here for the base class version of the Option/Bits/GunpodSingles.  Subclasses can change this.
end

--[[
	FUNCTION NAME: equipWeapon
	
	DESCRIPTION: Equips a primary weapon to the GunpodSingle.
	PARAMETERS:
		Weapon: A table that holds the arguments for a weapon
	@RETURN: void
]]--
function GunpodSingle: equipWeapon(sceneGroup, haterList, weaponType, ...)
	self.weapon = weaponType:new(sceneGroup, unpack(arg))
	self.weapon.targets = haterList
	self.weapon:setMuzzleLocation({ x = 0, y = -100 })
	self.weapon.owner = self
end

function GunpodSingle: update(x, y)
	self.sprite.x = x
	self.sprite.y = y
end