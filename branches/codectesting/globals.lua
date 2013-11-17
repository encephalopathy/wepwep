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
M.c_txtb_y  = h + 50
M.c_txtb_w  = 305
M.c_txtb_h  = 175
M.c_txtb_sw = 3			-- sw: stroke width

-- c_txt: codec text
M.c_txt_x      = 210
M.c_txt_y      = 610
M.c_txt_w      = 240
M.c_txt_h      = h - 175
M.c_txt_fs     = 20		-- fs: font size

-- c_p: codec portrait
M.c_p_img = {			-- c_p_img: portrait image, includes colors and pathnames

	-- each of these tables contains pathnames for portrait images and color values
	-- for each character and their expressions
	Reggie = {
		color		= {r = 225, g = 100, b = 100},
		neutral		= "images/face01.png"
	},
	
	Tyce   = {
		color 		= {r = 100, g = 225, b = 100},
		neutral		= "images/face02.png"
	}
}
M.c_p_x  = 25
M.c_p_y  = h + 50
M.c_p_w  = 175
M.c_p_sw = 3			-- sw: stroke width

-- c_p_img: codec portrait image
M.c_p_img_x = 112.5
M.c_p_img_y = h + 62.5 + 75

-- c_p_t: codec portrait text
M.c_p_t_x = 210
M.c_p_t_y = 585

return M