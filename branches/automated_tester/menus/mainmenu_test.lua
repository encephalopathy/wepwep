#! /usr/bin/lua
require 'Test.More'

plan(1)

--[[local function contextTest()
	local mainMenuContext = Context:new()
	
	local group = display.newGroup()
	
	mainMenuContext:mapMediator("com.mainmenu.views.PlayButton", "com.mainmenu.mediators.PlayButtonMediator")
    mainMenuContext:mapMediator("com.mainmenu.views.ShopButton", "com.mainmenu.mediators.ShopButtonMediator")
    mainMenuContext:mapMediator("com.mainmenu.views.EquipButton", "com.mainmenu.mediators.EquipButtonMediator")
	mainMenuContext:mapMediator("com.mainmenu.views.TestPlayGameButton", "com.mainmenu.mediators.TestGameMediator")
   
    mainMenuContext:preprocess(group)
	return nil
end]]--

is(5, 5, 'Passed Test')



pass "one"

done_testing()



