require 'org.View'
require 'com.Utility'
local storyboard = require('storyboard')
--TODO: Free scene and widget local variables
SecondaryItemButtons = View:subclass("SecondaryItemButtons")

local scene = storyboard.getScene("game")
local widget = require 'widget'

function SecondaryItemButtons:init(sceneGroup)
	self.super:init(sceneGroup)
	
	local group = self.sceneGroup
	function group:onPress(event)
		group:dispatchEvent({name = 'FireSecondaryWeapon', target = group, id = self.target.id})
	end
	group.name = 'secondary items'
	scene:addEventListener("enterScene", self.createButtons)
	self:createView(self)
end

local function getButtonResolution()
	--TODO: reset the x and y positions and width and height based on the resolution of the phone.
	local xSidePos, ySidePos = 70, 150
	local xPassiveStartPos, yPassiveStartPos = display.contentWidth/20, display.contentHeight/50 + display.contentHeight/23
	local width, height = 75, 75
	
	local passiveDx = 50
	local dy = 125
	return xSidePos, ySidePos, width, height, dy, xPassiveStartPos, yPassiveStartPos, passiveDx
end

local function createItemButton(group, i, name, xPos, yPos, width, height, isPassive)
	if group[i] == nil then
		--print(type(group.onPress))
		
		local labelColor
		local secondaryItem
		if isPassive then
			labelColor = { 0.3, 0.3, 0.3, 0.7 }
			secondaryItem = widget.newButton {
				left = xPos,
				top = yPos,
				label = "",
				id = name,
				labelAlign = "center",
				defaultFile = name,
				overFile = "com/resources/art/sprites/sheep.png",
				width = width,
				height = height,
				labelColor = { default = labelColor, over = labelColor },
				onRelease = group.onPress
			}
			secondaryItem.x, secondaryItem.y = xPos, yPos
			secondaryItem:setFillColor(155, 155, 155, 0.5)
		else
			labelColor = { 1, 1, 1, 1 }
			secondaryItem = widget.newButton {
				left = xPos,
				top = yPos,
				label = "",
				id = name,
				labelAlign = "center",
				defaultFile = name,
				overFile = "com/resources/art/sprites/sheep.png",
				width = width,
				height = height,
				labelColor = { default = labelColor, over = labelColor },
				onRelease = group.onPress
			}
		end
		
		secondaryItem.baseLabel = ""
		--secondaryItem:setFillColor(255, )
		--We need to keep a reference to the widget to destroy it later
		group:insert(secondaryItem)
	else
		group[i].defaultFile = name
	end
	
end

function SecondaryItemButtons:createPassiveLabel(group, passiveName, xSidePos, ySidePos, width, height, passiveDx)
	local passiveLabel = display.newImageRect(passiveName, width, height)
	passiveLabel.x, passiveLabel.y = xSidePos + passiveDx, ySidePos
	group:insert(passiveLabel)
end

function SecondaryItemButtons:createButtons(event)
	local screenWidth, screenHeight = display.contentWidth, display.contentHeight
	local xSidePos, ySidePos, width, height, dy, xPassiveStartPos, yPassiveStartPos, passiveDx = getButtonResolution()
	local i = 1
	
	local sceneGroup = scene.view

	local group = nil
	for j = 1, sceneGroup.numChildren, 1 do
		if sceneGroup[j].name == 'secondary items' then
			group = sceneGroup[j]
		end
	end
	assert(group ~= nil, 'No group found in Secondary Item Buttons')
	
	
	for passiveName, passive in pairs(mainInventory.passives) do
		--print('passive name: ' .. passiveName)
		if passive.isActivatable then
			createItemButton(group, i, passiveName, xSidePos, ySidePos, width, height, true, passive.isActivatable)
			i = i + 1
			ySidePos = ySidePos + dy
		else
			createPassiveLabel(group, passiveName, xSidePos, ySidePos, 20, 20, passiveDx)
			xSidePos = xSidePos + passiveDx
		end	
	end

	--print('mainInventory.secondaryWeapons is: ' .. tostring(mainInventory.secondaryWeapons))
	for weaponName, weapon in pairs(mainInventory.secondaryWeapons) do
		--print('CREATING SECONDARY WEAPON IN GAME: weapon name: ' .. weaponName)
		createItemButton(group, i, weaponName, xPos, yPos, width, height, false)
		i = i + 1
		yPos = yPos + dy
	end
end

--Also make sure to override this by placing the name of the class with a call to the function name.
function SecondaryItemButtons:__tostring()
	return SecondaryItemButtons.name()
end

return SecondaryItemButtons