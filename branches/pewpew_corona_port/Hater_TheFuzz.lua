require("Hater")

--[[
	This is a speific type of enemy, it moves at regular speed with a regular shot.
	It is intended to move in a curve from the top of the screen to one of the sides
	It always shoots directly at the player at a fixed interval.
]]--

Hater_TheFuzz = Hater:subclass("Hater_TheFuzz")

switched = false

function Hater_TheFuzz:init(sceneGroup, imgSrc, x, y, rotation, width, height, player)
	self.super:init(sceneGroup, imgSrc, x, y, rotation, width, height,
	{"sprites/enemy_06_piece_01.png", "sprites/enemy_06_piece_02.png", "sprites/enemy_06_piece_03.png", 
	"sprites/enemy_06_piece_04.png", "sprites/enemy_06_piece_05.png"})
	--Copy Paste these fields if you plan on using them in the collision function
	self.playerRef = player
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF THE FILE.
	self.sprite.objRef = self 
	self.health = 2
	self.maxHealth = 2
	self.moveXDirection = 0
	self.moveYDirection = 1
end

function Hater_TheFuzz:move(x, y)
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

function Hater_TheFuzz:update()
	self.super:update()
	local player = self.playerRef
	local speed = 3
	local width = player.sprite.x - self.sprite.x
	local height = player.sprite.y - self.sprite.y
	
   if (self.isFrozen) then
      return
   end
   
   if self.alive then
	unitWidth = (width/math.sqrt(width*width+height*height))
	unitHeight = (height/math.sqrt(width*width+height*height))
	local rotAngle = (180/math.pi) * math.acos(unitHeight)
	if width >= 0 then
		rotAngle = -rotAngle
	end
	self.sprite.rotation = rotAngle
	self:move(speed*unitWidth,speed*unitHeight)
	
	if (step % 90 == 0) then
		self:fire()						
	end
   end
end

function Hater_TheFuzz:fire()
	if self.alive == true then
		--if player.sprite.y >= self.sprite.y then
		--	self.super:fire()
		--else
			local player = self.playerRef
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
			end
		--end
		
	end

end










