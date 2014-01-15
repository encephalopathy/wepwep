--[[
Main inventory class. Right now it just manages the weapons, but
could be expanded to keep track of other items
--]]
require "org.Object"
require "com.managers.AIDirector"
require "com.game.weapons.Weapon"
require "com.game.weapons.primary.SpreadshotWeapon"
require "com.game.weapons.primary.SingleshotWeapon"
require "com.game.weapons.primary.SineWaveWeapon"
require "com.game.weapons.primary.HomingshotWeapon"
require "com.game.weapons.primary.DoubleshotWeapon"
require "com.game.weapons.primary.BackshotWeapon"
require "com.game.passives.Player.ExtraStartingHealth"
require "com.game.passives.Player.HealthRegen"
require "com.game.weapons.secondary.Bomb"
require "com.game.weapons.secondary.FreezeMissile"
require "com.game.weapons.secondary.StandardMissile"

Inventory = Object:subclass("Inventory")

--Should be based on what ship it is later.
local NUMBER_OF_EQUIP_SLOTS = 5

function Inventory:init (scene)
   -- keep all the weapons in a master list
   self.dollaz = 5000
   self.primaryWeapon = 1
   self.numOfEquipSlotsAvailable = NUMBER_OF_EQUIP_SLOTS
   -- permissions list
   
   self.slots = {}
   
   self.secondaryWeapons = {}
   
   self.passives = {}
end

---------------------------------------------------------------------------------

--[[
****************************************************************************************************************************

	Equips primary weapon, secondary weapons, and passives to the player's ship in game.  Unequips these items as well
	when the player leaves.  These functions can only should be touched in game and not in the shop menu.
	
****************************************************************************************************************************
]]--


--Equip all secondary weapons and passives to the player when the player starts the game.
function Inventory:equipRig(player, sceneGroup)
	self:equipPrimaryWeapon(player, sceneGroup)
	self:equipSecondaryItems(player, sceneGroup)
end

--Equips secondary weapons and passives in game.
function Inventory:equipSecondaryItems(player, sceneGroup)	
	for weaponName, secondaryWeapon in pairs(self.secondaryWeapons) do
		secondaryWeapon.sceneGroup = sceneGroup
		--print('Equipping secondary weapon in game: ' .. weaponName)
		player.secondaryWeapons[weaponName] = secondaryWeapon
		player.secondaryWeapons[weaponName].targets = AIDirector.haterList
		secondaryWeapon.owner = player
		secondaryWeapon:setMuzzleLocation({ x = 0, y = -100 })
	end
	
	--print('Does self.passives EXIST?: ' .. tostring(self.passives))
	for passiveName, passive in pairs(self.passives) do
		--print('Equipping passive in game: ' .. passiveName .. ' object: ' .. tostring(passive))
		passive:setOwner(player, sceneGroup)
		table.insert(player.defensePassives, passive)
	end
end

--Unequips the secondary weapons, passives, and primary weapons from the player's ship in game.
function Inventory:unequip(player)
	--Uninitializes player weapon.
	player.weapon.owner = nil
	player.weapon = nil

	--Unequips the passives from the player.
	for passiveName, passive in pairs(player.defensePassives) do
		print('removing passive: ' .. tostring(i))
		passive:clear()
		passive = nil
		player.defensePassives[passiveName] = nil
	end
	
	--Unequips the secondary weapons from the player.
	for weaponName, weapon in pairs(player.secondaryWeapons) do
		weapon.sceneGroup = nil
		weapon.owner = nil
		weapon.targets = nil
		player.secondaryWeapons[weaponName] = nil
		weapon.ammoAmount = weapon.maxAmmoAmount
	end
end


-------------------------------------------------------------------------------------------------------------------------

--[[
****************************************************************************************************************************
	
	Equips the primary weapons, secondary weapons, and passives for the player in the Shop Menu.  These functions
	should only be called in the Shop Menu.
	
****************************************************************************************************************************
]]--

-- Do permissions check and change weapons, will rename to equipRig.
function Inventory:equipPrimaryWeapon(player, sceneGroup)
	assert(self.primaryWeapon ~= nil, 'Equipped a nil weapon in Inventory:equipPrimaryWeapon')
    player.weapon = self.primaryWeapon
    player.weapon.sceneGroup = sceneGroup
	player.weapon.targets = AIDirector.haterList
	player.weapon:setMuzzleLocation({ x = 0, y = -100 })
	player.weapon.owner = player
end

-- Adds a secondary weapon to the equipment slots.
function Inventory:addSecondaryWeapon(slot, weaponName, weaponObject)
	if self.secondaryWeapons[weaponName] == nil and self.numOfEquipSlotsAvailable > 0 then
		local oldWeaponName = self.slots[slot]
		self.slots[slot] = weaponName
		
		--print('Adding secondary weapon in Inventory at slot ' .. slot .. ': ' .. weaponName)
		
		self.secondaryWeapons[weaponName] = weaponObject
		
		if oldWeaponName == nil then
			--print('Slot taken: ' .. slot)
			
			self.numOfEquipSlotsAvailable = self.numOfEquipSlotsAvailable + 1
		else
			self:removeItem(slot, oldWeaponName)
		end
	end
end

function Inventory:hasSecondaryWeapon(weaponName)
	return self.secondaryWeapons[weaponName] ~= nil
end

function Inventory:hasPassive(passiveName)
	return self.passives[passiveName] ~= nil
end

-- Removes a secondary weapon from the equipment slots.  If the secondary weapon is already equipped.  Double the shots that can be fired.
function Inventory:removeSecondaryWeapon(slot, weaponName)
	if self.secondaryWeapons[weaponName] ~= nil then
		self.secondaryWeapons[weaponName] = nil
		self.numOfEquipSlotsAvailable = self.numOfEquipSlotsAvailable - 1
	else
		self.secondaryWeapons[weaponName].ammoAmount = weaponObject.ammoAmount
	end
end

-- Add passive to the equipment slots.
function Inventory:addPassive(slot, passiveName, passiveObject)
	if self.numOfEquipSlotsAvailable > 0 then
		local oldPassiveName = self.slots[slot]
		self.slots[slot] = passiveName
		
		--print('Adding passive object: ' .. tostring(passiveObject))
		
		self.passives[passiveName] = passiveObject
		if oldPassiveName == nil then
			--print('Slot taken: ' .. slot)
			self.numOfEquipSlotsAvailable = self.numOfEquipSlotsAvailable - 1
		else
			self:removeItem(slot, oldPassiveName)
		end
	end
end

-- Remove a passive to the equipment slots.
function Inventory:removeItem(slot, itemName)
	if self.passives[itemName] ~= nil then
		--print('Removing passive in Inventory: ' .. itemName)
		self.passives[itemName] = nil
	elseif self.secondaryWeapons[itemName] ~= nil then
		--print('Removing secondary weapon in Inventory: ' .. itemName)
		self.secondaryWeapons[itemName] = nil
	end
	self.slots[itemName] = nil
	self.numOfEquipSlotsAvailable = self.numOfEquipSlotsAvailable + 1
end
