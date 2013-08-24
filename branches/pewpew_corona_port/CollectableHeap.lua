require("Object")
require("Queue")
--Ian: Take a look at BulletManager for a similar implementation.
CollectableHeap = Object:subclass("CollectableHeap")

--I assume that collectables move at the same speed
function CollectableHeap:init()
	self.inViewCollectables = Queue.new()
	self.outOfViewCollectables = Queue.new()
	RuntimeListener:addEventListener('offScreen', self)
	RuntimeListener:addEventListener('spawnCollectable', self)
end

--An event that listens to an offScreen event, this event should be dispatched
--When a player collects a piece of scrap or flies off the screen.
function CollectableHeap:offScreen(event)
	if event.name ~= offscreen or not Collectable:made(event.target) then
		return
	end
	
	local collectable = Queue.removeObject(self.inViewCollectables, event.target)
	Queue.insertFront(self.outOfViewCollectables, collectable)
end

--Spawns a collectable at the correct location, and sets the physics body to stop moving.
function CollectableHeap:spawnCollectable(event)
	if event.name ~= 'spawnScrap' or not Collectable:made(event.target) then
		return
	end
	
	local collectable = Queue.removeBack(self.outOfViewCollectables)
	
	collectable.sprite.x = event.target.x
	collectable.sprite.y = event.target.y
	collectable.sprite.isBodyActive = true
	Queue.insertFront(self.inViewColectables, collectable)
end