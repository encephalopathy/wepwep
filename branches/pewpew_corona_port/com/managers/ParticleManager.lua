require("Queue")
--[[
--	Particle Manager
--	Description: Updates all particle emitters at every tick of the game.  Note that particle Emitters of Haters
--	that are not on screen happen.  The Particle Manager has not been optimized to handle the case if there are a
--	lot of Haters in the level.
]]--

-- creates a new queue of emitters
particleEmitters = Queue.new()


--inserts to the front of the emitter list
function addParticleEmitter(emitter)
	Queue.insertFront(particleEmitters, emitter)
end


--remove emitter from back of list
function destroyParticleManager()
	while particleEmitters.size > 0 do
		local particleEmitter = Queue.removeBack(particleEmitters)
		particleEmitter:destroy()
	end
end

function cullAllParticles()

end


--generic update function for particles
function updateParticleEmitters()
  --  print("updating particles")
	for i = particleEmitters.first, particleEmitters.last, 1 do 
		particleEmitters[i]:updateParticles()
	end
    --updateParticleEmitters(coroutine.yield)
end