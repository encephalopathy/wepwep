--[[
globals.lua

Global variables for this program go here
--]]


local h = display.contentHeight

local M = {}

-- c_txtb: codec textbox
M.c_txtb_x  = 200
M.c_txtb_y  = h - 175
M.c_txtb_w  = 250
M.c_txtb_h  = 125
M.c_txtb_sw = 3			-- sw: stroke width

-- c_txt: codec text
M.c_txt_x  = 210
M.c_txt_y  = 635
M.c_txt_w  = 250
M.c_txt_h  = h - 175
M.c_txt_fs = 20			-- fs: font size

-- c_p: codec portrait
M.c_p_x  = 75
M.c_p_y  = h - 175
M.c_p_w  = 125
M.c_p_sw = 3

return M