require "com.game.enemies.Hater"

--[[
	Moves down to the bottom of the screen and then moves back up to the top.
]]--

Hater_UpDown = Hater:subclass("Hater_UpDown")

switched = false

function Hater_UpDown:init(sceneGroup, player)
	self.super:init(sceneGroup, "com/resources/art/sprites/enemy_06.png", 0, 0, 0, 75, 75, 
	{"com/resources/art/sprites/enemy_06_piece_01.png", 
	"com/resources/art/sprites/enemy_06_piece_02.png", 
	"com/resources/art/sprites/enemy_06_piece_03.png", 
	"com/resources/art/sprites/enemy_06_piece_04.png", 
	"com/resources/art/sprites/enemy_06_piece_05.png"}, player)
	--Copy Paste these fields if you plan on using them in the collision function
	
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF THE FILE.
	self.sprite.objRef = self 
	self.health = 10
	self.maxHealth = 10
	self.movedown = true
	self.switches = 0
	self.leave = false
end

function Hater_UpDown:initMuzzleLocations()
	self.muzzleLocations = {{x = 0, y = 100}}
end

function Hater_UpDown:move(x, y)
	self.sprite.x = self.sprite.x + x
	self.sprite.y = self.sprite.y + y
	
end

function Hater_UpDown:update(player)
	self.super:update()
   if (self.isFrozen) then
      return
   end

   --at bottom of screen
	if self.sprite.y > (display.contentHeight*.6) then
		self.movedown = false
		self.switches = self.switches + 1
	end
	
	--at top of screen
	if self.sprite.y < (display.contentHeight*.1) then
		self.movedown = true
		if self.switches > 0 then
			self.switches = self.switches + 1
		end
	end
	
	if self.switches == 4 then
		self.leave = true
	end
	
	if self.leave == true then
		self:move(0,5)
	elseif self.movedown == true then
		self:move(0,5)
	elseif self.movedown == false then
		self:move(0,-5)
	end

   if self.alive == true then
		self:fire()						
   end
   
end

function Hater_UpDown:respawn()
	self.super:respawn()
	self.movedown = true
	self.switches = 0
	self.leave = false
end

--Used to return the file path of a hater
function Hater_UpDown:__tostring()
	return 'com.game.enemies.Hater_UpDown'
end

return Hater_UpDown









