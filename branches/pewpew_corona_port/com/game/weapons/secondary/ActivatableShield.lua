require "com.game.passives.Player.PassiveShield"

ActivatableShield = Ride:subclass("ActivatableShield")

function ActivatableShield:init(sceneGroup, imgSrc, objectRef, sizeX, sizeY, shieldHealth)
	if sceneGroup == nil then
		assert("Activatable Shield: scenegroup is nil")
	elseif imgSrc == nil then
		print("Activatable Shield: imgsrc is nil, using default image")
		imgSrc = "com/resources/art/sprites/bullet_03.png"
	end

	self.i = 0
	self.health = shieldHealth
	self.maxhealth = shieldHealth
	self.isOn = false

	self.type = "dead"

	self.super:init(sceneGroup, imgSrc, objectRef.sprite.x, objectRef.sprite.y, rotation, sizeX, sizeY, nil, { categoryBits = 1, maskBits = 10 })
	self.sprite.objRef = self
	self.sprite:setFillColor(1, 1, 1, 0)
end

function ActivatableShield:onHit(phase, collide)
	if phase == "ended"  then
		if self.health > 0 and self.isOn == true then
			if not collide.isPlayerBullet and not Collectible:made(collide)  then
				self.health = self.health - 1
				Runtime:dispatchEvent({name = "playSound", soundHandle = 'Player_onHit'})
				if self.health <= 0 and not debugFlag then
					--sound:load(self.soundPathDeath) 
					--got the deadness
					--playerDeathSFX:play()
					self.type = "dead"
				end
			end
		end
	end
end

function ActivatableShield:update(x, y)
	if self.health > 0 and self.isOn == true and self.i == 0.75 then
		--if isOn
		self.sprite.x = x
		self.sprite.y = y
	elseif self.health > 0 and self.isOn == true and self.i < 0.75 then
		--if isOn but not fully visible, make it visible
		self.sprite.x = x
		self.sprite.y = y
		self.i = self.i + 0.25
		self.sprite:setFillColor(1, 1, 1, 1)
	elseif self.health > 0 and self.isOn == false and self.i > 0 then
		--if not isOn but still alive, make transparent
		self.sprite.x = x
		self.sprite.y = y
		self.i = self.i - 0.25
		self.sprite:setFillColor(1, 1, 1, self.i)
	elseif self.health == 0 and self.i > 0 then
		--if not isOn and not alive, make transparent
		self.sprite.x = x
		self.sprite.y = y
		self.i = self.i - 0.25
		self.sprite:setFillColor(1, 1, 1, self.i)
	end
end

function ActivatableShield:activate()
	if self.isOn == false then
		if self.health > 0 then
			self.isOn = true
			self.type = "player"
		end
	elseif self.isOn == true then
		self.isOn = false
		self.type = "dead"
	end
end

return ActivatableShield