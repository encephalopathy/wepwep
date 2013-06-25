require("Object")
require("Queue")
require("ParticleManager")

ParticleEmitter = Object:subclass("ParticleEmitter")

function ParticleEmitter:init(x, y, emitTime)
	self.particleLiveList = Queue.new()
	self.particleDeadList = Queue.new()
	self.emitCounter = 0
	self.x = x
	self.y = y
	self.active = false
	self.recyclable = false
	if emitTime ~= nil then
		self.emitTime = emitTime
	else
		self.emitTime = 1
	end
end

function ParticleEmitter:add(particle)
	particle.deadListRef = self.particleDeadList
	Queue.insertFront(self.particleLiveList, particle)
end

function ParticleEmitter:start()
	self:recycleParticles()
	for i = self.particleLiveList.first, self.particleLiveList.last, 1 do
		if self.x == nil and self.y == nil then
			self.particleLiveList[i]:activate(0, 0)
		else
			self.particleLiveList[i]:activate(self.x, self.y)
		end
	end
	self.active = true
end

function ParticleEmitter:updateLoc(x, y)
	if x then
		self.x = x
	end
	
	if y then
		self.y = y
	end
end

function ParticleEmitter:updateParticles()
	if self.active then
		if self.emitCounter % self.emitTime == 0 then
			if self.recyclable then
				self:recycleParticles()
			end
		end
		
		local activeParticleNum = self.particleLiveList.size
		--print('activate particle num: ' .. activeParticleNum)
		--print('dead particle num: ' .. self.particleDeadList.size)
		for i = 1, activeParticleNum, 1 do
			local particle = Queue.removeBack(self.particleLiveList)
			if particle then particle:update() end
			if not particle.alive then
				particle:deactivate()
				Queue.insertFront(self.particleDeadList, particle)
			else
				Queue.insertFront(self.particleLiveList, particle)
			end
		end
		self.emitCounter = self.emitCounter + 1
	end
end

function ParticleEmitter:stop()
	self.active = false
end

function ParticleEmitter:recycleParticles()
	while self.particleDeadList.size > 0 do
		local particle = Queue.removeBack(self.particleDeadList)
		particle:activate(self.x, self.y)
		Queue.insertFront(self.particleLiveList, particle)
	end
end

function emptyQueue(queue)
	while (queue.size > 0) do
		local value = Queue.removeBack(queue)
		value:destroy()
		value = nil
	end
	--queue = nil
end

function ParticleEmitter:destroy()
	emptyQueue(self.particleLiveList)
	emptyQueue(self.particleDeadList)
	self.particleLiveList = nil
	self.particleDeadList = nil
	--print(self.particleLiveList)
	--print(self.particleDeadList)
end