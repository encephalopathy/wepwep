module ( "Carousel", package.seeall )

require "com.equipmenu.Dequeue"
require "org.View"

CarouselView = View:subclass("CarouselView")

local widget = require "widget_corona.widgetLibrary.widget"
local storyboard = require("storyboard")

local spawnPoolLocX, spawnPoolLocY = 8000, 8000

local displayLocationX, displayLocationY = display.contentWidth * 0.01, display.contentHeight * 0.5
local padding = display.contentWidth * 0.1
local scene = nil

local function getInfo(id, itemName)
	print('ADDING ID TO EQUIP: ' .. id)
	scene:dispatchEvent({name = "GetToolTipData", target = {item = itemName, slot = id}})
	--shop:buyItem(itemName, id)
	--for i = 1, #carousels, 1 do
	--	displayCarousel(carousels[i])
	--end
end

local function setItemFillColor(item)
	if shop.Weapons[item.id] == nil and shop.SecondaryWeapons[item.id] == nil and shop.Passives[item.id] == nil then
		return
	end
	
	local itemTable
	local inventoryItem
	local primaryWeaponCarousel = false
	if shop.Weapons[item.id] ~= nil then
		itemTable = shop.Weapons
		primaryWeaponCarousel = true
	elseif shop.SecondaryWeapons[item.id] ~= nil then
		itemTable = shop.SecondaryWeapons
		inventoryItem = mainInventory.secondaryWeapons[item.id]
	elseif shop.Passives[item.id] ~= nil then
		itemTable = shop.Passives
		inventoryItem = mainInventory.passives[item.id]
	end

	local actualItem = itemTable[item.id]
	local weight = actualItem.weight
	local cost = actualItem.dollaz
	if not primaryWeaponCarousel then
		if inventoryItem ~= nil then
			item:setFillColor(0.5, 1, 0.5, 1)
		elseif mainInventory.dollaz - cost < 0 or mainInventory.weightAvailable - weight < 0 then
			item:setFillColor(1, 1, 1, 0.2)
		else
			item:setFillColor(1, 1, 1, 1)
		end
	else
		local primaryWeaponAsString = tostring(mainInventory.primaryWeapon)
		if mainInventory.primaryWeapon == actualItem then
			item:setFillColor(0.5, 1, 0.5, 1)
		elseif shop.Weapons[primaryWeaponAsString].weight + mainInventory.weightAvailable - weight < 0 or
		 shop.Weapons[primaryWeaponAsString].dollaz + mainInventory.dollaz - cost < 0 then
			 item:setFillColor(1, 1, 1, 0.2)
		 else
			 item:setFillColor(1, 1, 1, 1)
		 end		 
	end
end

--TODO: Move the object that is at carousel.last to the pool location.
function displayCarousel(carousel)
	if carousel == nil then warn('Carousel is nil') return end
	local startX = carousel.x
	local startY = carousel.y
	local numOfItemsShown = carousel.numItemsShown
	local first = carousel.first
	local width = carousel.width - padding * 2
	local seperationDistance = width / (carousel.numItemsShown)
	
	local index = carousel.items.first
	for i = 1, numOfItemsShown, 1 do
		print('Printing carousel items: ' .. tostring(carousel.items[index]))
		carousel.items[index].x = startX + seperationDistance * i
		carousel.items[index].y = startY
		index = index + 1
	end
end

function CarouselView:Buy(event)
	displayCarousel(CarouselView.static.carousels[CarouselView.static.carouselToDisplay])
end

function CarouselView:Sell(event)
	displayCarousel(CarouselView.static.carousels[CarouselView.static.carouselToDisplay])
end

function CarouselView:SwapCarousel(event)
	CarouselView.static.carouselToDisplay = event.carouselToDisplay
end

local function nextItem(carousel)
	local items = carousel.items
	local item = Dequeue.removeBack(items)
	local itemToMoveOffScreen = items[carousel.items.first + carousel.numItemsShown - 1]
	itemToMoveOffScreen.x, itemToMoveOffScreen.y = spawnPoolLocX, spawnPoolLocY
	Dequeue.insertFront(items, item)
	displayCarousel(carousel)
end

local function prevItem(carousel)	
	local item = Dequeue.removeFront(carousel.items)
	item.x, item.y = spawnPoolLocX, spawnPoolLocY
	Dequeue.insertBack(carousel.items, item)
	
	displayCarousel(carousel)
end


