require "com.game.collectibles.Collectible"

HealthPickUp = Collectible:subclass("HealthPickUp")

function HealthPickUp:init(sceneGroup, player, imgSrc, startX, startY, rotation, width, height)
	if width == nil then
		width = 65
	end
	
	if height == nil then
		height = 65
	end
	self.super:init(sceneGroup, 'com/resources/art/sprites/heart.png', startX, startY, rotation, width, height)
	
	self.initialSpeed = 100
	self.sprite.objRef = self
end

function HealthPickUp:activateEffect(player)
	print("HealthPickUp:activateEffect: HealthPickUp collected")
	Runtime:dispatchEvent({name = "playSound", soundHandle = 'HealthPickUp'})
	player.health = player.health + (PLAYER_MAXHEALTH * .1) --TODO: THIS VALUE WILL BE AFFECTED BY PASSIVES
	if player.health > PLAYER_MAXHEALTH then
		player.health = PLAYER_MAXHEALTH
	end
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