local PauseMenu = {}

local UiManager = require("uiManager")

PauseMenu.isPaused = false

function PauseMenu.load()

end

function PauseMenu.draw()
    
end

function PauseMenu.keypressed(key)
    if key == "escape" then
        if  PauseMenu.isPaused == false then
            PauseMenu.isPaused = true
        else
            PauseMenu.isPaused = false
        end
        print("Pause: "..tostring(PauseMenu.isPaused))
    end
end

return PauseMenu