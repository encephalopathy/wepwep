require 'org.View'

PauseButton = View:subclass("PauseButton")

function PauseButton(group)
	self.super:init(sceneGroup)
	
	local group = self.sceneGroup
	function group:onPress(event)
		group:dispatchEvent({name = clickEventName, target = group})
	end

	local screenWidth, screenHeight = display.contentWidth, display.contentHeight
	local newGameButton = widget.newButton {
		left = screenWidth - screenWidth*0.3
		top = screenHeight - screenHeight*0.15
		label = "",
		labelAlign = "center",
		defaultFile = "sprites/backtomenu_unpressed.png",
		overFile = "sprites/backtomenu_pressed.png",
		width = screenWidth*0.3,
		height = screenHeigt*0.2,
		onRelease = self.sceneGroup.onPress
	}
	newGameButton.baseLabel = ""
	
	--We need to keep a reference to the widget to destroy it later
	self.newGameButton = newGameButton
	self.sceneGroup:insert(newGameButton)
end

function PauseButton:destroy()
	self.newGameButton:removeSelf()
	self.super:destroy()
end

--Also make sure to override this by placing the name of the class with a call to the function name.
function PauseButton:__tostring()
	return PauseButton.name()
end

return PauseButton