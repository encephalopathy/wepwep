require "org.views.Button"

PlayButton = Button:subclass("PlayButton")
--To make views, make sure to call the createView by passing a reference for yourself when you
--are done.  That way the Context knows that a view has been created.
function PlayButton:init(sceneGroup)
	local x = display.contentWidth * 0.5 + 120
	local y = display.contentHeight - 225
	self.super:init(sceneGroup, x, y, "com/resources/art/sprites/button.png", "com/resources/art/sprites/button-over.png", "PlayGame", "Play Now", { default = {255}, over = {128} }, 154, 40)
	self:createView(self)
end

--Also make sure to override this by placing the name of the class with a call to the function name.
function PlayButton:__tostring()
	return PlayButton.name()
end

return PlayButton