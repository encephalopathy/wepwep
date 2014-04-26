require "com.game.enemies.Hater"
--[[
	Enemies spawned from Hater_Carrier. Fly out in different directions.
]]--

Hater_CarrierDrone = Hater:subclass("Hater_CarrierDrone")

function Hater_CarrierDrone:init(sceneGroup, player)
	self.super:init(sceneGroup, "com/resources/art/sprites/Hater_Drone1.png", 0, 0, 0, 75, 75, 
	{"com/resources/art/sprites/enemy_06_piece_01.png",
	 "com/resources/art/sprites/enemy_06_piece_02.png",
	 "com/resources/art/sprites/enemy_06_piece_03.png",
	 "com/resources/art/sprites/enemy_06_piece_04.png",
	 "com/resources/art/sprites/enemy_06_piece_05.png"
	 }, player
	)
	--Copy Paste these fields if you plan on using them in the collision function
	self.directionx = math.random(-2,2)
	self.directiony = math.random(1,4)
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF THE FILE.
	self.sprite.objRef = self 
	self.health = 1
	self.maxHealth = 1
	self.step = 0
end

function Hater_CarrierDrone:initMuzzleLocations()
	self.muzzleLocations = {{x = 0, y = 100}}
end

function Hater_CarrierDrone:move(x, y)
	--if self.alive == true then
		--self:fire()						
	--end
	self.sprite.x = self.sprite.x + x
	self.sprite.y = self.sprite.y + y
	
end

function Hater_CarrierDrone:update()
	self.super:update()
   if (self.isFrozen) then
      return
   end
   if self.alive then
	self:move(self.directionx,self.directiony)
	self.step = self.step + 1
	if (self.step % 90 == 30 ) then
		self:fire()						
	end
   end
end

--Used to return the file path of a hater
function Hater_CarrierDrone:__tostring()
	return 'com.game.enemies.Hater_CarrierDrone'
end

return Hater_CarrierDrone
