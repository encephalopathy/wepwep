-----------------------------------------------------------------------------------------
--
-- stringtoimage.lua
--
-- module with functions that takes in a string (plus a width and a height), and returns
-- an image of the appropriate dimensions from the sprite sheet.
-----------------------------------------------------------------------------------------

--[[ 
    BUT FIRST: Do objects that have the same image look at the same address to save
               their texture?
    
    TEST ONE: Using newImageRect using the image file
    When using newImageRect function, it seems that variables that use the same image
    create copies of the image that they use. Observe the _proxy variables in each of the
    background variables below.
    
    In code:
    -- display a background image
	local background  = display.newImageRect( "sprites/splash_main_menu.png", display.contentWidth, display.contentHeight )
	local background1 = display.newImageRect( "sprites/splash_main_menu.png", display.contentWidth, display.contentHeight )
	local background2 = display.newImageRect( "sprites/splash_main_menu.png", display.contentWidth, display.contentHeight )
	
	Debugger output:
	background(table: 0x111ecdae0)  ... _proxy = userdata: 0x111ee4ed8 }
    background1(table: 0x111bc20c0) ... _proxy = userdata: 0x111e9df08 }
    background2(table: 0x111e2c380) ... _proxy = userdata: 0x111e25088 }
    
    
    TEST TWO: Using newImageRect using the sprite sheet data.
    Here's using newImageRect using stuff from the sprite sheet. The same sort of thing
    happens as before. Each of the background._proxy fields (which I'm guessing is where
    the image data is located) are different:
    
    Code:
    local background  = display.newImageRect(spriteSheet, sheetInfo.frameIndex["splash_main_menu"],
	                                         display.contentWidth, display.contentHeight)
	local background1 = display.newImageRect(spriteSheet, sheetInfo.frameIndex["splash_main_menu"],
	                                         display.contentWidth, display.contentHeight)
	local background2 = display.newImageRect(spriteSheet, sheetInfo.frameIndex["splash_main_menu"],
	                                         display.contentWidth, display.contentHeight)
    
    Debugger output:
    background(table: 0x114e7af40)  ... _proxy = userdata: 0x114e7af38
    background1(table: 0x114e8d080) ... _proxy = userdata: 0x114e8d078
    background2(table: 0x114ec7120) ... _proxy = userdata: 0x114ec7118
    -- They taste the same, but look different!!
    
    
    TEST THREE: Creating one variable using newImageRect, but then having others point
    to that background.
    
    Code:
    
    Debugger output:
    
    
]]--
