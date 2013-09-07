require "org.Object"

View = Object:subclass("View")

function View:init(sceneGroup)
	self.sceneGroup = display.newGroup()
	sceneGroup:insert(self.sceneGroup)
end

function View:createView(instance)
	Runtime:dispatchEvent({name = "onViewCreated", target = instance})
end

function View:__tostring()
	return View.name()
end

function View:destroy()
	for i = 1, self.sceneGroup.numChildren, 1 do
		self.sceneGroup[i]:removeSelf()
	end
	self.sceneGroup:removeSelf()
	self.sceneGroup = nil
end