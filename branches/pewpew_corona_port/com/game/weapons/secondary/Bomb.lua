require "com.game.weapons.Bullet"

local DEFAULT_EXPLOSION_RADIUS = 64
local DEFAULT_DETONATION_TIME = 4
local DEFAULT_DAMAGE = 1

Bomb = Bullet:subclass("Bomb")

function Bomb:init(sceneGroup, imgSrc, isPlayerBomb, width, height)
	if imgSrc == nil then
		imgSrc = "com/resources/art/sprites/bomb.png"
	end
	
	--[[
		The fields are set in a weapon called GrenadeLauncer.
		damage
		explosionRadius
		detonationTime
	]]--
   self.explosionRadius = width
   self.explosion = self:createExplosionSpriteSheet({ width = 64, height = 64, numFrames = 16, sheetContentWidth = 256, sheetContentHeight = 256 } )
   self.super:init(sceneGroup, imgSrc, isPlayerBomb, width, height)
   self.alive = false
   self.damage = 1
   self.sprite.objRef = self
end


--[[
	FUNCTION NAME: createExplosionSpriteSheet
	
	DESCRIPTION: Used for creating the explosion sprite sheet
				 assets for the bomb.
]]--
function Bomb:createExplosionSpriteSheet(spriteSheetOptions)
	--creates an explosion particle effect by leveraging off of sprite sheets. Refer to Corona Sprite Sheets tutorial
	--for references because this stuff is really confusing to explain simply.
	local explosionSpriteSheet = graphics.newImageSheet("com/resources/art/sprites/exp2.png", spriteSheetOptions )
	--Creates a 16 frame animation that starts at animation one, that loops once, and lasts for 1000 miliseconds.
	local spriteOptions = { name = "explosion", start = 1, count = 16, time = 1000, loopCount = 1 }
	--Creates the sprite sheet.
	local explosion = display.newSprite(explosionSpriteSheet, spriteOptions)
	--Creates the explosion location to be offscreen so we it doesn't get rendered in the scene.
	explosion.x = 5000; explosion.y = 5000
	--Increase the scale dimensions of the animation so we can see it on the screen.
	explosion.xScale = 1; explosion.yScale = 1
	--Makes sure we do not see the animation.
	explosion.isVisible = false
	--Adds an event listener the game knows when to animate the explosion at the right time.
	explosion:addEventListener("sprite", self.afterExplosion)
	--Keeps a reference to the explosion for animation purposes.
	return explosion
	
end

--[[
	FUNCTION NAME: explode
	DESCRIPTION NAME: Responsible for exploding the bomb and destroying everything
					  in the vacinity of the explosion.
]]--
function Bomb:explode()
	if not self.explosion.isPlaying then
		self.explosion.x = self.sprite.x; self.explosion.y = self.sprite.y;
		
		--Scale the explosion based on the size of each element in the sprite
		--We assume that the sprite sheet is the square and therefore, only need to check
		--its width.
		local explosionSize = self.explosionRadius / self.explosion.width
		
		self.explosion.xScale = explosionSize; self.explosion.yScale = explosionSize
		self.explosion:play()
		Runtime:removeEventListener("enterFrame", self.update)
		self.alive = false
	end
	
	--Searches for all haters and kills them.
	for target in pairs(self.targets) do
		if (distance(target.sprite.x, target.sprite.y, self.sprite.x, self.sprite.y) < self.explosionRadius) then
			target.health = target.health - self.damage
		end
	end
end

--[[
	FUNCTION NAME: fire
	
	DESCRIPTION: Shoots a bomb and detonates the bomb when either
				 it collides with an enemy or when its detonation timer
				 runs out.
]]--
function Bomb:fire(x, y)
	self.super:fire(x, y)
	local updateFunction = function()
		if self.detonationTime > 0 then
			self.detonationTime = self.detonationTime - 1
		else
			self:explode()
		end
	end
	Runtime:addEventListener("enterFrame", updateFunction)
	self.update = updateFunction
end
--[[
	FUNCTION NAME: recycle
	DESCRIPTION Occlussion culls the bombs offscreen.
]]--
function Bomb:recycle()
	Runtime:removeEventListener("enterFrame", self.update)
	self.super:recycle(self)
end

--[[
	FUNCTION NAME: afterExplosion
	
	DESCRIPTION: Used for animating the explosion sprite sheet from
				 start to finish.
]]--
function Bomb:afterExplosion()
	if ( self.phase == "began" ) then
		self.target.isVisible = true
	elseif ( self.phase == "ended" ) then
		self.target.isVisible = false
	end
	
end


--[[
	FUNCTION NAME: onCollision
	
	DESCRIPTION: Automatically detonates the bomb whenever
				 it collides with a hater.
]]--
function Bomb:onCollision ()
	self:explode()
	self.super:onCollision()
end

function Bomb:destroy()
	if self.explosion ~= nil then
		self.explosion:removeEventListener("sprite", self.afterExplosion)
		self.explosion:removeSelf()
		self.explosion = nil
	end
	self.super:destroy()
end