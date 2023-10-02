local Option = {}

local UiManager = require("uiManager")

function Option.load()
    UiManager.addButtton("titleMenu", UiManager.screenCenterX,UiManager.screenCenterY-30)
end

function Option.update(dt)

end


function Option.draw()
    love.graphics.print("Option",x,y)
    --Add created button
    for i = #UiManager.buttonsInScene,1,-1 do
        local b = UiManager.buttonsInScene[i]
        if b.name =="titleMenu" then
            love.graphics.draw(b.img, b.x, b.y, 0,b.scaleW,b.scaleH, b.imgOX,b.imgOY)
        end
    end
end

return Option