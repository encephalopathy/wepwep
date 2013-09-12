--[[
main.lua

Where the test program begins.
--]]


-- M: global variables module
local M = require("globals")


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
local c_txt = display.newText(
	"Let me tell you a story about my father...",
	M.c_txt_x, M.c_txt_y,	-- x, y,
	M.c_txt_w, M.c_txt_h,	-- width, height,
	native.systemFont,  	-- font,
	M.c_txt_fs				-- font size
)
c_txt.alpha = 0
-- NOTE: no need to put text into the display group,
-- since it is not visible until the codec appears
--
-- c:insert(c_txt)


-- c_p: codec portrait
local c_p = display.newRect(M.c_p_x, M.c_p_y, M.c_p_w, M.c_p_w)
c_p.strokeWidth = M.c_p_sw
c_p:setFillColor(60, 60, 60)
c_p:setStrokeColor(200, 200, 200)
c:insert(c_p)


-- transition event listener
local function makeCodecTextAppear(obj)
	c_txt.alpha = 1
end


-- transition effect
transition.from(
	c, 
	{
		time=900,
		y=200,
		transition=easing.outExpo,
		onComplete=makeCodecTextAppear
	}
)
