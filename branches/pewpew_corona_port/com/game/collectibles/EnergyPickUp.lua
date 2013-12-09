require "com.game.collectibles.Collectible"

EnergyPickUp = Collectible:subclass("EnergyPickUp")

function EnergyPickUp:init(sceneGroup, player, imgSrc, startX, startY, rotation, width, height)
	self.super:init(sceneGroup, 'com/resources/art/sprites/bullet_03.png', startX, startY, rotation, width, height)
	
	self.initialSpeed = 100
	self.sprite.objRef = self
end

function EnergyPickUp:activateEffect(player)
	print("Picked up Energy")
	player.powah = player.powah + 5
	if player.powah > PLAYER_MAXPOWAH then
		player.powah = PLAYER_MAXPOWAH
	end
	print('Current Powah: '..player.powah)
end

function EnergyPickUp:update()
	self.super:update(self)
end

function EnergyPickUp:onSpawn()
	self.super:onSpawn()
	local angleOfLaunch = math.random() * 2 * math.pi
	self.sprite:setLinearVelocity(self.initialSpeed * (-math.sin(angleOfLaunch)), self.initialSpeed * math.cos(angleOfLaunch))
end

return EnergyPickUp