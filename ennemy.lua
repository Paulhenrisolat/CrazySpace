local Ennemy = {}

local MathManager = require("mathManager")
local UiManager = require("uiManager")
local Player = require("player")
local Shoot = require("shoot")
local SoundManager = require("soundManager")
local DebugManager = require("debugManager")
local HealingDrone = require("healingDrone")
local Explosion = require("explosion")
local Drop = require("drop")
local Power = require("power")

Ennemy.mapWidth = 2000
Ennemy.mapHeight = 2000

Ennemy.startPartie = false

Ennemy.ennemyList = {}
Ennemy.ennemyInScene = {}

Ennemy.ennemyState = {}
Ennemy.ennemyState.chase = "chase"
Ennemy.ennemyState.shoot = "shoot"
Ennemy.ennemyState.escape = "escape"
Ennemy.ennemyState.regen = "regen"
Ennemy.ennemyState.noState = "noState"

Ennemy.healAmount = 2
Ennemy.healCooldown = 1

function Ennemy.scrolling(dt)
    for i=#Ennemy.ennemyInScene,1,-1 do
        local e = Ennemy.ennemyInScene[i]
        if love.keyboard.isDown("up","z") and Player.HP > 0 then    
            local vx = Player.actualSpeed * math.cos(Player.rotation) * dt
            local vy = Player.actualSpeed * math.sin(Player.rotation) * dt
            e.x = e.x - vx
            e.y = e.y - vy
        end
        if love.keyboard.isDown("down","s") and Player.HP > 0 then    
            local vx = Player.actualSpeed * math.cos(Player.rotation) * dt
            local vy = Player.actualSpeed * math.sin(Player.rotation) * dt
            e.x = e.x + vx
            e.y = e.y + vy
        end
    end
end

--Create ennemy
function Ennemy.addEnnemy(name, img, ballimg, life, speed, runSpeed, damage, reloadTime)
    local newEnnemy = {}
    newEnnemy.name = tostring(name)
    newEnnemy.img = love.graphics.newImage(img)
    newEnnemy.projectileImage = love.graphics.newImage(ballimg)
    newEnnemy.ox = newEnnemy.img:getWidth()/2
    newEnnemy.oy = newEnnemy.img:getHeight()/2
    newEnnemy.life = life
    newEnnemy.speed = speed
    newEnnemy.runSpeed = runSpeed
    newEnnemy.damage = damage
    newEnnemy.projectileSpeed = 1000
    newEnnemy.reloadTime = reloadTime
    table.insert(Ennemy.ennemyList, newEnnemy)
end

--Add ennemy to scene
function Ennemy.spawning(ennemySelected, nbEnnemy)
    for i=#Ennemy.ennemyList,1,-1 do 
        if #Ennemy.ennemyInScene < nbEnnemy and Ennemy.startPartie == true then
            --get choosen ennemy in list to spawn
            local e = Ennemy.ennemyList[i]
            if e.name == tostring(ennemySelected) then
                local newEnnemyInScene = {}
                newEnnemyInScene.type = e
                newEnnemyInScene.x = love.math.random(Ennemy.mapWidth)
                newEnnemyInScene.y = love.math.random(Ennemy.mapHeight)
                newEnnemyInScene.rotation = 0
                newEnnemyInScene.radius = e.img:getWidth()/2
                newEnnemyInScene.maxHP = e.life
                newEnnemyInScene.HP = e.life
                newEnnemyInScene.state = Ennemy.ennemyState.chase
                newEnnemyInScene.reloadTime = e.reloadTime
                newEnnemyInScene.healAmount = Ennemy.healAmount
                newEnnemyInScene.healCooldown = Ennemy.healCooldown
                table.insert(Ennemy.ennemyInScene, newEnnemyInScene)
            end
        elseif #Ennemy.ennemyInScene >= nbEnnemy then
            Ennemy.startPartie = false
        end
    end
end

