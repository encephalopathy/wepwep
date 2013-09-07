require "org.Mediator"

EquipButtonMediator = Mediator:subclass("EquipButtonMediator")

function EquipButtonMediator:init()
	self.super:init()
end

function EquipButtonMediator:onRegister()
	self.storyboard = require( "storyboard" )
	self.viewInstance.sceneGroup:addEventListener("GoToEquip", self)
end

function EquipButtonMediator:onRemove()
	self.storyboard = nil
	self.viewInstance.sceneGroup:removeEventListener("GoToEquip", self)
end

function EquipButtonMediator:GoToEquip(event)
	if event.name == "GoToEquip" then
		self.storyboard.gotoScene("com.equipmenu.MenuEquip", "fade", 500)
	end

	return true
end

return EquipButtonMediator