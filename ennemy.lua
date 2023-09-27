local Ennemy = {}

local UiManager = require("uiManager")
local Player = require("player")

Ennemy.x = 0
Ennemy.y = 0
Ennemy.rotation = math.rad(-90)
Ennemy.rotationTarget = 0
Ennemy.speed = 50
Ennemy.img = love.graphics.newImage("img/ennemy.png")
Ennemy.ox = Ennemy.img:getWidth()/2
Ennemy.oy = Ennemy.img:getHeight()/2
Ennemy.detectionArea = 150
Ennemy.state = nill
Ennemy.footstep = 0
Ennemy.reloadTime = 0.5
Ennemy.life = 10

function Ennemy.Scrolling(dt)
    if love.keyboard.isDown("up","z") then    
        local vx = Player.actualSpeed * math.cos(Player.rotation) * dt
        local vy = Player.actualSpeed * math.sin(Player.rotation) * dt
        Ennemy.x = Ennemy.x - vx
        Ennemy.y = Ennemy.y - vy
    end
    if love.keyboard.isDown("down","s") then    
        local vx = Player.actualSpeed * math.cos(Player.rotation) * dt
        local vy = Player.actualSpeed * math.sin(Player.rotation) * dt
        Ennemy.x = Ennemy.x + vx
        Ennemy.y = Ennemy.y + vy
    end
end

function Ennemy.load()
    Ennemy.x = UiManager.screenW - 10
    Ennemy.y = UiManager.screenH - 10
end

function Ennemy.update(dt)
    Ennemy.Scrolling(dt)
    Ennemy.x = Ennemy.x + 5 * dt
end

function Ennemy.draw()
    love.graphics.draw(Ennemy.img, Ennemy.x, Ennemy.y,0,1,1,Ennemy.ox,Ennemy.oy)
end

return Ennemy