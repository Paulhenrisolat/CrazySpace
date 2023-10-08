local SceneManager = {}

local UiManager = require("uiManager")
local TitleMenu = require("titleMenu")
local PauseMenu = require("pauseMenu")
local Gameplay = require("gameplay")
local Option = require("option")
local SoundManager = require("soundManager")
local DebugManager = require("debugManager")

SceneManager.actualScene = "noScene"

SceneManager.scenes = {}

function SceneManager.addScene(sceneName)
    local newScene = {}
    newScene.sceneName = sceneName
    newScene.scene = require(sceneName)
    newScene.isActive = false
    table.insert(SceneManager.scenes, newScene)
    --print("Added scenes! ["..tostring(newScene.scene).."|"..newScene.sceneName.."|"..tostring(newScene.isActive).."]")
    --print("Scene Number: "..#SceneManager.scenes)
end

function SceneManager.changeScene()
    for i = #SceneManager.scenes,1,-1 do
        local s = SceneManager.scenes[i]
        if s.sceneName == SceneManager.actualScene then
            s.isActive = true
        elseif s.sceneName ~= SceneManager.actualScene then
            s.isActive = false
        end
    end
end

function SceneManager.drawScene()
    for i = #SceneManager.scenes,1,-1 do
        local s = SceneManager.scenes[i]
        if s.isActive == true then
            s.scene.draw()
        end
    end
end

function SceneManager.load()
    SceneManager.addScene("titleMenu")
    SceneManager.addScene("gameplay")
    SceneManager.addScene("option")

    UiManager.load()
    TitleMenu.load()
    Gameplay.load()
    Option.load()
    SoundManager.load()
end

function SceneManager.update(dt)
    SceneManager.changeScene()
    SceneManager.actualScene = UiManager.actualScene
    SoundManager.actualScene = SceneManager.actualScene
    UiManager.update(dt)
    SoundManager.update(dt)
    for i = #SceneManager.scenes,1,-1 do
        local s = SceneManager.scenes[i]
        if s.isActive == true then
            s.scene.update(dt)
        end
    end
end

function SceneManager.draw()
    SceneManager.drawScene()
    --debug
    if DebugManager.debug == true then
        SoundManager.draw()
        DebugManager.draw()
    end
    love.graphics.print("Scene: "..SceneManager.actualScene, UiManager.screenW-150, UiManager.screenH-30)
end

function SceneManager.keypressed(key)
    for i = #SceneManager.scenes,1,-1 do
        local s = SceneManager.scenes[i]
        if s.isActive == true then
            s.scene.keypressed(key)
        end
    end
    --debug
    DebugManager.keypressed(key)
    --PauseMenu.keypressed(key)
    --Gameplay.keypressed(key)
    --UiManager.keypressed(key)
end

function SceneManager.mousepressed(x, y, button, istouch)
    UiManager.mousepressed(x, y, button, istouch)
end

return SceneManager