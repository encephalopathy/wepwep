require 'org.View'
require 'com.Utility'

local widget = require('widget')

ToolTipView = View:subclass("ToolTipView")

local priceToolTipText =  "PRICE: "
local weightToolTipText = "WEIGHT : "

--temp
local loremIpsum = "Lorem ipsum dolor sit amet, nec omnis affert sensibus id, at est bonorum nominati, his primis nemore ne. Liber impedit eam te, at cibo nusquam scaevola sit, at graeco nostro est. In duo suavitate disputando, ad mei mucius imperdiet. Justo sanctus aliquando eum ad, has et possit maluisset efficiantur. Id esse liber voluptatibus vim, assentior disputando ei sed, zril utamur volutpat pro et. Clita epicurei invidunt vis ex."
local background, dollazText, weightText, splash_image, description, title

local sceneGroup


local function tempEventListener()
	print('hi')
end

function ToolTipView:init(sceneGroup)
	self.super:init(sceneGroup)
	self.description = nil
	
	print('CREATING TOOL TIP VIEW')
	local group = self.sceneGroup
	
	
	background = display.newRect(0, 0, display.contentWidth * 0.9,display.contentHeight * 0.4)
	background:setFillColor(0,0,0,0.2)
	local imageContainer = {}
	
	
	dollazText = display.newText( priceToolTipText .. 0, -display.contentWidth * 0.3, -display.contentHeight * 0.16, native.systemFont, 20 )
	weightText = display.newText( weightToolTipText .. 0, display.contentWidth * 0.3, -display.contentHeight * 0.16, native.systemFont, 20 )
	
	
	splash_image = display.newImageRect("com/resources/art/background/sheet_metal.png", display.contentWidth * 0.25, display.contentWidth * 0.25)
	
	--Left side button location
	--splash_image.x, splash_image.y = -display.contentWidth * 0.25, -display.contentHeight * 0.009
	
	--Right side button location
	splash_image.x, splash_image.y = display.contentWidth * 0.25, -display.contentHeight * 0.009
	
	--Place holder buy and sell buttons
	buyButton = widget.newButton {
		width = display.contentWidth * 0.2,
		height = display.contentHeight * 0.06,
		label="Buy",
		defaultFile="com/resources/art/sprites/button.png",
		overFile="com/resources/art/sprites/button-over.png",
		font = native.systemFont,
		onRelease = function()
			sceneGroup.isVisible = false
			--TODO: Give the target the correct frame index so that the inventory view can update 
			local target = {item = splash_image}
			sceneGroup:dispatchEvent({name = "Buy", target = target})
		end
	}
	sellButton = widget.newButton {
		width = display.contentWidth * 0.2,
		height = display.contentHeight * 0.06,
		label="Sell",
		defaultFile="com/resources/art/sprites/button.png",
		overFile="com/resources/art/sprites/button-over.png",
		font = native.systemFont,
	}
	
	--Left side button location
	--buyButton.x, buyButton.y = -display.contentWidth * 0.3, display.contentHeight * 0.15
	
	--Right side button location
	buyButton.x, buyButton.y = display.contentWidth * 0.3, display.contentHeight * 0.15
	sellButton.x, sellButton.y = buyButton.x, buyButton.y
	
	--Left side button location
	--description = display.newText( loremIpsum, -display.contentWidth * 0.1, -display.contentHeight * 0.09, display.contentWidth * 0.5, display.contentHeight * 0.20, native.systemFont, 16)
	
	--Right side button location
	description = display.newText( loremIpsum, -display.contentWidth * 0.4, -display.contentHeight * 0.09, display.contentWidth * 0.5, display.contentHeight * 0.20, native.systemFont, 16)
	description.anchorX, description.anchorY = 0, 0
	title = display.newText( "PLACEHOLDER TITLE", 0, -display.contentHeight * 0.119, native.systemFont, 25 )

	
	self.sceneGroup:insert(background)
	self.sceneGroup:insert(description)
	self.sceneGroup:insert(dollazText)
	self.sceneGroup:insert(weightText)
	
	self.sceneGroup.x, self.sceneGroup.y = display.contentWidth * 0.5, display.contentHeight * 0.5
	self.sceneGroup.anchorX, self.sceneGroup.anchorY = 0, 0
	self.sceneGroup:insert(title)
	self.sceneGroup:insert(splash_image)
	self.sceneGroup:insert(buyButton)
	self.sceneGroup:insert(sellButton)
	
	ToolTipView.static.buyButton = buyButton
	ToolTipView.static.sellButton = sellButton
	
	ToolTipView.static.sceneGroup = self.sceneGroup
	sceneGroup:addEventListener('OnLoadSpriteDataComplete', self)
	sceneGroup:addEventListener('DisplayToolTip', self)
	
	print('SCENEGROUP IN TOOLTIP VIEW IS: ' .. tostring(sceneGroup))
	
	self:createView(self)
	
