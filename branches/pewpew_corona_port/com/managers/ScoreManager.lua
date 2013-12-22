--Score Manager
--local startingDollaz --the amount of money that you enter a session with
--local sectionScore --the score for the section you are playing
--local runScore --the score for the current session you are playing
local gameScene

ScoreManager = {}

--constructor
function ScoreManager.create()
	ScoreManager.startingDollaz = 0
	ScoreManager.runScore = 0
	ScoreManager.sectionScore = 0
	
	local storyboard = require('storyboard')
	local scene = storyboard.getScene("game")
	
	gameScene = scene
	
	Runtime:addEventListener("enterScene", ScoreManager.resetRunScore)
	Runtime:addEventListener("enterScene", ScoreManager.resetSectionScore)
end

function ScoreManager:addListener() --grab scene object from the storyBoard for optimization
	Runtime:addEventListener("addScore", ScoreManager.addScore)
	--gameScene.view:addEventListener("addScore", ScoreManager.addScore)
end

function ScoreManager:removeListener() --grab scene object from the storyBoard for optimization
	Runtime:removeEventListener("addScore", ScoreManager.addScore)
	--gameScene.view:removeEventListener("addScore", ScoreManager.addScore)
end

function ScoreManager.addScore(event)
	print("INSIDE ScoreManager.addScore")
	if event.name == "addScore" then
		--print("inside addScore")
		-- print("ScoreManager.runScore: "..ScoreManager.runScore)
		-- print("event.score: "..event.score)
		-- print("ScoreManager.startingDollaz: "..ScoreManager.startingDollaz)
		-- print("new runScore: "..(ScoreManager.runScore + (event.score - ScoreManager.startingDollaz)))
		ScoreManager.runScore = ScoreManager.runScore + (event.score - ScoreManager.startingDollaz)
		print(ScoreManager.runScore)
		--print("ScoreManager runScore: "..ScoreManager.runScore)
	end
end

function ScoreManager.resetRunScore(event)
	print("resetRunScore")
	if event.name == "resetRunScore" then
		ScoreManager.runScore = 0
	end
end

function ScoreManager.resetSectionScore(event)
	print("resetSectionScore")
	if event.name == "resetSectionScore" then
		ScoreManager.sectionScore = 0
	end
end


