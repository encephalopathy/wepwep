require("Object");
require("Queue");
require("Bullet")
require("SineWaveBullet")

BulletManager = Object:subclass("BulletManager");

local DEFAULT_WIDTH = 50
local DEFAULT_HEIGHT = 50
local DEFAULT_ROTATION = 0

--local bulletGroupInView = display.newGroup()
--local bulletGroupOutofView = display.newGroup()

function BulletManager:init (scene)
	self.sceneGroup = scene
	self.playerOnScreenBullets = {}
	self.playerOffScreenBullets = {}
	self.haterOnScreenBullets = {}
	self.haterOffScreenBullets = {}
	self.bulletGroupInView = display.newGroup()
	--self.bulletGroupOutofView = display.newGroup()
	--self.sceneGroup:insert(self.bulletGroupInView)
	--self.bulletGroupOutofView:removeSelf()
end

function BulletManager:start()
	print('Starting BulletManager')
	Runtime:addEventListener("offScreen", self)
end

function BulletManager:offScreen (event)
	if (event.name ~= "offScreen") then
		return
	end

	local bullet = event.target
	local onScreenBulletList
	local offScreenBulletList
	
	local shipType
	if bullet.isPlayerBullet then
		onScreenBulletList = self.playerOnScreenBullets
		offScreenBulletList = self.playerOffScreenBullets
		shipType = 'player '
	else
		onScreenBulletList = self.haterOnScreenBullets
		offScreenBulletList = self.haterOffScreenBullets
		shipType = 'hater '
	end
	if offScreenBulletList[tostring(bullet)] ~= nil then
		if offScreenBulletList[tostring(bullet)][bullet.imgSrc] ~= nil then
			print(shipType .. 'onScreenList.size ' .. onScreenBulletList[tostring(bullet)][bullet.imgSrc].size)
			print(shipType .. 'offScreenBulletList.size ' .. offScreenBulletList[tostring(bullet)][bullet.imgSrc].size)
		end
	end
	
	self:addBulletToOffScreen(offScreenBulletList, onScreenBulletList, bullet)
	
	--print(shipType .. 'offScreenBulletList.size ' .. offScreenBulletList[tostring(bullet)][bullet.imgSrc].size)
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
	print('create bullet')
	if (bullet == nil) then
		print('Is a nil bullet AND BULLET SIZE = 0')
		bullet = bulletClass:new(self.bulletGroupInView, imgSrc, isPlayerBullet, -5000, -5000, DEFAULT_ROTATION, width, height)
	end
	
	self:addBulletToOnScreen(onScreenBulletList, bullet)
	return bullet
end

function BulletManager:cacheOnScreenAmmo(onScreenBullets, offScreenBullets)
	for className, typeOfBullets in pairs(onScreenBullets) do
		for imgSrc, bullets in pairs(typeOfBullets) do
			while bullets.size > 0 do
				local bullet = Queue.removeBack(bullets)
				bullet.sprite.isVisible = false
				bullet.sprite.x = 5000
				bullet.sprite.y = 5000
				--self.bulletGroupOutofView:insert(bullet.sprite)
				--self.bulletGroupInView:remove(bullet.sprite)
				Queue.insertFront(offScreenBullets[tostring(bullet)][bullet.imgSrc], bullet)
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

	assert(bullet.sprite ~= nil)
	bullet.sprite.isVisible = true
	bullet.sprite.isBodyActive = true
	--self.bulletGroupInView:insert(bullet.sprite)
	--self.bulletGroupOutofView:remove(bullet.sprite)
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
	bullet.sprite.isVisible = false
	bullet.sprite.isBodyActive = false
	bullet.sprite.x = 5000
    bullet.sprite.y = 5000

	
	bullet = Queue.removeObject(onScreenList[tostring(bullet)][bullet.imgSrc], bullet)
	print('onScreenBulletSize: ' .. onScreenList['Bullet']['sprites/bullet_02.png'].size)
	print('offScreenBulletSize: ' .. offScreenList['Bullet']['sprites/bullet_02.png'].size)
	Queue.insertFront(offScreenList[tostring(bullet)][bullet.imgSrc], bullet)
end

function BulletManager:stop()
	self:cacheOnScreenAmmo(self.playerOnScreenBullets, self.playerOffScreenBullets, self.sceneGroup)
	--if self.playerOnScreenBullets['Bullet']['sprites/bullet_02.png'] ~= nil then
		print('player onScreenBulletSize: ' .. self.playerOnScreenBullets['Bullet']['sprites/bullet_02.png'].size)
		print('player offScreenBulletSize: ' .. self.playerOffScreenBullets['Bullet']['sprites/bullet_02.png'].size)
	--end
	self:cacheOnScreenAmmo(self.haterOnScreenBullets, self.haterOffScreenBullets, self.sceneGroup)
	--if self.playerOnScreenBullets['Bullet']['sprites/bullet_02.png'] ~= nil then
		print('hater onScreenBulletSize: ' .. self.haterOnScreenBullets['Bullet']['sprites/bullet_02.png'].size)
		print('hater offScreenBulletSize: ' .. self.haterOffScreenBullets['Bullet']['sprites/bullet_02.png'].size)
	--end
end
