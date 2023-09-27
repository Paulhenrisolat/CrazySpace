local SceneManager = {}

local UiManager = require("uiManager")
local TitleMenu = require("titleMenu")
local PauseMenu = require("pauseMenu")
local Gameplay = require("gameplay")

SceneManager.actualScene = "noScene"

SceneManager.scenes = {}

function SceneManager.addScene(sceneName)
    local newScene = {}
    newScene.sceneName = sceneName
    newScene.scene = require(sceneName)
    newScene.isActive = false
    table.insert(SceneManager.scenes, newScene)
    print("Added scenes! ["..tostring(newScene.scene).."|"..newScene.sceneName.."|"..tostring(newScene.isActive).."]")
    print("Scene Number: "..#SceneManager.scenes)
end

function SceneManager.changeScene()
    for i = #SceneManager.scenes,1,-1 do
        local s = SceneManager.scenes[i]
        if s.sceneName == SceneManager.actualScene then
            s.isActive = true
        elseif s.sceneName ~= SceneManager.actualScene then
            s.isActive = false
        end
        --print("Scenes Status ["..tostring(s.scene).."|"..s.sceneName.."|"..tostring(s.isActive).."]")
    end
end

function SceneManager.loadScene()
    for i = #SceneManager.scenes,1,-1 do
        local s = SceneManager.scenes[i]
        if s.isActive == true then
            s.scene.draw()
        --else
            --love.graphics.print("SceneManager Debbug *Press SPACE*",x,y)
            --love.graphics.print("Scene loaded: "..#SceneManager.scenes.." Scene Active: "..SceneManager.actualScene,x,15)
        end
    end
end

function SceneManager.load()
    SceneManager.addScene("titleMenu")
    SceneManager.addScene("gameplay")
    
    UiManager.load()
    TitleMenu.load()
    Gameplay.load()
end

function SceneManager.update(dt)
    SceneManager.actualScene = UiManager.actualScene
    
    SceneManager.changeScene()
    UiManager.update(dt)

    for i = #SceneManager.scenes,1,-1 do
        local s = SceneManager.scenes[i]
        if s.isActive == true then
            s.scene.update(dt)
        end
    end
end

function SceneManager.draw()
    SceneManager.loadScene()
end

function SceneManager.keypressed(key)
    PauseMenu.keypressed(key)
    if key == "space" then
        --SceneManager.changeScene("titleMenu")
        SceneManager.actualScene = "titleMenu"
    end
end

function SceneManager.mousepressed(x, y, button, istouch)
    UiManager.mousepressed(x, y, button, istouch)
end

return SceneManager