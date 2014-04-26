require "com.game.enemies.Hater"
--[[
	The basic of the basic. Enemy will move straight down on the screen and then move out of view
	Your everyday normal guy kind of enemy.
]]--

Hater_Normal = Hater:subclass("Hater_Normal")

switched = false

function Hater_Normal:init(sceneGroup, player)
	self.super:init(sceneGroup, "com/resources/art/sprites/enemy_01.png", 0, 0, 0, 75, 75,
	{"com/resources/art/sprites/enemy_01_piece_01.png",
	"com/resources/art/sprites/enemy_01_piece_02.png",
	"com/resources/art/sprites/enemy_01_piece_03.png",
	"com/resources/art/sprites/enemy_01_piece_04.png",
	"com/resources/art/sprites/enemy_01_piece_05.png"}, player)
	--Copy Paste these fields if you plan on using them in the collision function
	
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF THE FILE.
	self.sprite.objRef = self 
	self.health = 1
	self.maxHealth = 1
	self.speed = 3
end

function Hater_Normal:initMuzzleLocations()
	self.muzzleLocations = {{x = 0, y = 100}}
end

function Hater_Normal:move(x, y)
	self.sprite.x = self.sprite.x + x
	self.sprite.y = self.sprite.y + y
end

--Used to return the file path of a hater
function Hater_Normal:__tostring()
	return 'com.game.enemies.Hater_Normal'
end

function Hater_Normal:update()

	self.super:update()
	
	if self.XVector == nil and self.YVector == nil then
		self.angle = math.rad(self.sprite.rotation)
		self.YVector = math.cos(self.angle)
		self.XVector = -math.sin(self.angle)
	end

   	if (self.isFrozen) then
    	return
   	end
   	if self.alive then
		self:move(self.speed*self.XVector, self.speed*self.YVector)
		--if (step % 90 == 0 and self.alive == true) then
		if self.alive == true then
			self:fire()						
		end					
	--end
   end
end

return Hater_Normal