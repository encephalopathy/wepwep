require("MoveableObject")

Particle = MoveableObject:subclass("Particle")

function Particle:init(sceneGroup, imgSrc, width, height, velX, velY, aX, aY, rotation, lifeTime, maxVelX, maxVelY, maxAX, maxAY)
	self.super:init(sceneGroup, imgSrc, nil, 0, 0, 0, width, height)
	if velX ~= nil then
		self.velX = velX
	else
		self.velX = 0
	end
	
	if velY ~= nil then
		self.velY = velY
	else
		self.velY = 0
	end
	
	if aX ~= nil then
		self.aX = aX
	else
		self.aX = 0
	end
	
	if aY ~= nil then
		self.aY = aY
	else
		self.aY = 0
	end
	
	if lifeTime ~= nil then
		self.lifeTime = lifeTime
		self.currentLifeTime = lifeTime
	else
		self.lifeTime = 0
		self.currentLifeTime = 0
	end
	
	if rotation ~= nil then
		self.rotationRate = rotation
	else
		self.rotationRate = 0
	end
	
	self.maxVelX = maxVelX
	self.maxVelY = maxVelY
	self.maxAX = maxAX
	self.maxAY = maxAY
	self.sprite.visible = false
end

function Particle:activate(x, y)
	self:move(x, y)
	self.currentLifeTime = self.lifeTime
	self.alive = true
	self.sprite.visible = true
end

function Particle:update()
	if self.alive then
	
		if self.maxAX == nil or self.aX <= self.maxVelX then
			self.velX = self.velX + self.aX
		end
		
		if self.maxAY == nil or self.aY <= self.maxVelY then
			self.velY = self.velY + self.aY
		end
		
		if self.maxVelX == nil or self.velX <= self.maxVelX then
			self.sprite.x = self.sprite.x + self.velX
		end
		
		if self.maxVelX == nil or self.velY <= self.maxVelY then
			self.sprite.y = self.sprite.y + self.velY
		end
		
		if self.rotationRate > 0 then
			self.sprite.rotation = self.sprite.rotation + self.rotationRate
		end
	end
	
	if self.currentLifeTime > 0 then
		self.currentLifeTime = self.currentLifeTime - 1
	else
		self.alive = false
	end
end

function Particle:deactivate()
	self:move(0, 0)
	self.sprite.visible = false
	self.alive = false
end

function Particle:destroy()
	self.super:destroy()
end