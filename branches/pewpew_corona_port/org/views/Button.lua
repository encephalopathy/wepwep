require "org.View"

Button = View:subclass("View")

local widget = require 'widget'

function Button:init(sceneGroup, x, y, buttonImg, buttonImgOnOver, text, textColor, width, height)
	self.super:init(sceneGroup)
	--print(self.sceneGroup)
	
	
	local group = self.sceneGroup
	function group:onPress(event)
		group:dispatchEvent({name = "PlayGame", target = group})
	end
	
	buttonImg = buttonImg or "button.png"
	buttonImgOnOver = buttonImgOnOver or "button-over.png"
	textColor = textColor or { default = {255}, over = {128} }
	width = width or 128
	height = height or 128

	local newGameButton = widget.newButton {
		label = text,
		labelColor = color,
		defaultFile = buttonImg,
		overFile = buttonImgOnOver,
		width = width,
		height = height,
		onRelease = self.sceneGroup.onPress
	}
	
	newGameButton:setReferencePoint(  display.CenterReferencePoint )
	self.sceneGroup:insert(newGameButton)
end

function Button:__tostring()
	return Button.name()
end

