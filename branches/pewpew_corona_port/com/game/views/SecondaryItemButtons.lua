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
	local xPos, yPos = 70, 70
	local width, height = 50, 50
	local dy = 50
	return xPos, yPos, width, height, dy
end

local function createItemButton(group, i, name, xPos, yPos, width, height, isPassive)
	if group[i] == nil then
		--print(type(group.onPress))
		
		local labelColor
		local secondaryItem
		if isPassive then
			labelColor = { 0.3, 0.3, 0.3, 0.7 }
			secondaryItem = display.newImageRect(name, width, height)
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

function SecondaryItemButtons:createButtons(event)
	local screenWidth, screenHeight = display.contentWidth, display.contentHeight
	local xPos, yPos, width, height, dy = getButtonResolution()
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
		createItemButton(group, i, passiveName, xPos, yPos, width, height, true)
		i = i + 1
		yPos = yPos + dy
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