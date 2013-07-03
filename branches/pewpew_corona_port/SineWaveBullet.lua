require("Bullet")
SineWaveBullet = Bullet:subclass("SineWaveBullet")

function SineWaveBullet:init(sceneGroup, imgSrc, isPlayerBullet, startX, startY, rotation, width, height)
	self.super:init(sceneGroup, imgSrc, "kinematic", startX, startY, rotation, width, height)
end

function SineWaveBullet:fire()
	local updateFunction = function() 
		local speed = 5
		local newY = self.initialY - self.time * speed
		local newX = self.initialX + self.amp * math.sin(self.time * 4 * math.pi / 50)
		self:move(newX, newY)
		self.time = self.time + 1
		self.alive = true
		end
	Runtime:addEventListener("enterFrame", updateFunction)
	self.update = updateFunction
end

function SineWaveBullet:__tostring()
	return "A SineWaveBullet with initial.xy ( " .. self.initialX .. ", " .. self.initialY .. " )"
end

function SineWaveBullet:recycle(bullet)
	Runtime:removeEventListener("enterFrame", self.update)
end

