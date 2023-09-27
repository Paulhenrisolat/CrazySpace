local Gameplay = {}

local UiManager = require("uiManager")
local Player = require("player")
local Ennemy = require("ennemy")

Gameplay.bg = love.graphics.newImage("img/spaceia.jpg")
Gameplay.bgX = 0
Gameplay.bgY = 0
Gameplay.bgOX = Gameplay.bg:getWidth()/2
Gameplay.bgOY = Gameplay.bg:getHeight()/2

function Gameplay.Scrolling(dt)
    if love.keyboard.isDown("up","z") then    
        local vx = Player.actualSpeed * math.cos(Player.rotation) * dt
        local vy = Player.actualSpeed * math.sin(Player.rotation) * dt
        Gameplay.bgX = Gameplay.bgX - vx
        Gameplay.bgY = Gameplay.bgY - vy
    end
    if love.keyboard.isDown("down","s") then    
        local vx = Player.actualSpeed * math.cos(Player.rotation) * dt
        local vy = Player.actualSpeed * math.sin(Player.rotation) * dt
        Gameplay.bgX = Gameplay.bgX + vx
        Gameplay.bgY = Gameplay.bgY + vy
    end
end

function Gameplay.load()
    Player.load()
    Ennemy.load()
end

function Gameplay.update(dt)
    Player.update(dt)
    Ennemy.update(dt)
    Gameplay.Scrolling(dt)
end

function Gameplay.draw()
    love.graphics.draw(Gameplay.bg,Gameplay.bgX,Gameplay.bgY,0,5,5, Gameplay.bgOX, Gameplay.bgOY)
    Player.draw()
    Ennemy.draw()
    --debug
    --love.graphics.print()
end

return Gameplay