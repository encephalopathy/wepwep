require "com.game.enemies.Hater"

--[[
	Enemy will lock on to the players location and move towards it. Once it gets there, it will stay on 
	top of the player and then destroys itself once the player moves out of its position.
]]--

Hater_Arc = Hater:subclass("Hater_Arc")

switched = false

veloY = 2

function Hater_Arc:init(sceneGroup, player)
	self.super:init(sceneGroup, "com/resources/art/sprites/enemy_03.png", 0, 0, 0, 75, 75,
	{"com/resources/art/sprites/enemy_03_piece_01.png", 
	"com/resources/art/sprites/enemy_03_piece_02.png", 
	"com/resources/art/sprites/enemy_03_piece_03.png", 
	"com/resources/art/sprites/enemy_03_piece_04.png", 
	"com/resources/art/sprites/enemy_03_piece_05.png"}, player)
	--Copy Paste these fields if you plan on using them in the collision function
	self.playerRef = player
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF THE FILE.
	self.sprite.objRef = self 
	self.health = 2
	self.maxHealth = 2
	self.moveXDirection = 0
	self.moveYDirection = 1
end

function Hater_Arc:initMuzzleLocations()
	self.muzzleLocations = {{x = 0, y = 100}}
end

function Hater_Arc:move(x, y)
	--[[
		I want this enemy to fly in one direction
		then about halfway down to switch 
		horizontal direction
		so like it goes from right to left or left to right
		This just starts them off in a single direction though
	]]--
	--self:move(math.sin(self.time*4*math.pi/400)*2,3)
	--print("LOLOLOLOL")
	self.sprite.x = self.sprite.x + x
	self.sprite.y = self.sprite.y + y
	
end

function Hater_Arc:update()
	self.super:update()
	local player = self.playerRef
	local speed = 3
	--local width = player.sprite.x - self.sprite.x
	--local height = player.sprite.y - self.sprite.y
   local accel = -.01
	
   if (self.isFrozen) then
      return
   end
   
   if self.alive then
	--unitWidth = (width/math.sqrt(width*width+height*height))
	--unitHeight = (height/math.sqrt(width*width+height*height))
	--local rotAngle = (180/math.pi) * math.acos(unitHeight)
   veloY = veloY + accel;
	--if width >= 0 then
		--rotAngle = -rotAngle
	--end
	self.sprite.rotation = rotAngle
	self:move(speed,speed*veloY)
	--Need to Add Acceleration, probably with some variables
   -- accel will be negative
   -- veloY is the Y velocity
   -- veloX is the X velocity
   -- veloY needs to change by accel on every update so it needs to be defined outside of the update function
   -- veloX for now will always move to the right
   
   -- Downward curve
   -- Decrease both x and y until x hits 0 then keep it there
	self:fire()						
   end
end

function Hater_Arc:fire()
	if self.alive == true then
		self.super:fire()
		--if player.sprite.y >= self.sprite.y then
		--	self.super:fire()
		--else
			--[[local player = self.playerRef
			local haterToPlayerDist = math.sqrt(
				(player.sprite.x - self.sprite.x) * (player.sprite.x - self.sprite.x)
				+ (player.sprite.y - self.sprite.y) * (player.sprite.y - self.sprite.y)
			)
			--fires in the direction of player
			--print('haterToPlayerDist: ' .. haterToPlayerDist)
			if haterToPlayerDist > 0 then
				local newBullet = Queue.removeBack(self.bulletsOutOfView)
				local playerDirectionX = (player.sprite.x - self.sprite.x) / haterToPlayerDist
				local playerDirectionY = (player.sprite.y - self.sprite.y) / haterToPlayerDist
				
				local rotAngle = (180/math.pi) * math.acos(playerDirectionY)
				if playerDirectionX > 0 then
					rotAngle = -rotAngle
				end
				newBullet.sprite.rotation = rotAngle
				newBullet:move(self.sprite.x + playerDirectionX * 3.8, self.sprite.y + playerDirectionY * 3.8)
				newBullet:fire(playerDirectionX * 500, playerDirectionY * 500)
				newBullet.alive = true
				Queue.insertFront(self.bulletsInView, newBullet)
			end]]--
		--end
		
	end

end

--Used to return the file path of a hater
function Hater_Arc:__tostring()
	return 'com.game.enemies.Hater_Arc'
end

return Hater_Arc








