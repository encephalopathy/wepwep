require("Bullet")
require("Utility")
HomingBullet = Bullet:subclass("HomingBullet")

function HomingBullet:init(sceneGroup, imgSrc, isPlayerBullet, startX, startY, rotation, width, height)
	self.super:init(sceneGroup, imgSrc, isPlayerBullet, startX, startY, 0, width, height)
	self.hasTarget = false
end

function HomingBullet:selectATarget()
	local closestTargetDistance = math.sqrt(display.contentWidth * display.contentWidth + display.contentHeight * display.contentHeight)
	local closestTarget = nil
	for target in pairs (self.targets) do
		local currentTargetDistance = self:getDistanceToTarget(target)
		if currentTargetDistance < closestTargetDistance and self.sprite.y > target.sprite.y and target.alive then
			closestTarget = target
			closestTargetDistance = currentTargetDistance
			--print('piece of shit')
		end
	end
	return closestTarget
end

function HomingBullet:getDistanceToTarget(target)
	local haterDistance = distance(self.sprite.x, self.sprite.y, target.sprite.x, target.sprite.y)
	return haterDistance
end

function HomingBullet:fire(bulletSpeed)
	local updateFunction = function()
		if not self.hasTarget then
			local newTarget = self:selectATarget()
			if newTarget ~= nil then
				--local rotation = math.rad(self.sprite.rotation)
				--self.super:fire(bulletSpeed * math.cos(rotation), bulletSpeed * math.sin(rotation))
			--else
				local targetVectorX = newTarget.sprite.x - self.sprite.x
				local targetVectorY = newTarget.sprite.y - self.sprite.y
				local targetVectorMagnitude = math.sqrt(targetVectorX * targetVectorX + targetVectorY * targetVectorY)
				self.sprite.rotation = -math.deg(math.acos(-targetVectorY / targetVectorMagnitude))
				
				local speedRatio = bulletSpeed / targetVectorMagnitude
				
				local xVelocity = targetVectorX * speedRatio
				local yVelocity = targetVectorY * speedRatio

				self.super:fire(xVelocity, yVelocity)
			end
		end
	end
	self.alive = true
	Runtime:addEventListener("enterFrame", updateFunction)
	self.update = updateFunction
end

function HomingBullet:__tostring()
	return "A HomingBullet with initial.xy ( " .. self.initialX .. ", " .. self.initialY .. " )"
end

function HomingBullet:recycle(bullet)
	--self.super:recycle()
	self.sprite.x = 5000
    self.sprite.y = 5000
    self.alive = false
	Runtime:removeEventListener("enterFrame", self.update)
end

function HomingBullet:destroy()
	self.updateFunction = nil
	self.super:destroy()
end

