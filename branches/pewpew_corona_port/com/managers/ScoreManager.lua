--Score Manager
--local startingDollaz --the amount of money that you enter a session with
--local sectionScore --the score for the section you are playing
--local runScore --the score for the current session you are playing
local gameScene

ScoreManager = {}

--constructor
function ScoreManager.create()
	ScoreManager.runScore = 0
	ScoreManager.sectionScore = 0
	
	local storyboard = require('storyboard')
	local scene = storyboard.getScene("game")
	
	if scene == nil then
		print("scene is nil")
	end
	
	gameScene = scene
	
	gameScene:addEventListener("exitScene", ScoreManager.resetRunScore)
	gameScene:addEventListener("exitScene", ScoreManager.resetSectionScore)
	
end

function ScoreManager:addListener() --grab scene object from the storyBoard for optimization
	print("Inside addListener")
	Runtime:addEventListener("addScore", ScoreManager.addScore)
end

function ScoreManager:removeListener() --grab scene object from the storyBoard for optimization
	print("inside removeListener")
	Runtime:removeEventListener("addScore", ScoreManager.addScore)
end

function ScoreManager.addScore(event)
	--print("INSIDE ScoreManager.addScore")
	if event.name == "addScore" then
		--print("inside addScore")
		-- print("ScoreManager.runScore: "..ScoreManager.runScore)
		--print("event.score: "..event.score)
		--print("new runScore: "..(ScoreManager.runScore + (event.score )))
		ScoreManager.runScore = ScoreManager.runScore + event.score
		--print(ScoreManager.runScore)
		--print("ScoreManager runScore: "..ScoreManager.runScore)
	end
end

function ScoreManager.resetRunScore(event)
	print("INSIDE ScoreManger.resetRunScore")
	if event.name == "exitScene" then
		mainInventory.dollaz = mainInventory.dollaz + ScoreManager.runScore
		--print("mainInventory.dollaz: "..mainInventory.dollaz)
		ScoreManager.runScore = 0
	end
end

function ScoreManager.resetSectionScore(event)
	print("INSIDE ScoreManager.resetSectionScore")
	if event.name == "exitScene" then
		ScoreManager.sectionScore = 0
	end
end


