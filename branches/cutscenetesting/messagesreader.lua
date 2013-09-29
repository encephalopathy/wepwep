--[[
messagesreader.lua

Reads in a text file, and returns a table containing all of the messages
and speakers. Used as input for the codec.
]]--


local messages = {}

messages = {			-- NOTE: messages[0] is the number of total messages
	[0] = 5,
	{name = "Reggie", content = "Let me tell you a story about my father..."},
	{name = "Reggie", content = "He was a silly little man, who has no hopes for the future."},
	{name = "Reggie", content = "He always had a bungle of dishes to clean."},
	{name = "Reggie", content = "Do you know what I'm saying?"},
	{name = "Tyce",   content = "Frankly, sir, I don't give a damn."}
}

return messages