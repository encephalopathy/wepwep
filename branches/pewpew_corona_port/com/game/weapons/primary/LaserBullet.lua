require "com.game.weapons.Bullet"
require "com.Utility"
require "com.physics"
LaserBullet = Bullet:subclass("LaserBullet")

function LaserBullet:init(sceneGroup, imgSrc, isPlayerBullet, width, height)
	self.super:init(sceneGroup, imgSrc, isPlayerBullet, width, height)
end

function LaserBullet:fire(Player, MuzzleLocation)
	local updateFunction = function() 
		self:move(Player.X, Player.Y)
		local directionX =  (MuzzleLocation.X-Player.X)/distance(Player.X,Player.Y,MuzzleLocation.X,MuzzleLocation.Y)
		local directionY = (MuzzleLocation.Y-Player.Y)/distance(Player.X,Player.Y,MuzzleLocation.X,MuzzleLocation.Y)
		currentX = Player.X
		currentY = Player.Y
		local vector = {X = 0, Y = 0, Magnitude = 0}
		vector.X = directionX
		vector.Y = directionY
		vector.Magnitude = distance(Player.X,Player.Y,MuzzleLocation.X,MuzzleLocation.Y)
		local rayCast = display.newImageRect( sceneGroup, nil, 1, 1)
		physics.addBody( rayCast, "dynamic", {density=0, filter = collisionFilter, shape = verticies} )
		while rayCast.minY > 0 or rayCast.maxY do

		end
		self.time = self.time + 1
	end
	self.alive = true
	Runtime:addEventListener("enterFrame", updateFunction)
	self.update = updateFunction
end


function LaserBullet:bulletMiss()
	hastheBulletHit = false;
	if (currentY > display.contentWidth) then
		hastheBulletHit = true;
	elseif (currentY < 0) then
		hastheBulletHit = true;
	elseif (currentX > display.contentHeight) then
		hastheBulletHit = true;
	elseif (currentX < 0) then
		hastheBulletHit = true;
	else then
		hastheBulletHit = false;
	end
	return !hastheBulletHit
end

function LaserBullet:__tostring()
	return "LaserBullet"
end

function LaserBullet:recycle()
	Runtime:removeEventListener("enterFrame", self.update)
	self.super:recycle(self)
	
end

function LaserBullet:destroy()
	self.updateFunction = nil
	self.super:destroy()
end

