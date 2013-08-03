require("Object")

Context = Object:subclass("Object")

function Context:init()
	 
	self.commands = {}
	self.mediators = {}
	self.mediatorInstances = {}
	
	Runtime:addEventListener("onViewCreated", function(event)
		local view = event.target
		if view == nil then
			error('Error: Context recieved a create event without a view instance in the event object')
		end
	
		self:createMediator(view)
	
	end)
	Runtime:addEventListener("onViewDestroyed", self.onViewDestroyed)
	
	
	
		
end

function Context:onViewCreated()
	local view = self.target
	if view == nil then
		error('Error: Context recieved a create event without a view instance in the event object')
	end
	
	self:createMediator(view)
end

function Context:onViewDestroyed(event)
	local view = event.target
	if view == nil then
		error('Error: Context recieved a destroy event without a view instance in the event object')
	end
	self:removeMediator(view)
end

function Context:onHandleEvent(event)
	local commandClassName = Context.static.commands[event.name]
	
	if commandClassName ~= nil then
		local command = assert(require(commandClassName):new(), 'Failed to find comand: ', commandClassName)
		command.context = self
		command:execute(event)
	end
end

function Context:mapCommand(eventName, commandClass)
	self.commands[eventName] = self:getClassName(commandClass)
	Runtime:addEventListener(eventName, function(event) context:onHandleEvent(event) end)
end

function Context:mapMediator(viewClass, mediatorClass)
	local viewClassName = self:getClassName(viewClass)

	self.mediators[viewClassName] = mediatorClass
	print('Mapping the view: ' .. viewClassName .. ' to ' .. self.mediators[viewClassName])
end

function Context:unmapMediator(viewClass)
	self.mediators[viewClass.__toString()] = nil
end

function Context:createMediator(viewInstance)
	local mediatorClassName = self.mediators[tostring(viewInstance)]

	if mediatorClassName ~= nil then
		local mediatorClass = require( mediatorClassName ):new()
		print(mediatorClass)
		mediatorClass.viewInstance = viewInstance
		self.mediatorInstances[#self.mediatorInstances + 1] = mediatorClass
		mediatorClass:onRegister()
	end
end

--function Context:removeMediator(viewInstance)
--	for i = 1, viewInstance
--end

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