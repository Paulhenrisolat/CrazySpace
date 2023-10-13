local SoundManager = {}

SoundManager.sounds = {}
SoundManager.sounds.gameplayMusic = love.audio.newSource("sound/melodictechno.mp3", "stream")
SoundManager.sounds.titleMusic = love.audio.newSource("sound/electrosport.mp3", "stream")
SoundManager.sounds.buttonSound = love.audio.newSource("sound/click.mp3", "static")
SoundManager.sounds.laserSound = love.audio.newSource("sound/plasmacannon.mp3", "static")
SoundManager.sounds.laserESound = love.audio.newSource("sound/lasergun.mp3", "static")
SoundManager.sounds.explosionSound = love.audio.newSource("sound/explode.wav", "static")
SoundManager.sounds.healSound = love.audio.newSource("sound/heal.wav", "static")
SoundManager.sounds.looseSound = love.audio.newSource("sound/loose.wav", "static")
SoundManager.sounds.hurtSound = love.audio.newSource("sound/hurt.wav", "static")

SoundManager.actualScene = "nill"

--Change music for each scene
function SoundManager.musicManager()
    if SoundManager.actualScene == "titleMenu" then
        SoundManager.sounds.titleMusic:stop()
        SoundManager.sounds.gameplayMusic:play()
    elseif SoundManager.actualScene == "gameplay" then
        SoundManager.sounds.gameplayMusic:stop()
        SoundManager.sounds.titleMusic:play()
    end
end

function SoundManager.getVolume(sound)
    local volume = sound:getVolume()
    return volume
end

function SoundManager.load()
    SoundManager.sounds.laserESound:setVolume(0.1)
    SoundManager.sounds.gameplayMusic:setVolume(0.1)
    SoundManager.sounds.titleMusic:setVolume(0.1)
end

function SoundManager.update(dt)
    SoundManager.musicManager()
end

function SoundManager.draw()
    --Debug
    love.graphics.print("MusicScene: "..SoundManager.actualScene,x,700)
end

function SoundManager.keypressed(key)
    if key == "kp+" and SoundManager.getVolume(SoundManager.sounds.gameplayMusic) < 1 then
        --print("Volume: "..SoundManager.getVolume(SoundManager.sounds.gameplayMusic))
        SoundManager.sounds.gameplayMusic:setVolume(SoundManager.getVolume(SoundManager.sounds.gameplayMusic)+0.2)
    end
    if key == "kp-" and SoundManager.getVolume(SoundManager.sounds.gameplayMusic) > 0 then
        --print("Volume: "..SoundManager.getVolume(SoundManager.sounds.gameplayMusic))
        SoundManager.sounds.gameplayMusic:setVolume(SoundManager.getVolume(SoundManager.sounds.gameplayMusic)-0.2)
    end
end

return SoundManager