local function createCarousel(sceneGroup, id, package, x, y, width, height, numItemsShown, isVerticalNotHorizontal, dollazText, weightText)
	
	local newCarousel = {}
	local carouselGroup = display.newGroup()
	
	sceneGroup:insert(carouselGroup)
	newCarousel.yPos = y
	newCarousel.items = Dequeue.new()
	
    newCarousel.prevItem = widget.newButton {
		ref = newCarousel,
		width = padding,
		height = padding,
		defaultFile = defaultImagePath,
		overFile = clickedImagePath,
		id = "",
		label = "<",
		font = native.systemFont,
		onRelease = function (event) 
			prevItem(newCarousel, numItemsShown)
		end
	}
	
	newCarousel.prevItem.x = x
	newCarousel.prevItem.y = y
	
	
	newCarousel.prevItem.ref = newCarousel
	
    newCarousel.nextItem = widget.newButton {
		ref = newCarousel,
		width = padding,
		height = padding,
		defaultFile = defaultImagePath,
		overFile = clickedImagePath,
		id = "",
		label = ">",
		font = native.systemFont,
		onEvent = function (event)
			nextItem(newCarousel, numItemsShown)
		end
	}
	
	newCarousel.nextItem.x = x
	newCarousel.nextItem.y = y
	
	
	if not isVerticalNotHorizontal then
		newCarousel.nextItem.x = x + width - padding
	end
	
	--print('Number of items: ' .. tostring(#package))
	for key, value in pairs(package) do
		--print('RENDERING BUTTON ' .. tostring(package[key]))
		local newItem = widget.newButton {
			ref = id,
			width = display.contentWidth/10,
			height = display.contentHeight/10,
			defaultFile = package[key],
			overFile = 'com/resources/art/sprites/sheep.png',
			id = package[key],
			font = native.systemFont,
			onEvent = function(event)
				getInfo(id, package[key])
				--dollazText.text = "DOLLAZ : " .. tostring(mainInventory.dollaz)
				--weightText.text = "SPACE LEFT : " .. tostring(mainInventory.weightAvailable)
			end
		}
		newItem.x, newItem.y = spawnPoolLocX, spawnPoolLocY
		carouselGroup:insert(newItem)
		--print('Carousel item: ' .. tostring(newItem))
		Dequeue.insertFront(newCarousel.items, newItem)
	end
	
	carouselGroup:insert(newCarousel.prevItem)
	carouselGroup:insert(newCarousel.nextItem)
	
	newCarousel.x = x
	newCarousel.y = y
	newCarousel.width = width
	newCarousel.height = height
	newCarousel.id = id
	newCarousel.numItemsShown = numItemsShown
	newCarousel.isVerticalNotHorizontal = isVerticalNotHorizontal
	newCarousel.location = carouselGroup
	--displayCarousel(newCarousel)
	return newCarousel
	--table.insert(carousels, newCarousel)
	
end

function CarouselView:__tostring()
	return CarouselView.name()
end

function CarouselView:OnLoadSpriteDataComplete(event)
	local contents = event.target
	
	print('Recieved CarouselView sprite data')
	local primaryWeapsSplashImages = contents.primarySplashImages
	local secondarySplashImages = contents.secondarySplashImages
	
	assert(primaryWeapsSplashImages ~= nil)
	assert(secondarySplashImages ~= nil)
	
	local width, height = 50, 50
	local slotsAvailable = mainInventory.numOfEquipSlotsAvailable
	local carouselToDisplayIndex = CarouselView.static.carouselToDisplay
	
	--Show one carousel as a default for the shop, probably the primary weapon slot if it 		is not equipped.
	CarouselView.static.carousels[carouselToDisplayIndex] = createCarousel(scene, carouselToDisplayIndex, primaryWeapsSplashImages, 100, display.contentHeight * 0.3, 300, display.contentHeight * 0.1, 3, false, dollaztext, weighttext)
	CarouselView.static.carousels[carouselToDisplayIndex].location.x = spawnPoolLocY
	CarouselView.static.carousels[carouselToDisplayIndex].location.y = spawnPoolLocX
	
	--Cached carousels based on what inventory slot the player chooses.
	for i = 1, slotsAvailable, 1 do
		if carouselToDisplayIndex ~= i then
			CarouselView.static.carousels[i] = createCarousel(scene, i, secondarySplashImages, 100, display.contentHeight * 0.3, 300, display.contentHeight * 0.1, 3, false, dollaztext, weighttext)
			CarouselView.static.carousels[i].location.x, CarouselView.static.carousels[i].location.y = spawnPoolLocX, spawnPoolLocY
			--CarouselView.static.carousels[i].location.isVisible = false
		end
	end
	
	CarouselView.static.carouselToDisplay = -1
	--displayCarousel(CarouselView.static.carousels[carouselToDisplayIndex])
end

function CarouselView:DisplayCarousel(event)
	
	local contents = event.target
	
	local newCarouselIndexToDisplay = contents.carouselID
	print('DISPLAYING CAROUSEL : ' .. newCarouselIndexToDisplay)
	--print('Old carousel to display: ' .. CarouselView.static.carouselToDisplay)
	local carouselCurrentlyDisplayed = CarouselView.static.carousels[CarouselView.static.carouselToDisplay]
	
	local lastCarouselIndex = CarouselView.static.carouselToDisplay
	
	if newCarouselIndexToDisplay ~= lastCarouselIndex then
		--We check if the carousel is nil when we first display the newest carousel.
		if carouselCurrentlyDisplayed ~= nil then
			print('SWAPPING CAROUSELS')
			carouselCurrentlyDisplayed.location.x, carouselCurrentlyDisplayed.location.y = 8000, 8000
			carouselCurrentlyDisplayed.location.isVisible = false
		end
		local carouselToDisplay = CarouselView.static.carousels[newCarouselIndexToDisplay]
		assert(carouselToDisplay ~= nil)
		carouselToDisplay.location.x = displayLocationX
		carouselToDisplay.location.y = displayLocationY
		carouselToDisplay.location.isVisible = true
		
		CarouselView.static.carouselToDisplay = newCarouselIndexToDisplay
		displayCarousel(carouselToDisplay)
	end
end

function CarouselView:init(sceneGroup)
	self.super:init(sceneGroup)
	print('CREATING CAROUSEL VIEW')
	local carousels = {}
	local carouselToDisplayIndex = 1
	
	CarouselView.static.carouselToDisplay = carouselToDisplayIndex
	CarouselView.static.carousels = carousels
	scene = self.sceneGroup
	
	sceneGroup:addEventListener("OnLoadSpriteDataComplete", self)
	--sceneGroup:addEventListener("DisplayCarousel", self)
	self.sceneGroup:addEventListener("DisplayCarousel", self)
	--Runtime:addEventListener("DisplayCarousel", self)
	
	--displayCarousel(carousels[carouselToDisplayIndex])
	self:createView(self)
end

return CarouselView