require "com.game.enemies.Hater_Homing"

--[[
	This enemy will move along a given vector while shooting towards the player's current position.
]]--

Hater_Turret = Hater:subclass("Hater_Turret")

switched = false

function Hater_Turret:init(sceneGroup, player)
	self.super:init(sceneGroup, "com/resources/art/sprites/turret.png", 0, 0, 0, 100, 100,
	{"com/resources/art/sprites/enemy_03_piece_01.png", 
	"com/resources/art/sprites/enemy_03_piece_02.png", 
	"com/resources/art/sprites/enemy_03_piece_03.png", 
	"com/resources/art/sprites/enemy_03_piece_04.png", 
	"com/resources/art/sprites/enemy_03_piece_05.png"}, player)
	--Copy Paste these fields if you plan on using them in the collision function
	--self.playerRef = player
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF THE FILE.
	self.sprite.objRef = self 
	self.health = 2
	self.maxHealth = 2

	self.speed = 3
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
		print("Hater_Turret:update() self.sprite.rotation is ", self.sprite.rotation)
		if self.sprite.rotation == 90 or self.sprite.rotation == 270 then
			self.angle = math.rad(self.sprite.rotation - 90)
			self.XVector = math.cos(self.angle)
			self.YVector = math.sin(self.angle)
			--self.sprite.rotation = self.sprite.rotation * -1
		else
			self.XVector = 0
			self.YVector = 1
		end
		print("Hater_Turret:update() self.XVector is ", self.XVector)
		print("Hater_Turret:update() self.YVector is ", self.YVector)
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