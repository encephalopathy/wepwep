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
	@objectRef: The object which contains the field to be modified by this passive.
	@fieldName: The name of the field that is to be modified by this passive.
]]--
function Passive:init(objectRef, fieldName)
	self.objectRef = objectRef
	self.fieldName = fieldName
end

--[[
	FUNCTION NAME: update
	
	DESCRIPTION: Updates the passive.
	
	@RETURN: VOID
]]--
function Passive:update()
end

return Passive