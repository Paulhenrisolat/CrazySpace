local TitleMenu = {}

local UiManager = require("uiManager")

TitleMenu.btnPlayX = UiManager.screenCenterX
TitleMenu.btnPlayY = UiManager.screenCenterY

TitleMenu.btnConfigX = UiManager.screenCenterX
TitleMenu.btnConfigY = UiManager.screenCenterY + 50

function TitleMenu.buttonPos(x,y)
    local newBtnPos ={}
    newBtnPos.x = x
    newBtnPos.y = y
    newBtnPos.isActive = false
    table.insert(UiManager.buttonsInScene, newBtnPos)
end

function TitleMenu.load()
    TitleMenu.buttonPos(TitleMenu.btnPlayX,TitleMenu.btnPlayY)
    TitleMenu.buttonPos(TitleMenu.btnConfigX,TitleMenu.btnConfigY)
end

function TitleMenu.update(dt)

end

function TitleMenu.draw()
    love.graphics.print("TitleMenu",x,y)
    love.graphics.print("btn:"..#UiManager.buttons.." In scene:"..#UiManager.buttonsInScene.." Mouse Pos x:"..UiManager.mouseX.." y:"..UiManager.mouseY,x,15)
    love.graphics.print("BTN index: "..UiManager.buttonSelected,x,30)
    --1,2,3->play,config,exit
    UiManager.addButton(1,TitleMenu.btnPlayX,TitleMenu.btnPlayY)
    UiManager.addButton(2,TitleMenu.btnConfigX,TitleMenu.btnConfigY)
end

function TitleMenu.keypressed(key)

end

return TitleMenu