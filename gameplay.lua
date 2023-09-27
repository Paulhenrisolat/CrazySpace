local Gameplay = {}

local UiManager = require("uiManager")
local Player = require("player")

Gameplay.bg = love.graphics.newImage("img/spaceia.jpg")

function Gameplay.load()
    Player.load()
end

function Gameplay.update(dt)
    Player.update(dt)
end

function Gameplay.draw()
    love.graphics.draw(Gameplay.bg,x,y)
    Player.draw()
end

return Gameplay