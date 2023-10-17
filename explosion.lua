local Explosion = {}

local Player = require("player")

Explosion.img = love.graphics.newImage("img/explosion.png")
Explosion.img2 = love.graphics.newImage("img/explosion2.png")
Explosion.img3 = love.graphics.newImage("img/explosion3.png")
Explosion.imgs = {}
Explosion.imgOX = Explosion.img:getWidth()/2
Explosion.imgOY = Explosion.img:getHeight()/2
Explosion.lifeTime = 1--0.5

Explosion.explosionInScene = {}

function Explosion.scrolling(dt)
    for i=#Explosion.explosionInScene,1,-1 do
        local e = Explosion.explosionInScene[i]
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

function Explosion.addExplosionToScene(x, y)
    local newExplosion = {}
    newExplosion.x = x
    newExplosion.y = y
    newExplosion.imgFrame = 1
    newExplosion.lifeTime = Explosion.lifeTime
    table.insert(Explosion.explosionInScene, newExplosion)
end

function Explosion.manager(dt)
    for i=#Explosion.explosionInScene,1,-1 do
        local e = Explosion.explosionInScene[i]
        
        --Time before remove
        e.lifeTime = e.lifeTime - 1 * dt
        if e.lifeTime <= 0 then
            table.remove(Explosion.explosionInScene, i)
        end

        --Animation
        e.imgFrame = e.imgFrame + 5 * dt
        if e.imgFrame >= #Explosion.imgs + 1 then
            e.imgFrame = 1
        end
    end
end

function Explosion.load()
    Explosion.imgs[1] = Explosion.img
    Explosion.imgs[2] = Explosion.img2
    Explosion.imgs[3] = Explosion.img3
end

function Explosion.update(dt)
    Explosion.scrolling(dt)
    Explosion.manager(dt)
end

function Explosion.draw()
    for i=#Explosion.explosionInScene,1,-1 do
        local e = Explosion.explosionInScene[i]
        local perfectFrame = math.floor(e.imgFrame)
        love.graphics.draw(Explosion.imgs[perfectFrame],e.x,e.y,0,1,1,Explosion.imgOX,Explosion.imgOY)
    end
end

return Explosion