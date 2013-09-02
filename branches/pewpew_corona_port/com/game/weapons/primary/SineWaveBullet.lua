require "com.game.weapons.Bullet"
require "com.Utility"
SineWaveBullet = Bullet:subclass("SineWaveBullet")

function SineWaveBullet:init(sceneGroup, imgSrc, isPlayerBullet, width, height)
	self.super:init(sceneGroup, imgSrc, isPlayerBullet, width, height)
end

function SineWaveBullet:fire()
	local updateFunction = function() 
		local speed = 5
		
		local newX = self.initialX + self.amp * math.sin(self.time * 4 * math.pi / 50)
		local newY = self.initialY - self.time * speed
		
		--rotate NewX and NewY
		local newX = self.amp * math.sin(self.time * 4 * math.pi / 50)
		local newY = -self.time * speed
		if self.rotation ~= 0 then
			local rotatedCoordinates = rotate2DPoint(newX, newY, math.rad(self.rotation))
			newX, newY = rotatedCoordinates.x, rotatedCoordinates.y
		end
		newX = self.initialX + newX
		newY = self.initialY + newY
		self:move(newX, newY)
		self.time = self.time + 1
	end
	self.alive = true
	Runtime:addEventListener("enterFrame", updateFunction)
	self.update = updateFunction
end

function SineWaveBullet:__tostring()
	return "SineWaveBullet"
end

function SineWaveBullet:recycle()
	Runtime:removeEventListener("enterFrame", self.update)
	self.super:recycle(self)
	
end

function SineWaveBullet:destroy()
	self.updateFunction = nil
	self.super:destroy()
end
