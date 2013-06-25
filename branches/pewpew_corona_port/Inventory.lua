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

Inventory = Object:subclass("Inventory")


function Inventory:init (scene)

   -- keep all the weapons in a master list
   self.Weapons = {}
   self.Weapons[1] = Singleshot:new(scene)
   self.Weapons[2] = Spreadshot:new(scene)
   self.Weapons[3] = SineWave:new(scene)
   self.Weapons[4] = HomingShot:new(scene)
   self.Weapons[5] = Doubleshot:new(scene) 
   --self.scene = scene
   
   self.dollaz = 1000
   self.equippedWeapon = 1
   self.equippedGameWeapon = nil
   
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
   self.SecondaryWeapons[1].ammo = 4
   self.SecondaryWeapons[2].ammo = 4
   self.SecondaryWeapons[3].ammo = 4
   
   self.euippedOnce = false
	
end

-- Do permissions check and change weapons
function Inventory:equip(player, sceneGroup)
   local weapon = nil
   
	if (self.permission[self.equippedWeapon] == true and
		self.Weapons[self.equippedWeapon] ~= nil) then

      weapon = self.Weapons[self.equippedWeapon]
	   weapon.owner = player
      self.player = player
      self.sceneGroup = sceneGroup
		weapon:load(40, sceneGroup)
   end
	player.weapon = weapon
	self.equippedGameWeapon = weapon
end

function Inventory:equipSecondaryWeapon(player, sceneGroup)
   local weapon = nil
   weapon = self.SecondaryWeapons[self.equippedSecondaryWeapon];
   weapon.sceneGroup = sceneGroup
   weapon.owner = player
   self.sceneGroup = sceneGroup
   self.equippedSecondaryGameWeapon = weapon
   player.secondaryWeapon = weapon
end

function Inventory:selectSecondaryWeapon(weaponNumber)
   self.equippedSecondaryWeapon = weaponNumber
end

function Inventory:checkBullets(haterList)
   self.equippedGameWeapon:checkBullets(haterList)
end

function Inventory:checkBombs(haterList)
   self.equippedSecondaryGameWeapon:checkBombs(haterList)
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
   self.SecondaryWeapons[1].ammo = numShots
   self.SecondaryWeapons[2].ammo = numShots
   self.SecondaryWeapons[3].ammo = numShots
end

-- add ammo to all of the weapons
function Inventory:addAmmo(numShots)
   self.SecondaryWeapons[1].ammo = self.SecondaryWeapons[1].ammo + numShots
   self.SecondaryWeapons[2].ammo = self.SecondaryWeapons[2].ammo + numShots
   self.SecondaryWeapons[3].ammo = self.SecondaryWeapons[3].ammo + numShots
end
