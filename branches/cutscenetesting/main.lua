--[[
main.lua

The codec appears, cycles through messages when the codec is touched,
and then disappears.
--]]


-- memory checking function
local function checkMemory()
   collectgarbage( "collect" )
   local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
   print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
end

timer.performWithDelay( 1000, checkMemory, 0 )


-- M: global variables module
local M = require("globals")


-- MSGS: messages module
local MSGS = require("messagesreader")


-- w: display width, h: display height
local w  = display.contentWidth
local h  = display.contentHeight


-- bg: background
local bg = display.newRect(0, 0, w, h)
bg:setFillColor(0, 0, 50)


-- c: codec
local c = display.newGroup()


-- c_txtb: codec textbox
local c_txtb = display.newRect(M.c_txtb_x , M.c_txtb_y, M.c_txtb_w, M.c_txtb_h)
c_txtb.strokeWidth = M.c_txtb_sw
c_txtb:setFillColor(0, 0, 200)
c_txtb:setStrokeColor(200, 200, 200)
c:insert(c_txtb)


-- c_txt: codec text
local msg_c = 1 					-- msg_c: message counter

local c_txt = display.newText(
	MSGS[msg_c].content,			-- text
	M.c_txt_x, M.c_txt_y,			-- x, y,
	M.c_txt_w, M.c_txt_h,			-- width, height,
	native.systemFont,  			-- font,
	M.c_txt_fs						-- font size
)
c_txt.alpha = 0


-- c_p: codec portrait
local c_p = display.newRect(M.c_p_x, M.c_p_y, M.c_p_w, M.c_p_w)
c_p.strokeWidth = M.c_p_sw
c_p:setFillColor(60, 60, 60)
c_p:setStrokeColor(200, 200, 200)
c:insert(c_p)


-- c_p_txt: codec portrait text
local c_p_txt = display.newText(
	MSGS[msg_c].name,				-- text
	M.c_p_t_x, M.c_p_t_y,			-- x, y
	M.c_p_w, 28,					-- width, height
	native.systemFont,				-- font,
	M.c_txt_fs						-- font size
)
c_p_txt.alpha = 0


-- codec assets populating listener
local function makeCodecAssetsAppear(obj)
	c_txt.alpha   = 1
	c_p_txt.alpha = 1
	
	local speaker = MSGS[msg_c].name
	local c_p_rgb = M.c_p_img[speaker]
	c_p:setFillColor(c_p_rgb.r, c_p_rgb.g, c_p_rgb.b)
end


-- appearing codec effect
local function activateCodec()
	transition.from(
		c, 
		{
			time = 900,
			y = 200,
			transition = easing.outExpo,
			onComplete = makeCodecAssetsAppear
		}
	)
end


-- codec disposal
local function disposeCodec()

	-- dispose codec textbox
	c_txtb:removeSelf()
	c_txtb = nil
	
	-- dispose codec portrait
	c_p:removeSelf()
	c_p = nil
	
	-- dispose codec text
	c_txt:removeSelf()
	c_txt = nil
	
	-- dispose codec portrait text
	c_p_txt:removeSelf()
	c_p_txt = nil
	
end


-- disappearing codec effect
local function deactivateCodec()
	c_txt.alpha   = 0
	c_p_txt.alpha = 0
	transition.to(
		c, 
		{
			time = 900,
			y = 200,
			transition = easing.outExpo,
			onComplete = disposeCodec
		}
	)
end


-- codec touch event listener
function c:touch(event)

	-- if the codec is touched
	if event.phase == "began" then
		c.alpha = 0.5
	
	-- if the codec is released
	elseif event.phase == "ended" or event.phase == "cancelled" then
		c.alpha = 1.0
		
		-- if there are any more messages
		if msg_c < MSGS[0] then
		
			-- change the message and/or portrait in codec
			msg_c = msg_c + 1
			local speaker = MSGS[msg_c].name
			local message = MSGS[msg_c].content
			local c_p_rgb = M.c_p_img[speaker]
			
			c_txt.text    = message
			c_p_txt.text  = speaker
			c_p:setFillColor(c_p_rgb.r, c_p_rgb.g, c_p_rgb.b)
			
		else
		
			-- send the codec away
			deactivateCodec()
		end
	end
	
	return true
end

c:addEventListener("touch", c)


-- function call to activate the codec
activateCodec()
