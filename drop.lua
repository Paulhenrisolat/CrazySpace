local Drop = {}

local Player = require("player")
local DebugManager = require("debugManager")

Drop.healImg = love.graphics.newImage("img/healdrop.png")
Drop.healImgOX = Drop.healImg:getWidth()/2
Drop.healImgOY = Drop.healImg:getHeight()/2
Drop.healRadius = Drop.healImg:getWidth()/2
Drop.healAmount = 10

Drop.dropInScene = {}
Drop.lifeTime = 5
Drop.canDrop = false

-- If the distance of one object to the other is less than the sum of their radius(s) return true
function math.checkCircularCollision(ax, ay, bx, by, ar, br)
	local dx = bx - ax
	local dy = by - ay
	local dist = math.sqrt(dx * dx + dy * dy)
	return dist < ar + br
end

function Drop.Scrolling(dt)
    for i=#Drop.dropInScene,1,-1 do
        local d = Drop.dropInScene[i]
        if love.keyboard.isDown("up","z") and Player.HP > 0 then    
            local vx = Player.actualSpeed * math.cos(Player.rotation) * dt
            local vy = Player.actualSpeed * math.sin(Player.rotation) * dt
            d.x = d.x - vx
            d.y = d.y - vy
        end
        if love.keyboard.isDown("down","s") and Player.HP > 0 then    
            local vx = Player.actualSpeed * math.cos(Player.rotation) * dt
            local vy = Player.actualSpeed * math.sin(Player.rotation) * dt
            d.x = d.x + vx
            d.y = d.y + vy
        end
    end
end

function Drop.chance()
    local randChance = love.math.random(1, 2)
    print("luck: "..randChance)
    if randChance == 1 then
        Drop.canDrop = false
    end
    if randChance == 2 then
        Drop.canDrop = true
    end
end

function Drop.addDropToScene(x, y)
    Drop.chance()
    if Drop.canDrop == true then
        local newDrop = {}
        newDrop.x = x
        newDrop.y = y
        newDrop.radius = Drop.healRadius
        newDrop.lifeTime = Drop.lifeTime
        table.insert(Drop.dropInScene, newDrop)
        Drop.canDrop = false
    end
end

function Drop.manager(dt)
    for i=#Drop.dropInScene,1,-1 do
        local d = Drop.dropInScene[i]
        d.lifeTime = d.lifeTime - 1 * dt
        if d.lifeTime <= 0 then
            table.remove(Drop.dropInScene, i)
        end
        if math.checkCircularCollision(d.x, d.y, Player.x, Player.y, d.radius, Player.radius) then
            Player.HP = Player.HP + Drop.healAmount
            table.remove(Drop.dropInScene, i)
        end
    end
end

function Drop.load()
end

function Drop.update(dt)
    Drop.Scrolling(dt)
    Drop.manager(dt)
end

function Drop.draw()
    for i=#Drop.dropInScene,1,-1 do
        local d = Drop.dropInScene[i]
        love.graphics.draw(Drop.healImg,d.x,d.y,0,1,1,Drop.healImgOX,Drop.healImgOY)
    end
    --debug
    if DebugManager.debug == true then
        for i=#Drop.dropInScene,1,-1 do
            local d = Drop.dropInScene[i]
            love.graphics.circle("line", d.x, d.y, d.healRadius)
        end
    end
end

return Drop