require "com.game.enemies.Hater"

--[[
	A lean, mean, green machine. His power is ultimate!
]]--

Hater_BIGBOSSU = Hater:subclass("Hater_BIGBOSSU")

switched = false

function Hater_BIGBOSSU:init(sceneGroup)
	self.super:init(sceneGroup, "com/resources/art/sprites/boss_01.png", 0, 0, 0, 100, 100)
	--Copy Paste these fields if you plan on using them in the collision function
	
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF THE FILE.
	self.sprite.objRef = self 
	moveLeft = false
	moveRight = false
	startMoving = false
	self.health = 50
	self.maxHealth = 50
end

function Hater_BIGBOSSU:initMuzzleLocations()
	self.muzzleLocations = {{x = 0, y = 100}}
end

function Hater_BIGBOSSU:move(x, y)
	--[[
		This fool ominously floats down to the top of the screen and then oscillates left and right
	]]--
	--self:move(math.sin(self.time*4*math.pi/400)*2,3)
	--print("LOLOLOLOL")
	if moveRight then self.sprite.x = self.sprite.x + x end
	if moveLeft then self.sprite.x = self.sprite.x - x end
	if startMoving == false  then self.sprite.y = self.sprite.y + y end
	
	if self.sprite.y > 150 and startMoving == false then
		startMoving = true
		moveRight = true
	end
	
	if self.sprite.x > 400 then 
		moveRight = false
		moveLeft = true
	end
	
	if self.sprite.x < 40 then 
		moveRight = true
		moveLeft = false
	end
	
end

function Hater_BIGBOSSU:update()
	self.super:update()
	if self.alive then
		if (step % 90 == 0 and self.alive == true) then
				self:fire()						
		end
	end
	self:move(3,2)
end

function Hater_BIGBOSSU:__tostring()
	return 'com.game.enemies.BIGBOSSU'
end

return Hater_BIGBOSSU