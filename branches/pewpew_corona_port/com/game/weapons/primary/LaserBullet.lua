require "com.game.weapons.Bullet"
require "com.Utility"
LaserBullet = Bullet:subclass("LaserBullet")

function LaserBullet:init(sceneGroup, imgSrc, isPlayerBullet, width, height)
	self.super:init(sceneGroup, imgSrc, isPlayerBullet, width, height)
end

function LaserBullet:fire(Player)
	local updateFunction = function() 
		local speed = 5
		
		local newX = self.initialX + self.amp * math.sin(self.time * 4 * math.pi / 50)
		local newY = self.initialY - self.time * speed
		
		newX = self.initialX + newX
		newY = self.initialY + newY
		self:move(Player.X, Player.Y)
		self.time = self.time + 1
	end
	self.alive = true
	Runtime:addEventListener("enterFrame", updateFunction)
	self.update = updateFunction
end

function LaserBullet:__tostring()
	return "LaserBullet"
end

function LaserBullet:recycle()
	Runtime:removeEventListener("enterFrame", self.update)
	self.super:recycle(self)
	
end

function LaserBullet:destroy()
	self.updateFunction = nil
	self.super:destroy()
end