function Ennemy.manager(dt)
    for i=#Ennemy.ennemyInScene,1,-1 do 
        local e = Ennemy.ennemyInScene[i]
        if Player.isDead == false then
            if MathManager.dist(e.x,e.y,Player.x,Player.y) > 250 and e.HP > e.maxHP/2 then
                e.state = Ennemy.ennemyState.chase
            elseif e.HP <= e.maxHP/2 then
                e.state = Ennemy.ennemyState.escape
            end
            --STATE CHASE
            if e.state == "chase" then
                --rotate to player
                local rotationTowardPlayer = MathManager.angle(e.x, e.y, Player.x, Player.y)
                e.rotation = rotationTowardPlayer
                --follow player
                local vx = e.type.speed * math.cos(e.rotation) * dt
                local vy = e.type.speed * math.sin(e.rotation) * dt
                e.x = e.x + vx
                e.y = e.y + vy
                if MathManager.dist(e.x,e.y,Player.x,Player.y) < 250 then
                    e.state = Ennemy.ennemyState.shoot
                end
            end
            --STATE SHOOT
            if e.state == "shoot" then
                --rotate to player
                local rotationTowardPlayer = MathManager.angle(e.x, e.y, Player.x, Player.y)
                e.rotation = rotationTowardPlayer
                e.reloadTime = e.reloadTime - 5*dt
                if e.reloadTime <= 0 then
                    Shoot.shooting(e.x, e.y, e.rotation, e.type.projectileImage, e.type.projectileSpeed, e.type.damage, "ennemy")
                    SoundManager.sounds.laserESound:stop()
                    SoundManager.sounds.laserESound:play()
                    e.reloadTime = 1
                end
            end
            --STATE ESCAPE
            if e.state == "escape" then
                --rotate to healing drone
                for hi=#HealingDrone.healdronesInScene,1,-1 do
                    local h = HealingDrone.healdronesInScene[hi]
                    local rotationTowardHealingDrone = MathManager.angle(e.x, e.y, h.x, h.y)
                    e.rotation = rotationTowardHealingDrone
                    --go to healing drone
                    local vx = e.type.runSpeed * math.cos(e.rotation) * dt
                    local vy = e.type.runSpeed * math.sin(e.rotation) * dt
                    e.x = e.x + vx
                    e.y = e.y + vy
                    if MathManager.checkCircularCollision(e.x, e.y, h.x, h.y, e.radius, h.radius) then
                        e.state = Ennemy.ennemyState.regen
                    end
                end
            end
            --STATE REGEN
            if e.state == "regen" then
                Ennemy.heal(e, dt)
            end
        --NO STATE
        else
            e.state = Ennemy.ennemyState.noState
        end
    end
end

function Ennemy.collision()
    for i=#Ennemy.ennemyInScene,1,-1 do
        local e = Ennemy.ennemyInScene[i]
        if e.HP > 0 then
            for a=#Shoot.projectiles,1,-1 do
                local b = Shoot.projectiles[a]
                if MathManager.checkCircularCollision(e.x, e.y, b.x, b.y, e.radius, b.radius) and b.team == "player" then
                    --print("Hit !")
                    e.HP = e.HP - b.damage
                    table.remove(Shoot.projectiles, a)
                end
            end
        end
        if MathManager.checkCircularCollision(e.x, e.y, Power.x, Power.y, e.radius, Power.radius) and Power.isExecute == true then
            e.HP = e.HP - Power.damage
        end
    end
end

function Ennemy.heal(ennemy, dt)
    ennemy.healCooldown = ennemy.healCooldown - 1 * dt
    if ennemy.healCooldown <= 0 then
        ennemy.HP = ennemy.HP + ennemy.healAmount
        ennemy.healCooldown = Ennemy.healCooldown
    end
end

function Ennemy.death()
    for i=#Ennemy.ennemyInScene,1,-1 do
        local e = Ennemy.ennemyInScene[i]
        if e.HP <= 0 then
            SoundManager.sounds.explosionSound:stop()
            SoundManager.sounds.explosionSound:play()
            Explosion.addExplosionToScene(e.x,e.y)
            Drop.addDropToScene(e.x,e.y)
            Player.money = Player.money + 2
            Player.kill = Player.kill + 1
            table.remove(Ennemy.ennemyInScene, i)
        end
    end
end

function Ennemy.load()
    --clear the table 
    for i=#Ennemy.ennemyInScene,1,-1 do
        table.remove(Ennemy.ennemyInScene, i)
    end
    HealingDrone.load()
    Ennemy.startPartie = true
    --Create ennemy : name,img,ballimg,life,speed,runSpeed,dmg,reloadtime
    Ennemy.addEnnemy(weakling, "img/ennemyv2.png", "img/balle.png", 10, 160, 200, 2, 1)
end

function Ennemy.update(dt)
    HealingDrone.update(dt)
    --Add ennemy : name,number
    Ennemy.spawning(weakling, 25)
    Ennemy.scrolling(dt)
    Ennemy.manager(dt)
    Ennemy.collision()
    Ennemy.death()
end

function Ennemy.draw()
    HealingDrone.draw()
    for i=#Ennemy.ennemyInScene,1,-1 do
        local e = Ennemy.ennemyInScene[i]
        love.graphics.draw(e.type.img,e.x,e.y,e.rotation,1,1,e.type.ox,e.type.oy)
        love.graphics.print("id: "..i.." HP: "..e.HP.."/"..e.maxHP.." state:"..e.state,e.x,e.y-30)
    end
    --debug
    if DebugManager.debug == true then
        love.graphics.print("Spawning: "..tostring(Ennemy.partieStart).." EnnemySpawned: "..#Ennemy.ennemyInScene,x,30)
        love.graphics.print("HealingDrone: "..tostring(#HealingDrone.healdronesInScene),210,30)
        for i=#Ennemy.ennemyInScene,1,-1 do
            local e = Ennemy.ennemyInScene[i]
            love.graphics.print("ennemy["..i.."]".."x :"..math.floor(e.x).." y:"..math.floor(e.y),x,45 + i * 10)
            love.graphics.circle("line", e.x, e.y, e.radius)
        end
    end
end

return Ennemy