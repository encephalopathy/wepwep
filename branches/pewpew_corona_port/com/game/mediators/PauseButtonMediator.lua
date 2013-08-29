require("org.Mediator")

PauseButtonMediator = Mediator:subclass("PauseButtonMediator")

function PauseButtonMediator:init()
	self.super:init()
end

function PauseButtonMediator:onRegister()
	self.storyboard = require( "storyboard" )
	self.viewInstance.sceneGroup:addEventListener("PauseGame", self)
end

function PauseButtonMediator:onRemove()
	self.storyboard = nil
	self.viewInstance.sceneGroup:removeEventListener("PauseGame", self)
end

function PauseButtonMediator:PauseGame(event)
	if event.name == "PauseGame" then
		self.storyboard.gotoScene("mainmenu", "fade", 500)
	end

	return true
end

return PauseButtonMediator