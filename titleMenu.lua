local TitleMenu = {}

local UiManager = require("uiManager")
local DebugManager = require("debugManager")

TitleMenu.img = love.graphics.newImage("img/titleImg.png")

function TitleMenu.load()
    UiManager.addButtton("gameplay", UiManager.screenCenterX,UiManager.screenCenterY)
    UiManager.addButtton("option", UiManager.screenCenterX,UiManager.screenCenterY+50)
end

function TitleMenu.update(dt)

end

function TitleMenu.draw()
    love.graphics.draw(TitleMenu.img)
    love.graphics.print("CrazySpace",UiManager.screenCenterX-30,UiManager.screenCenterY-80)
    --Add created BTN
    for i = #UiManager.buttonsInScene,1,-1 do
        local b = UiManager.buttonsInScene[i]
        if b.name =="gameplay" or b.name == "option" then
            love.graphics.draw(b.img, b.x, b.y, 0,b.scaleW,b.scaleH, b.imgOX,b.imgOY)
        end
    end
    --Debug
    if DebugManager.debug == true then
        love.graphics.print("TitleMenu",x,y)
        love.graphics.print("btn:"..#UiManager.buttons.." In scene:"..#UiManager.buttonsInScene.." Mouse Pos x:"..UiManager.mouseX.." y:"..UiManager.mouseY,x,15)
        love.graphics.print("BTN Name :"..UiManager.buttonSelectedname,x,30)
    end
end

function TitleMenu.keypressed(key)

end

return TitleMenu