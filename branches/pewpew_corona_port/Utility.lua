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

function distance (x1, y1, x2, y2)
   return math.sqrt((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2))
end

function tprint (tbl, indent)
  if not indent then indent = 0 end
  for k, v in pairs(tbl) do
    formatting = string.rep("  ", indent) .. k .. ": "
    if type(v) == "table" then
      print(formatting)
      tprint(v, indent+1)
    else
      print(formatting .. v)
    end
  end
end