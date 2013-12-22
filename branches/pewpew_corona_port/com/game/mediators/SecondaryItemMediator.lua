require("org.Mediator")

SecondaryItemMediator = Mediator:subclass("SecondaryItemMediator")

function SecondaryItemMediator:init()
	self.super:init()
end

function SecondaryItemMediator:onRegister()
	--print('view id in secondaryItemMediator: ' .. tostring(self.view))
	self.viewInstance.sceneGroup:addEventListener("FireSecondaryWeapon", self)
end

function SecondaryItemMediator:onRemove()
	self.viewInstance.sceneGroup:removeEventListener("FireSecondaryWeapon", self)
end

function SecondaryItemMediator:FireSecondaryWeapon(event)
	local itemName = event.id
	print('itemName: ' .. tostring(itemName))
	print('Fire Secondary Weapon')
	if event.name == "FireSecondaryWeapon" then
		Runtime:dispatchEvent({name = 'fireSecondary', item = itemName})
	end

	return true
end

return SecondaryItemMediator