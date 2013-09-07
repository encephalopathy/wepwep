require "org.Mediator"

ShopButtonMediator = Mediator:subclass("ShopButtonMediator")

function ShopButtonMediator:init()
	self.super:init()
end

function ShopButtonMediator:onRegister()
	self.storyboard = require( "storyboard" )
	self.viewInstance.sceneGroup:addEventListener("GoToShop", self)
end

function ShopButtonMediator:onRemove()
	self.storyboard = nil
	self.viewInstance.sceneGroup:removeEventListener("GoToShop", self)
end

function ShopButtonMediator:GoToShop(event)
	if event.name == "GoToShop" then
		self.storyboard.gotoScene("com.shopmenu.MenuStore", "fade", 500)
	end

	return true
end

return ShopButtonMediator