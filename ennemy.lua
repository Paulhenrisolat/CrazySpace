local Ennemy = {}

local UiManager = require("uiManager")
local Player = require("player")
local Shoot = require("shoot")

Ennemy.mapWidth = nill
Ennemy.mapHeight = nill

Ennemy.ennemyList = {}
Ennemy.ennemyInScene = {}

-- Returns the distance between two points.
function math.dist(x1,y1, x2,y2) 
    return ((x2-x1)^2+(y2-y1)^2)^0.5 
end  

-- Returns the angle between two vectors assuming the same origin.
function math.angle(x1,y1, x2,y2) 
    return math.atan2(y2-y1, x2-x1) 
end

-- If the distance of one object to the other is less than the sum of their radius(s) return true
function math.checkCircularCollision(ax, ay, bx, by, ar, br)
	local dx = bx - ax
	local dy = by - ay
	local dist = math.sqrt(dx * dx + dy * dy)
	return dist < ar + br
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
function Ennemy.addEnnemy(name, img, ballimg, life, speed, damage, reloadTime)
    local newEnnemy = {}
    newEnnemy.name = tostring(name)
    newEnnemy.img = love.graphics.newImage(img)
    newEnnemy.projectileImage = love.graphics.newImage(ballimg)
    newEnnemy.ox = newEnnemy.img:getWidth()/2
    newEnnemy.oy = newEnnemy.img:getHeight()/2
    newEnnemy.life = life
    newEnnemy.speed = speed
    newEnnemy.damage = damage
    newEnnemy.projectileSpeed = 1000
    newEnnemy.reloadTime = reloadTime
    table.insert(Ennemy.ennemyList, newEnnemy)
end

function Ennemy.manager(dt)
    for i=#Ennemy.ennemyInScene,1,-1 do 
        local e = Ennemy.ennemyInScene[i]
        local rotationTowardPlayer = math.angle(e.x, e.y, Player.x, Player.y)
        e.rotation = rotationTowardPlayer
        local vx = e.type.speed * math.cos(e.rotation) * dt
        local vy = e.type.speed * math.sin(e.rotation) * dt
        e.x = e.x + vx
        e.y = e.y + vy
        if math.dist(e.x,e.y,Player.x,Player.y) < 250 then
            --local reload = e.reloadTime
            e.reloadTime = e.reloadTime - 5*dt
            if e.reloadTime <= 0 then
                Shoot.shooting(e.x, e.y, e.rotation, e.type.projectileImage, e.type.projectileSpeed, e.type.damage, "ennemy")
                e.reloadTime = 1
            end
        end 
    end
end

function Ennemy.spawning(ennemySelected, nbEnnemy)
    if #Ennemy.ennemyInScene < nbEnnemy  then
    --get choosen ennemy in list to spawn
        for i=#Ennemy.ennemyList,1,-1 do 
            local e = Ennemy.ennemyList[i]
            if e.name == tostring(ennemySelected) then
                local newEnnemyInScene = {}
                newEnnemyInScene.type = e
                newEnnemyInScene.x = love.math.random(Ennemy.mapWidth)
                newEnnemyInScene.y = love.math.random(Ennemy.mapHeight)
                newEnnemyInScene.radius = e.img:getWidth()/2
                newEnnemyInScene.maxHP = e.life
                newEnnemyInScene.HP = e.life
                newEnnemyInScene.reloadTime = e.reloadTime
                table.insert(Ennemy.ennemyInScene, newEnnemyInScene)
            end
        end
    end
end

function Ennemy.collision()
    for i=#Ennemy.ennemyInScene,1,-1 do
        local e = Ennemy.ennemyInScene[i]
        for a=#Shoot.projectiles,1,-1 do
            local b = Shoot.projectiles[a]
            if math.checkCircularCollision(e.x, e.y, b.x, b.y, e.radius, b.radius) and b.team == "player" then
                print("Hit !")
                e.HP = e.HP - b.damage
                table.remove(Shoot.projectiles, a)
            end
        end
    end
end

function Ennemy.death()
    for i=#Ennemy.ennemyInScene,1,-1 do
        local e = Ennemy.ennemyInScene[i]
        if e.HP <= 0 then
            table.remove(Ennemy.ennemyInScene, i)
        end
    end
end

function Ennemy.load()
    --Create ennemy : name,img,ballimg,life,speed,dmg,reloadtime
    Ennemy.addEnnemy(weakling, "img/ennemy.png", "img/balle.png", 10, 160, 2, 5)
end

function Ennemy.update(dt)
    Ennemy.spawning(weakling, 50)
    Ennemy.Scrolling(dt)
    Ennemy.manager(dt)
    Ennemy.collision()
    Ennemy.death()
end

function Ennemy.draw()
    for i=#Ennemy.ennemyInScene,1,-1 do
        local e = Ennemy.ennemyInScene[i]
        love.graphics.draw(e.type.img,e.x,e.y,e.rotation,1,1,e.type.ox,e.type.oy)
        love.graphics.print("id: "..i.." HP: "..e.maxHP.."/"..e.HP,e.x,e.y-30)
    end
    --debug
    love.graphics.print("Spawning: "..tostring(Ennemy.partieStart).." EnnemySpawned: "..#Ennemy.ennemyInScene,x,30)
    for i=#Ennemy.ennemyInScene,1,-1 do
        local e = Ennemy.ennemyInScene[i]
        love.graphics.print("ennemy["..i.."]".."x :"..math.floor(e.x).." y:"..math.floor(e.y),x,45 + i * 10)
        love.graphics.circle("line", e.x, e.y, e.radius)
    end
end

return Ennemy