


-- Slider listener
local function sliderListener( event )
    local slider = event.target
    local value = event.value
end


local function callBackOnRelease()
    
	return true
end


--release button
if onReleaseCallback == nil then
		onReleaseCallback = onDefaultRelease
	end