local Player = {}

local MathManager = require("mathManager")
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
Player.runSpeed = 500
Player.rotSpeed = 3
Player.img = love.graphics.newImage("img/spaceshipv1.png")
Player.radius = Player.img:getWidth()/2
-- stats
Player.HP = 0
Player.maxHP = 100
Player.damage = 9
Player.projectileSpeed = 1000
Player.projectileImage = love.graphics.newImage("img/ballp.png")
Player.money = 0
Player.kill = 0
Player.isDead = false
Player.luck = 5 --higher mean less chance to drop item

function Input(dt)
  if Player.HP > 0 then
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
    if MathManager.checkCircularCollision(Player.x, Player.y, b.x, b.y, Player.radius, b.radius) and b.team == "ennemy" then
        --print("take dmg !")
        SoundManager.sounds.hurtSound:stop()
        SoundManager.sounds.hurtSound:play()
        Player.HP = Player.HP - b.damage
        table.remove(Shoot.projectiles, i)
    end
  end     
end

function Player.manager()
  if Player.HP <= 0 and Player.isDead == false then
    --SoundManager.sounds.looseSound:stop()
    SoundManager.sounds.looseSound:play()
    Player.isDead = true
  end
end

function Player.load()
  Player.HP = Player.maxHP
  Player.isDead = false
  Player.x = UiManager.screenCenterX
  Player.y = UiManager.screenCenterY
end

function Player.update(dt)
  Input(dt)
  Player.collision()
  Power.playerKill = Player.kill
  Power.update(dt)
  Shoot.playerSpeed = Player.actualSpeed
  Shoot.playerRotation = Player.rotation
  Player.manager()
end

function Player.draw()
  love.graphics.draw(Player.img, Player.x, Player.y, Player.rotation, 1, 1,Player.img:getWidth()/2, Player.img:getHeight()/2)
  love.graphics.print("HP: "..Player.HP.." / "..Player.maxHP)
  love.graphics.print("Kill: "..Player.kill.."Money: "..Player.money.." $",x,15)
  Power.draw()
  --debug
  if DebugManager.debug == true then
    love.graphics.circle("line", Player.x, Player.y, Player.radius)
  end
end

function Player.keypressed(key)
  if key == "space" then
    if Player.HP > 0 then
      Shoot.shooting(Player.x, Player.y, Player.rotation, Player.projectileImage, Player.projectileSpeed, Player.damage, "player")
      SoundManager.sounds.laserSound:stop()
      SoundManager.sounds.laserSound:play()
    end
  end
  if key == "return" and Power.jaugeCount >= 7 then
    Player.kill = 0
    Power.jaugeCount = 0
  end
end

return Player