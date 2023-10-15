-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")
love.graphics.setDefaultFilter("nearest")

local SceneManager = require("sceneManager")

function love.load()
    love.window.setTitle("CrazySpace !")
    --love.window.setMode(1000, 800, {resizable=true})
    SceneManager.load()
end

function love.update(dt)
    SceneManager.update(dt)
end

function love.draw()
    SceneManager.draw()
end

function love.keypressed(key)
    SceneManager.keypressed(key)
end

function love.mousepressed(x, y, button, istouch)
    SceneManager.mousepressed(x, y, button, istouch)
end