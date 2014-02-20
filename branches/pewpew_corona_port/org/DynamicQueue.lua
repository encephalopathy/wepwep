module ( "DynamicQueue", package.seeall )

function new()
	return {first = 0, last = -1, size = 0, nilSpots = {}, dict = {}}
end

function insertFront(queue, value)
	assert(value ~= nil)
	local added = false
	--if #queue.nilSpots > 0 then
		
		--[[while #queue.nilSpots > 0 and not added do
			local nilIndex = table.remove(queue.nilSpots)
		
			if nilIndex >= queue.first and nilIndex <= queue.last then
				if nilIndex == queue.first then
					local first = queue.first - 1
					queue.first = first
					queue[first] = value
					queue.size = queue.size + 1
				elseif nilIndex == queue.last then
					local last = queue.last + 1
					queue.last = last
					queue[last] = value
					queue.size = queue.size + 1
				else
					queue[nilIndex] = value	
				end
				added = true
			end
		end
		
		if not added then
			print('Did not find any nil spots so readding them to queue.')
			local first = queue.first - 1
			queue.first = first
			queue[first] = value
			queue.size = queue.size + 1
		end]]--

	--else
	local first = queue.first - 1
	queue.first = first
	queue[first] = value
	queue.size = queue.size + 1
		--assert(queue.dict[value] == nil)
		
	--queue.dict[value] = first
		
end


function removeBack(queue)
	if (queue.size == 0) then
		return nil
	end
	local last = queue.last
	--[[for i = 1, #queue.nilSpots, 1 do
		if queue.nilSpots[i] == last then
			print('Removing redundant index with nil size: ' .. #queue.nilSpots)
			table.remove(queue.nilSpots, i)
			
			break
		end
	end]]--
	if queue.first > last then error("Queue is empty") end
	local value = queue[last]
	--assert(queue.dict[value] ~= nil)
	--[[print('Removing bullet at index: ' .. last)
	for key, val in pairs(queue.dict) do
		print('bullet dict key: ' .. tostring(key))
		print('bullet dict value: ' .. tostring(val))
	end
	queue.dict[value] = nil--]]
	queue[last] = nil
	queue.last = last - 1
	queue.size = queue.size - 1
	assert(value ~= nil)
	return value
end

function removeIndex (queue, index)
	--print('Removing index: ' .. index)
	--print('first: ' .. queue.first)
	--print('last: ' .. queue.last)
	
	--if index < queue.first and index > queue.last then
		
		--end
   --[[print('BEFORE')
	for key, val in pairs(queue.dict) do
		print('bullet dict key: ' .. tostring(key))
		print('bullet dict value: ' .. tostring(val))
	end]]--
   assert(index >= queue.first and index <= queue.last)

   if (index == queue.last) then
      return removeBack(queue)
   end
   
   --[[local duplicate = false
   for i = 1, #queue.nilSpots, 1 do
	   if queue.nilSpots[i] == index then
		   duplicate = true
		   break
	   end
   end
   
   if not dupilcate then
   	 table.insert(queue.nilSpots, index)
   end]]--
   
   local value = queue[index]
   
   queue[index] = nil
   --queue.dict[value] = nil
   for i = index, queue.first, -1 do
	  local newIndex = i-1
      queue[i] = queue[newIndex]
	  --[[local oldVal = queue[i]
	  if queue.dict[oldVal] ~= nil then
		if queue.dict[oldVal] < queue.first + 1 or queue.dict[oldVal] > queue.last then
			queue.dict[oldVal] = nil
		else 
	  	    queue.dict[oldVal] = newIndex
	    end
  	  end]]--
   end
   
   --[[print('AFTER')
	for key, val in pairs(queue.dict) do
		print('bullet dict key: ' .. tostring(key))
		print('bullet dict value: ' .. tostring(val))
	end]]--
   
   queue.first = queue.first + 1
   
   queue.size = queue.size - 1
   
   assert(value ~= nil)
   return value
end

--TODO: Need to create a better way to remove objects from
--a queue without a linear search
function removeObject(queue, object)
	assert(object ~= nil)
	for i = queue.first, queue.last, 1 do
		if (queue[i] == object) then
			return removeIndex(queue, i)
		end
	end
	--[[local index = queue.dict[object]
	if index ~= nil then
		removeIndex(queue,index)
	end]]--
	return nil
end