--[[
globals.lua

Global variables for the codec are in here
--]]


local h = display.contentHeight

local M = {}

M.w = display.contentWidth
M.h = display.contentHeight

-- c_txtb: codec textbox
M.c_txtb_x  = 200
M.c_txtb_y  = h - 175 + 200
M.c_txtb_w  = 250
M.c_txtb_h  = 125
M.c_txtb_sw = 3			-- sw: stroke width

-- c_txt: codec text
-- NOTE: codec messages are now assigned in messagesreader.lua
M.c_txt_x      = 210
M.c_txt_y      = 635
M.c_txt_w      = 240
M.c_txt_h      = h - 175
M.c_txt_fs     = 20		-- fs: font size

-- c_p: codec portrait
M.c_p_img = {			-- c_p_img: portrait image (this will be replaced with strings for images)
	Reggie = {r = 225, g = 100, b = 100},
	Tyce   = {r = 100, g = 225, b = 100}
}
M.c_p_x  = 75
M.c_p_y  = h - 175 + 200
M.c_p_w  = 125
M.c_p_sw = 3			-- sw: stroke width

-- c_p_t: codec portrait text
M.c_p_t_x = 85
M.c_p_t_y = 720

return M