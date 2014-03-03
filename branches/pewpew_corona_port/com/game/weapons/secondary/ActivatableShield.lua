require "com.game.passives.Player.PassiveShield"

ActivatableShield = PassiveShield:subclass("ActivatableShield")

function ActivatableShield:init(scengroup, imgSrc, objectRef, sizeX, sizeY)
	if scenegroup == nil then
		assert("Activatable Shield: scenegroup is nil")
	elseif imgSrc == nil then
		print("Activatable Shield: imgsrc is nil, using default image")
		imgSrc = "com/resources/art/sprites/bullet_03.png"
	end

	self.i = 1

	self.active = false

	self.type = "player"

	self.super:init(sceneGroup, imgSrc, objectRef.sprite.x, objectRef.sprite.y, rotation, sizeX, sizeY, nil, { categoryBits = 1, maskBits = 10 })
	self.sprite.objRef = self
	self.sprite:setFillColor(1, 1, 1, 0.5)
end

function PassiveShield:onHit(phase, collide)
	if phase == "ended"  then
		if self.alive == true and self.active == true then
			if not collide.isPlayerBullet and not Collectible:made(collide)  then
				self.item.ammoAmount = self.item.ammoAmount - 1
				Runtime:dispatchEvent({name = "playSound", soundHandle = 'Player_onHit'})
				if self.item.ammoAmount <= 0 and not debugFlag then
					--sound:load(self.soundPathDeath) 
					--got the deadness
					--playerDeathSFX:play()
					self.alive = false
					self.type = "dead"
				end
			end
		end
	end
end

function PassiveShield:update(x, y)
	if self.alive == true and self.active == true then
		self.sprite.x = x
		self.sprite.y = y
	elseif self.alive == false and self.i >= 0 then
		self.i = self.i - 0.25
		self.sprite:setFillColor(1, 1, 1, self.i)
	elseif self.alive == false and self.i == 0 then
		self.super:destroy()
	end
end