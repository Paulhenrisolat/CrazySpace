local SoundManager = {}

SoundManager.sounds = {}
SoundManager.sounds.gameplayMusic = love.audio.newSource("sound/melodictechno.mp3", "stream")
SoundManager.sounds.titleMusic = love.audio.newSource("sound/electrosport.mp3", "stream")
SoundManager.sounds.buttonSound = love.audio.newSource("sound/click.mp3", "static")
SoundManager.sounds.laserSound = love.audio.newSource("sound/plasmacannon.mp3", "static")
SoundManager.sounds.laserESound = love.audio.newSource("sound/lasergun.mp3", "static")

SoundManager.actualScene = "nill"

--Change music for each scene
function SoundManager.musicManager()
    if SoundManager.actualScene == "titleMenu" then
        SoundManager.sounds.gameplayMusic:stop()
        --SoundManager.sounds.titleMusic:play()
    elseif SoundManager.actualScene == "gameplay" then
        SoundManager.sounds.titleMusic:stop()
        SoundManager.sounds.gameplayMusic:play()
    end
end

function SoundManager.load()

end

function SoundManager.update(dt)
    SoundManager.musicManager()
end

function SoundManager.draw()
    --Debug
    love.graphics.print("MusicScene: "..SoundManager.actualScene,x,700)
end

return SoundManager