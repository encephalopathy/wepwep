require "org.Mediator"

TestGameMediator = Mediator:subclass("TestGameMediator")

function TestGameMediator:init()
	self.super:init()
end

function TestGameMediator:onRegister()
	self.storyboard = require( "storyboard" )
	self.viewInstance.sceneGroup:addEventListener("PlayGame", self)
end

function TestGameMediator:onRemove()
	self.storyboard = nil
	self.viewInstance.sceneGroup:removeEventListener("PlayGame", self)
end

function TestGameMediator:PlayGame(event)
	if event.name == "PlayGame" then
		local options = { effect = "fade", time = 500, params = { debug = true } }
		self.storyboard.gotoScene( "com.game.Game", options)
	end

	return true
end

return TestGameMediator