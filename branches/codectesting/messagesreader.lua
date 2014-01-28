--[[
messagesreader.lua

Reads in a text file, and returns a table containing all of the messages
and speakers. Used as input for the codec.
]]--


-- mr: messagesreader, public functions for messagesreader
local mr = {}


local messages = {}


messages = {			-- NOTE: messages[0] is the number of total messages
	length = 5,
	{name = "Reggie", content = "Let me tell you a story about my father..."},
	{name = "Reggie", content = "He was a silly little man, who has no hopes for the future."},
	{name = "Reggie", content = "He always had a bundle of dishes to clean."},
	{name = "Reggie", content = "Do you know what I'm saying?"},
	{name = "Tyce",   content = "Frankly, sir, I don't give a damn."}
}


function removeCommentedContent(line)

    -- find a hash, if there is one 
    local hashPosition = line:find("#")
    
    -- remove the commented section of the line
    if hashPosition ~= nil then

        line = line:sub(0, hashPosition - 1)

    end
    
    -- return the uncommented content of the line
    return line
end


-- parse the line to grab the message table (NOT the messages table)
function parseLine(line)

	local message = {}

   	--TODO: figure out what to do if your content has a quotation marks inside it
   	message.content = line:match('%b""')

   	if message.content ~= nil then
		message.content = message.content:gsub('"', "")
   		line = line:gsub('%b""', "")
   	end

   	-- grab the name and the mood, in probably a very silly way
   	i = 1
   	for word in string.gmatch(line, "%a+") do
   		if i == 1 then
   			message.name = word
   		elseif i == 2 then
   			message.mood = word
   		end
   		i = i + 1
   	end

   	-- if the input was incorrect, then use the default words
   	if message.name == nil or message.mood == nil or message.content == nil then
   		print("ERROR (messagesreader): Input incorrect! Sending default values...")
   		message.name = "NOW YOU FUCKED UP!"
   		message.mood = "NOW YOU FUCKED UP!"
   		message.content = "YOU HAVE FUCKED UP NOW!"
   	end

   	return message
end


-- grab the line, and return a table containing the message to add to the messages table
function interpretLine(line)
    
    -- remove the commented content from the line
    line = removeCommentedContent(line)
    
    if string.len(line) == 0 then 
   		return nil
   	else
   		-- parse line, and populate the message table
   		local message = parseLine(line)

   		-- return the message table
   		return message
   	end
end


-- read a text file, and then populate the messages table with those messages
function mr.readMessagesTextFile(messagesFileName)

	-- load the file
	local filePath 	= system.pathForFile(messagesFileName)
	local file, err	= io.open(filePath)
	
	-- read the file, and do stuff with it
	if file then
	
		local currentLine = file:read("*l")
		local messagesIndex = 1
		
		while currentLine ~= nil do
		
	        -- interpret the line and get the message table
		    local message = interpretLine(currentLine)
		    
		    -- if there is a table that is returned from interpret line
		    if message ~= nil then

		    	-- put the table into messages
		    	messages[messagesIndex] = message

		    	-- increase the lineIndex
		    	messagesIndex = messagesIndex + 1
		    end
		    
		    --update the messages count with the correct number of messages
		    messages.length = messagesIndex - 1

		    -- move to the next line
		    currentLine = file:read("*l")
		end
		
	else
		print(err)
	end

	-- close and remove the file
	io.close(file)
	file = nil
end


-- let's test this function out
mr.readMessagesTextFile("messages.txt")


return messages