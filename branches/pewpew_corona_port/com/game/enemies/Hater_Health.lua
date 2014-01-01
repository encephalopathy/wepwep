require "com.game.enemies.Hater"
--[[
	The basic of the basic. Enemy will move straight down on the screen and then move out of view
	Your everyday normal guy kind of enemy.
]]--

Hater_Health = Hater:subclass("Hater_Health")

switched = false

function Hater_Health:init(sceneGroup)
	self.super:init(sceneGroup, "com/resources/art/sprites/enemy_01.png", 0, 0, 0, 100, 100,
	{"com/resources/art/sprites/enemy_01_piece_01.png",
	"com/resources/art/sprites/enemy_01_piece_02.png",
	"com/resources/art/sprites/enemy_01_piece_03.png",
	"com/resources/art/sprites/enemy_01_piece_04.png",
	"com/resources/art/sprites/enemy_01_piece_05.png"})
	--Copy Paste these fields if you plan on using them in the collision function
	
	--COPY THIS LINE AND PASTE IT AT THE VERY BOTTOM OF THE FILE.
	self.sprite.objRef = self 
end

function Hater_Health:initMuzzleLocations()
	self.muzzleLocations = {{x = 0, y = 100}}
end

function Hater_Health:die()
	self.super:die()
	Runtime:dispatchEvent({name = "spawnCollectible", target = "HealthPickUp", position =  {x = self.sprite.x, y = self.sprite.y}})
end

--Used to return the file path of a hater
function Hater_Health:__tostring()
	return 'com.game.enemies.Hater_Health'
end

return Hater_Normal