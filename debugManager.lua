local DebugManager = {}

local UiManager = require("uiManager")

DebugManager.debug = false

function DebugManager.draw()
    love.graphics.print("DEBUG MODE ACTIVATED",UiManager.screenCenterX)
end

function DebugManager.keypressed(key)
    if key == "tab" then
        if DebugManager.debug == true then
            DebugManager.debug = false
        else
            DebugManager.debug = true
        end
    end
end

return DebugManager