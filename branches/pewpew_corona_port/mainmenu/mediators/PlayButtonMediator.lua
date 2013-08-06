require "org.Mediator"

PlayButtonMediator = Mediator:subclass("PlayButtonMediator")

function PlayButtonMediator:init()
	self.super:init()
end

function PlayButtonMediator:onRegister()
	self.storyboard = require( "storyboard" )
	self.viewInstance.sceneGroup:addEventListener("PlayGame", self)
end

function PlayButtonMediator:onRemove()
	self.storyboard = nil
	self.viewInstance.sceneGroup:removeEventListener("PlayGame", self)
end

function PlayButtonMediator:PlayGame(event)
	if event.name == "PlayGame" then
		self.storyboard.gotoScene( "level1", "fade", 500 )
	end

	return true
end

return PlayButtonMediator