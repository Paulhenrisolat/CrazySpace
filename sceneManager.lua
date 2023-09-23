local SceneManager = {}

SceneManager.actualScene = nill

SceneManager.scenes = {}

function SceneManager.AddScene(sceneName)
    local newScene = {}
    newScene.sceneName = sceneName
    newScene.scene = require(sceneName)
    newScene.isActive = false
    table.insert(SceneManager.scenes, newScene)
    print("Added scenes! ["..tostring(newScene.scene).."|"..newScene.sceneName.."|"..tostring(newScene.isActive).."]")
    print("Scene Number: "..#SceneManager.scenes)
end

function SceneManager.LoadScene()
    for i = #SceneManager.scenes,1,-1 do
        local s = SceneManager.scenes[i]
        if s.isActive == true then
            s.scene.draw()
        else
            love.graphics.print("SceneManager Debbug",x,y)
            love.graphics.print("Scene loaded: "..#SceneManager.scenes,x,15)
        end
    end
end

function SceneManager.load()
    SceneManager.AddScene("titleMenu")
end

function SceneManager.update(dt)

end

function SceneManager.draw()
    SceneManager.LoadScene()
end

function SceneManager.keypressed(key)
    if key == "space" then
        for i = #SceneManager.scenes,1,-1 do
            local s = SceneManager.scenes[i]
            if s.sceneName == "titleMenu" and s.isActive == true then
                s.isActive = false
            elseif s.sceneName == "titleMenu" then
                s.isActive = true
            end
            print("Scenes Status ["..tostring(s.scene).."|"..s.sceneName.."|"..tostring(s.isActive).."]")
        end
    end
end

return SceneManager