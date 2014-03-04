require "org.Object"

Passive = Object:subclass("Passive")

--[[
-- CLASS NAME: Passive
--
-- DESCRIPTION:  The base class for all passive abilities in Shoot Em' Up! Pew Pew!!  Passives are responsible for modifying the game in some manner either every update or whenever conditions are met.

-- FUNCTIONS:
-- @init: Creates a passive and sets the fields required to update the ride.
-- @update: Updates the passive when applicable.
]]--

--[[
	CONSTRUCTOR:
	@fieldName: The name of the field that is to be modified by this passive.
]]--
function Passive:init(fieldName, isActivatable)
	self.fieldName = fieldName
	if isActivatable == nil then
		self.isActivatable = false
	else
		self.isActivatable = isActivatable
	end
	self.activated = false

end

--[[
	FUNCTION NAME: setOwner
	
	DESCRIPTION: Sets the owner for this passive.  This function gets called
				 when the player or hater enters the game.
	@RETURN: VOID
]]--
function Passive:setOwner(objectRef)
	assert(objectRef ~= nil, 'Did not equip an owner such as player or an enemy to this passive')
	
	self.objectRef = objectRef
	self.activated = false
end

--[[
	FUNCTION NAME: update
	
	DESCRIPTION: Updates the passive.
	
	@RETURN: VOID
]]--
function Passive:update()
end

--[[
	FUNCTION NAME: clear
	
	DESCRIPTION: Zeros out all the necassary fields needed when the passive de-equips from the player.
	
	@RETURN: VOID
]]--
function Passive:clear()
	self.objectRef = nil
	self.activated = false
end

--[[
	FUNCTION NAME: activate
	
	DESCRIPTION: Toggles an activation effect when called by the Player.  If desired, this function should be overriden for
				 additonal functionality.
	
	@RETURN: VOID
]]--
function Passive:activate()
	self.activated = not self.activated
end

return Passive