require("Object");
require("Queue");
require("Bullet")
require("SineWaveBullet")

BulletManager = Object:subclass("BulletManager");

BulletManager.onScreenBullets = {}
BulletManager.offScreenBullets = {}

--onScreenBullets[bullet.className][bullet.imgSrc]

function BulletManager:offScreen (event)
	if (event.name ~= "offScreen") then
		return
	end
	local bullet = self:getBulletFromOnScreen(event.bullet);
	self:addBulletToOffScreen(event.bullet)
end

function BulletManager:init (scene)
	self.sceneGroup = scene
	Runtime:addEventListener("offScreen", self)
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
	
	local bullet = nil;
	bullet = self:getBulletFromOffScreen (bulletClass, imgSrc)
	if (bullet == nil) then
		bullet = bulletClass:new(self.sceneGroup, imgSrc, isPlayerBullet, -5000, -5000, DEFAULT_ROTATION, width, height);
	end
	self:addBulletToOnScreen(bullet)
	return bullet
end

function BulletManager:getBulletFromOnScreen (bullet)
	return Queue.removeObject(BulletManager.static.onScreenBullets[bullet.className][bullet.imgSrc], bullet)
end

function BulletManager:addBulletToOnScreen (bullet)
	if (BulletManager.static.onScreenBullets[bullet.className] == nil) then
		BulletManager.static.onScreenBullets[bullet.className] = {}
	end
	if (BulletManager.static.onScreenBullets[bullet.className][bullet.imgSrc] == nil) then
		BulletManager.static.onScreenBullets[bullet.className][bullet.imgSrc] = Queue.new()
	end
	Queue.insertFront(BulletManager.static.onScreenBullets[bullet.className][bullet.imgSrc], bullet)
end

function BulletManager:getBulletFromOffScreen (bulletClass, imgSrc)
	if (BulletManager.static.offScreenBullets[bulletClass.static.className] == nil) then
		return nil
	end
	if (BulletManager.static.offScreenBullets[bulletClass.static.className][imgSrc] == nil) then
		return nil
	end
	return Queue.removeBack(BulletManager.static.offScreenBullets[bulletClass.static.className][imgSrc])
end

function BulletManager:addBulletToOffScreen (bullet)
	if (BulletManager.static.offScreenBullets[bullet.className] == nil) then
		BulletManager.static.offScreenBullets[bullet.className] = {}
	end
	if (BulletManager.static.offScreenBullets[bullet.className][bullet.imgSrc] == nil) then
		BulletManager.static.offScreenBullets[bullet.className][bullet.imgSrc] = Queue.new()
	end
	Queue.insertFront(BulletManager.static.offScreenBullets[bullet.className][bullet.imgSrc], bullet)
end

function BulletManager:clean()

end
