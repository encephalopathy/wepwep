function createBttn(widget, display, labelName, x, y, onReleaseCallback)

	if onReleaseCallback == nil then
		onReleaseCallback = onDefaultRelease
	end

	local newGameButton = widget.newButton{
		label=labelName,
		labelColor = { default={255}, over={128} },
		defaultFile="button.png",
		overFile="button-over.png",
		width=154, height=40,
		onRelease = onReleaseCallback	-- event listener function
	}
	
	if display ~= nil then
		newGameButton:setReferencePoint(  display.CenterReferencePoint )
	end
	
	if x ~= nil then
		newGameButton.x = x
	end
	
	if y ~= nil then
		newGameButton.y = y
	end

	return newGameButton
end


-- Slider listener
local function sliderListener( event )
    local slider = event.target
    local value = event.value
end