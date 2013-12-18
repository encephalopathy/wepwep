require "org.Object"
require "com.Utility"
Context = Object:subclass("Object")

--Sets up the context variables that will manage all mediators, commands and views.
function Context:init()
	self.commands = {}
	self.mediators = {}
	
	self.viewInstantiation = {}
	self.commandInstantion = {}
	self.mediatorInstances = {}
	
	Runtime:addEventListener("onViewCreated", self)
	Runtime:addEventListener("onViewDestroyed", self)
end

--Gets called when a view is created, this event is dispatced in the file View.lua in the function createView under org.
function Context:onViewCreated(event)
	local view = event.target
	if view == nil then
		error('Error: Context recieved a create event without a view instance in the event object')
	end
	
	self:createMediator(view)
end

--Gets called when a view is destroyed
function Context:onViewDestroyed(event)
	local view = event.target
	if view == nil then
		error('Error: Context recieved a destroy event without a view instance in the event object')
	end
	self:removeMediator(view)
end

--Handles a command event, executes that command and creates the appropiate command class for it.
function Context:onHandleEvent(event)
	local commandClassName = self.commands[event.name]
	
	if commandClassName ~= nil then
		local command = assert(require(commandClassName):new(), 'Failed to find comand: ', commandClassName)
		command.context = self
		command:execute(event)
	end
end

--Maps the appropiate command to a particular event that has occured.  This event can be located
--in the view.
function Context:mapCommand(eventName, commandClass)
	self.commands[eventName] = self:getClassName(commandClass)
	Runtime:addEventListener(eventName, function(event) context:onHandleEvent(event) end)
end

--Maps a view to a mediator so that events from the mediator can be created when the view is created later.
function Context:mapMediator(viewClass, mediatorClass)
	local viewClassName = self:getClassName(viewClass)
	self.mediators[viewClassName] = mediatorClass
	
	self.viewInstantiation[viewClass] = viewClass
	print('Mapping the view: ' .. viewClassName .. ' to ' .. self.mediators[viewClassName])
end

--Unmaps the view class to the particular mediator so that when this view is created, the associated mediator
--that corresponds to that view is NOT created.
function Context:unmapMediator(viewClass)
	self.mediators[tostring(viewClass)] = nil
end

--Creates a mediator for the particular view that it was mapped to.
function Context:createMediator(viewInstance)
	local mediatorClassName = self.mediators[tostring(viewInstance)]
	if mediatorClassName ~= nil then
		local mediatorClass = require( mediatorClassName ):new()
		mediatorClass.viewInstance = viewInstance
		self.mediatorInstances[viewInstance] = mediatorClass
		mediatorClass:onRegister()
	end
end

--Removes the mediator
function Context:removeMediator(viewInstance)
	local mediatorToRemove = self.mediatorInstances[viewInstance]
	assert(mediatorToRemove ~= nil, 'Failed to remove a nil mediator with view: ', viewInstance)
end


--[[Gets the appropiate class name by truncating everything before the last period.  We assume that
	 the variable you pass to this function is a sting and a path name.
     ex of how to use this. Suppose I pass this to this function: "images.sprites.wtf", 
     this gets turned into "wtf".
--]]
function Context:getClassName(classType)
		assert(classType ~= nil, "You cannot pass a null classType")
		local testStartIndex,testEndIndex = classType:find(".", 1, true)
		if testStartIndex == nil then
			return classType
		end
		local startIndex = 1
		local endIndex = 1
		local lastStartIndex = 1
		local lastEndIndex = 1
		while startIndex do
			startIndex,endIndex = classType:find(".", startIndex, true)
			if startIndex ~= nil and endIndex ~= nil then
				lastStartIndex = startIndex
				lastEndIndex = endIndex
				startIndex = startIndex + 1
				endIndex = endIndex + 1
			end
		end
		local className = classType:sub(lastStartIndex + 1)
		return className
end

function Context:preprocess(group)
	for view in pairs(self.viewInstantiation) do
		require(view):new(group)
	end
end