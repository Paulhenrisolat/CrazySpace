local HealingDrone = {}

local Player = require("player")
local DebugManager = require("debugManager")

HealingDrone.mapWidth = 0
HealingDrone.mapHeight = 0

HealingDrone.healdrones = {}
HealingDrone.healdronesInScene = {}

function HealingDrone.Scrolling(dt)
    for i=#HealingDrone.healdronesInScene,1,-1 do
        local h = HealingDrone.healdronesInScene[i]
        if love.keyboard.isDown("up","z") and Player.life > 0 then    
            local vx = Player.actualSpeed * math.cos(Player.rotation) * dt
            local vy = Player.actualSpeed * math.sin(Player.rotation) * dt
            h.x = h.x - vx
            h.y = h.y - vy
        end
        if love.keyboard.isDown("down","s") and Player.life > 0 then    
            local vx = Player.actualSpeed * math.cos(Player.rotation) * dt
            local vy = Player.actualSpeed * math.sin(Player.rotation) * dt
            h.x = h.x + vx
            h.y = h.y + vy
        end
    end
end

function HealingDrone.spawning(name, life, radius, healAmount)
    local newHealingdroneInScene = {}
    newHealingdroneInScene.name = name
    newHealingdroneInScene.hpRegen = healAmount
    newHealingdroneInScene.img = love.graphics.newImage("img/ennemy2.png")
    newHealingdroneInScene.radius = newHealingdroneInScene.img:getWidth()
    newHealingdroneInScene.imgOX = newHealingdroneInScene.img:getWidth()/2
    newHealingdroneInScene.imgOY = newHealingdroneInScene.img:getHeight()/2
    newHealingdroneInScene.x = love.math.random(800)--Gameplay.mapWidth)
    newHealingdroneInScene.y = love.math.random(800)--Gameplay.mapHeight)
    newHealingdroneInScene.radius = newHealingdroneInScene.img:getWidth()/2
    newHealingdroneInScene.maxHP = life
    newHealingdroneInScene.HP = newHealingdroneInScene.maxHP
    table.insert(HealingDrone.healdronesInScene, newHealingdroneInScene)
end

function HealingDrone.load()
    HealingDrone.spawning("HealingDrone",120, 100, 1)
end

function HealingDrone.update(dt)
    HealingDrone.Scrolling(dt)
end

function HealingDrone.draw()
    for i=#HealingDrone.healdronesInScene,1,-1 do
        local h = HealingDrone.healdronesInScene[i]
        love.graphics.draw(h.img,h.x,h.y,0,1,1,h.imgOX,h.imgOY)
        love.graphics.print("id: "..h.name.." HP: "..h.maxHP.."/"..h.HP,h.x,h.y-30)
        if DebugManager.debug == true then
            love.graphics.circle("line", h.x, h.y, h.radius)
        end
    end
end

return HealingDrone