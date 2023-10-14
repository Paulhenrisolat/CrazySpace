local Gameplay = {}

local Player = require("player")
local Ennemy = require("ennemy")
local Shoot = require("shoot")
local Explosion = require("explosion")
local Drop = require("drop")
local DeathManager = require("deathManager")
local WinManager = require("winManager")
local DebugManager = require("debugManager")

Gameplay.bg = love.graphics.newImage("img/spaceia.jpg")
Gameplay.mapWidth = Gameplay.bg:getWidth()
Gameplay.mapHeight = Gameplay.bg:getHeight()
Gameplay.bgOX = Gameplay.mapWidth/2
Gameplay.bgOY = Gameplay.mapHeight/2
Gameplay.bgX = 0
Gameplay.bgY = 0

function Gameplay.Scrolling(dt)
    if love.keyboard.isDown("up","z") and Player.HP > 0 then    
        local vx = Player.actualSpeed * math.cos(Player.rotation) * dt
        local vy = Player.actualSpeed * math.sin(Player.rotation) * dt
        Gameplay.bgX = Gameplay.bgX - vx
        Gameplay.bgY = Gameplay.bgY - vy
    end
    if love.keyboard.isDown("down","s") and Player.HP > 0 then    
        local vx = Player.actualSpeed * math.cos(Player.rotation) * dt
        local vy = Player.actualSpeed * math.sin(Player.rotation) * dt
        Gameplay.bgX = Gameplay.bgX + vx
        Gameplay.bgY = Gameplay.bgY + vy
    end
end

function Gameplay.load()
    --Ennemy.mapWidth = Gameplay.bg:getWidth()
    --Ennemy.mapHeight = Gameplay.bg:getHeight()
    Player.load()
    Ennemy.load()
    Explosion.load()
    WinManager.load()
end

function Gameplay.update(dt)
    Player.update(dt)
    Ennemy.update(dt)
    Shoot.update(dt)
    WinManager.update(dt)
    Explosion.update(dt)
    Drop.update(dt)
    Gameplay.Scrolling(dt)
end

function Gameplay.draw()
    love.graphics.draw(Gameplay.bg,Gameplay.bgX,Gameplay.bgY,0,5,5, Gameplay.bgOX, Gameplay.bgOY)
    Player.draw()
    Ennemy.draw()
    Shoot.draw()
    Explosion.draw()
    Drop.draw()
    DeathManager.draw()
    WinManager.draw()
    --debug
    if DebugManager.debug == true then
        love.graphics.print("Projectiles: "..#Shoot.projectiles,x,45)
    end
end

function Gameplay.keypressed(key)
    Player.keypressed(key)
    DeathManager.keypressed(key)
    WinManager.keypressed(key)
end

return Gameplay