local deathManager = {}

local UiManager = require("uiManager")
local Player = require("player")

deathManager.img = love.graphics.newImage("img/over.png")
deathManager.imgOX = deathManager.img:getWidth()/2
deathManager.imgOY = deathManager.img:getHeight()/2

function deathManager.load()

end

function deathManager.draw()
    if Player.life <= 0 then
        love.graphics.draw(deathManager.img,UiManager.screenCenterX,UiManager.screenCenterY,0,2,2,deathManager.imgOX,deathManager.imgOY)
        love.graphics.print("GameOver",UiManager.screenCenterX-50,UiManager.screenCenterY-40)
        love.graphics.print("Money Gained: "..Player.money,UiManager.screenCenterX-50,UiManager.screenCenterY-20)
        love.graphics.print("- Press Enter/Return -",UiManager.screenCenterX-50,UiManager.screenCenterY)
    end
end

function deathManager.keypressed(key)
    if key=="return" and Player.life <= 0 then
        print("death")
        UiManager.actualScene = "titleMenu"
        Player.life = Player.maxLife
    end
end

return deathManager