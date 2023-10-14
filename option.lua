local Option = {}

local UiManager = require("uiManager")

Option.InputImg = love.graphics.newImage("img/inputImg.png")
Option.InputX = UiManager.screenCenterX
Option.InputY = 100
Option.InputOX = Option.InputImg:getWidth()/2
Option.InputOY = Option.InputImg:getHeight()/2

function Option.load()
    UiManager.addButtton("titleMenu", UiManager.screenCenterX,UiManager.screenCenterY-30)
end

function Option.update(dt)

end


function Option.draw()
    love.graphics.print("Option",x,y)
    love.graphics.draw(Option.InputImg, Option.InputX, Option.InputY, 0,1,1, Option.InputOX,Option.InputOY)
    love.graphics.print("-- Z/Q/S/D | UP/LEFT/DOWN/RIGHT ARROW : Movement", UiManager.screenCenterX, Option.InputY+110, 0,1,1, Option.InputOX,Option.InputOY)
    love.graphics.print("-- SPACE : Shoot", UiManager.screenCenterX, Option.InputY+130, 0,1,1, Option.InputOX,Option.InputOY)
    love.graphics.print("-- ESCAPE : Pause", UiManager.screenCenterX, Option.InputY+150, 0,1,1, Option.InputOX,Option.InputOY)
    love.graphics.print("-- RETURN : Finish game, return to menu", UiManager.screenCenterX, Option.InputY+170, 0,1,1, Option.InputOX,Option.InputOY)
    love.graphics.print("-- TAB : Debug Mode", UiManager.screenCenterX, Option.InputY+190, 0,1,1, Option.InputOX,Option.InputOY)
    --Add created button
    for i = #UiManager.buttonsInScene,1,-1 do
        local b = UiManager.buttonsInScene[i]
        if b.name == "titleMenu" then
            love.graphics.draw(b.img, b.x, b.y, 0,b.scaleW,b.scaleH, b.imgOX,b.imgOY)
        end
    end
end

function Option.keypressed(key)
end

return Option