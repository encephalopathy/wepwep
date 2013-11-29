require "com.game.enemies.Hater"
require "com.game.enemies.CarrierDrone"
--[[
	Slowly moves to the middle of the screen. Once it gets there, it begins to spawn smaller enemies
]]--

Hater_Carrier = Hater:subclass("Hater_Carrier")
--Assign screen width
local scrnWidth = display.stageWidth
 
--Assign screen height
local scrnHeight  = display.stageHeight

function Hater_Carrier:init(sceneGroup, player, sameHaterTypeInView, sameHaterTypeOutOfView, haterList, spawnTypeTable, releaseTime)
	
	if spawnTypeTable == nil then
		spawnTable = { type = 'com.game.enemies.Hater_CarrierDrone', x = -5000, y = -50000 }
		table.insert(spawnTable, 'com.game.enemies.Hater_CarrierDrone')
	else
		assert(type(spawnTypeTable) == table)
	end
	
	self:poolHaterMinions(spawnTypeTable, haterList.outOfView)
	
	self.super:init(sceneGroup, "com/resources/art/sprites/enemy_08.png", 0, 0, 0, 100, 100, 
	{"com/resources/art/sprites/enemy_08_piece_01.png",
	 "com/resources/art/sprites/enemy_08_piece_02.png",
	 "com/resources/art/sprites/enemy_08_piece_03.png",
	 "com/resources/art/sprites/enemy_08_piece_04.png",
	 "com/resources/art/sprites/enemy_08_piece_05.png"
	 }
	)
	--Copy Paste these fields if you plan on using them in the collision function
		
	if releaseTime == nil then
		releaseTime = DEFAULT_HATER_RELEASE_TIME
	end
	
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF THE FILE.
	self.hatersOutofView = haterList.outOfView
	self.hatersInView = haterList.inView
	self.sprite.objRef = self
	self.health = 10
	self.maxHealth = 10
	self.releaseTime = releaseTime
	self.step = 0
end

function Hater_Carrier:initMuzzleLocations()
	self.muzzleLocations = {{x = 0, y = 100}}
end

function Hater_Carrier:move(x, y)
	self.sprite.x = self.sprite.x + x
	self.sprite.y = self.sprite.y + y
	
end

function Hater_Carrier:update()
	self.super:update()
   if (self.isFrozen) then
      return
   end
   self:releaseIfAble()
end

function Hater_Carrier:releaseIfAble()
	
	if self.releaseTime > 0 then
		self.releaseTime = self.releaseTime - 1
	else
		self:deployHater(self.sprite.x, self.sprite.y+(self.sprite.height/2))
	end
end

function Hater_Carrier:deployHater(minionType, x, y)
	assert(self.haterOutofView[minionType] ~= nil, minionType .. " is not a hater type")
	if self.hatersOutofView.size > 0 then
		local hater = Queue.removeBack(self.hatersOutofView[minionType])
		hater.sprite.x = x
		hater.sprite.y = y
		Queue.insertFront(self.hatersInView[minionType], hater)
	end
end

function Hater_Carrier:poolHaterMinions(minionTypes, haterGroup, haterOutOfViewList, xLoc, yLoc)
	
	for i = 1, #minionTypes, 1 do
		local minionType = minionTypes[i].type
		
		if haterOutOfViewList[minionType] == nil then
			haterOutofViewList[minionType] = Queue.new()
		end
		
		Queue.insertFront(haterOutOfViewList[minionType], require(minionType):new(haterGroup, minionTypes))
	end
end

--Used to return the file path of a hater
function Hater_Carrier:__tostring()
	return 'com.game.enemies.Hater_Carrier'
end

return Hater_Carrier