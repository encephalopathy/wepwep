require("Hater")

--[[
	This is a speific type of enemy, it moves at regular speed with a regular shot.
	It is intended to move in a curve from the top of the screen to one of the sides
	It always shoots directly at the player at a fixed interval.
]]--

Hater_FIRECROTCH = Hater:subclass("Hater_FIRECROTCH")

switched = false

function Hater_FIRECROTCH:init(sceneGroup, imgSrc, x, y, rotation, width, height)
	self.super:init(sceneGroup, imgSrc, x, y, rotation, width, height)
	--Copy Paste these fields if you plan on using them in the collision function
	
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF THE FILE.
	self.sprite.objRef = self 
	moveLeft = false
	moveRight = false
	startMoving = false
	self.health = 50
	self.maxHealth = 50
end

function Hater_FIRECROTCH:equipRig(sceneGroup)
	self:equip(self.primaryWeapons, Singleshot, sceneGroup, 15, {0, 30})
end

function Hater_FIRECROTCH:move(x, y)
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

function Hater_FIRECROTCH:update()
	self.super:update()
	if self.alive then
		if (step % 90 == 0 and self.alive == true) then
				self:fire()						
		end
	end
	self:move(3,2)
end

