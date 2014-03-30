require "com.game.enemies.Hater"
require "com.game.enemies.Hater_CarrierDrone"
--[[
	Slowly moves to the middle of the screen. Once it gets there, it begins to spawn smaller enemies
	
	This is the base class for Carrier types. If you want to build a Carrier, you MUST build a Carrier and
	Drone together to make sure they act how you want them to.
	
]]--

Hater_Carrier = Hater:subclass("Hater_Carrier")
--Assign screen width
local scrnWidth = display.stageWidth
 
--Assign screen height
local scrnHeight  = display.stageHeight

function Hater_Carrier:init(sceneGroup, player, inView, outOfView, haterList, allHatersInView)
	self.super:init(sceneGroup, "com/resources/art/sprites/enemy_08.png", 0, 0, 0, 100, 100, 
	{"com/resources/art/sprites/enemy_08_piece_01.png",
	 "com/resources/art/sprites/enemy_08_piece_02.png",
	 "com/resources/art/sprites/enemy_08_piece_03.png",
	 "com/resources/art/sprites/enemy_08_piece_04.png",
	 "com/resources/art/sprites/enemy_08_piece_05.png"
	 }
	)
	--Copy Paste these fields if you plan on using them in the collision function
	
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF THE FILE.
	self.sprite.objRef = self 
	self.health = 10
	self.maxHealth = 10
	self.drones = 0
	print("drone count: ",self.drones)
	self.step = 0
	self.sceneGroup = sceneGroup
	self.player = player
	
	--variables used for spawning new drones
	self.inView = inView
	self.outOfView = outOfView
	self.haterList = haterList
	self.allHatersInView = allHatersInView
	self.droneType = "com.game.enemies.Hater_CarrierDrone"
end

function Hater_Carrier:initMuzzleLocations()
	self.muzzleLocations = {{x = 0, y = 100}}
end

function Hater_Carrier:move(x, y)
	--[[
		I want this enemy to fly in one direction
		then about halfway down to switch 
		horizontal direction
		so like it goes from right to left or left to right
		This just starts them off in a single direction though
	]]--
	--self:move(math.sin(self.time*4*math.pi/400)*2,3)
	--print(self.sprite.x .. " " .. self.sprite.y)
	self.sprite.x = self.sprite.x + x
	self.sprite.y = self.sprite.y + y
	
end

--This can be overwritten to change the behavior of the carrier
--NOTE: the number of drones spawned has been changed for the build on 3/18
--will return later with an actual fix lol
function Hater_Carrier:update()
	self.super:update()
   if (self.isFrozen) then
      return
   end
   if self.alive then
		self.step = self.step + 1 
		if self.drones < 5 and self.sprite.x < scrnWidth/2 and self.sprite.y < scrnHeight/2 + self.sprite.height then
			self:move(0.6,1.2)
		end
		
		--reached the center, step is up = release a drone
		if (self.step % 90 == 0 and self.drones < 5 and self.sprite.x <= scrnWidth/2 + self.sprite.width 
			and self.sprite.x >= scrnWidth/2 and self.sprite.y <= scrnHeight/2 + self.sprite.height 
			and self.sprite.y >= scrnWidth/2 - self.sprite.height) then
				self:release()
		
		elseif (self.drones >= 5) then
			self:move(1,-1)
		end
		self:fire()
  end
end

--DO NOT OVERRIDE THIS FUNCTION
--This is the base function for how Carriers will release their drones
function Hater_Carrier:release()
	--print("Inside Hater_Carrier:release")
	self.drones = self.drones + 1
	print("drone count: ",self.drones)

	--add it to the inView queue
	local haterType = self.droneType
	
	local enemyInView = nil
	if self.haterList[haterType] == nil then--this check is only run if this is the very first drone made
		self.haterList[haterType] = {}
		self.haterList[haterType].outOfView = Queue.new()
		self.haterList[haterType].inView = Queue.new()

		--print(type(require(haterType)))
		
		local newHater = require(haterType):new(self.sceneGroup, self.player, 
										self.inView, self.outOfView,
										self.haterList, self.allHatersInView)
										
		enemyInView = newHater
	
	else
		if self.haterList[haterType].outOfView.size > 0 then
			enemyInView = Queue.removeBack(self.haterList[haterType].outOfView)
			enemyInView:respawn()
		else
			enemyInView = require(haterType):new(self.sceneGroup, self.player,
										self.inView, self.outOfView, self.haterList, self.allHatersInView)
			enemyInView.sprite.isBodyActive = false
			enemyInView.sprite.isVisible = false
		end
	end
	enemyInView.sprite.isBodyActive = true
	enemyInView.sprite.isVisible = true
	Queue.insertFront(self.haterList[haterType].inView, enemyInView)

	self:droneSpawn(enemyInView)
	enemyInView:equipRig(self.sceneGroup, self.Weapons, self.Passives)
	
	--need to set the enemyInView into the allHatersInView queue
	self.allHatersInView[enemyInView] = enemyInView
	
	
end

--sets up the new enemy with the correct variables for when it spawns
function Hater_Carrier:droneSpawn(enemyInView)
	enemyInView.sprite.x = self.sprite.x
	enemyInView.sprite.y = self.sprite.y + (self.sprite.height/2)
	enemyInView.sprite.rotation = self.rotation
end


--Used to return the file path of a hater
function Hater_Carrier:__tostring()
	return 'com.game.enemies.Hater_Carrier'
end

return Hater_Carrier