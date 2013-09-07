require "org.Object"

Mediator = Object:subclass("Mediator")

function Mediator:init()
	self.viewInstance = nil
end

function Mediator:destroy()
	self.viewInstance:destroy()
end

Mediator:virtual("onRegister")

Mediator:virtual("onRemove")

return Mediator