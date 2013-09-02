require "com.game.weapons.Bullet"

local DEFAULT_EXPLOSION_RADIUS = 64
local DEFAULT_DETONATION_TIME = 7
local DEFAULT_DAMAGE = 1

Bomb = Bullet:subclass("Bomb")

function Bomb:init(sceneGroup, isPlayerBomb, targets, imgSrc, detonationTime, explosionRadius, damage)
	if imgSrc == nil then
		imgSrc = "com/resources/art/sprites/bomb.png"
	end
	
	if explosionRadius == nil then
		explosionRadius = DEFAULT_EXPLOSION_RADIUS
	end
	
	if damage == nil then
		damage = DEFAULT_EXPLOSION_RADIUS
	end
	
	if detonationTime == nil then
		detonationTime = DEFAULT_DETONATION_TIME
	end
	
   self.super:init(sceneGroup, imgSrc, isPlayerBomb)
   self.alive = false
   self.damage = 1
   self.isPlayerBomb = isPlayerBomb
   self.targets = targets
   self.explosionRadius = explosionRadius
   self.damage = damage
   self.detonationTime = detonationTime
   --Hardcoded explosion taken from Ride, you will need to overrid this if you want a different explosion.
   self:createExplosionSpriteSheet({ width = explosionRadius, height = explosionRadius, numFrames = 16, sheetContentWidth = 256, sheetContentHeight = 256 } )
   
   self.sprite.objRef = self
end

function Bomb:fire()
	self.super:fire()
	local updateFunction = function()
		self:explode()
	end
	Runtime:addEventListener("enterFrame", updateFunction)
	self.update = updateFunction
end

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
	explosion.xScale = 3; explosion.yScale = 3
	--Makes sure we do not see the animation.
	explosion.isVisible = false
	--Adds an event listener the game knows when to animate the explosion at the right time.
	explosion:addEventListener("sprite", self.afterExplosion)
	--Keeps a reference to the explosion for animation purposes.
	self.explosion = explosion
	
end

function Bomb:afterExplosion()
	if ( self.phase == "began" ) then
		self.target.isVisible = true
		self:explode()
	elseif ( self.phase == "ended" ) then
		self.target.isVisible = false
	end
	
end

function Bomb:explode()
	for targetType, target in pairs(self.targets) do
		if (distance(target.sprite.x, target.sprite.y, self.sprite.x, self.sprite.y) < self.explosionRadius) then
			target.health = target.health - self.damage
		end
	end
end

function Bomb:onCollision ()
	self:explode()
	self.super:onCollision()
end

function Bomb:recycle()
	self.super:recycle(self)
	Runtime:removeEventListener("enterFrame", self.update)
end

function Bomb:destroy()
	if self.explosion ~= nil then
		self.explosion:removeEventListener("sprite", self.afterExplosion)
		self.explosion:removeSelf()
		self.explosion = nil
	end
	self.super:destroy()
end