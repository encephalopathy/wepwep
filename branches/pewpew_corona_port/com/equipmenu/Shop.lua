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
require "com.game.passives.Player.ShieldCollection"
require "com.game.passives.Player.PassiveShield"
require "com.game.weapons.secondary.ActivatableShield"

--Corona specific library that handles reading and writing json.
local json = require('json')

Shop = Object:subclass("Shop")

local shop
local scene
--[[
	NOTE: DOLLARZ are not in the game.
]]--
function Shop:init(scene)
	print('CREATING SHOP')
   Shop.static.scene = scene
   
   self.Weapons = {}
   
   local SingleshotValues = { item = Singleshot:new(scene, true, 5, 900, 0, 0, "com/resources/art/sprites/bullet_02.png"), dollaz = 40, weight = 5}
   local SpreadshotValues = { item = Spreadshot:new(scene, true, 15, 200, 0, 0, "com/resources/art/sprites/bullet_06.png", 20, nil, nil, nil, nil, 5, 45, 1, 15), dollaz = 5, weight = 2 }
   local SineWaveValues = { item = SineWave:new(nil, true, 25, 200), dollaz = 50, weight = 5 , description = ""}
   local HomingshotValues = { item = Homingshot:new(nil, true, 35, 200), dollaz = 100, weight = 5, description = ""}
   local DoubleshotValues = { item = Doubleshot:new(nil, true, 15, 200, 0, 0, "com/resources/art/sprites/bullet_02.png"), dollaz = 70, weight = 5, description = "" }
   local BackshotValues = { item = Backshot:new(nil, true, 15, 200, "com/resources/art/sprites/bullet_02.png"), dollaz = 80, weight = 5, description = ""}
   local SineWaveValues = { item = SineWave:new(scene, true, 25, 200), dollaz = 50, weight = 5 }
   local HomingshotValues = { item = Homingshot:new(scene, true, 35, 200), dollaz = 100, weight = 5}
   local DoubleshotValues = { item = Doubleshot:new(scene, true, 15, 200, 0, 0, "com/resources/art/sprites/bullet_02.png"), dollaz = 70, weight = 5 }
   local BackshotValues = { item = Backshot:new(scene, true, 15, 200, "com/resources/art/sprites/bullet_02.png"), dollaz = 80, weight = 5}
   
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
   self.Weapons['com/resources/art/sprites/shop_splash_images/BackShot.png'] = BackshotValues --purple
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
   ]]--
   --print('scene: ' .. tostring(scene))
   scene:addEventListener("LoadSpriteData", self)
   Runtime:addEventListener("GetToolTipData", self)
   
end

local function parseConstructor(data)
	--for key, value in pairs(data) do
	--	print('key: ' .. tostring(key))
	--	print('value: ' .. tostring(value))
	--end
	if #data == 0 then return end
	for i = 1, #data, 1 do
		
		--path:(%w+%p*[%w+%p*]*)
		if type(data[i]) == 'string' then
			local startIndex, endIndex = string.find(data[i], ":")
			--print('startIndex: ' .. tostring(startIndex))
			--print('endIndex: ' .. tostring(endIndex))
			if startIndex then
				--print('WHAT IS THIS PATH: ' .. tostring(startIndex))
				--print('startIndex is: ' .. startIndex)
				--print('path is: ' .. string.sub(data[i], startIndex))
				data[i] = require(data[i]:sub(startIndex + 1))
			elseif data[i] == 'nil' then
				data[i] = nil
			end
		end
	end
	return unpack(data)
end

