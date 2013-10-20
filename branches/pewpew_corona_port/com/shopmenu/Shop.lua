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
   self.Weapons[1] = Singleshot:new(scene, true, 25, -200)
   self.Weapons[2] = Spreadshot:new(scene, true, 35, -200, nil, nil, nil, nil, nil, 4, 15, 4, 15)
   self.Weapons[3] = SineWave:new(scene, true, 40, -200)
   self.Weapons[4] = Homingshot:new(scene, true)
   self.Weapons[5] = Doubleshot:new(scene, true, 25, -200, 7)
   self.Weapons[6] = Backshot:new(scene, true)
   
   self.permission = {}
   self.permission[1] = true
   self.permission[2] = false
   self.permission[3] = false
   self.permission[4] = false
   self.permission[5] = false
   self.permission[6] = false
   
   self:createSecondaryWeapons()
   
   self:createPassives()
end

function Shop:createSecondaryWeapons()
	 -- Keep second list for secondary weapons
   self.SecondaryWeapons = {}
   
   --Commented out because physics doesn't exist in the menus
   self.SecondaryWeapons['Bomb'] = Singleshot:new(scene, true, 1, 50, "com/resources/art/sprites/bomb.png", Bomb)
   self.SecondaryWeapons['Missile'] = Singleshot:new(scene, true, 1, 50, "com/resources/art/sprites/missile.png", StandardMissile)
   self.SecondaryWeapons['FrezeMissile'] = Singleshot:new(scene, true, 1, 50, "com/resources/art/sprites/missile.png", FreezeMissile)
end

-- Unlock a weapon to equip.
function Shop:unlock (weaponNumber)
   self.permission[weaponNumber] = true
end

-- Lock a weapon to equip.
function Shop:lock (weaponNumber)
   self.permission[weaponNumber] = false
end

function Shop:createPassives()
   self.Passives = {}
   self.Passives['ExtraStartingHealth'] = ExtraStartingHealth:new()
   self.Passives['HealthRegen'] = HealthRegen:new()
end