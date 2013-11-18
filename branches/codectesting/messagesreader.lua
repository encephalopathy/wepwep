--[[
messagesreader.lua

Reads in a text file, and returns a table containing all of the messages
and speakers. Used as input for the codec.
]]--


-- mr: messagesreader, public functions for messagesreader
local mr = {}


local messages = {}


messages = {			-- NOTE: messages[0] is the number of total messages
	[0] = 5,
	{name = "Reggie", content = "Let me tell you a story about my father..."},
	{name = "Reggie", content = "He was a silly little man, who has no hopes for the future."},
	{name = "Reggie", content = "He always had a bundle of dishes to clean."},
	{name = "Reggie", content = "Do you know what I'm saying?"},
	{name = "Tyce",   content = "Frankly, sir, I don't give a damn."}
}


function removeCommentedContent(line)
    -- find a hash, if there is one 
    local hashPosition = line:find("#")
    
    if hashPosition ~= nil then
        line = line:sub(0, hashPosition - 1)
        print("The stuff that is NOT commented is \""..line.."\".")
    end
    
    return line
end

-- grab the line, and assign the strings to the appropriate values
function interpretLine(line)
    
    -- remove the commented content from the line
    line = removeCommentedContent(line)
    
    print(line)
end


-- read a text file, and then populate the messages table with those messages
function mr.readMessagesTextFile(messagesFileName)

	-- load the file
	local filePath 	= system.pathForFile(messagesFileName)
	local file, err	= io.open(filePath)
	
	-- read the file, and do stuff with it
	if file then
	
		local currentLine = file:read("*l")
		
		while currentLine ~= nil do
		
	        -- interpret the line 
		    interpretLine(currentLine)
		    
		    -- move to the next line
		    currentLine = file:read("*l")
		end
		
	else
		print(err)
	end

	-- close and remove the file
	io.close(file)
	file = nil
	print("read messages all finished!")
end


-- let's test this function out
mr.readMessagesTextFile("messages.txt")


return messages