--[[
Main inventory class. Right now it just manages the weapons, but
could be expanded to keep track of other items
--]]
require "org.Object"
require "com.game.weapons.Weapon"
require "com.game.weapons.secondary.SecondaryWeapon"
require "com.game.weapons.primary.SpreadshotWeapon"
require "com.game.weapons.primary.SingleshotWeapon"
require "com.game.weapons.primary.SineWaveWeapon"
require "com.game.weapons.primary.HomingShotWeapon"
require "com.game.weapons.primary.DoubleshotWeapon"
require "com.game.weapons.secondary.Bomb"
require "com.game.weapons.secondary.FreezeMissile"
require "com.game.weapons.secondary.StandardMissile"

Inventory = Object:subclass("Inventory")

local numOfSlots = 5

function Inventory:init (scene)

   -- keep all the weapons in a master list
   self.Weapons = {}
   self.Weapons[1] = Singleshot:new(scene, 25, -200)
   self.Weapons[2] = Spreadshot:new(scene)
   self.Weapons[3] = SineWave:new(scene)
   self.Weapons[4] = HomingShot:new(scene)
   self.Weapons[5] = Doubleshot:new(scene, 25, -200, 7) 
   --self.scene = scene
   
   self.dollaz = 5000
   self.equippedWeapon = 1
   
   -- permissions list
   self.permission = {}
   self.permission[1] = true;
   self.permission[2] = false;
   self.permission[3] = false;
   self.permission[4] = false;
   self.permission[5] = false;
   
   self.equipped = {}
   
   -- Keep second list for secondary weapons
   self.equippedSecondaryWeapon = 1
   self.equippedSecondaryWeapons = {}
   self.SecondaryWeapons = {}
   
   --Commented out because physics doesn't exist in the menus
   self.SecondaryWeapons['Bomb'] = Singleshot:new(scene, true, 1, 50, "com/resources/art/sprites/bomb.png", Bomb)
   self.SecondaryWeapons['Missile'] = Singleshot:new(scene, true, 1, 50, "com/resources/art/sprites/missile.png", StandardMissile)
   self.SecondaryWeapons['FreeMissile'] = Singleshot:new(scene, true, 1, 50, "com/resources/art/sprites/missile.png", FreezeMissile)
   --self.SecondaryWeapons[2] = FreezeMissile:new(scene)
   --self.SecondaryWeapons[3] = StandardMissile:new(scene)
      
   -- Keep track of ammo for each
	self:setDefaultAmmoAmount()
end

function Inventory:setDefaultAmmoAmount()
	self.SecondaryWeapons['Bomb'].ammoAmount = 4
	self.SecondaryWeapons['Missile'].ammoAmount = 4
	self.SecondaryWeapons['FreeMissile'].ammoAmount = 4
end

-- Do permissions check and change weapons, will rename to equipRig
function Inventory:equipPrimaryWeapon(player, sceneGroup)
   local weapon = nil
   
	if (self.permission[self.equippedWeapon] == true and
		self.Weapons[self.equippedWeapon] ~= nil) then
		weapon = self.Weapons[self.equippedWeapon]
		weapon.owner = player
		--self.player = player
		
		--Choose the spawn location based on the ship later
		weapon:load(40, sceneGroup, { 0, -100 }, true)
   end
	player.weapon = weapon
end

function Inventory:equipRig(player, sceneGroup)
	self:equipPrimaryWeapon(player, sceneGroup)
	self:equipSecondaryWeapon(player, sceneGroup)
end

function Inventory:selectSecondaryWeapon(weaponNumber)
   self.equippedSecondaryWeapon = weaponNumber
end

function Inventory:addSecondaryWeapon(weaponNumber)
	if self.SecondaryWeapons[weaponNumber] ~= nil then
		self.equippedSecondaryWeapon[weaponNumber] = weaponNumber
	end
end

function Inventory:removeSecondaryWeapon(weaponNumber)
	self.equippedSecondaryWeapon[weaponNumber] = nil
end

function Inventory:unequip(player)
	player.weapon.owner = nil
	player.weapon:unload()
end

function Inventory:equipSecondaryWeaponsInGame(player)
	player.secondaryWeapon = self.SecondaryWeapons['Bomb']
end


function Inventory:equipOneWeapon(weaponNumber)
   if (self.permission[weaponNumber]) then
      self.equippedWeapon = weaponNumber
      --self:equip(self.player, self.sceneGroup)
   end
end

-- Unlock a weapon
function Inventory:unlock (weaponNumber)
   self.permission[weaponNumber] = true
end

-- Lock a weapon
function Inventory:lock (weaponNumber)
   self.permission[weaponNumber] = false
end

-- set ammo of all shots to the same number
function Inventory:setAmmo(numShots)
   self.SecondaryWeapons['Bomb'].ammoAmount = numShots
   self.SecondaryWeapons['Missile'].ammoAmount = numShots
   self.SecondaryWeapons['FreezeMissile'].ammoAmount = numShots
end

-- add ammo to all of the weapons
function Inventory:addAmmo(numShots)
   self.SecondaryWeapons['Bomb'].ammoAmount = self.SecondaryWeapons['Bomb'].ammoAmountAmmount + numShots
   self.SecondaryWeapons['Missile'].ammoAmount = self.SecondaryWeapons['Missile'].ammoAmountAmmount + numShots
   self.SecondaryWeapons['FreezeMissile'].ammoAmount = self.SecondaryWeapons['FreezeMissile'].ammoAmountAmmount + numShots
end
