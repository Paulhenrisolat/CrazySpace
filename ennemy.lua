local Ennemy = {}

local UiManager = require("uiManager")
local Player = require("player")

Ennemy.mapWidth = nill
Ennemy.mapHeight = nill
Ennemy.spawnX = 0
Ennemy.spawnY = 0
Ennemy.partieStart = true

Ennemy.ennemyList = {}
Ennemy.ennemyInScene = {}

Ennemy.ennemyToSpawn = 0
Ennemy.ennemySpawned = 0

-- Returns the distance between two points.
function math.dist(x1,y1, x2,y2) 
    return ((x2-x1)^2+(y2-y1)^2)^0.5 
end
  
-- Returns the angle between two vectors assuming the same origin.
function math.angle(x1,y1, x2,y2) 
    return math.atan2(y2-y1, x2-x1) 
end


function Ennemy.Scrolling(dt)
    for i=#Ennemy.ennemyInScene,1,-1 do
        local e = Ennemy.ennemyInScene[i]
        if love.keyboard.isDown("up","z") then    
            local vx = Player.actualSpeed * math.cos(Player.rotation) * dt
            local vy = Player.actualSpeed * math.sin(Player.rotation) * dt
            e.x = e.x - vx
            e.y = e.y - vy
        end
        if love.keyboard.isDown("down","s") then    
            local vx = Player.actualSpeed * math.cos(Player.rotation) * dt
            local vy = Player.actualSpeed * math.sin(Player.rotation) * dt
            e.x = e.x + vx
            e.y = e.y + vy
        end
    end
end

--Creer ennemi
function Ennemy.addEnnemy(name, img, life, speed, damage, reloadTime)
    local newEnnemy = {}
    newEnnemy.name = tostring(name)
    newEnnemy.x = 0
    newEnnemy.y = 0
    newEnnemy.img = love.graphics.newImage(img)
    newEnnemy.ox = newEnnemy.img:getWidth()/2
    newEnnemy.oy = newEnnemy.img:getHeight()/2
    newEnnemy.maxLife = life
    newEnnemy.life = newEnnemy.maxLife
    newEnnemy.speed = speed
    newEnnemy.damage = damage
    newEnnemy.reloadTime = reloadTime
    newEnnemy.randPosStart = true
    table.insert(Ennemy.ennemyList, newEnnemy)
end

function Ennemy.manager(dt)
    for i=#Ennemy.ennemyInScene,1,-1 do 
        local e = Ennemy.ennemyInScene[i]
        local rotationTowardPlayer = math.angle(e.x, e.y, Player.x, Player.y)
        e.rotation = rotationTowardPlayer
        --e.spez = e.footstep - dt
        local vx = e.speed * math.cos(e.rotation) * dt
        local vy = e.speed * math.sin(e.rotation) * dt
        e.x = e.x + vx
        e.y = e.y + vy
    end
end

function Ennemy.spawning(ennemySelected, nbEnnemy)
    if nbEnnemy == #Ennemy.ennemyInScene then
        Ennemy.partieStart = false
    elseif Ennemy.partieStart == true and #Ennemy.ennemyInScene < nbEnnemy  then
    --get choosen ennemy in list to spawn
        for i=#Ennemy.ennemyList,1,-1 do 
            local e = Ennemy.ennemyList[i]
            if e.name == tostring(ennemySelected) then
                table.insert(Ennemy.ennemyInScene, e)
            end
        end
    end
end

function Ennemy.randPostion()
    local newPos = true
    if Ennemy.partieStart == false and newPos == true then
        for i=#Ennemy.ennemyInScene,1,-1 do 
            local e = Ennemy.ennemyInScene[i]
            if e.randPosStart == true then
                e.x = love.math.random(Ennemy.mapWidth)
                e.y = love.math.random(Ennemy.mapHeight)
                e.randPosStart = false
                print("E["..i.."] x:"..e.x.." y:"..e.y)
                newPos = false
            end
        end
    end
end

function Ennemy.load()
    --add ennemy : name,img,life,speed,dmg,reloadtime
    Ennemy.addEnnemy(weakling, "img/ennemy.png", 10, 160, 2, 3)
end

function Ennemy.update(dt)
    Ennemy.spawning(weakling, 3)
    Ennemy.randPostion()
    Ennemy.Scrolling(dt)
    Ennemy.manager(dt)
    
end

function Ennemy.draw()
    for i=#Ennemy.ennemyInScene,1,-1 do
        local e = Ennemy.ennemyInScene[i]
        love.graphics.draw(e.img,e.x,e.y,e.rotation,1,1,e.ox,e.oy)
        love.graphics.print("id: "..i,e.x,e.y-30)
    end
    --debug
    love.graphics.print("Spawning: "..tostring(Ennemy.partieStart).." EnnemySpawned: "..#Ennemy.ennemyInScene,x,30)
    for i=#Ennemy.ennemyInScene,1,-1 do
        local e = Ennemy.ennemyInScene[i]
        love.graphics.print("ennemy["..i.."]".."x :"..math.floor(e.x).." y:"..math.floor(e.y),x,45 + i * 10)
    end
end

return Ennemy