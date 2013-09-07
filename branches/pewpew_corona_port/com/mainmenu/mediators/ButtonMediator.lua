require "org.Mediator"

ButtonMediator = Mediator:subclass("ButtonMediator")

function ButtonMediator:init()
	self.super:init()
end

function ButtonMediator:onRegister()
	self.viewInstance:addEventListener("clicked", self)
end

function ButtonMediator:onRemove()
	self.viewInstance:removeEventListener("clicked", self)
end

function ButtonMediator:clicked(event)
	print('I am in Button Mediators click function')
end

return ButtonMediator

