require("Object");
require("Queue");
require("Bullet")

BulletManager = Object:subclass("BulletManager");

BulletManager.onScreenBullets = Queue.new()
BulletManager.offScreenBullets = Queue.new()

local function bulletListener (event)
	if (event.name ~= "offScreen") then
		return
	end
	local bullet = Queue.removeObject(BulletManager.static.onScreenBullets, event.bullet);
	Queue.insertFront(BulletManager.static.offScreenBullets, bullet);
end

function BulletManager:init (scene)
	self.sceneGroup = scene
	Runtime:addEventListener("offScreen", bulletListener)
end

DEFAULT_WIDTH = 50
DEFAULT_HEIGHT = 50
DEFAULT_ROTATION = 0

function BulletManager:getBullet (bulletClass, imgSrc, isPlayerBullet, width, height)

	if (imgSrc == nil) then
		imgSrc = "sprites/bullet_02.png"
	end
	if (width == nil) then
		width = DEFAULT_WIDTH
	end
	if (height == nil) then
		height = DEFAULT_HEIGHT
	end
	
	if isPlayerBullet == nil then
		isPlayerBullet = false
	end
	
	-- search for correct type of bullet in off screen queue
	for i = BulletManager.static.offScreenBullets.first, BulletManager.static.offScreenBullets.last, 1 do
	  	local bullet = BulletManager.static.offScreenBullets[i]
		--print(BulletManager.static.offScreenBullets.size)
		--print(bullet)
		if bullet ~= nil then
			if bullet.imgSrc == imgSrc then
				Queue.removeIndex(BulletManager.static.offScreenBullets, i);
				Queue.insertFront(BulletManager.static.onScreenBullets, bullet)
				bullet.isPlayerBullet = isPlayerBullet
				return bullet
			end
		end
	end
	local bullet = bulletClass:new(self.sceneGroup, imgSrc, isPlayerBullet, -5000, -5000, DEFAULT_ROTATION, width, height);
	
	Queue.insertFront(BulletManager.static.onScreenBullets, bullet)
	return bullet
end

local function emptyQueue(queueToEmpty)
	while queueToEmpty.size > 0 do
		local bullet = Queue.removeBack(queueToEmpty)
		if bullet ~= nil then --will take this if statement out when Thomas refactors how bullets are handled.
			bullet:destroy()
		end
	end
end

function BulletManager:clean()
	emptyQueue(BulletManager.static.offScreenBullets)
	emptyQueue(BulletManager.static.onScreenBullets)
end
