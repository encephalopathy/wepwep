require 'org.Object'
require "com.game.weapons.Weapon"
require "com.game.weapons.primary.SpreadshotWeapon"
require "com.game.weapons.primary.SingleshotWeapon"
require "com.game.weapons.primary.SineWaveWeapon"
require "com.game.weapons.primary.HomingShotWeapon"
require "com.game.weapons.primary.DoubleshotWeapon"
require "com.game.weapons.primary.BackshotWeapon"
require "com.game.passives.Player.ExtraStartingHealth"
require "com.game.passives.Player.HealthRegen"
require "com.game.weapons.secondary.Bomb"
require "com.game.weapons.secondary.FreezeMissile"
require "com.game.weapons.secondary.StandardMissile"

Shop = Object:subclass("Shop")

--[[
	NOTE: DOLLARZ are not in the game.
]]--
function Shop:init()
   self.Weapons = {}
   self.Weapons['com/resources/art/sprites/shop_splash_images/SingleShot.png'] = { item = Singleshot:new(scene, true, 25, 200, 0, 0), dollaz = 40 }
   self.Weapons['com/resources/art/sprites/shop_splash_images/SpreadShot.png'] = { item = Spreadshot:new(scene, true, 35, 200, 0, 0, nil, nil, nil, nil, nil, nil, 4, 15, 4, 15), dollaz = 500 }
   self.Weapons['com/resources/art/sprites/shop_splash_images/Sinewave.png'] = { item = SineWave:new(scene, true, 25, 200), dollaz = 50 }
   self.Weapons['com/resources/art/sprites/shop_splash_images/HomingShot.png'] = { item = Homingshot:new(scene, true, 35, 200), dollaz = 100 }
   self.Weapons['com/resources/art/sprites/shop_splash_images/DoubleShot.png'] = { item = Doubleshot:new(scene, true, 25, 200, 0, 0), dollaz = 70 }
   self.Weapons['com/resources/art/sprities/shop_splash_images/BackShot.png'] = { item = Backshot:new(scene, true), dollaz = 80 }
   
   self.permission = {}
   self.permission[1] = true
   self.permission[2] = false
   self.permission[3] = false
   self.permission[4] = false
   self.permission[5] = false
   self.permission[6] = false
   
   self:createSecondaryWeapons()
   
   self:createPassives()
   
   mainInventory.primaryWeapon = self.Weapons['com/resources/art/sprites/shop_splash_images/SingleShot.png'].item
end

function Shop:createSecondaryWeapons()
	 -- Keep second list for secondary weapons
   self.SecondaryWeapons = {}
   
   --Commented out because physics doesn't exist in the menus
   self.SecondaryWeapons["com/resources/art/sprites/bomb.png"] = { item = Singleshot:new(scene, true, 1, 50, "com/resources/art/sprites/bomb.png", Bomb), cost = 50 }
   self.SecondaryWeapons["com/resources/art/sprites/missile.png"] = { item = Singleshot:new(scene, true, 1, 50, "com/resources/art/sprites/missile.png", StandardMissile), cost = 70 }
   self.SecondaryWeapons["com/resources/art/sprites/missile.png"] = { item = Singleshot:new(scene, true, 1, 50, "com/resources/art/sprites/missile.png", FreezeMissile), cost = 100 }
   
end

-- Unlock a weapon to equip.
function Shop:unlock (weaponNumber)
   self.permission[weaponNumber] = true
end

-- Lock a weapon to equip.
function Shop:lock (weaponNumber)
   self.permission[weaponNumber] = false
end

function Shop:buyItem(itemName, slot) 
	if self.Weapons[itemName] ~= nil then
		self:buyPrimaryWeapon(itemName)
	elseif self.SecondaryWeapons[itemName] ~= nil then
		--self:buySecondaryWeapon(weaponName)
	else
		--self:buyPassive(passiveName)
	end
end

function Shop:buyPrimaryWeapon(weaponNumber, slot)
	if mainInventory.primaryWeapon ~= self.Weapons[weaponNumber].item then
		print('Equipping Weapon: ' .. weaponNumber)
		mainInventory.primaryWeapon = self.Weapons[weaponNumber].item
		mainInventory.dollaz = mainInventory.dollaz - self.Weapons[weaponNumber].dollaz
		return true
	else
		return false
	end
end

function Shop:buySecondaryWeapon(weaponName, slot)
	if not mainInventory:hasSecondaryWeapon(weaponName) then
		--mainInvetory.primaryWeapon = self.SecondaryWeapons[weaponName].item
		mainInventory.dollaz = mainInventory.dollaz - self.SecondaryWeapons[weaponName].dollaz
		return true
	else
		return false
	end
end

function Shop:buyPassive(passiveName, slot)
	if not mainInventory:hasPassive(passiveName) then
		--mainInvetory.primaryWeapon = self.Passives[passiveName].item
		mainInventory.dollaz = mainInventory.dollaz - self.Passives[passiveName].dollaz
		return true
	else
		return false
	end
end

function Shop:createPassives()
   self.Passives = {}
   self.Passives['ExtraStartingHealth'] = { item = ExtraStartingHealth:new(), cost = 100 }
   self.Passives['HealthRegen'] = { item = HealthRegen:new(), cost = 100 }
end