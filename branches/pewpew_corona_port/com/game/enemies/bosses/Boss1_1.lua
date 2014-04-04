require "com.game.enemies.Hater"
--[[
	The basic of the basic. Enemy will move straight down on the screen and then move out of view
	Your everyday normal guy kind of enemy.
]]--

Boss1_1 = Hater:subclass("Boss1_1")

switched = false

function Boss1_1:init(sceneGroup, player)
	self.super:init(sceneGroup, "com/resources/art/sprites/boss_01.png", 0, 0, 0, 256, 256,
	{"com/resources/art/sprites/enemy_01_piece_01.png",
	"com/resources/art/sprites/enemy_01_piece_02.png",
	"com/resources/art/sprites/enemy_01_piece_03.png",
	"com/resources/art/sprites/enemy_01_piece_04.png",
	"com/resources/art/sprites/enemy_01_piece_05.png"}, player)
	
	self.moveLeft = false
	self.moveRight = false
	self.startMoving = false
	
	--Copy Paste these fields if you plan on using them in the collision function
	
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF THE FILE.
	self.sprite.objRef = self 
	self.health = 50
	self.maxHealth = 50
end

function Boss1_1:initMuzzleLocations()
	self.muzzleLocations = {}
	self.muzzleLocations[1] = {x = 25, y = 100}
	self.muzzleLocations[2] = {x = -25, y = 100}
	self.muzzleLocations[3] = {x = 80, y = 50}
	self.muzzleLocations[4] = {x = -80, y = 50}
end

function Boss1_1:move(x, y)
	--[[
	This fool ominously floats down to the top of the screen and then oscillates left and right
	]]--
	--self:move(math.sin(self.time*4*math.pi/400)*2,3)
	--print("LOLOLOLOL")
	-- if self.moveRight then self.sprite.x = self.sprite.x + x end
	-- if self.moveLeft then self.sprite.x = self.sprite.x - x end
	-- if self.startMoving == false  then self.sprite.y = self.sprite.y + y end
 
	-- if self.sprite.y > 150 and self.startMoving == false then
		-- self.startMoving = true
		-- self.moveRight = true
	-- end
 
	-- if self.sprite.x > 400 then 
		-- self.moveRight = false
		-- self.moveLeft = true
	-- end
 
	-- if self.sprite.x < 40 then 
		-- self.moveRight = true
		-- self.moveLeft = false
	-- end
	self.sprite.x = self.sprite.x + x
	self.sprite.y = self.sprite.y + y
end

--Used to return the file path of a hater
function Boss1_1:__tostring()
	return 'com.game.enemies.bosses.Boss1_1'
end

function Boss1_1:update()
	self.super:update()

	if self.sprite.x > 400 then 
		self.moveRight = false
		self.moveLeft = true
	end
	
	if self.sprite.x < 40 then 
		self.moveRight = true
		self.moveLeft = false
	end
	
   if (self.isFrozen) then
      return
   end

	if self.sprite.y < 250 then
		self:move(0,3)
	elseif self.moveRight then
		self:move(5,0)
	elseif self.moveLeft then
		self:move(-5,0)
	else 
		self:move(2,0)
	end

   if self.alive then
	--self:move(3,2)
	--if (step % 90 == 0 and self.alive == true) then
	if self.alive == true then
		self:fire()						
	end					
	--end
	if  self.sprite.y > ((display.contentHeight/2) - (self.sprite.y/2)) then
		return
	else
		self:move(0,3)
	end
   end
end

return Boss1_1