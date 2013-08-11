require("Hater")
require("Hater_PootiePoo")
--[[
	This is a speific type of enemy, it moves at regular speed with a regular shot.
	It is intended to move in a curve from the top of the screen to one of the sides
	It always shoots directly at the player at a fixed interval.
]]--

Hater_PooSlinger = Hater:subclass("Hater_PooSlinger")
--Assign screen width
local scrnWidth = display.stageWidth
 
--Assign screen height
local scrnHeight  = display.stageHeight

function Hater_PooSlinger:init(sceneGroup, imgSrc, x, y, rotation, width, height, shipPieces)
	self.super:init(sceneGroup, imgSrc, x, y, rotation, width, height, 
	{"sprites/enemy_02_piece_01.png",
	 "sprites/enemy_02_piece_02.png",
	 "sprites/enemy_02_piece_03.png",
	 "sprites/enemy_02_piece_04.png",
	 "sprites/enemy_02_piece_05.png"
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

function Hater_PooSlinger:equipRig(sceneGroup)
	self:equip(self.primaryWeapons, Singleshot, sceneGroup, 15, {0, 30})
end

function Hater_PooSlinger:move(x, y)
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

function Hater_PooSlinger:update()
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

function Hater_PooSlinger:release()
	self.pootsreleased = self.pootsreleased + 1
	
	self:moveHaterToTopOfScreen(haterPootiePooInViewList, haterPootiePooOutofViewList, self.sprite.x, self.sprite.y+(self.sprite.height/2))
end

function Hater_PooSlinger:moveHaterToTopOfScreen(inViewList, outOfViewList, xLoc, yLoc)
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