function Shop:parseItemJSONCollection(jsonData)
	local data = {}
	local name
	local imgData = {}
	
	for key, itemField in pairs(jsonData) do	
		
		
		--print('key: ' .. tostring(key))
		name = tostring(key) 
		secondKey = tostring(itemField.splash_image)
		local newItem = {}
		data[name] = newItem
		data[secondKey] = newItem
		
		if imgData[secondKey] == nil then
			imgData[secondKey] = secondKey
		end
		--print('Parsed: ' .. tostring(name))
		--print('secondaryKey: ' .. tostring(secondKey))
		--print('itemField.constructor: ' .. tostring(itemField.constructorFields))
		
		newItem.item = require(itemField.classPath):new(parseConstructor(itemField.constructorFields))
		newItem.description = itemField.description
		newItem.title = itemField.title
		newItem.weight = tonumber(itemField.weight)
		newItem.dollaz = tonumber(itemField.dollaz)
		
		data[name] = newItem
		data[name] = data[secondKey]
	end
	return data, imgData
end

function Shop:LoadSpriteData(event)
	print('LOADING SPRITE DATA')
	if event.target == nil then error('Unable to load sprite data') end
	local filename = event.target.fileToLoad
	
	local filePath = system.pathForFile( filename, system.ResourceDirectory )
	local file = io.open(filePath, "r")
	if file == nil then error('Incorrect file to load for items in shop: ' .. tostring(filename)) end
	print('filePath: ' .. tostring(filePath))
	print('file: ' .. tostring(file))
	local contents = file:read("*a")
	io.close(file)
	local shopData = json.decode(contents)
	if shopData == nil then
		error('Unable to the load the appropiate file that stores all the data pertaining to shop')
	end
	
	--TODO: Load data that determines which carousels are still selected or not.
	
	local primaryWeapons = shopData['PrimaryWeapons']
	
	local secondaryWeapons = shopData['SecondaryWeapons']
	
	local passives = shopData['Passives']
	
	print('Loading Primary Weapons')
	self.Weapons, primarySpriteData = self:parseItemJSONCollection(primaryWeapons)
	print('Loading Secondary Weapons')
	self.SecondaryWeapons, secondarySpriteData = self:parseItemJSONCollection(secondaryWeapons)
	print('Loading Passives')
	self.Passives, passiveSpriteData = self:parseItemJSONCollection(passives)
	
	
	local secondarySplashImages = {}
	
	for key, value in pairs(secondarySplashImages) do
		secondarySplashImages[key] = secondarySpriteData[key]
	end
	
	for key, value in pairs(passiveSpriteData) do
		secondarySplashImages[key] = passiveSpriteData[key]
	end
	
	--[[print('Images in Shop: ')
	print('RECIEVED PRIMARY SPLASH IMAGES: ')
	for key, value in pairs(primarySpriteData) do
		print('Key: ' .. tostring(key))
		print('Value: ' .. tostring(value))
	end
	
	print('SECONDARY PRIMARY SPLASH IMAGES')
	for key, value in pairs(secondarySplashImages) do
		print('Key: ' .. tostring(key))
		print('Value: ' .. tostring(value))
	end
	]]--
	
	Shop.static.scene:dispatchEvent({name = "OnLoadSpriteDataComplete", target = {primarySplashImages = primarySpriteData, 
																				  secondarySplashImages = secondarySplashImages}
																				  })
	--TODO: Load the appropiate weapon, passive, and secondary item data from a file so we do not have to hard code it in code. - Brent Arata
end

