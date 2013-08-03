require "org.Mediator"

MainMenuMediator = Mediator:subclass("MainMenuMediator")

function MainMenuMediator:init()
	self.super:init()
end

function MainMenuMediator:onRegister()
	self.storyboard = require( "storyboard" )
	self.viewInstance.sceneGroup:addEventListener("PlayGame", self)
end

function MainMenuMediator:onRemove()
	self.storyboard = nil
	self.viewInstance.sceneGroup:removeEventListener("PlayGame", self)
end

function MainMenuMediator:PlayGame(event)
	if event.name == "PlayGame" then
		self.storyboard.gotoScene( "level1", "fade", 500 )
	elseif event.name == "Enter Weapon Shop" then
		self.storyboard.gotoScene("MenuStore", "fade", 500)
	elseif event.name == "Enter Equip Menu" then
		self.storyboard.gotoScene("MenuEquip", "fade", 500)
	end
	return true
end

return MainMenuMediator