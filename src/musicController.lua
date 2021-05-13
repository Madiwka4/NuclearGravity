sounds = {
    ["menu"] = love.audio.newSource("entities/music/menu.ogg", "static"),
    ["boom"] = love.audio.newSource("entities/planet/boom.wav", "static"),
    ["close"] = love.audio.newSource("entities/planet/close.wav", "static"),
    ["play"] = love.audio.newSource("entities/music/play.wav", "static"),
    ["appear"] = love.audio.newSource("entities/ship/Appear.wav", "static"),
    ["finish"] = love.audio.newSource("entities/ship/Finish.wav", "static")
}
mute = false
function musicController(orders, toggling)
    if (orders == 'norm' and not mute) then 
        if (gameState == 'menu' or gameState == "selectlv") then 
            sounds['menu']:play()
        elseif gameStatus == 'play' then 
            stopSounds()
            sounds["play"]:play()
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