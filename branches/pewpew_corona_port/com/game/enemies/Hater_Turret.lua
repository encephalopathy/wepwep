require "com.game.enemies.Hater_Homing"

--[[
	This enemy will move along a given vector while shooting towards the player's current position.
]]--

Hater_Turret = Hater:subclass("Hater_Turret")

switched = false

function Hater_Turret:init(sceneGroup, player)
	self.super:init(sceneGroup, "com/resources/art/sprites/turret.png", 0, 0, 0, 75, 75,
	{"com/resources/art/sprites/enemy_03_piece_01.png", 
	"com/resources/art/sprites/enemy_03_piece_02.png", 
	"com/resources/art/sprites/enemy_03_piece_03.png", 
	"com/resources/art/sprites/enemy_03_piece_04.png", 
	"com/resources/art/sprites/enemy_03_piece_05.png"}, player)
	--Copy Paste these fields if you plan on using them in the collision function
	--self.playerRef = player
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF THE FILE.
	self.sprite.objRef = self 
	self.health = 25
	self.maxHealth = 25

	self.speed = 2
end

function Hater_Turret:initMuzzleLocations()
	self.muzzleLocations = {{x = 0, y = 100}}
end

function Hater_Turret:move(x, y)
	self.sprite.x = self.sprite.x + x
	self.sprite.y = self.sprite.y + y
end

function Hater_Turret:update()
	self.super:update()
	
	if self.XVector == nil and self.YVector == nil then
		self.angle = math.rad(self.sprite.rotation)
		self.YVector = math.cos(self.angle)
		self.XVector = -math.sin(self.angle)
	end
	
	local player = self.playerRef
	local width = player.sprite.x - self.sprite.x
	local height = player.sprite.y - self.sprite.y

	if self.alive then
		if self.isFrozen then
			return
		else
			unitHeight = (height/math.sqrt(width*width+height*height))
			local rotAngle = (180/math.pi) * math.acos(unitHeight)
			if width >= 0 then
				rotAngle = -rotAngle
			end
			self.sprite.rotation = rotAngle
			self:move(self.speed*self.XVector, self.speed*self.YVector)
			self:fire()
		end
	end
end

function Hater_Turret:fire()
	if self.alive then
		self.super:fire()
	end
end

function Hater_Turret:__tostring()
	return 'com.game.enemies.Hater_Turret'
end

return Hater_Turret