local WinManager = {}

local UiManager = require("uiManager")
local Ennemy = require("ennemy")
local Player = require("player")

WinManager.gameIsWon = false
WinManager.imgX = UiManager.screenCenterX
WinManager.imgY = UiManager.screenCenterY

function WinManager.win()
    if Player.life > 0 and #Ennemy.ennemyInScene == 0 then
        WinManager.gameIsWon = true
    end
end

function WinManager.load()
end

function WinManager.update(dt)
    WinManager.win()
end

function WinManager.draw()
    if WinManager.gameIsWon == true then
        love.graphics.print("You WIN !",WinManager.imgX,WinManager.imgY)
        love.graphics.print("- Press Enter/Return -",WinManager.imgX,WinManager.imgY+30)
    end
end

function WinManager.keypressed(key)
    if key=="return" and WinManager.gameIsWon == true then
        UiManager.actualScene = "titleMenu"
        Player.life = Player.maxLife
        WinManager.gameIsWon = false
    end
end

return WinManager