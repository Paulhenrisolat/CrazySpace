local TitleMenu = {}

local UiManager = require("uiManager")

function TitleMenu.load()
    --1,2,3->play,option,exit
    print("test")
    UiManager.addButtton("gameplay", UiManager.screenCenterX,UiManager.screenCenterY)
    UiManager.addButtton("option", UiManager.screenCenterX,UiManager.screenCenterY+50)
    print(#UiManager.buttonsInScene)
end

function TitleMenu.update(dt)

end

function TitleMenu.draw()
    love.graphics.print("TitleMenu",x,y)
    love.graphics.print("btn:"..#UiManager.buttons.." In scene:"..#UiManager.buttonsInScene.." Mouse Pos x:"..UiManager.mouseX.." y:"..UiManager.mouseY,x,15)
    love.graphics.print("BTN Name :"..UiManager.buttonSelectedname,x,30)
    --Add created
    for i = #UiManager.buttonsInScene,1,-1 do
        local b = UiManager.buttonsInScene[i]
        if b.name =="gameplay" or b.name == "option" then
            love.graphics.draw(b.img, b.x, b.y, 0,b.scaleW,b.scaleH, b.imgOX,b.imgOY)
        end
    end
end

function TitleMenu.keypressed(key)

end

return TitleMenu