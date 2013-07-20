--[[
Main inventory class. Right now it just manages the weapons, but
could be expanded to keep track of other items
--]]
require("Object")
require("Weapon")
require("SecondaryWeapon")
require("SpreadshotWeapon")
require("SingleshotWeapon")
require("SineWaveWeapon")
require("HomingShotWeapon")
require("DoubleshotWeapon")
require("StandardBombSecondaryWeapon")
require("FreezeMissileSecondaryWeapon")
require("StandardMissileSecondaryWeapon")

Inventory = newclass("Inventory")


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
   self.SecondaryWeapons = {}
   self.SecondaryWeapons[1] = StandardBomb:new(scene)
   self.SecondaryWeapons[2] = FreezeMissile:new(scene)
   self.SecondaryWeapons[3] = StandardMissile:new(scene)
      
   -- Keep track of ammo for each
   self.SecondaryWeapons[1].ammoAmount = 4
   self.SecondaryWeapons[2].ammoAmount = 4
   self.SecondaryWeapons[3].ammoAmount = 4
   self.SecondaryWeapons[3].ammoAmount = 4
   
   self.euippedOnce = false
	
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

function Inventory:equipSecondaryWeapon(player, sceneGroup)
   local weapon = nil
   weapon = self.SecondaryWeapons[self.equippedSecondaryWeapon];
   weapon.owner = player
   self.equippedSecondaryGameWeapon = weapon
   player.secondaryWeapon = weapon
end

function Inventory:equipRig(player, sceneGroup)
	self:equipPrimaryWeapon(player, sceneGroup)
	self:equipSecondaryWeapon(player, sceneGroup)
end

function Inventory:selectSecondaryWeapon(weaponNumber)
   self.equippedSecondaryWeapon = weaponNumber
end

function Inventory:unequip(player)
	player.weapon.owner = nil
	player.weapon:unload()
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
   self.SecondaryWeapons[1].ammoAmount = numShots
   self.SecondaryWeapons[2].ammoAmount = numShots
   self.SecondaryWeapons[3].ammoAmount = numShots
end

-- add ammo to all of the weapons
function Inventory:addAmmo(numShots)
   self.SecondaryWeapons[1].ammoAmount = self.SecondaryWeapons[1].ammoAmountAmmount + numShots
   self.SecondaryWeapons[2].ammoAmount = self.SecondaryWeapons[2].ammoAmountAmmount + numShots
   self.SecondaryWeapons[3].ammoAmount = self.SecondaryWeapons[3].ammoAmountAmmount + numShots
end
