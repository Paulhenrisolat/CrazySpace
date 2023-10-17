local Shoot = {}

Shoot.playerSpeed = 0
Shoot.playerRotation = 0
Shoot.projectileLifeTime = 1

Shoot.projectiles = {}

-- ball : x,y,rotation,image,speed,damage,timeBeforeRemove
function Shoot.shooting(px, py, prot, pimg, pspeed, pdmg, team)
    local newProjectile = {}
    newProjectile.x = px 
    newProjectile.y = py
    newProjectile.rotation = prot
    newProjectile.image = pimg
    newProjectile.radius = newProjectile.image:getWidth()
    newProjectile.speed = pspeed
    newProjectile.damage = pdmg
    newProjectile.lifeTime = Shoot.projectileLifeTime
    newProjectile.team = team
    table.insert(Shoot.projectiles, newProjectile)
end

function Shoot.scrolling(dt)
    if love.keyboard.isDown("up","z") then    
        local vx = Shoot.playerSpeed * math.cos(Shoot.playerRotation) * dt
        local vy = Shoot.playerSpeed * math.sin(Shoot.playerRotation) * dt
        for i=#Shoot.projectiles,1,-1 do
            local b = Shoot.projectiles[i]
            b.x = b.x - vx
            b.y = b.y - vy
        end
    end
    if love.keyboard.isDown("down","s") then    
        local vx = Shoot.playerSpeed * math.cos(Shoot.playerRotation) * dt
        local vy = Shoot.playerSpeed * math.sin(Shoot.playerRotation) * dt
        for i=#Shoot.projectiles,1,-1 do
            local b = Shoot.projectiles[i]
            b.x = b.x + vx
            b.y = b.y + vy
        end
    end
end

function Shoot.projectileMovement(dt)
    for i=#Shoot.projectiles,1,-1 do 
        local b = Shoot.projectiles[i]
        b.x = b.x + dt * b.speed * math.cos(b.rotation)
        b.y = b.y + dt * b.speed * math.sin(b.rotation)
        b.lifeTime = b.lifeTime - 1 * dt
        if b.lifeTime <= 0 then
            table.remove(Shoot.projectiles, i)
        end
    end
end

function Shoot.update(dt)
    Shoot.projectileMovement(dt)
    Shoot.scrolling(dt)
end

function Shoot.draw()
    for i=#Shoot.projectiles,1,-1 do
        local b = Shoot.projectiles[i]
        love.graphics.draw(b.image, b.x, b.y, b.rotation, 1, 1,b.image:getWidth()/2, b.image:getHeight()/2)
        --debug
        --love.graphics.circle("line", b.x, b.y, b.radius)
    end
end

return Shoot