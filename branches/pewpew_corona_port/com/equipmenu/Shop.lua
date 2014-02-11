require 'org.Object'
require 'com.Utility'
require "com.game.weapons.Weapon"
require "com.game.weapons.primary.SpreadshotWeapon"
require "com.game.weapons.primary.SingleshotWeapon"
require "com.game.weapons.primary.SineWaveWeapon"
require "com.game.weapons.primary.HomingShotWeapon"
require "com.game.weapons.primary.DoubleshotWeapon"
require "com.game.weapons.primary.BackshotWeapon"
require "com.game.passives.Player.ExtraStartingHealth"
require "com.game.passives.Player.HealthRegen"
require "com.game.passives.Player.GunpodCollection"
require "com.game.passives.Player.NRGRegen"
require "com.game.passives.Player.HealthUponScrapPickUp"
require "com.game.weapons.secondary.GrenadeLauncher"
require "com.game.weapons.secondary.Bomb"
require "com.game.weapons.secondary.FreezeMissile"
require "com.game.weapons.secondary.StandardMissile"

Shop = Object:subclass("Shop")

--[[
	NOTE: DOLLARZ are not in the game.
]]--
function Shop:init()
   self.Weapons = {}
   
   local SingleshotValues = { item = Singleshot:new(scene, true, 15, 200, 0, 0), dollaz = 40, weight = 5}
   local SpreadshotValues = { item = Spreadshot:new(scene, true, 15, 200, 0, 0, nil, nil, nil, nil, nil, nil, 4, 15, 4, 15), dollaz = 500, weight = 5 }
   local SineWaveValues = { item = SineWave:new(scene, true, 25, 200), dollaz = 50, weight = 5 }
   local HomingshotValues = { item = Homingshot:new(scene, true, 35, 200), dollaz = 100, weight = 5}
   local DoubleshotValues = { item = Doubleshot:new(scene, true, 15, 200, 0, 0), dollaz = 70, weight = 5 }
   local BackshotValues = { item = Backshot:new(scene, true), dollaz = 80, weight = 5}
   
   self.Weapons['com/resources/art/sprites/shop_splash_images/SingleShot.png'] = SingleshotValues --black
   self.Weapons['Singleshot'] = SingleshotValues
   self.Weapons['com/resources/art/sprites/shop_splash_images/SpreadShot.png'] = SpreadshotValues --red
   self.Weapons['Spreadshot'] = SpreadshotValues
   self.Weapons['com/resources/art/sprites/shop_splash_images/Sinewave.png'] = SineWaveValues --green
   self.Weapons['SineWave'] = SineWaveValues
   self.Weapons['com/resources/art/sprites/shop_splash_images/HomingShot.png'] = HomingshotValues --orange
   self.Weapons['Homingshot'] = HomingshotValues
   self.Weapons['com/resources/art/sprites/shop_splash_images/DoubleShot.png'] = DoubleshotValues --black split
   self.Weapons['Doubleshot'] = DoubleshotValues
   self.Weapons['com/resources/art/sprities/shop_splash_images/BackShot.png'] = BackshotValues --purple
   self.Weapons['Backshot'] = BackshotValues
   
   -- for key,value in pairs(self.Weapons) do
		-- print("key: "..key.." value: "..tostring(value))
   -- end
   
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
   
   local GrenadeLauncherValues = { item = GrenadeLauncher:new(scene, true, 1, 200), dollaz = 50, weight = 2}
   local MissileValues = { item = Singleshot:new(scene, true, 1, 200, 0, 0, 'com/resources/art/sprites/missile.png', 0, StandardMissile), dollaz = 70, weight = 1}
   local FreezeMissileValues = { item = Singleshot:new(scene, true, 1, 200, 0, 0, "com/resources/art/sprites/missile.png", 0, FreezeMissile), dollaz = 100, weight = 3}
   
   --Commented out because physics doesn't exist in the menus
   self.SecondaryWeapons['com/resources/art/sprites/bomb.png'] = GrenadeLauncherValues
   self.SecondaryWeapons['GrenadeLauncher'] = GrenadeLauncherValues
   self.SecondaryWeapons['com/resources/art/sprites/missile.png'] = MissileValues
   self.SecondaryWeapons['Missile'] = MissileValues
   self.SecondaryWeapons['com/resources/art/sprites/shop_splash_images/FreezeMissile.png'] = FreezeMissileValues
   self.SecondaryWeapons['FreezeMissile'] = FreezeMissileValues
   
   --Sets the max ammo ammount that the secondary weapons can use per game
   self.SecondaryWeapons['com/resources/art/sprites/bomb.png'].item:setAmmoAmount(3)
   self.SecondaryWeapons['com/resources/art/sprites/missile.png'].item:setAmmoAmount(10)
   self.SecondaryWeapons['com/resources/art/sprites/shop_splash_images/FreezeMissile.png'].item:setAmmoAmount(10)
   
end

function Shop:createPassives()
   self.Passives = {}
   self.Passives['com/resources/art/sprites/heart.png'] = { item = ExtraStartingHealth:new(), dollaz = 100 , weight = 1} --heart
   self.Passives['com/resources/art/sprites/shop_splash_images/HealthRegen.png'] = { item = HealthRegen:new(), dollaz = 100 ,weight = 1} --red circle
   self.Passives['com/resources/art/sprites/shop_splash_images/Gunpods.png'] = { item = GunpodCollection:new(GunpodSingle, "com/resources/art/sprites/rocket_01.png", 80, 0, Singleshot, true, 1, 200), dollaz = 100 ,weight = 3} --gunpod
   self.Passives['com/resources/art/sprites/shop_splash_images/NRGRegen.jpg'] = { item = NRGRegen:new(), dollaz = 100 ,weight = 2} --battery
   self.Passives['com/resources/art/sprites/shop_splash_images/HealthPickUp.png'] = { item = HealthUponScrapPickUp:new(), dollaz = 100, weight = 2} --health pick up plus
