require "org.Object"
require "org.Queue"
require "com.game.collectibles.Collectible"
--TODO: Add sceneGroup for ground collectibles
CollectibleHeap = Object:subclass("CollectibleHeap")

local PREALLOCATED_AMOUNT = 5
--I assume that Collectibles move at the same speed
function CollectibleHeap:init(collectibleTypes)
	self.inViewCollectibles = {}
	self.outOfViewCollectibles = {}
	self.collectibleGroup = display.newGroup()
	for i = 1, #collectibleTypes, 1 do
		self:preallocate(collectibleTypes[i], self.collectibleGroup)
	end
end

--[[
	Sprite pools the collectibles to their approipiate outOfView queues.
]]--
function CollectibleHeap:preallocate(collectibleType, sceneGroup)
	self.outOfViewCollectibles[collectibleType] = Queue.new()
	self.inViewCollectibles[collectibleType] = Queue.new()
	for i = 0, PREALLOCATED_AMOUNT, 1 do
		Queue.insertFront(self.outOfViewCollectibles[collectibleType], require('com.game.collectibles.' .. collectibleType):new(sceneGroup)) 
	end
end

function CollectibleHeap:start(sceneGroup)
	print(self.collectibleGroup.numChildren)
	
	sceneGroup:insert(self.collectibleGroup)
	Runtime:addEventListener('spawnCollectible', self)
end

--An event that listens to an offScreen event, this event should be dispatched
--When a player collects a piece of scrap or flies off the screen.
function CollectibleHeap:recycle(collectible)
	self:deactivateCollectible(collectible)
	local collectible = Queue.removeObject(self.inViewCollectibles[tostring(collectible)], collectible)
	Queue.insertFront(self.outOfViewCollectibles[tostring(collectible)], collectible)
end

--Spawns a Collectible at the correct location, and sets the physics body to stop moving.
function CollectibleHeap:spawnCollectible(event)
	if event.name ~= 'spawnCollectible' then
		return
	end
	
	local collectible = Queue.removeBack(self.outOfViewCollectibles[tostring(event.target)])
	assert(event.position ~= nil, 'Did not pass a pass location to a spawnCollectible event call')
	assert(event.position.x, 'Did not set the x location for the collectible ' .. tostring(event.target))
	assert(event.position.y, 'Did not set the y location for the collectible ' .. tostring(event.target))
	collectible:spawn(event.position)
	Queue.insertFront(self.inViewCollectibles[tostring(event.target)], collectible)
end

--[[
	FUNCTION NAME: deactivateCollectible
	
	DESCRIPTION: Stores all collectible items on screen back into their
				 respective outOfView queues.
	@RETURN: VOID
]]--
function CollectibleHeap:deactivateCollectible(collectible)
	collectible.sprite.x = -10000
	collectible.sprite.y = -10000
	collectible.alive = false
	collectible.sprite.isBodyActive = false
	collectible.sprite.isVisible = false
end

--[[
	FUNCTION NAME: stop
	
	DESCRIPTION: Stores all collectible items on screen back into their
				 respective outOfView queues.
	@RETURN: VOID
]]--
function CollectibleHeap:stop(sceneGroup)
	for typeOfCollectible, collectibleTypeQueue in pairs(self.inViewCollectibles) do
		while collectibleTypeQueue.size > 0 do
			local collectibleOnScreen = Queue.removeBack(collectibleTypeQueue)
			self:deactivateCollectible(collectibleOnScreen)
			Queue.insertFront(self.outOfViewCollectibles[typeOfCollectible], collectibleOnScreen)
		end
	end
	sceneGroup:remove(self.collectibleGroup)
	Runtime:removeEventListener('spawnCollectible', self)
end

--[[
	FUNCTION NAME: update
	
	DESCRIPTION: Updates each collectible in the game and also spawns
				 and checks for occlusion culling.
	@RETURN: VOID
]]--
function CollectibleHeap:update()
	for typeOfCollectible, collectibleTypeQueue in pairs(self.inViewCollectibles) do
		for i = collectibleTypeQueue.first, collectibleTypeQueue.last, 1 do
		
			local collectible = collectibleTypeQueue[i]
			
			--Spawns the collectible at the appropiate location
			if not collectible.sprite.isVisible then
					collectible:onSpawn()
			--Occlusion culls the collectible if it falls off screen.
			elseif collectible.sprite.x < -collectible.sprite.width or collectible.sprite.x > display.contentWidth or
					collectible.sprite.y < -collectible.sprite.height or collectible.sprite.y > display.contentHeight or
					not collectible.alive then
					self:recycle(collectible)
			--Updates the collectible
			else
				collectible:update()
			end
			
		end
	end
end