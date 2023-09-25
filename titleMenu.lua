local TitleMenu = {}

TitleMenu.btnPlayX = 100
TitleMenu.btnPlayY = 100

function TitleMenu.buttonPos(x,y)
    local newBtnPos ={}
    newBtnPos.x = x
    newBtnPos.y = y
    table.insert(UiManager.buttonsInScene, newBtnPos)
    --UiManager.mouseOnButton()
end

function TitleMenu.load()
    TitleMenu.buttonPos(TitleMenu.btnPlayX,TitleMenu.btnPlayY)
end

function TitleMenu.update(dt)

end

function TitleMenu.draw()
    love.graphics.print("TitleMenu",x,y)
    love.graphics.print("btn:"..#UiManager.buttons.."Mouse Pos x:"..UiManager.mouseX.." y:"..UiManager.mouseY,x,15)
    love.graphics.print("Mouse On button: "..tostring(UiManager.mouseIsOnBTN),x,30)
    UiManager.addButton(1,TitleMenu.btnPlayX,TitleMenu.btnPlayY)
end

function TitleMenu.keypressed(key)

end

return TitleMenu