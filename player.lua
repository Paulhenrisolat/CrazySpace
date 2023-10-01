local Player = {}

local UiManager = require("uiManager")
local Shoot = require("shoot")
-- general info
Player.x = 0
Player.y = 0
Player.rotation = math.rad(-90)
Player.speed = 180
Player.actualSpeed = Player.speed
Player.runSpeed = 500--300
Player.rotSpeed = 3
Player.img = love.graphics.newImage("img/spaceshipv1.png")
-- stats
Player.life = 10
Player.maxLife = 10
Player.damage = 5
Player.projectileSpeed = 1000
Player.projectileImage = love.graphics.newImage("img/ballp.png")

function Input(dt)
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

function Player.load()
  Player.x = UiManager.screenCenterX
  Player.y = UiManager.screenCenterY
end

function Player.update(dt)
  Input(dt)
  Shoot.playerSpeed = Player.actualSpeed
  Shoot.playerRotation = Player.rotation
end

function Player.draw()
  love.graphics.draw(Player.img, Player.x, Player.y, Player.rotation, 1, 1,Player.img:getWidth()/2, Player.img:getHeight()/2)
  love.graphics.print("HP: "..Player.life.." / "..Player.maxLife)
end

function Player.keypressed(key)
  if key == "space" then
    Shoot.shooting(Player.x, Player.y, Player.rotation, Player.projectileImage, Player.projectileSpeed, Player.damage, "player")
  end
end

return Player