module ( "DynamicQueue", package.seeall )

function new()
	return {first = 0, last = -1, size = 0, dict = {}}
end

function insertFront(queue, value)
	assert(value ~= nil)
	local first = queue.first - 1
	queue.first = first
	queue[first] = value
	queue.size = queue.size + 1
	queue.dict[value] = first
		
end


function removeBack(queue)
	if (queue.size == 0) then
		return nil
	end
	local last = queue.last
	if queue.first > last then error("Queue is empty") end
	local value = queue[last]
	print('Removing bullet at index: ' .. last)
	for key, val in pairs(queue.dict) do
		print('bullet dict key: ' .. tostring(key))
		print('bullet dict value: ' .. tostring(val))
	end
	queue.dict[value] = nil
	queue[last] = nil
	queue.last = last - 1
	queue.size = queue.size - 1
	assert(value ~= nil)
	return value
end

function removeIndex (queue, index)
	print('Removing index: ' .. index)
	print('first: ' .. queue.first)
	print('last: ' .. queue.last)
   print('BEFORE')
	for key, val in pairs(queue.dict) do
		print('bullet dict key: ' .. tostring(key))
		print('bullet dict value: ' .. tostring(val))
	end
   assert(index >= queue.first and index <= queue.last)

   if (index == queue.last) then
      return removeBack(queue)
   end
   
   local value = queue[index]
   
   queue[index] = nil
   for i = index, queue.first, -1 do
      queue[i] = queue[i-1]
	  local oldVal = queue[i]
	  if queue.dict[oldVal] ~= nil then
		if queue.dict[oldVal] < queue.first + 1 or queue.dict[oldVal] > queue.last then
			queue.dict[oldVal] = nil
		else 
	  	    queue.dict[oldVal] = i
	    end
  	  end
   end
   
   print('AFTER')
	for key, val in pairs(queue.dict) do
		print('bullet dict key: ' .. tostring(key))
		print('bullet dict value: ' .. tostring(val))
	end
   
   queue.first = queue.first + 1
   
   queue.size = queue.size - 1
   
   assert(value ~= nil)
   return value
end

--TODO: Need to create a better way to remove objects from
--a queue without a linear search
function removeObject(queue, object)
	assert(object ~= nil)
	local index = queue.dict[object]
	if index ~= nil then
		removeIndex(queue,index)
	end
	return nil
end