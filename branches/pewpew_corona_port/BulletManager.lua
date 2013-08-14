require("Object");
require("Queue");
require("Bullet")
require("SineWaveBullet")

BulletManager = Object:subclass("BulletManager");

local DEFAULT_WIDTH = 50
local DEFAULT_HEIGHT = 50
local DEFAULT_ROTATION = 0

function BulletManager:init (scene)
	self.sceneGroup = scene
	self.playerOnScreenBullets = {}
	self.playerOffScreenBullets = {}
	self.haterOnScreenBullets = {}
	self.haterOffScreenBullets = {}
end

function BulletManager:start()
	print('Starting BulletManager')
	self:reactivateCachedBullets(self.playerOffScreenBullets)
	self:reactivateCachedBullets(self.haterOffScreenBullets)
	Runtime:addEventListener("offScreen", self)
end

function BulletManager:offScreen (event)
	if (event.name ~= "offScreen" or event.bullet.alive == false) then
		return
	end
	--if not usingBulletManagerBullets then return true end
	local bullet = event.bullet
	local onScreenBulletList
	local offScreenBulletList
	
	if bullet.isPlayerBullet then
		onScreenBulletList = self.playerOnScreenBullets
		offScreenBulletList = self.playerOffScreenBullets
	else
		onScreenBulletList = self.haterOnScreenBullets
		offScreenBulletList = self.haterOffScreenBullets
	end
	self:addBulletToOffScreen(offScreenBulletList, onScreenBulletList, bullet)
	return true
end

function BulletManager:getBullet (bulletClass, imgSrc, isPlayerBullet, width, height)
	local onScreenBulletList
	local offScreenBulletList

	if (imgSrc == nil) then
		imgSrc = "sprites/bullet_02.png"
	end
	if (width == nil) then
		width = DEFAULT_WIDTH
	end
	if (height == nil) then
		height = DEFAULT_HEIGHT
	end
	
	if isPlayerBullet ~= nil then
		if isPlayerBullet then
			onScreenBulletList = self.playerOnScreenBullets
			offScreenBulletList = self.playerOffScreenBullets
		else
			onScreenBulletList = self.haterOnScreenBullets
			offScreenBulletList = self.haterOffScreenBullets
		end
	end
	
	local bullet = nil;
	bullet = self:getBulletFromOffScreen (offScreenBulletList, bulletClass, imgSrc)
	if (bullet == nil) then
		print('Is a nil bullet')
		bullet = bulletClass:new(self.sceneGroup, imgSrc, isPlayerBullet, -5000, -5000, DEFAULT_ROTATION, width, height)
	end
	
	self:addBulletToOnScreen(onScreenBulletList, bullet)
	return bullet
end

function BulletManager:reactivateCachedBullets(offScreenBullets)
	if #offScreenBullets == 0 then return end
	for className, typeOfBullets in ipairs(offScreenbullets) do
		for imgSrc, bullets in ipairs(typeOfBullets[className]) do
			for i = bullets.first, bullets.last, -1 do
				self.sceneGroup:insert(bullets[imgSrc], bullets[imgSrc].sprite)
			end
		end
	end
end

function BulletManager:cacheOnScreenAmmo(onScreenBullets, offScreenBullets)
	for className, typeOfBullets in ipairs(onScreenBullets) do
		for imgSrc, bullets in ipairs(typeOfBullets) do
			while bullets.size > 0 do
				local bullet = Queue.removeBack(bullets)
				self.sceneGroup:remove(bullet.sprite)
				Queue.insertFront(offScreenBullets[tostring(className)][imgSrc], bullet)
			end
		end
	end
end

function BulletManager:addBulletToOnScreen(onScreenList, bullet)
	if (onScreenList[tostring(bullet)] == nil) then
		onScreenList[tostring(bullet)] = {}
	end
	if (onScreenList[tostring(bullet)][bullet.imgSrc] == nil) then
		onScreenList[tostring(bullet)][bullet.imgSrc] = Queue.new()
	end
	print(bullet.creationCount)
	Queue.insertFront(onScreenList[tostring(bullet)][bullet.imgSrc], bullet)
end

function BulletManager:getBulletFromOnScreen(onScreenList, bullet)
	assert(bullet ~= nil)
	local newBullet = Queue.removeObject(onScreenList[tostring(bullet)][bullet.imgSrc], bullet)
	return newBullet
end

function BulletManager:getBulletFromOffScreen (offScreenList, bulletClass, imgSrc)
	if (offScreenList[tostring(bulletClass)] == nil) then
		return nil
	end
	if (offScreenList[tostring(bulletClass)][imgSrc] == nil) then
		return nil
	end
	print('OffScreenList size: ' .. offScreenList[tostring(bulletClass)][imgSrc].size)
	return Queue.removeBack(offScreenList[tostring(bulletClass)][imgSrc])
end

function BulletManager:addBulletToOffScreen (offScreenList, onScreenList, bullet)
	assert(offScreenList ~= nil)
	assert(onScreenList ~= nil)
	assert(bullet ~= nil)
	
	if (offScreenList[tostring(bullet)] == nil) then
		offScreenList[tostring(bullet)] = {}
	end
	if (offScreenList[tostring(bullet)][bullet.imgSrc] == nil) then
		offScreenList[tostring(bullet)][bullet.imgSrc] = Queue.new()
	end
	--Disable Box2D movement here
	bullet.alive = false
	bullet = Queue.removeObject(onScreenList[tostring(bullet)][bullet.imgSrc], bullet)
	print('OnScreenList size: ' .. onScreenList[tostring(bullet)][bullet.imgSrc].size)
	Queue.insertFront(offScreenList[tostring(bullet)][bullet.imgSrc], bullet)
end

function BulletManager:stop()
	self:cacheOnScreenAmmo(self.playerOnScreenBullets, self.playerOffScreenBullets, self.sceneGroup)
	self:cacheOnScreenAmmo(self.haterOnScreenBullets, self.haterOffScreenBullets, self.sceneGroup)
end
