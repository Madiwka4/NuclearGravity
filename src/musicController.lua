sounds = {
    ["boom"] = love.audio.newSource("entities/planet/boom.wav", "static"),
    ["close"] = love.audio.newSource("entities/planet/close.ogg", "static"),
    ["appear"] = love.audio.newSource("entities/ship/Appear.ogg", "static"),
    ["finish"] = love.audio.newSource("entities/ship/Finish.ogg", "static"),
    ["planet"] = love.audio.newSource("entities/planet/teleport.ogg", "static"),
    ["launch"] = love.audio.newSource("entities/enemy/rlaunch.ogg", "static")
}
music = {
    ["menu"] = love.audio.newSource("entities/music/menu.ogg", "static"),
    ["play"] = love.audio.newSource("entities/music/play.mp3", "static")
}
mute = false
function musicController(orders, toggling)
    if (orders == 'norm' and not mute and not reachedGoal) then 
        if (gameState == 'menu' or gameState == "selectlv") then 
            music['menu']:play()
            music["play"]:play()
            music["play"]:setVolume(0)
            music["menu"]:setVolume(1)
        elseif gameStatus == 'play' then 
            music["play"]:play()
            music["play"]:setVolume(0.8)
            music["menu"]:setVolume(0.2)
        elseif gameStatus == 'setup' then 
            music['menu']:play()
            music["play"]:play()
            music["play"]:setVolume(0.6)
            music["menu"]:setVolume(1)
        end
    elseif orders == "mute" then 
        if toggling == 1 then 
            mute = true 
        else 
            mute = false
        end
    elseif orders == "click" then 
       -- print("entities/camera/button0" .. math.random(1, 5)..".mp3.flac")
        local tempClick = love.audio.newSource("entities/camera/button0" .. math.random(1, 5)..".mp3.flac", "static")
        tempClick:play()
    end
end
function stopSounds()
    for i, sound in ipairs(sounds) do 
        sound[i]:stop()
        print("stopping sounds")
    end
end 
function stopMusic()
    music["play"]:setVolume(0)
    music["menu"]:setVolume(0)
end 