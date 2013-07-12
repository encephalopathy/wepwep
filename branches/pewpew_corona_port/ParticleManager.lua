require("Queue")
--[[
	Particle Manager
	Description: Updates all particle emitters at every tick of the game.  Note that particle Emitters of Haters
	that are not on screen happen.  The Particle Manager has not been optimized to handle the case if there are a
	lot of Haters in the level.
]]--
particleEmitters = Queue.new()

function addParticleEmitter(emitter)
	Queue.insertFront(particleEmitters, emitter)
end

function destroyParticleManager()
	while particleEmitters.size > 0 do
		local particleEmitter = Queue.removeBack(particleEmitters)
		particleEmitter:destroy()
	end
end

function updateParticleEmitters()
	for i = particleEmitters.first, particleEmitters.last, 1 do 
		particleEmitters[i]:updateParticles()
	end
end