function Shop:createSecondaryWeapons()
	-- Keep second list for secondary weapons
   self.SecondaryWeapons = {}
   
   local GrenadeLauncherValues = { item = GrenadeLauncher:new(nil, true, 1, 200), dollaz = 50, weight = 2, description = ""}
   local MissileValues = { item = Singleshot:new(nil, true, 1, 200, 0, 0, 'com/resources/art/sprites/missile.png', 0, StandardMissile), dollaz = 70, weight = 1, description = ""}
   local FreezeMissileValues = { item = Singleshot:new(nil, true, 1, 200, 0, 0, "com/resources/art/sprites/missile.png", 0, FreezeMissile), dollaz = 100, weight = 3, description = ""}
   --local ActivatableShieldValues = { item = ShieldCollection:new(true, "com/resources/art/sprites/shop_splash_images/ActivatableShield.png", ActivatableShield, 10), dollaz = 10, weight = 1}
   
   --Commented out because physics doesn't exist in the menus
   self.SecondaryWeapons['com/resources/art/sprites/bomb.png'] = GrenadeLauncherValues
   self.SecondaryWeapons['GrenadeLauncher'] = GrenadeLauncherValues
   self.SecondaryWeapons['com/resources/art/sprites/missile.png'] = MissileValues
   self.SecondaryWeapons['Missile'] = MissileValues
   self.SecondaryWeapons['com/resources/art/sprites/shop_splash_images/FreezeMissile.png'] = FreezeMissileValues
   self.SecondaryWeapons['FreezeMissile'] = FreezeMissileValues
   --[[self.SecondaryWeapons['com/resources/art/sprites/shop_splash_images/ActivatableShield.png'] = ActivatableShieldValues
   self.SecondaryWeapons['ActivatableShield'] = ActivatableShieldValues]]--
   
   --Sets the max ammo ammount that the secondary weapons can use per game
   self.SecondaryWeapons['com/resources/art/sprites/bomb.png'].item:setAmmoAmount(3)
   self.SecondaryWeapons['com/resources/art/sprites/missile.png'].item:setAmmoAmount(10)
   self.SecondaryWeapons['com/resources/art/sprites/shop_splash_images/FreezeMissile.png'].item:setAmmoAmount(10)
   --Activatable Shield health/ammo amount set in initialization
   
end

function Shop:createPassives()
   self.Passives = {}
   self.Passives['com/resources/art/sprites/heart.png'] = { item = ExtraStartingHealth:new(), dollaz = 10 , weight = 1} --heart
   self.Passives['com/resources/art/sprites/shop_splash_images/HealthRegen.png'] = { item = HealthRegen:new(), dollaz = 100 ,weight = 1, description = ""} --red circle
   self.Passives['com/resources/art/sprites/shop_splash_images/Gunpods.png'] = { item = GunpodCollection:new(false, GunpodSingle, "com/resources/art/sprites/rocket_01.png", 80, 0, Singleshot, true, 1, 200), dollaz = 100 ,weight = 3, description = ""} --gunpod
   self.Passives['com/resources/art/sprites/shop_splash_images/NRGRegen.png'] = { item = NRGRegen:new(), dollaz = 100 ,weight = 2} --battery
   self.Passives['com/resources/art/sprites/shop_splash_images/HealthPickUp.png'] = { item = HealthUponScrapPickUp:new(), dollaz = 100, weight = 2, description = ""} --health pick up plus
   self.Passives['com/resources/art/sprites/shop_splash_images/ActivatableShield.png'] = { item = ShieldCollection:new(true, "com/resources/art/sprites/bullet_03.png", ActivatableShield, 10), dollaz = 10, weight = 1 } --shield you can turn on and off
   self.Passives['com/resources/art/sprites/shop_splash_images/PassiveShield.png'] = { item = ShieldCollection:new(false, "com/resources/art/sprites/bullet_03.png", PassiveShield, 20), dollaz = 20, weight = 1 }  --shield that starts out on and lasts until it runs out of health
   
end


function Shop:GetToolTipData(event)
	print('GETTING TOOLTIP DATA')
	local contentType = event.target.itemType
	local weaponKey = event.target.item
	local item
	
	if contentType then
		if contentType == 'Primary' then
			item = self.Weapons[weaponKey]
		elseif contentType == 'Secondary' then
			item = self.SecondaryWeapons[weaponKey]
		elseif contentType == 'Passive' then
			item = self.Passives[weaponKey]
		end
	end
	
	Shop.static.scene:dispatchEvent({name = "DisplayToolTip", target = {description = item.description, 
	title = item.title, cost = item.dollaz, weight = item.weight}})
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

function Shop:buyItem(event)
	local itemName = event.target.itemName
	local slot = event.target.slot
	
	
	assert(type(itemName) == 'string', 'The parameter itemName must be a string')
	assert(type(slot) == 'number', 'Did not pass a slot number to buyItem')
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
	print("equipping: ".. sassweaponName .." weight to be applied: "..self.Weapons[weaponName].weight)
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