end



function ToolTipView:OnBuyButtonRelase(event)
	sceneGroup.isVisible = false
	--TODO: Give the target the correct frame index so that the inventory view can update 
	local target = {item = 'img', }
	sceneGroup:dispatchEvent({name = "Buy", target = target})
end

function ToolTipView:OnSellButtonRelease(event)
	sceneGroup.isVisible = false
	local target = {item = 'img'}
	sceneGroup:dispatchEvent({name = "Sell", target = target})
end

function ToolTipView:DisplayToolTip(event)
	print('DISPLAYING TOOLTIP DATA')
	local contents = event.target
	
	sceneGroup.isVisible = contents ~= nil
	
	
	local descriptionText = contents.description
	local isEquipped = contents.isEquipped
	local title = contents.title
	
	local dollaz = contents.target.dollaz
	local weight = contents.target.weight
	
	--TODO: Set the splash_image variable to be equal to the appropiate splash image when
	--      an image is selected
	description.text = descriptionText
	dollazText.text = priceToolTipText .. dollaz
	weight.text =  weightToolTipText .. weight
	title.text = title
	
	ToolTipView.static.sellButton.isVisible = isEquipped
	ToolTipView.static.buyButton.isVisible = not isEquipped
end

function ToolTipView:OnLoadSpriteDataComplete(event)
	print('DISPLAY TOOLIPVIEW SPRITE LOADING COMPLETE')
	local contents = event.target
	local primaryWeapons = contents.primarySplashImages
	local secondaryWeapons = contents.secondarySplashImages
	
	--[[print('Images on Carousel View: ')
	print('RECIEVED PRIMARY SPLASH IMAGES')
	for key, value in pairs(primaryWeapons) do
		print('Key: ' .. tostring(key))
		print('Value: ' .. tostring(value))
	end
	
	print('SECONDARY PRIMARY SPLASH IMAGES')
	for key, value in pairs(secondaryWeapons) do
		print('Key: ' .. tostring(key))
		print('Value: ' .. tostring(value))
	end]]--
	
	local function loadContent(itemSprites, itemImgs)
		assert(itemSprites ~= nil)
		for key, value in pairs(itemImgs) do
			local key = itemImgs[key]
			--print('load content key: ' .. key)
			itemSprites[key] = display.newImageRect(ToolTipView.static.sceneGroup, key, 50, 50)
			assert(itemSprites[key] ~= nil)
			
			itemSprites[key].x = -6000
			itemSprites[key].y = -6000
			itemSprites[key].isVisible = false
		end
	end
	
	local itemSplashImages = {}
	loadContent(itemSplashImages, primaryWeapons)
	loadContent(itemSplashImages, secondaryWeapons)
	
	ToolTipView.static.sprites = itemSplashImages
end

function ToolTipView:__tostring()
	return ToolTipView.name()
end

return ToolTipView