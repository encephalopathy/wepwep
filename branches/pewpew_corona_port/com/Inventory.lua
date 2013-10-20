--[[
Main inventory class. Right now it just manages the weapons, but
could be expanded to keep track of other items
--]]
require "org.Object"
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
   self.equippedWeapon = 1
   self.numOfEquipSlotsAvailable = NUMBER_OF_EQUIP_SLOTS
   -- permissions list
   
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
-- Do permissions check and change weapons, will rename to equipRig.
function Inventory:equipPrimaryWeapon(player, sceneGroup)


   local weapon = nil
   
	if (self.permission[self.equippedWeapon] == true and
		self.Weapons[self.equippedWeapon] ~= nil) then
		weapon = self.Weapons[self.equippedWeapon]
		
		weapon:setMuzzleLocation({ x = 0, y = -100 })
		weapon.owner = player
		--self.player = player
		
		weapon.sceneGroup = sceneGroup
   end
	player.weapon = weapon
end

--Equip all secondary weapons and passives to the player when the player starts the game.
function Inventory:equipRig(player, sceneGroup)
	self:equipPrimaryWeapon(player, sceneGroup)
	self:equipSecondaryItems(player, sceneGroup)
end

--Equips secondary weapons and passives in game.
function Inventory:equipSecondaryItems(player, sceneGroup)	
	for weaponName, secondaryWeapon in pairs(self.secondaryWeapons) do
		secondaryWeapon.sceneGroup = sceneGroup
		table.insert(player.secondaryWeapons, secondaryWeapon)
	end
	
	for passiveName, passive in pairs(self.passives) do
		passive.objectRef = player
		table.insert(player.defensePassives, passive)
	end
end

--Unequips the secondary weapons, passives, and primary weapons from the player's ship in game.
function Inventory:unequip(player)
	--Uninitializes player weapon.
	player.weapon.owner = nil
	player.weapon = nil
	
	--Unequips the passives from the player.
	for passive in pairs(player.defensePassives) do
		passive.objectRef = nil
		passive = nil
	end
	
	--Unequips the secondary weapons from the player.
	for weapon in pairs(player.secondaryWeapons) do
		weapon.sceneGroup = nil
		weapon = nil
	end
end


-------------------------------------------------------------------------------------------------------------------------

--[[
****************************************************************************************************************************
	
	Equips the primary weapons, secondary weapons, and passives for the player in the Shop Menu.  These functions
	should only be called in the Shop Menu.
	
****************************************************************************************************************************
]]--
function Inventory:equipPrimaryWeapon(weaponObject)
	assert(weaponObject ~= nil, 'Equipped a nil weapon in Inventory:equipPrimaryWeapon')
    self.equippedWeapon = weaponObject
end

-- Adds a secondary weapon to the equipment slots.
function Inventory:addSecondaryWeapon(weaponName)
	if self.secondaryWeapons[weaponName] ~= nil and self.numOfEquipSlotsAvailable > 0 then
		self.secondaryWeapons[weaponname] =  weaponObject
		self.numOfEquipSlotsAvailable = self.numOfEquipSlotsAvailable + 1
	else
		self.secondaryWeapons[weaponObject].ammoAmount = self.secondaryWeapons[weaponObject].ammoAmount + weaponObject.ammoAmount
	end
end

function Inventory:hasSecondaryWeapon(weaponName)
	return self.secondaryWeapons[weaponName] ~= nil
end

function Inventory:hasPassive(passiveName)
	return self.passives[weaponName] ~= nil
end

-- Removes a secondary weapon from the equipment slots.  If the secondary weapon is already equipped.  Double the shots that can be fired.
function Inventory:removeSecondaryWeapon(weaponName)
	if self.secondaryWeapons[weaponName] ~= nil then
		self.secondaryWeapons[weaponName] = nil
		self.numOfEquipSlotsAvailable = self.numOfEquipSlotsAvailable - 1
	else
		self.secondaryWeapons[weaponName].ammoAmount = weaponObject.ammoAmount
	end
end

-- Add passive to the equipment slots.
function Inventory:addPassive(passiveName)
	if self.passives[passiveName] ~= nil and self.numOfEquipSlotsAvailable > 0 then
		self.passives[passiveName] = passiveObject
		self.numOfEquipSlotsAvailable = self.numOfEquipSlotsAvailable - 1
	end
end

-- Remove a passive to the equipment slots.
function Inventory:removePassvive(passiveName)
	if self.passives[passiveName] ~= nil then
		self.passives[passiveName] = nil
		self.numOfEquipSlotsAvailable = self.numOfEquipSlotsAvailable + 1
	end
end
