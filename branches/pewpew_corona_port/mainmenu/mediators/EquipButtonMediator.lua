require("org.Mediator")

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

function ShopButtonMediator:GoToEquip(event)
	if event.name == "GoToEquip" then
		storyboard.gotoScene("MenuEquip", "fade", 500)
	end

	return true
end

return EquipButtonMediator