local Player = {}

local UiManager = require("uiManager")

Player.x = 0
Player.y = 0
Player.rotation = math.rad(-90)
Player.speed = 180
Player.actualSpeed = 180
Player.runSpeed = 1000
Player.rotSpeed = 3
Player.img = love.graphics.newImage("img/spaceshipv1.png")
Player.life = 10
Player.maxLife = 10

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
    print(Player.x)
end

function Player.update(dt)
    Input(dt)
end

function Player.draw()
    love.graphics.draw(Player.img, Player.x, Player.y, Player.rotation, 1, 1,Player.img:getWidth()/2, Player.img:getHeight()/2)
    love.graphics.print("HP: "..Player.life.." / "..Player.maxLife)
end

function Player.keypressed(key)

end

return Player