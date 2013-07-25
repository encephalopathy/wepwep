require("Object");
require("Queue");

BulletManager = Object:subclass("BulletManager");

function BulletManager:init (scene)
	self.onScreenQueue = Queue.new()
	self.offScreenQueue = Queue.new()
	self.sceneGroup = scene
	self:addEventListener("bulletOffScreen", self:bullet_listener)
	
end

function BulletManager:bulletListener (event)
	if (event.type != "offScreen") then
		return
	end
	local bullet = Queue.removeObject(self.onScreenBullets, event.bullet);
	Queue.insertFront(self.offScreenBullets, bullet);
end

DEFAULT_WIDTH = 1
DEFAULT_HEIGHT = 1
DEFAULT_ROTATION = 0

function BulletManager:getBullet (bulletClass, className, imgSrc, width, height, rotation)

	if (imgSrc == nil) then
		imgSrc = "img/bullet.png"
	end
	if (width == nil) then
		width = DEFAULT_WIDTH
	end
	if (height == nil) then
		height = DEFAULT_HEIGHT
	end
	if (rotation == nil) then
		rotation = DEFAULT_ROTATION
	end
	
	-- search for correct type of bullet in off screen queue
	for i = self.offScreenBullets.first, self.offScreenBullets.last, 1 do
	  	local bullet = self.offScreenBullets[i]
		if (bullet.imgSrc == imgSrc and bullet.className == className) then
			Queue.removeIndex(self.offScreenBullets, i);
			Queue.insertFront(self.onScreenBullets, bullet)
			return bullet
		end
	end
	local bullet = bulletClass:new(self.sceneGroup, imgSrc, true, -5000, -5000, rotation, width, height);
	Queue.insertFront(self.onScreenBullets, bullet)
	return bullet
end
