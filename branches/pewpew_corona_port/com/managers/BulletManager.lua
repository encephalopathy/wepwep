require "org.Object"
require "org.Queue"
require "com.game.weapons.Bullet"
require "com.game.weapons.primary.SineWaveBullet"
require "com.game.weapons.secondary.StandardMissile"
require "com.game.weapons.secondary.FreezeMissile"

BulletManager = Object:subclass("BulletManager");

local DEFAULT_WIDTH = 65
local DEFAULT_HEIGHT = 65

function BulletManager:init (sceneGroup)
	self.playerOnScreenBullets = {}
	self.playerOffScreenBullets = {}
	self.haterOnScreenBullets = {}
	self.haterOffScreenBullets = {}
	self.bulletGroupInView = display.newGroup()
	sceneGroup:insert(self.bulletGroupInView)
end

function BulletManager:start()
	Runtime:addEventListener("offScreen", self)
end

function BulletManager:offScreen (event)
	if (event.name ~= "offScreen" or not Bullet:made(event.target)) then
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
	
	--print('Ship type collecting bullets on crash: ' .. shipType)
	if bullet ~= nil then
		self:addBulletToOffScreen(offScreenBulletList, onScreenBulletList, bullet)
	end
	
	return true
end

function BulletManager:getBullet (bulletClass, imgSrc, isPlayerBullet, width, height)
	local onScreenBulletList
	local offScreenBulletList
	if (imgSrc == nil) then
		imgSrc = "com/resources/art/sprites/bullet_02.png"
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
		bullet = bulletClass:new(self.bulletGroupInView, imgSrc, isPlayerBullet, width, height)
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
				--print('Caching Bullet: ' .. tostring(bullet) .. ' imgSrc: ' .. tostring(bullet.imgSrc))
				
				if offScreenBullets[tostring(bullet)] == nil then
					offScreenBullets[tostring(bullet)] = {}
				end
				
				if offScreenBullets[tostring(bullet)][bullet.imgSrc] == nil then
					offScreenBullets[tostring(bullet)][bullet.imgSrc] = Queue.new()
				end
				
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

	Queue.insertFront(onScreenList[tostring(bullet)][bullet.imgSrc], bullet)
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

	Queue.insertFront(offScreenList[tostring(bullet)][bullet.imgSrc], bullet)
end

function BulletManager:stop(sceneGroup)
	-- print('Stopping bullet Manager')
	-- print('PLAYER BULLETS ON SCREEN')
	-- for bulletName, bulletTable in pairs(self.playerOnScreenBullets) do
		-- print('key: ' .. tostring(bulletName) .. ' value: ' .. tostring(bulletTable))
		-- for bulletImgSrc, bullet in pairs(bulletTable) do
			-- print('		' .. tostring(bulletImgSrc) .. ': ' .. tostring(bullet))
		-- end 
	-- end
	
	-- print('HATER BULLETS ON SCREEN')
	-- for bulletName, bulletTable in pairs(self.haterOnScreenBullets) do
		-- print('bulletName: ' .. tostring(bulletName) .. ' value: ' .. tostring(bulletTable))
		
		-- for bulletImgSrc, bullet in pairs(bulletTable) do
			-- print('		' .. tostring(bulletImgSrc) .. ': ' .. tostring(bullet))
		-- end
	-- end
	self:cacheOnScreenAmmo(self.playerOnScreenBullets, self.playerOffScreenBullets, self.bulletGroupInView)
	self:cacheOnScreenAmmo(self.haterOnScreenBullets, self.haterOffScreenBullets, self.bulletGroupInView)
	Runtime:removeEventListener("offScreen", self)
end
