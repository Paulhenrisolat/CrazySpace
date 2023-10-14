local PauseMenu = {}

local Option = require("option")
local UiManager = require("uiManager")

PauseMenu.isPaused = false
PauseMenu.actualScene = nill

function PauseMenu.load()
    Option.load()
end

function PauseMenu.update(dt)
    PauseMenu.actualScene = UiManager.actualScene
    UiManager.isPaused = PauseMenu.isPaused
end

function PauseMenu.draw()
    if PauseMenu.actualScene ~= "titleMenu" then
        Option.draw()
    end
end

function PauseMenu.keypressed(key)
    if key == "escape" then
        if  PauseMenu.isPaused == false then
            if PauseMenu.actualScene == "titleMenu" then
                UiManager.actualScene = "option"
            elseif PauseMenu.actualScene == "option" then
                UiManager.actualScene = "titleMenu"
            else
                PauseMenu.isPaused = true
            end
        else
            PauseMenu.isPaused = false
        end
        print("Pause: "..tostring(PauseMenu.isPaused))
    end
end

return PauseMenu