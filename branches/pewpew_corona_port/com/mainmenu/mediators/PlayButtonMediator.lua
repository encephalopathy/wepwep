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
		print("DISPATCHING EVENT")
		Runtime:dispatchEvent({name = 'playSound', soundHandle = 'enterGame'})
	    local options = { effect = "fade", time = 500 }
		self.storyboard.gotoScene( "com.equipmenu.MenuEquip", options)
		--play sound effect for playButton
	end

	return true
end

return PlayButtonMediator
