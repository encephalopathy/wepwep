module ( "Queue", package.seeall )

function new()
	return {first = 0, last = -1, size = 0}
end

function insertFront(queue, value)
	local first = queue.first - 1
	queue.first = first
	queue[first] = value
	queue.size = queue.size + 1
end

function removeBack(queue)
	local last = queue.last
	if queue.first > last then error("Queue is empty") end
	local value = queue[last]
	queue[last] = nil
	queue.last = last - 1
	queue.size = queue.size - 1
	return value
end

