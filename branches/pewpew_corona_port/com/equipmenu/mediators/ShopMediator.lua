require 'org.Mediator'

ShopMediator = Mediator:subclass("ShopButtonMediator")

local sceneGroupRef

function ShopMediator:init()
	self.super:init()
end

function ShopMediator:onRegister()
	self.viewInstance.sceneGroup:addEventListener("Display", self)
	self.viewInstance.sceneGroup:addEventListener("Buy", self)
	self.viewInstance.sceneGroup:addEventListener("Sell", self)
	self.viewInstance.sceneGroup:addEventListener("OnItemSelect", self)
	sceneGroupRef = self.viewInstance.sceneGroup
end

function ShopMediator:onRemove()
	self.viewInstance.sceneGroup:removeEventListener("Display", self)
	self.viewInstance.sceneGroup:removeEventListener("Buy", self)
	self.viewInstance.sceneGroup:removeEventListener("Sell", self)
	self.viewInstance.sceneGroup:removeEventListener("OnItemSelect", self)
	self.viewInstance.sceneGroup:removeEventListener("OnLoadSpriteDataComplete", self)
	sceneGroupRef = nil
end

function ShopMediator:Display(event)
	if event.name == "Display" then
		print("DISPATCHING EVENT")
		Runtime:dispatchEvent({name = "playSound", soundHandle = 'enterEquip'})
		event.name = "ShowToolTip"
		Runtime:dispatchEvent(event)
	end

	return true
end

function ShopMediator:OnItemSelect(event)
	
	local contents = event.target
	
	print('isEmptySlot: ' .. tostring(contents.empty))
	print('itemToDisplay: ' .. tostring(contents.item))
	print('slotNum: ' .. tostring(contents.slotNum))
	
	local isEmptySlot = contents.empty
	local itemToDisplay = contents.item
	local slotNum = contents.slotNum
	
	if not isEmptySlot then
		Runtime:dispatchEvent({name = "GetToolTipData", target = {item = contents.item}})
	end
	print('Trying to display carousel from Shop Mediator')
	sceneGroupRef:dispatchEvent({name = "DisplayCarousel", target = {carouselID = slotNum}})
end

--TODO: Move the logic that determines whether the player can buy or sell items in these functi
function ShopMediator:Buy(event)
	self.viewInstance.sceneGroup:dispatchEvent({name = "FillInventorySlot", target = event.target})
	self.viewInstance.sceneGroup:dispatchEvent({name = "SetItemSelected", target = event.target})
end

function ShopMediator:Sell(event)
	self.viewInstance.sceneGroup:dispatchEvent({name = "SellItem", target = event.target})
	
end
	
return ShopMediator

