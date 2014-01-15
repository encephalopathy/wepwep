require "com.game.enemies.Hater"
require "com.game.enemies.CarrierDrone"
--[[
	Slowly moves to the middle of the screen. Once it gets there, it begins to spawn smaller enemies
]]--

Hater_RandomCarrier = Hater_Carrier:subclass("Hater_RandomCarrier")
--Assign screen width
local scrnWidth = display.stageWidth
 
--Assign screen height
local scrnHeight  = display.stageHeight

function Hater_RandomCarrier:init(sceneGroup, player, sameHaterTypeInView, sameHaterTypeOutOfView, haterList, spawnTypeTable, releaseTime)
	self.super:init(sceneGroup, player, sameHaterTypeInView, sameHaterTypeOutofView, haterList, spawnTypeTable, releaseTime)
end

function Hater_RandomCarrier:initMuzzleLocations()
	self.muzzleLocations = {{x = 0, y = 100}}
end

function Hater_RandomCarrier:move(x, y)
	self.sprite.x = self.sprite.x + x
	self.sprite.y = self.sprite.y + y
end

function Hater_RandomCarrier:update()
	self.super:update()
   if (self.isFrozen) then
      return
   end
   if self.alive then
		self.step = self.step + 1   
		if self.releaseTime < 11 and self.sprite.x < scrnWidth/2 and self.sprite.y < scrnHeight/2 + self.sprite.height then
			self:move(0.6,1.2)
		end
		if (self.step % 90 == 0 and self.releaseTime < 11 and self.sprite.x <= scrnWidth/2 + self.sprite.width 
			and self.sprite.x >= scrnWidth/2 and self.sprite.y <= scrnHeight/2 + self.sprite.height 
			and self.sprite.y >= scrnWidth/2 - self.sprite.height) then
				self:deployHater("com.enemies.Hater_CarrierDrone", self.sprite.x, self.sprite.y+(self.sprite.height/2))
				print("Poooooot")
		
		elseif (self.releaseTime > 11) then
			self:move(1,-1)
	end
  end
end

return Hater_RandomCarrier