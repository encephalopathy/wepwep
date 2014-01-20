module ( "Carousel", package.seeall )

require "com.equipmenu.Dequeue"

local widget = require "widget"
local storyboard = require( "storyboard" )


local spawnPoolLocX, spawnPoolLocY = 200, 5000
local padding = display.contentWidth * 0.1

local function equip(id, itemName)
	print('ADDING ID TO EQUIP: ' .. id)
	shop:buyItem(itemName, id)
end

--TODO: Move the object that is at carousel.last to the pool location.
local function displayCarousel(carousel)
	local startX = carousel.x
	local startY = carousel.y
	local numOfItemsShown = carousel.numItemsShown
	local first = carousel.first
	local width = carousel.width - padding * 2
	local seperationDistance = width / (carousel.numItemsShown)
	
	local index = carousel.items.first
	for i = 1, numOfItemsShown, 1 do
		carousel.items[index].x = startX + seperationDistance * i
		carousel.items[index].y = startY
		index = index + 1
	end
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


function new(sceneGroup, id, package, x, y, width, height, numItemsShown, isVerticalNotHorizontal, dollazText)
	local newCarousel = {}
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
		onEvent = function (event) 
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
	
	for i = 1, #package, 1 do
		local newItem = widget.newButton {
			ref = id,
			width = display.contentWidth/10,
			height = display.contentHeight/10,
			defaultFile = package[i],
			overFile = 'com/resources/art/sprites/sheep.png',
			id = package[i],
			font = native.systemFont,
			onEvent = function(event)
				equip(id, package[i])
				dollazText.text = "Dollaz : " .. tostring(mainInventory.dollaz)
			end
		}
		newItem.x, newItem.y = spawnPoolLocX, spawnPoolLocY
		sceneGroup:insert(newItem)
		Dequeue.insertFront(newCarousel.items, newItem)
	end
	
	sceneGroup:insert(newCarousel.prevItem)
	sceneGroup:insert(newCarousel.nextItem)
	
	newCarousel.x = x
	newCarousel.y = y
	newCarousel.width = width
	newCarousel.height = height
	newCarousel.id = id
	newCarousel.numItemsShown = numItemsShown
	newCarousel.isVerticalNotHorizontal = isVerticalNotHorizontal
	displayCarousel(newCarousel)
	return newCarousel
end