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

function Hater_Carrier:init(sceneGroup)
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
	self.pootsreleased = 0
	self.step = 0
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

function Hater_Carrier:update()
	self.super:update()
   if (self.isFrozen) then
      return
   end
   if self.alive then
		self.step = self.step + 1   
		if self.pootsreleased < 11 and self.sprite.x < scrnWidth/2 and self.sprite.y < scrnHeight/2 + self.sprite.height then
			self:move(0.6,1.2)
		end
		if (self.step % 90 == 0 and self.pootsreleased < 11 and self.sprite.x <= scrnWidth/2 + self.sprite.width 
			and self.sprite.x >= scrnWidth/2 and self.sprite.y <= scrnHeight/2 + self.sprite.height 
			and self.sprite.y >= scrnWidth/2 - self.sprite.height) then
				self:release()
				print("Poooooot")
		
		elseif (self.pootsreleased > 11) then
			self:move(1,-1)
	end
  end
end

function Hater_Carrier:release()
	self.pootsreleased = self.pootsreleased + 1
	
	self:moveHaterToTopOfScreen(haterPootiePooInViewList, haterPootiePooOutofViewList, self.sprite.x, self.sprite.y+(self.sprite.height/2))
end

function Hater_Carrier:moveHaterToTopOfScreen(inViewList, outOfViewList, xLoc, yLoc)
	--print("moving hater to screen")
	if outOfViewList.size > 0 then
		--10 columns in the level editor
		local hater = Queue.removeBack(outOfViewList)
		hater.sprite.x = xLoc
		hater.sprite.y = yLoc
		Queue.insertFront(inViewList, hater)
		haterList[hater] = hater
	end
end

--Used to return the file path of a hater
function Hater_Carrier:__tostring()
	return 'com.game.enemies.Hater_Carrier'
end

return Hater_Carrier