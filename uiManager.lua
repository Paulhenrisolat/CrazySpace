local UiManager = {}

UiManager.buttons = {}
UiManager.buttonsInScene = {}

UiManager.screenW = love.graphics:getWidth()
UiManager.screenH = love.graphics:getHeight()

UiManager.screenCenterX = UiManager.screenW/2
UiManager.screenCenterY = UiManager.screenH/2

UiManager.mouseX = love.mouse.getX()
UiManager.mouseY = love.mouse.getY()

UiManager.buttonSelected = 0

UiManager.actualScene = "titleMenu"

function UiManager.createButton(text, img)
    local newButton = {}
    newButton.text = text
    newButton.img = love.graphics.newImage("img/"..img..".png")
    newButton.imgW = newButton.img:getWidth()
    newButton.imgH = newButton.img:getHeight()
    newButton.imgOX = newButton.imgW/2
    newButton.imgOY = newButton.imgH/2
    newButton.imgScaleW = 1
    newButton.imgScaleH = 1
    table.insert(UiManager.buttons, newButton)
end

function UiManager.addButton(btn, x, y)
    love.graphics.draw(UiManager.buttons[btn].img, x, y, 0,UiManager.buttons[btn].imgScaleW,UiManager.buttons[btn].imgScaleH, UiManager.buttons[btn].imgOX,UiManager.buttons[btn].imgOY)
end

function UiManager.mouseOnButton()
    for i = #UiManager.buttonsInScene,1,-1 do
        local b = UiManager.buttonsInScene[i]

        if UiManager.actualScene == "titleMenu" and b.x + UiManager.buttons[i].imgOX >= UiManager.mouseX and b.x - UiManager.buttons[i].imgOX <= UiManager.mouseX 
           and b.y + UiManager.buttons[i].imgOY >= UiManager.mouseY and b.y - UiManager.buttons[i].imgOY <= UiManager.mouseY then
            b.isActive = true
            UiManager.buttonSelected = i
            UiManager.buttons[i].imgScaleW = 2
            UiManager.buttons[i].imgScaleH = 2
        else
            b.isActive = false
            UiManager.buttons[i].imgScaleW = 1
            UiManager.buttons[i].imgScaleH = 1
        end
    end
end

function UiManager.mousepressed(x, y, button, istouch)
    if button == 1 then
        for i = #UiManager.buttonsInScene,1,-1 do
            local b = UiManager.buttonsInScene[i]
            if b.isActive == true then
                UiManager.buttonAction()
            end
        end
    end
end

function UiManager.buttonAction()
    if UiManager.buttonSelected == 1 then
        UiManager.actualScene = "gameplay"
        print(UiManager.actualScene)
    end
    if UiManager.buttonSelected == 2 then
        UiManager.actualScene = "config"
        print(UiManager.actualScene)
    end
end

function UiManager.load()
    UiManager.createButton("play", "playbtn")
    UiManager.createButton("option", "optionbtn")
    UiManager.createButton("exit", "exitbtn")
end

function UiManager.update(dt)
    UiManager.mouseX = love.mouse.getX()
    UiManager.mouseY = love.mouse.getY()
    UiManager.mouseOnButton()
end

function UiManager.draw()

end

function UiManager.keypressed(key)
    if key == "space" then
        --SceneManager.changeScene("titleMenu")
        UiManager.actualScene = "titleMenu"
    end
end

return UiManager