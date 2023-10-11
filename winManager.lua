local WinManager = {}

local UiManager = require("uiManager")
local Ennemy = require("ennemy")
local Player = require("player")

WinManager.gameIsWon = false
WinManager.img = love.graphics.newImage("img/win.png")
WinManager.imgX = UiManager.screenCenterX
WinManager.imgY = UiManager.screenCenterY
WinManager.imgOX = WinManager.img:getWidth()/2
WinManager.imgOY = WinManager.img:getHeight()/2


function WinManager.win()
    if Player.HP > 0 and #Ennemy.ennemyInScene == 0 then
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
        love.graphics.draw(WinManager.img,UiManager.screenCenterX,UiManager.screenCenterY,0,2,2,WinManager.imgOX,WinManager.imgOY)
        love.graphics.print("You WIN !",WinManager.imgX,WinManager.imgY)
        love.graphics.print("- Press Enter/Return -",WinManager.imgX-30,WinManager.imgY+30)
    end
end

function WinManager.keypressed(key)
    if key=="return" and WinManager.gameIsWon == true then
        UiManager.actualScene = "titleMenu"
        Player.HP = Player.maxHP
        WinManager.gameIsWon = false
    end
end

return WinManager