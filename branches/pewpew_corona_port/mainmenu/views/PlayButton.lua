require "org.views.Button"

PlayButton = Button:subclass("PlayButton")

function PlayButton:init(sceneGroup)
	local centerOfScreenX = display.contentWidth*0.5
	self.super:init(sceneGroup, centerOfScreenX + 120, display.contentHeight - 225, 
		"button.png", "button-over.png", "Play Now", 
		{ default = {255}, over = {128} }, 154, 40)
		self:createView(self)
end

function PlayButton:__tostring()
	return PlayButton.name()
end
