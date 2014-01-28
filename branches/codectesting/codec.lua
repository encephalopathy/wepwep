--[[
codec.lua

The codec appears, cycles through messages when the codec is touched,
and then disappears.

TODO: Redo drawing of the codec
--]]


-- M: global variables module
local M = require("globals")


-- MSGS: messages module
local MSGS = require("messagesreader")


-- c: public codec functions that can be called in main.lua
local c = {}


-- sfx: sound effects table
local sfx = {
	activeChannelNumber = 0,
	ring 	= audio.loadSound("sounds/ring.wav"),
	answer	= audio.loadSound("sounds/answer.wav"),
	appear	= audio.loadSound("sounds/appear.wav"),
	advance	= audio.loadSound("sounds/advance.wav"),
	hangUp	= audio.loadSound("sounds/hangup.wav"),
}


-- w: display width, h: display height
local w  = M.w
local h  = M.h


-- bg: background
local bg = display.newRect(0, 0, w, h)
bg:setFillColor(0, 0, 50)


-- ca: codec answering
local ca = display.newGroup()
ca.alpha = 0


-- ca_b: codec answering button
local ca_b = display.newRect(w*0.33, h*0.85, w*0.33, 50) -- x, y, width, height
ca_b.strokeWidth = M.c_txtb_sw
ca_b:setFillColor(255, 0, 0)
ca_b.currentTransition = nil
ca:insert(ca_b)


-- ca_b_txt: codec answering button text
local ca_b_txt = display.newText(
	"CALL!!",				-- text
	w*0.395, h*0.853,		-- x, y
	w*0.33, 50,				-- width, height
	native.systemFont,		-- font
	36						-- font size
)
ca:insert(ca_b_txt)


-- codec answering fade in function
local caFadeOut

local function caFadeIn()

	-- play the ringing sound
	sfx.activeChannelNumber = audio.play(sfx.ring)
	
	-- make the transition happen
	ca_b.currentTransition = transition.to(
		ca,
		{
			time=300,
			alpha=1,
			transition=easing.inOutQuad,
			onComplete=caFadeOut
		}
	)
end


-- codec answering button fade out
function caFadeOut()
	ca_b.currentTransition = transition.to(
		ca,
		{
			time=500,
			alpha=0.1,
			transition=easing.inOutQuad,
			onComplete=caFadeIn
		}
	)
end


-- codec activation button touch event listener
local activateCodec

function ca_b:touch(event)

	-- if the codec activation button is touched
	if event.phase == "began" then
	
		-- cancel the ca_b's transition
		transition.cancel(ca_b.currentTransition)
		
		-- stop the currently playing sound effect
		audio.stop(sfx.activeChannelNumber)
		
		-- play the codec activation button
		audio.play(sfx.answer)
	
		-- make the text box darker
		ca_b:setFillColor(200, 0, 0)
	
	-- if the codec is released
	elseif event.phase == "ended" or event.phase == "cancelled" then
	
		-- remove codec activation box and text
		disposeCodecAnsweringButton()
		
		-- activate the codec
		activateCodec()
	end
	
	return true
end

ca_b:addEventListener("touch", ca_b)


-- disposing codec answering button
function disposeCodecAnsweringButton()
	
	ca_b.currentTransition = nil
	
	ca_b:removeSelf()
	ca_b = nil
		
	ca_b_txt:removeSelf()
	ca_b_txt = nil
		
	ca:removeSelf()
	ca = nil
end


-- c_dg: codec display group
local c_dg = display.newGroup()


-- c_txtb: codec textbox
local c_txtb = display.newRect(M.c_txtb_x, M.c_txtb_y, M.c_txtb_w, M.c_txtb_h)
c_txtb.strokeWidth = M.c_txtb_sw
c_txtb:setFillColor(0, 0, 200)
c_txtb:setStrokeColor(200, 200, 200)
c_dg:insert(c_txtb)


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
c_dg:insert(c_p)


-- c_p_img: codec portrait image
local c_p_imgtable = {
	Reggie 	= display.newImageRect(M.c_p_img.Reggie.neutral, M.c_p_w, M.c_p_w),
	Tyce	= display.newImageRect(M.c_p_img.Tyce.neutral, M.c_p_w, M.c_p_w)
}

-- c_p_reggie: reggie's portrait image
local c_p_reggie	= c_p_imgtable["Reggie"]
c_p_reggie.x 		= M.c_p_img_x
c_p_reggie.y 		= M.c_p_img_y
c_p_reggie.alpha	= 0

-- c_p_tyce: tyce's portrait image
local c_p_tyce		= c_p_imgtable["Tyce"]
c_p_tyce.x 			= M.c_p_img_x
c_p_tyce.y 			= M.c_p_img_y
c_p_tyce.alpha		= 0
c_dg:insert(c_p_reggie)
c_dg:insert(c_p_tyce)


