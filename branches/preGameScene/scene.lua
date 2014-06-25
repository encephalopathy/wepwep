-- M: global variables module
local M = require("globals")
local sceneTwo = require( "scene2" )
-- c: public codec functions that can be called in main.lua
local c = {}

-- w: display width, h: display height
--local variables 
local w  = M.w
local h  = M.h

local images = {
"images/ffsplash.jpg",
"images/ffb.jpg",
"images/ffc.jpg",
"images/ffd.jpg",
"images/ffe.jpg",
}



local sceneText = {
"The story of Pew Pew",
"Once there was spaceship",
"he was very very lonely",
"so he went on a journey!",
"and then crashed into the sea!",
}

local soundClips = {
"sounds/s0.mp3",
"sounds/s1.wav",
"sounds/s2.wav",
"sounds/s3.wav",
"sounds/s4.wav",
}

images = sceneTwo.images;
sceneText = sceneTwo.sceneText;

local currentImageSpace = 1;

local function setImage( currentImage,xValue,yValue)
  currentImage.x = xValue
  currentImage.y = yValue
end

local objectGroup = display.newGroup()
objectGroup.width =  display.contentWidth;
objectGroup.height = display.contentHeight;
objectGroup.x = 300;
objectGroup.y = 400
sceneStarted = false;

-- touchArea
local touchArea = display.newRect(0, 0, w, h)
touchArea:setFillColor(0, 0, 200)
touchArea:setStrokeColor(200, 200, 200)
touchArea.alpha = .1
objectGroup:insert(touchArea)

local function normalizeImage(currentImage)
  currentImage.width = w
  currentImage.height = h
  setImage(currentImage, w/2,h/2)
end

local function fadeImage(object, transitionTime, fadeTo)
    object.alpha = 0.0
    if object.alpha ~= fadeTo then
      transition.to(object, {time = transitionTime, alpha = fadeTo})
    end
  end

local function iterateImage(currentImage, newImage)
  currentImage = display.newImage(newImage);
  normalizeImage(currentImage);
  fadeImage(currentImage, 400, 1.0)
end

local function imageDestroy (currentImage)
  fadeImage(currentImage, 4000, 0.0)
  currentImage:removeSelf()
  currentImage = nil
end

function destroyTextBox(textBox)
textBox:removeSelf();
end

local gameMusic = audio.loadStream( "sounds/fftheme.wav" );
local gameMusicChannel; 
local narratorChannel;
local sceneStarted = false

objectGroup:addEventListener("touch", objectGroup)

function objectGroup:touch(event)
  if event.phase == "ended" then
    if sceneStarted == false then
      gameMusicChannel = audio.play( gameMusic, { loops = -1 } );
      sceneStarted = true;
    end
 if currentImageSpace <= #images then
      audio.stop(narratorChannel);
      narratorSound = audio.loadStream(soundClips[currentImageSpace]);
      iterateImage(currentImage,images[currentImageSpace])
      narratorChannel = audio.play(narratorSound);
      overlay = display.newRect( w/2, 750, w, 100)
      overlay:setFillColor(gray)
      text = display.newText(sceneText[currentImageSpace], w * .5, 825, 400, 200,native.font,30);
    else 
      iterateImage(currentImage,"images/black.png");
      audio.stop(gameMusicChannel);
    end
      currentImageSpace = currentImageSpace + 1;
      --touchSwapTest(currentImageSpace)
      --printTestResults()
     -- destroyTextBox(text);
  end
  return 0;
end

function touchSwapTest(currentSpace)
--swap images when screen is touched
testCounter = testCounter + 1;
print("swap images when screen is touched")
testImageOne = display.newImage( images[1])
currentImage = display.newImage( images[1])
print(currentSpace)
  if touched and testImageOne ~= currentImage then
    print("green")
    passingTests = passingTests + 1;
  else
    print("red failed on swap")
  end

end

local function printTestResults()
  print( passingTests)
  print("of")
  print(testCounter)
end

function c:assetTest()
  testCounter = 0;
  passingTests = 0;
  local check = true
--images are loaded
testCounter = testCounter + 1;
print("images are loaded")
if images ~= nil then 
 print("green");
 passingTests = passingTests + 1;
else
  print("red")
end

-- images are used to create image objects
testCounter = testCounter + 1;
local testImage = display.newImage( images[1])
print("images are used to create image objects")
if testImage.width ~= nil then
  print("green");
  passingTests = passingTests + 1;
else
  print("red")
end

testImage:removeSelf()

--image is displayable
testCounter = testCounter + 1;
local testImage = display.newImage( images[1])
testImage.x = 10
testImage.y = 10
print("image is displayable")
if testImage.x ~= 0 then
  print("green");
  passingTests = passingTests + 1;
else
  print("red")
end
--set images to specific places
testCounter = testCounter + 1;
testImage:removeSelf()
local testImage = display.newImage( images[1])
setImage(testImage, 50,50)
print("set images to specific places")
if testImage.x == 50 then
  print("green");
  passingTests = passingTests + 1;
else
  print("red")
end
testImage:removeSelf()

--swap image with another from images array
testCounter = testCounter + 1;
local testImageOne = display.newImage(images[1])
local testImageTwo = display.newImage(images[2])
testImageTwo:removeSelf()
testImageOne:removeSelf()
testImageOne = display.newImage(images[2])

print("swap image with another from images array")
if testImageOne.width == testImageTwo.width then
  print("green")
  passingTests = passingTests + 1;
else
  print("red")
end
testImageOne:removeSelf()

--swap through entire images array
testCounter = testCounter + 1;
local testImage = display.newImage(images[1])
local expectedImage = display.newImage(images[5])
expectedImage:removeSelf()
for i = 1, #images , 1 do
  testImage:removeSelf()
  testImage = display.newImage(images[i])
end

print("swap through entire images array")
if testImage.width == expectedImage.width then
  print("green")
  passingTests = passingTests + 1;
else
  print("red")
end

testImage: removeSelf()

printTestResults()
end

return c
