require 'org.View'

InventoryView = View:subclass("InventoryView")

local DEFAULT_IMAGE_BACKGROUND = 'com/resources/art/background/sheet_metal.png'

local scene
local widget = require('widget')

function InventoryView:init(sceneGroup)
	self.super:init(sceneGroup)
	self.carousels = nil
	
	local inventorySlotGroup = self.sceneGroup
	
	print('Slots avialable: ' .. mainInventory.numOfEquipSlotsAvailable)
	
	--TODO: Have max slots be associated to a selected ship.
	self:createInventorySlots(inventorySlotGroup, mainInventory.numOfEquipSlotsAvailable, 50)
	scene = sceneGroup
	inventorySlotGroup.x, inventorySlotGroup.y = display.contentWidth * 0.3, display.contentHeight * 0.2
	inventorySlotGroup.anchorX, inventorySlotGroup.anchorY = 0, 0
	--print('scene.x: ' .. tostring(inventorySlotGroup.x))
	--print('scene.y: ' .. tostring(inventorySlotGroup.y))
	sceneGroup:addEventListener('OnLoadSpriteDataComplete', self)
	self:createView(self)
end



function InventoryView:OnLoadSpriteDataComplete(event)
	print('DISPLAY TOOLIPVIEW SPRITE LOADING')
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
	
	InventoryView.static.sprites = itemSplashImages
end

--[[
	createInventorySlots
	DESCRIPTION:
		Creates the inventory slot backgrounds for each available slot.
]]
function InventoryView:createInventorySlots(sceneGroup, numberOfSlots, padding)
	local inventorySlots = {}
	
	local dx = display.contentWidth * 0.2
	local primaryCreated = true
	local title
	
	function sceneGroup.onRelease(event)
		local contents = event.target
		print('Img src in contents for the sceneGroup in InventoryView: ' .. tostring(contents.id))
		sceneGroup:dispatchEvent({name = "OnItemSelect", target = contents.id})
	end
	
	InventoryView.static.inventorySlots = inventorySlots
	
	for slotNum = 1, numberOfSlots, 1 do
		local group = display.newGroup()
		local background = display.newImageRect(group, DEFAULT_IMAGE_BACKGROUND, 70, 70)
		
		if primaryCreated then
			title = display.newText('PRIMARY', -display.contentWidth * 0.3, -display.contentHeight * 0.16, native.systemFont, 15 )
			primaryCreated = false
		else
			title = display.newText('SECONDARY', -display.contentWidth * 0.3, -display.contentHeight * 0.16, native.systemFont, 15 )
		end
		--TODO: Add a sprite sheet of all the weapon splash images.
		
		inventorySlots[slotNum] = widget.newButton {
									width = padding,
									height = padding,
									defaultFile = "com/resources/art/sprites/sheep.png",
									overFile = "com/resources/art/sprites/sheep.png",
									id = { empty = true, slotNum = slotNum, item = self.defaultFile},
									label = "Free",
									font = native.systemFont,
									onRelease = sceneGroup.onRelease
								}
								
								print('background: ' .. tostring(background))
								print('inventorySlots: ' .. tostring(inventorySlots[slotNum]))
		local xLoc = dx * (slotNum - 1)						
								
		inventorySlots[slotNum].x, inventorySlots[slotNum].y = 0, 0
		title.x, title.y = 0, -display.contentHeight * 0.07
		background.x, background.y = 0, 0
		group:insert(background)
		group:insert(title)
		group:insert(inventorySlots[slotNum])
		group.x, group.y = (slotNum - 1) * dx, 0
		sceneGroup:insert(group)
	end
end


--[[
	Sender events
]]--
function InventoryView:SelectObject(event)
	local id = event.id
	local item = mainInventory[id]
	
	scene:dispatchEvent({name = "Display", target = {slot = id, item = item}})
end

function InventoryView:Buy(event)
	local slot = event.target.id
	local imageToReplace = event.target.imgSrc
	
	--TODO: Display the correct frame
	
	if InventoryView.static.inventorySlots[slot].frame ~= imageToReplace then
		InventoryView.static.inventorySlots[slot].frame = imageToReplace
	else
		scene:dispatchEvent({name = "Display"})
	end
	
end

function InventoryView:__tostring()
	return InventoryView.name()
end

function InventoryView:clear()
	
end

return InventoryView