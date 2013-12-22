module ( "Dequeue", package.seeall )

function new()
	return {first = 0, last = -1, size = 0}
end

function insertFront(queue, value)
	assert(value ~= nil)
	local first = queue.first - 1
	queue.first = first
	queue[first] = value
	queue.size = queue.size + 1
end

function removeBack(queue)
	if (queue.size == 0) then
		return nil
	end
	local last = queue.last
	if queue.first > last then error("Queue is empty") end
	local value = queue[last]
	queue[last] = nil
	queue.last = last - 1
	queue.size = queue.size - 1
	assert(value ~= nil)
	return value
end

function removeFront(queue)
	if (queue.size == 0) then
		return nil
	end
	local first = queue.first
	if queue.first > queue.last then print("Queue is empty") end
	local value = queue[first]
	queue[first] = nil
	queue.first = first + 1
	queue.size = queue.size - 1
	assert(value ~= nil)
	return value
end

function insertBack(queue, value)
	assert(value ~= nil)
	local last = queue.last + 1
	queue[last] = value
	queue.last = last
	queue.size = queue.size + 1
end

function removeIndex (queue, index)
   if (index < queue.first or index > queue.last) then
	  print ("not a valid Queue location")
      return
   end
   if (index == queue.last) then
      return removeBack(queue)
   end
   if (index == 0) then
      local oldFirst = queue.first
      queue.first = queue.first + 1
      local value = queue[oldFirst]
      queue[oldFirst] = nil
      queue.size = queue.size - 1
	  assert(value ~= nil)
      return value
   end
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