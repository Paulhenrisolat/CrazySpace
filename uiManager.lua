local UiManager = {}

UiManager.buttons = {}
UiManager.buttonsInScene = {}
UiManager.btnHeight = 1
UiManager.btnWidth = 1

UiManager.screenW = love.graphics:getWidth()
UiManager.screenH = love.graphics:getHeight()

UiManager.mouseX = love.mouse.getX()
UiManager.mouseY = love.mouse.getY()
UiManager.mouseIsOnBTN = false

function UiManager.createButton(text, img)
    local newButton = {}
    newButton.text = text
    newButton.img = love.graphics.newImage("img/"..img..".png")
    newButton.imgW = newButton.img:getWidth()
    newButton.imgH = newButton.img:getHeight()
    newButton.imgOX = newButton.imgW/2
    newButton.imgOY = newButton.imgH/2
    table.insert(UiManager.buttons, newButton)
end

function UiManager.addButton(btn, x, y)
    love.graphics.draw(UiManager.buttons[btn].img, x, y, 0,1,1, UiManager.buttons[btn].imgOX,UiManager.buttons[btn].imgOY)
end

function UiManager.mouseOnButton()
    for i = #UiManager.buttonsInScene,1,-1 do
        local b = UiManager.buttonsInScene[i]
        --print("BTN["..i.."] pos X: "..b.x.." Y: "..b.y)
        if UiManager.mouseX >= b.x and UiManager.mouseY >= b.x then
            UiManager.mouseIsOnBTN = true
        else
            UiManager.mouseIsOnBTN = false
        end
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

end

return UiManager