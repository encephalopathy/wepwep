require "com.game.collectibles.Collectible"

HealthPickUp = Collectible:subclass("HealthPickUp")

function HealthPickUp:init(sceneGroup, player, imgSrc, startX, startY, rotation, width, height)
	self.super:init(sceneGroup, 'com/resources/art/sprites/heart.png', startX, startY, rotation, width, height)
	
	self.initialSpeed = 100
	self.sprite.objRef = self
end

function HealthPickUp:activateEffect(player)
	player.health = player.health + 5
end

function HealthPickUp:update()
	self.super:update(self)
end

function HealthPickUp:onSpawn()
	self.super:onSpawn()
	local angleOfLaunch = math.random() * 2 * math.pi
	self.sprite:setLinearVelocity(self.initialSpeed * (-math.sin(angleOfLaunch)), self.initialSpeed * math.cos(angleOfLaunch))
end

return HealthPickUp