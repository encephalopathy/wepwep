-----------------------------------------------------------------------------------------
--
-- GameConstants.lua
--
-- Contains variables that need to be remembered across multiple modules. A safer
-- alternative to global variables
-----------------------------------------------------------------------------------------

local M = {}

M.sheetInfo = require("spritesheetrgba4444")
M.spriteSheet = graphics.newImageSheet("spritesheetrgba4444.png", M.sheetInfo:getSheet())

-- OLD VARIABLES: are these variables being used or not?
oldScaleX = 1
oldScaleY = 1

PLAYER_MAXHEALTH = 10
PLAYER_MAXPOWAH  = 30

PLAYER_HEALTHBAR_MAX = 240
PLAYER_POWAHBAR_MAX  = 100

HEALTH_BAR_REGISTRATION_X_LOC = 340
POWAH_BAR_REGISTRATION_Y_LOC  = 500

currentLevelNumber = 0
currentLevel = 1

world = nil

return M
