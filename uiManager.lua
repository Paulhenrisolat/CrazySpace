local UiManager = {}

UiManager.buttons = {}
UiManager.btnHeight = 1
UiManager.btnWidth = 1

function createButton(text, action)
    local newButton = {
        text = text,
        action = action
    }
    table.insert(newButton, UiManager.buttons)
end

function playScene()
end

function mainMenuScene()
end

function UiManager.load()

end

function UiManager.update(dt)

end

function UiManager.draw()

end

function UiManager.keypressed(key)

end

return UiManager