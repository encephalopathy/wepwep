require "org.views.Button"

EquipButton = Button:subclass("EquipButton")
--To make views, make sure to call the createView by passing a reference for yourself when you
--are done.  That way the Context knows that a view has been created.
function EquipButton:init(sceneGroup)
	local x = centerOfScreenX + 120
	local y = display.contentHeight - 75
	self.super:init(sceneGroup, x, y, "button.png", "button-over.png", "GoToEquip", "Hangar", { default = {255}, over = {128} }, 154, 40) 
	self:createView(self)
end

--Also make sure to override this by placing the name of the class with a call to the function name.
function EquipButton:__tostring()
	return EquipButton.name()
end