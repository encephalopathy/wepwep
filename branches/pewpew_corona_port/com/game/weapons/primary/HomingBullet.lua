require "com.game.weapons.Bullet"
require "com.Utility"
require "com.game.enemies.Hater"
HomingBullet = Bullet:subclass("HomingBullet")

--[[TODO: Would be nice if the homing bullet arched after fired.  For the person reading this and needs to implement this, this
	would require the use of an acceleration vector that changes the velocity vector.
]]--
function HomingBullet:init(sceneGroup, imgSrc, isPlayerBullet, width, height)
	self.super:init(sceneGroup, imgSrc, isPlayerBullet, width, height)
	self.hasTarget = false
end

function HomingBullet:selectATarget()
	local closestTargetDistance = math.sqrt(display.contentWidth * display.contentWidth + display.contentHeight * display.contentHeight)
	local closestTarget = nil
	for target in pairs (self.targets) do
		local currentTargetDistance = self:getDistanceToTarget(target)
		if currentTargetDistance < closestTargetDistance and self:bulletisPastTarget(target, self.sprite) and target.alive then
			closestTarget = target
			closestTargetDistance = currentTargetDistance
		end
	end
	return closestTarget
end

function HomingBullet:getDistanceToTarget(target)
	local haterDistance = distance(self.sprite.x, self.sprite.y, target.sprite.x, target.sprite.y)
	return haterDistance
end

--Will need to change this when we add passives that the player can equip and shoot things with
function HomingBullet:bulletisPastTarget(target, bullet)
	if Hater:made(target) then return (bullet.y > target.sprite.y) else return (bullet.y < target.sprite.y) end
end

function HomingBullet:fire(bulletSpeed)
	local updateFunction = function()
		if not self.hasTarget then
			local newTarget = self:selectATarget()
			if newTarget ~= nil then
				local targetVectorX = newTarget.sprite.x - self.sprite.x
				local targetVectorY = newTarget.sprite.y - self.sprite.y
				local targetVectorMagnitude = math.sqrt(targetVectorX * targetVectorX + targetVectorY * targetVectorY)
				
				local rotationAngle = math.deg(math.acos(-targetVectorY / targetVectorMagnitude))
				if targetVectorX < 0 then
					rotationAngle = -rotationAngle
				end
				self.sprite.rotation = rotationAngle
				
				local speedRatio = bulletSpeed / targetVectorMagnitude
				
				local xVelocity = targetVectorX * speedRatio
				local yVelocity = targetVectorY * speedRatio

				self.super:fire(xVelocity, yVelocity)
				self.previousVelocity = { x = xVelocity, y = yVelocity }
			end
		end
	end
	self.alive = true
	Runtime:addEventListener("enterFrame", updateFunction)
	self.update = updateFunction
end

function HomingBullet:__tostring()
	return "HomingBullet"
end

function HomingBullet:recycle()
	Runtime:removeEventListener("enterFrame", self.update)
	self.super:recycle(self)
end

function HomingBullet:destroy()
	self.updateFunction = nil
	self.super:destroy()
end