end

-- Unlock a weapon to equip.
function Shop:unlock (weaponName)
   self.permission[weaponName] = true
end

-- Lock a weapon to equip.
function Shop:lock (weaponName)
   self.permission[weaponName] = false
end

function Shop:buyItem(itemName, slot)
	assert(type(itemName) == 'string', 'The parameter itemName must be a string')
	assert(type(slot) == 'number', 'Did not pass a slot number to buyItem')
	
	if self.Weapons[itemName] ~= nil then
		self:buyPrimaryWeapon(itemName)
	elseif self.SecondaryWeapons[itemName] ~= nil then
		self:buySecondaryWeapon(itemName, slot)
	elseif self.Passives[itemName] ~= nil then
		self:buyPassive(itemName, slot)
	else
		print('WARNING: The item: ' .. itemName .. ' is not a passive or a secondary weapon.')
	end
end

function Shop:buyPrimaryWeapon(weaponName, slot)
	print("equipping: "..weaponName.." weight to be applied: "..self.Weapons[weaponName].weight)
	local adjustedWeight = mainInventory.weightAvailable + self.Weapons[tostring(mainInventory.primaryWeapon)].weight
	local temp = adjustedWeight - self.Weapons[weaponName].weight
	if(temp>=0)then 
		--print("weight left over; allow equip")
		local newDollazAmount = mainInventory.dollaz - self.Weapons[weaponName].dollaz
		if mainInventory.primaryWeapon ~= self.Weapons[weaponName].item and newDollazAmount > 0 then 
			mainInventory.weightAvailable = mainInventory.weightAvailable + self.Weapons[tostring(mainInventory.primaryWeapon)].weight 
			--print('Equipping Weapon: ' .. weaponName)
			mainInventory.primaryWeapon = self.Weapons[weaponName].item
			mainInventory.dollaz = newDollazAmount
			mainInventory.weightAvailable = mainInventory.weightAvailable - self.Weapons[weaponName].weight 
			return true
		else
			return false
		end
	end
end

--Buy weapon also equips
function Shop:buySecondaryWeapon(weaponName, slot)
	print("equipping: "..weaponName.." weight to be applied: "..self.SecondaryWeapons[weaponName].weight)
	local temp = mainInventory.weightAvailable - self.SecondaryWeapons[weaponName].weight
	if(temp>=0)then
		--print("weight left over; allow equip")
		local newDollazAmount = mainInventory.dollaz - self.SecondaryWeapons[weaponName].dollaz
		if not mainInventory:hasSecondaryWeapon(weaponName) and newDollazAmount > 0 then
			--print('equipping secondary weapon: ' .. weaponName)
			
			if(mainInventory.slots[slot] ~= nil) then
				self:refund(slot)
			end
			mainInventory:addSecondaryWeapon(slot, weaponName, self.SecondaryWeapons[weaponName].item)
			mainInventory.dollaz = mainInventory.dollaz - self.SecondaryWeapons[weaponName].dollaz
			mainInventory.weightAvailable = mainInventory.weightAvailable - self.SecondaryWeapons[weaponName].weight
			--print("mainInventory.weightAvailable: "..mainInventory.weightAvailable)
			return true
		else
			return false
		end
	else
		print("Your ship can't carry that much weight!")
	end
	
end

function Shop:buyPassive(passiveName, slot)
	print("equipping: "..passiveName.." weight to be applied: "..self.Passives[passiveName].weight)
	local temp = mainInventory.weightAvailable - self.Passives[passiveName].weight
	if(temp>=0) then
		--print("weight left over; allow equip")
		local newDollazAmount = mainInventory.dollaz - self.Passives[passiveName].dollaz
		if not mainInventory:hasPassive(passiveName) and newDollazAmount > 0 then
			if(mainInventory.slots[slot] ~= nil) then
				self:refund(slot)
			end
			--print('equipping passive at slot ' .. slot .. ': ' ..passiveName)
			mainInventory:addPassive(slot, passiveName, self.Passives[passiveName].item)
			mainInventory.dollaz = mainInventory.dollaz - self.Passives[passiveName].dollaz
			--print("mainInventory.weightAvailable: "..mainInventory.weightAvailable)
			mainInventory.weightAvailable = mainInventory.weightAvailable - self.Passives[passiveName].weight
			return true
		else
			return false
		end
	else
		print("Your ship can't carry that much weight!")
	end
	
end

function Shop:refund(slot)
	--print(tostring(mainInventory.slots[slot]))
	local oldName = mainInventory.slots[slot]
	if self.SecondaryWeapons[oldName] ~= nil then
		mainInventory.weightAvailable = mainInventory.weightAvailable + self.SecondaryWeapons[tostring(oldName)].weight
		--print("Secondary Refunded; new weight: "..mainInventory.weightAvailable)
	elseif self.Passives[oldName] ~= nil then
		mainInventory.weightAvailable = mainInventory.weightAvailable + self.Passives[tostring(oldName)].weight
		--print("Passives Refunded; new weight: "..mainInventory.weightAvailable)
	end

end