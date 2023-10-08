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

Power.jaugeImgW = Power.jauge:getWidth()
Power.jaugeImgH = Power.jauge:getHeight()

Power.jaugeX = UiManager.screenW - 50
Power.jaugeY = UiManager.screenH - 50

Power.playerKill = 0
Power.jaugeCount = 0

function Power.load()
end

function Power.update()
end

function Power.draw()
    love.graphics.draw(Power.jauge,Power.jaugeX - Power.jaugeImgW,Power.jaugeY - Power.jaugeImgH)
end

return Power