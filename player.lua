local Player = {}

local UiManager = require("uiManager")
local Shoot = require("shoot")
local SoundManager = require("soundManager")
local DebugManager = require("debugManager")
local Power = require("power")

-- general info
Player.x = 0
Player.y = 0
Player.rotation = math.rad(-90)
Player.speed = 180
Player.actualSpeed = Player.speed
Player.runSpeed = 500--300
Player.rotSpeed = 3
Player.img = love.graphics.newImage("img/spaceshipv1.png")
Player.radius = Player.img:getWidth()/2
-- stats
Player.life = 0
Player.maxLife = 100
Player.damage = 7
Player.projectileSpeed = 1000
Player.projectileImage = love.graphics.newImage("img/ballp.png")
Player.money = 0
Player.kill = 0

-- If the distance of one object to the other is less than the sum of their radius(s) return true
function math.checkCircularCollision(ax, ay, bx, by, ar, br)
	local dx = bx - ax
	local dy = by - ay
	local dist = math.sqrt(dx * dx + dy * dy)
	return dist < ar + br
end

function Input(dt)
  if Player.life > 0 then
    if love.keyboard.isDown("up","z") then    
      local vx = Player.speed * math.cos(Player.rotation) * dt
      local vy = Player.speed * math.sin(Player.rotation) * dt
      --Player.x = Player.x + vx
      --Player.y = Player.y + vy
    end
    if love.keyboard.isDown("down","s") then    
      local vx = Player.speed * math.cos(Player.rotation) * dt
      local vy = Player.speed * math.sin(Player.rotation) * dt
      --Player.x = Player.x - vx
      --Player.y = Player.y - vy
    end
    if love.keyboard.isDown("right","d") then
      Player.rotation = Player.rotation + Player.rotSpeed * dt
    end
    if love.keyboard.isDown("left","q") then
      Player.rotation = Player.rotation - Player.rotSpeed * dt
    end
    if love.keyboard.isDown("rshift","lshift") then
      Player.actualSpeed = Player.runSpeed
    else
      Player.actualSpeed = Player.speed
    end
  end
end

function Player.collision()
  for i=#Shoot.projectiles,1,-1 do
    local b = Shoot.projectiles[i]
    if math.checkCircularCollision(Player.x, Player.y, b.x, b.y, Player.radius, b.radius) and b.team == "ennemy" then
        --print("take dmg !")
        Player.life = Player.life - b.damage
        table.remove(Shoot.projectiles, i)
    end
  end     
end

function Player.load()
  Player.life = Player.maxLife
  Player.x = UiManager.screenCenterX
  Player.y = UiManager.screenCenterY
end

function Player.update(dt)
  Input(dt)
  Player.collision()
  Power.playerKill = Player.kill
  Shoot.playerSpeed = Player.actualSpeed
  Shoot.playerRotation = Player.rotation
end

function Player.draw()
  love.graphics.draw(Player.img, Player.x, Player.y, Player.rotation, 1, 1,Player.img:getWidth()/2, Player.img:getHeight()/2)
  love.graphics.print("HP: "..Player.life.." / "..Player.maxLife)
  love.graphics.print("Money: "..Player.money.." $",x,15)
  Power.draw()
  --debug
  if DebugManager.debug == true then
    love.graphics.circle("line", Player.x, Player.y, Player.radius)
  end
end

function Player.keypressed(key)
  if Player.life > 0 then
    if key == "space" then
      Shoot.shooting(Player.x, Player.y, Player.rotation, Player.projectileImage, Player.projectileSpeed, Player.damage, "player")
      SoundManager.sounds.laserSound:stop()
      SoundManager.sounds.laserSound:play()
    end
  end
end

return Player