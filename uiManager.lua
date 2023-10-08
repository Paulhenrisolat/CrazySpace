local UiManager = {}

local SoundManager = require("soundManager")
UiManager.buttons = {}
UiManager.buttonsInScene = {}

UiManager.screenW = 1000
UiManager.screenH = 800
UiManager.screenCenterX = UiManager.screenW/2
UiManager.screenCenterY = UiManager.screenH/2

UiManager.mouseX = love.mouse.getX()
UiManager.mouseY = love.mouse.getY()

UiManager.buttonSelectedname = "noBtn"

UiManager.actualScene = "titleMenu"

function UiManager.createButton(name, img)
    local newButton = {}
    newButton.name = name
    newButton.img = love.graphics.newImage("img/"..img..".png")
    newButton.imgW = newButton.img:getWidth()
    newButton.imgH = newButton.img:getHeight()
    newButton.imgOX = newButton.imgW/2
    newButton.imgOY = newButton.imgH/2
    table.insert(UiManager.buttons, newButton)
end

function UiManager.addButtton(btnName, x,y)
    for i=#UiManager.buttons,1,-1 do 
        local b = UiManager.buttons[i]
        print(b.name.." "..tostring(btnName))
        if b.name == tostring(btnName) then
            local newButtonInScene = {}
            newButtonInScene.type = b
            newButtonInScene.name = b.name
            newButtonInScene.img = b.img
            newButtonInScene.imgOX = b.imgOX
            newButtonInScene.imgOY = b.imgOY
            newButtonInScene.x = x
            newButtonInScene.y = y
            newButtonInScene.scaleW = 1
            newButtonInScene.scaleH = 1
            newButtonInScene.mouseOn = false
            newButtonInScene.isActive = false
            table.insert(UiManager.buttonsInScene, newButtonInScene)
        end
    end
end

function UiManager.mouseOnButton(dt)
    for i = #UiManager.buttonsInScene,1,-1 do
        local b = UiManager.buttonsInScene[i]

        if UiManager.actualScene ~= "gameplay" and b.x + b.imgOX >= UiManager.mouseX and b.x - b.imgOX <= UiManager.mouseX 
           and b.y + b.imgOY >= UiManager.mouseY and b.y - b.imgOY <= UiManager.mouseY then
            b.mouseOn = true
            UiManager.buttonSelectedname = b.name
            b.scaleW = 2
            b.scaleH = 2
            UiManager.buttonsSound = true
        else
            b.mouseOn = false
            b.scaleW = 1
            b.scaleH = 1
        end

    end
end

function UiManager.mousepressed(x, y, button, istouch)
    if button == 1 then
        --SoundManager.sounds.buttonSound:play()
        UiManager.buttonAction()
    end
end

function UiManager.buttonAction()
    for i = #UiManager.buttonsInScene,1,-1 do
        local b = UiManager.buttonsInScene[i]
        if b.mouseOn == true then
            UiManager.actualScene = tostring(b.name)
            print("BTN pressed: "..UiManager.buttonSelectedname)
        end
    end
end

function UiManager.load()
    -- Screen config
    love.window.setMode(UiManager.screenW, UiManager.screenH, {resizable=false})
    UiManager.screenCenterX = UiManager.screenW/2
    UiManager.screenCenterY = UiManager.screenH/2

    -- Create all buton in the game (scene/btnName, imgName)
    UiManager.createButton("gameplay", "playbtn")
    UiManager.createButton("option", "optionbtn")
    UiManager.createButton("exit", "exitbtn")
    UiManager.createButton("titleMenu", "mainmenubtn")
end

function UiManager.update(dt)
    UiManager.mouseX = love.mouse.getX()
    UiManager.mouseY = love.mouse.getY()
    UiManager.mouseOnButton(dt)
end

function UiManager.draw()
    love.graphics.print("UI TEST",UiManager.screenCenterX,y)
end

function UiManager.keypressed(key)
    --debug
    if key == "space" then
        for i = #UiManager.buttonsInScene,1,-1 do
            local b = UiManager.buttonsInScene[i]
            --print(b.name.."/"..tostring(b.mouseOn))
        end
        --UiManager.actualScene = "gameplay"
    end
end

return UiManager