-- c_p_txt: codec portrait text
local c_p_txt = display.newText(
	MSGS[msg_c].name,				-- text
	M.c_p_t_x, M.c_p_t_y,			-- x, y
	M.c_p_w, 28,					-- width, height
	native.systemFontBold,			-- font,
	M.c_txt_fs						-- font size
)
c_p_txt.alpha = 0


-- appearing codec effect
local makeCodecAssetsAppear

function activateCodec()

	-- play the appearing sound effect
	audio.play(sfx.appear)
	
	-- make the codec screen appear
	transition.to(
		c_dg, 
		{
			time = 900,
			y = -200,
			transition = easing.outExpo,
			onComplete = makeCodecAssetsAppear
		}
	)
end


-- codec assets populating listener
function makeCodecAssetsAppear(obj)

	-- make text appear
	c_txt.alpha   = 1
	c_p_txt.alpha = 1
	
	-- make portrait appear
	local speaker = MSGS[msg_c].name
	local c_p_rgb = M.c_p_img[speaker].color
	c_p:setFillColor(c_p_rgb.r, c_p_rgb.g, c_p_rgb.b)
	c_p_txt:setTextColor(c_p_rgb.r, c_p_rgb.g, c_p_rgb.b)
	c_p_imgtable[speaker].alpha = 1
end


-- codec touch event listener
local deactivateCodec

function c_dg:touch(event)

	-- if the codec is touched
	if event.phase == "began" then
		
		-- change the alpha to half
		c_dg.alpha = 0.5
	
	-- if the codec is released
	elseif event.phase == "ended" or event.phase == "cancelled" then
		c_dg.alpha = 1.0
		
		-- if there are any more messages
		if msg_c < MSGS[0] then
		
			-- play the advance sound effect
			audio.play(sfx.advance)
			
			-- make the previous image go away
			local previousSpeaker = MSGS[msg_c].name
			c_p_imgtable[previousSpeaker].alpha = 0
		
			-- grab the information for the next message
			msg_c = msg_c + 1
			local speaker = MSGS[msg_c].name
			local message = MSGS[msg_c].content
			local c_p_rgb = M.c_p_img[speaker].color
			
			-- change the message and portrait in the codec
			c_txt.text    = message
			c_p_txt.text  = speaker
			c_p:setFillColor(c_p_rgb.r, c_p_rgb.g, c_p_rgb.b)
			c_p_txt:setTextColor(c_p_rgb.r, c_p_rgb.g, c_p_rgb.b)
			c_p_imgtable[speaker].alpha = 1
			
		else
		
			-- send the codec away
			deactivateCodec()
		end
	end
	
	return true
end
c_dg:addEventListener("touch", c_dg)


-- disappearing codec effect
local disposeCodec

function deactivateCodec()
	
	-- play the disappearing codec sound
	audio.play(sfx.hangUp)
	
	-- make the text disappear
	c_txt.alpha   = 0
	c_p_txt.alpha = 0
	
	-- have the codec fall off the screen
	transition.to(
		c_dg, 
		{
			time = 900,
			y = 25,
			transition = easing.outExpo,
			onComplete = disposeCodec
		}
	)
end


-- codec sound effect disposal
local function disposeCodecSfx()
	
	sfx.activeChannelButton = nil
	
	-- dispose the rest of the sound effects
	for s,v in pairs(sfx) do
		audio.dispose(sfx[s])
		sfx[s] = nil
	end
	
	-- dispose the sfx table
	sfx = nil
end


-- complete codec disposal
function disposeCodec()

	-- dispose the sfx
	disposeCodecSfx()
	
	-- dispose codec display group event listener
	

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
	
	-- remove codec display group
	c_dg:removeSelf()
	c_dg = nil
	
	-- codec has now finally ended
	Runtime:dispatchEvent(c.codecEndEvent) 
	
end


-- codecStartEvent: the event that indicates the codec has started operating
c.codecStartEvent = {
	name = "codecStartEvent"
}


-- codecStartEventListener: called when the codecStartEvent is called
local function codecStartEventListener(event)
	print(event.name .. " has happened")
	
	-- codec answering button fades in
	caFadeIn()
end


-- add the codec start event listener to runtime
Runtime:addEventListener("codecStartEvent", codecStartEventListener)


-- codecEndEvent: the event that indicates the codec has ended
c.codecEndEvent = {
	name = "codecEndEvent"
}


-- codecStartEvent: called when the codecEndEvent is called
local function codecEndEventListener(event)
	print(event.name .. " has happened")
end


-- add the codec end event listener to runtime
Runtime:addEventListener("codecEndEvent", codecEndEventListener)


return c
