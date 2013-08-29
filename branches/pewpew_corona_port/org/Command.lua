require "org.Mediator"

Command = Object:subclass("Command")

function Command:init()
	command.context = nil
end

function Command:execute(event)
	
end

