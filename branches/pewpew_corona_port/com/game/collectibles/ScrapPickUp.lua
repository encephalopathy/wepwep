require "com.game.collectibles.Collectible"

ScrapPickUp = Collectible:subclass("ScrapPickUp")

function ScrapPickUp:init(sceneGroup, player, imgSrc, startX, startY, rotation, width, height)
	if width == nil then
		width = 70
	end
	
	if height == nil then
		height = 70
	end
	
	self.super:init(sceneGroup, 'com/resources/art/sprites/swag_01.png', startX, startY, rotation, width, height)
	
	self.initialSpeed = 100
	self.sprite.objRef = self

end

function ScrapPickUp:activateEffect(player)
	--print("Picked up Scrap")
	Runtime:dispatchEvent({name = "playSound", soundHandle = 'ScrapPickUp'})
	--mainInventory.dollaz = mainInventory.dollaz + 5
	--print("dispatchEvent ScrapPickUp.lua addScore")
	--Runtime:dispatchEvent({name = "addScore", score = 5})
end

function ScrapPickUp:update()
	self.super:update(self)
end

function ScrapPickUp:onSpawn()
	self.super:onSpawn()
	local angleOfLaunch = math.random() * 2 * math.pi
	self.sprite:setLinearVelocity(self.initialSpeed * (-math.sin(angleOfLaunch)), self.initialSpeed * math.cos(angleOfLaunch))
end

return ScrapPickUp