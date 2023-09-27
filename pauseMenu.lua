local PauseMenu = {}

local UiManager = require("uiManager")

function PauseMenu.keypressed(key)
    if key == "escape" then
        UiManager.actualScene = "titleMenu"
        print(UiManager.actualScene)
    end
end

return PauseMenu