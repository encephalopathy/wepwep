require "org.View"

Button = View:subclass("Button")

local widget = require 'widget'

function Button:init(sceneGroup, x, y, buttonImg, buttonImgOnOver, clickEventName, text, textColor, width, height)
	self.super:init(sceneGroup)
	
	local group = self.sceneGroup
	function group:onPress(event)
		group:dispatchEvent({name = clickEventName, target = group})
	end
	
	buttonImg = buttonImg or "com/resources/art/sprites/button.png"
	buttonImgOnOver = buttonImgOnOver or "com/resources/art/sprites/button-over.png"
	textColor = textColor or { default = {255}, over = {128} }
	width = width or 128
	height = height or 128

	local newGameButton = widget.newButton {
		label = text,
		labelColor = textColor,
		defaultFile = buttonImg,
		overFile = buttonImgOnOver,
		width = width,
		height = height,
		onRelease = self.sceneGroup.onPress
	}
	
	newGameButton.x = x or 0
	newGameButton.y = y or 0
	
	newGameButton:setReferencePoint(display.CenterReferencePoint)
	--We need to keep a reference to the widget to destroy it later
	self.newGameButton = newGameButton
	self.sceneGroup:insert(newGameButton)
end

function Button:__tostring()
	return Button.name()
end

function Button:destroy()
	self.newGameButton:removeSelf()
	self.super:destroy()
end

