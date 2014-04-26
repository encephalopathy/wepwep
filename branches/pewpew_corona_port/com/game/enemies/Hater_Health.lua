require "com.game.enemies.Hater"
--[[
	The basic of the basic. Enemy will move straight down on the screen and then move out of view
	Your everyday normal guy kind of enemy.
]]--

Hater_Health = Hater:subclass("Hater_Health")

switched = false

function Hater_Health:init(sceneGroup, player)
	self.super:init(sceneGroup, "com/resources/art/sprites/enemy_01.png", 0, 0, 0, 75, 75,
	{"com/resources/art/sprites/enemy_01_piece_01.png",
	"com/resources/art/sprites/enemy_01_piece_02.png",
	"com/resources/art/sprites/enemy_01_piece_03.png",
	"com/resources/art/sprites/enemy_01_piece_04.png",
	"com/resources/art/sprites/enemy_01_piece_05.png"}, player)
	--Copy Paste these fields if you plan on using them in the collision function
	
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF THE FILE.
	self.sprite.objRef = self 
	self.health = 5
	self.maxHealth = 5
end

function Hater_Health:initMuzzleLocations()
	self.muzzleLocations = {{x = 0, y = 100}}
end

function Hater_Health:onHit(phase, collide)
	if phase == 'began' then
		if self.alive and collide.isPlayerBullet then
			Runtime:dispatchEvent({name = "playSound", soundHandle = 'Hater_onHit'})
			self.health = self.health - collide.damage
			
			if FreezeMissile:made(collide) then
				self.isFrozen = true
				--TODO:Fix the bug where freeze time is not working
				self.freezeTimer = 0
			end
			
			if self.health <= 0 then
				self:die()
			else
				self.startColorTimer()
			end
		end
   
		if self.alive and collide.type == "player" then
			self.health = 0
		end
	end

end

function Hater_Health:move(x, y)
	self.sprite.y = self.sprite.y + y
end

function Hater_Health:update()
	self.super:update()
   if (self.isFrozen) then
      return
   end
   if self.alive then
	self:move(0,3)
	--if (step % 90 == 0 and self.alive == true) then
	if self.alive == true then
		self:fire()						
	end					
	--end
   end
end

function Hater_Health:die()
	print("Hater_Health:die")
	Runtime:dispatchEvent({name = "playSound", soundHandle = 'Hater_die'})
	Runtime:dispatchEvent({name = "spawnCollectible", target = "HealthPickUp", position =  {x = self.sprite.x, y = self.sprite.y}})
end

--Used to return the file path
function Hater_Health:__tostring()
	return 'com.game.enemies.Hater_Health'
end

return Hater_Health