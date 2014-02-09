module ( "DynamicQueue", package.seeall )

function new()
	return {first = 0, last = -1, size = 0, nilSpots = {}}
end

function insertFront(queue, value)
	assert(value ~= nil)
	if #queue.nilSpots > 0 then
		local nilIndex = table.remove(queue.nilSpots)
		queue[nilIndex] = value
	else
		local first = queue.first - 1
		queue.first = first
		queue[first] = value
		queue.size = queue.size + 1
	end
		
end


function removeBack(queue)
	if (queue.size == 0) then
		return nil
	end
	local last = queue.last
	if queue.nilSpots[last] ~= nil then
		table.remove(queue.nilSpots, last)
	end
	if queue.first > last then error("Queue is empty") end
	local value = queue[last]
	queue[last] = nil
	queue.last = last - 1
	queue.size = queue.size - 1
	assert(value ~= nil)
	return value
end

function removeIndex (queue, index)
   if (index < queue.first or index > queue.last) then
	  --print ("not a valid Queue location")
      return
   end
   if (index == queue.last) then
      return removeBack(queue)
   end
   table.insert(queue.nilSpots, index)
   local value = queue[index]
   queue[index] = nil
   for i = index, queue.first, -1 do
      queue[i] = queue[i-1]
   end
   queue.first = queue.first + 1
   
   queue.size = queue.size - 1
   
   assert(value ~= nil)
   return value
end

--TODO: Need to create a better way to remove objects from
--a queue without a linear search
function removeObject(queue, object)
	for i = queue.first, queue.last, 1 do
		if (queue[i] == object) then
			return removeIndex(queue, i)
		end
	end
	return nil
end