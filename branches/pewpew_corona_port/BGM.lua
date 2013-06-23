MOAIUntzSystem.initialize(44100, 1000) --may need to initialize the sound system out here instead of each screen

MOAIUntzSystem.setVolume(1) --set the initial volume
volumeValue = MOAIUntzSystem.getVolume() --get the volume you shit

--BGM for the main menu
mainMenuBGM = MOAIUntzSound.new()
mainMenuBGM:load('menuBackMusic.ogg')
mainMenuBGM:setLooping(true)

--BGM for the game
gameBGM = MOAIUntzSound.new()
gameBGM:load('gameBackMusic.ogg')
gameBGM:setLooping(true)

--BGM for the shop
storeBGM = MOAIUntzSound.new()
storeBGM:load('shopMusic.ogg')
storeBGM:setLooping(true)
storeBGMPlaying = false

--BGM for the equip screen
equipBGM = MOAIUntzSound.new()
equipBGM:load('equipMusic.ogg')
equipBGM:setLooping(true)
equipBGMPlaying = false
