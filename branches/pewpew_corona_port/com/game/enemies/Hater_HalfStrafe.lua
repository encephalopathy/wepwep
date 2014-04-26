require "com.game.enemies.Hater"

--[[
	Moves vertically down the screen until it reaches the mid point then begins moving from left/right
	horizontally, back and forth until it is destroyed.
]]--

Hater_HalfStrafe = Hater:subclass("Hater_HalfStrafe")

switched = false

function Hater_HalfStrafe:init(sceneGroup, player)
	self.super:init(sceneGroup, "com/resources/art/sprites/enemy_02.png", 0, 0, 0, 100, 100,
	{"com/resources/art/sprites/enemy_02_piece_01.png",
	"com/resources/art/sprites/enemy_02_piece_02.png",
	"com/resources/art/sprites/enemy_02_piece_03.png",
	"com/resources/art/sprites/enemy_02_piece_04.png",
	"com/resources/art/sprites/enemy_02_piece_05.png"}, player)
	--Copy Paste these fields if you plan on using them in the collision function
	
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF THE FILE.
	self.sprite.objRef = self 
	self.moveLeft = false
	self.moveRight = true
	self.health = 1
	self.maxHealth = 1
	self.switches = 0 
	self.leave = false
end

function Hater_HalfStrafe:initMuzzleLocations()
	self.muzzleLocations = {{x = 0, y = 100}}
end

function Hater_HalfStrafe:move(x, y)
	self.sprite.x = self.sprite.x + x
	self.sprite.y = self.sprite.y + y
	
end

function Hater_HalfStrafe:update()
	self.super:update()

	if (self.isFrozen) then
      return
    end
	
	--right side, switch
	if self.sprite.x > 400 and self.leave == false then 
		self.moveRight = false
		self.moveLeft = true
		self.switches = self.switches + 1
	end
	--left side, switch
	if self.sprite.x < 40 and self.leave == false then 
		self.moveRight = true
		self.moveLeft = false
		self.switches = self.switches + 1
	end
	
	if(self.switches == 4 ) then
		self.leave = true
	end
	
	if(self.leave == true) then
		self:move(5,0)
	elseif self.sprite.y < (display.contentHeight/2) then
		self:move(0,3)
	elseif self.moveRight then
		self:move(5,0)
	elseif self.moveLeft then
		self:move(-5,0)
	end
	
	if self.alive == true then
		self:fire()						
	end
	
end

--Used to return the file path of a hater
function Hater_HalfStrafe:__tostring()
	return 'com.game.enemies.Hater_HalfStrafe'
end

return Hater_HalfStrafe








