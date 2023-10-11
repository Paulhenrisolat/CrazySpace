local Power = {}

local UiManager = require("uiManager")

Power.jauge = love.graphics.newImage("img/jauge.png")
Power.jauge1 = love.graphics.newImage("img/jauge1.png")
Power.jauge2 = love.graphics.newImage("img/jauge2.png")
Power.jauge3 = love.graphics.newImage("img/jauge3.png")
Power.jauge4 = love.graphics.newImage("img/jauge4.png")
Power.jauge5 = love.graphics.newImage("img/jauge5.png")
Power.jauge6 = love.graphics.newImage("img/jauge6.png")
Power.jauge7 = love.graphics.newImage("img/jauge7.png")

Power.img = nill
Power.jaugeImgW = Power.jauge:getWidth()
Power.jaugeImgH = Power.jauge:getHeight()

Power.jaugeX = UiManager.screenW - 50
Power.jaugeY = UiManager.screenH - 50

Power.playerKill = 0
Power.jaugeCount = 0

function Power.manager()
    if Power.jaugeCount < Power.playerKill then
        Power.jaugeCount = Power.jaugeCount + 1
    elseif Power.jaugeCount >= 7 then
        Power.canUse = true
        --Power.jaugeCount = 7
    end

    if Power.jaugeCount <= 0 then
        Power.img = Power.jauge
    end
    if Power.jaugeCount == 1 then
        Power.img = Power.jauge1
    end
    if Power.jaugeCount == 2 then
        Power.img = Power.jauge2
    end
    if Power.jaugeCount == 3 then
        Power.img = Power.jauge3
    end
    if Power.jaugeCount == 4 then
        Power.img = Power.jauge4
    end
    if Power.jaugeCount == 5 then
        Power.img = Power.jauge5
    end
    if Power.jaugeCount == 6 then
        Power.img = Power.jauge6
    end
    if Power.jaugeCount >= 7 then
        Power.img = Power.jauge7
    end
    
end

function Power.load()
end

function Power.update(dt)
    Power.manager()
end

function Power.draw()
    love.graphics.draw(Power.img,Power.jaugeX - Power.jaugeImgW,Power.jaugeY - Power.jaugeImgH)
end

return Power