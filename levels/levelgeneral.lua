levelgeneral = Class{}
local levelLoaded = false
local M = {}
local thrusterMax = 0
local animationComplete = false
local frame = 0
asteroidImage = love.graphics.newImage("entities/planet/asteroid.png")

function levelgeneral.update(dt)
    if not pauseStatus then 
    if not levelLoaded then 
        level = require("levels/level" .. currentLevel)
        startTime = os.time(os.date("*t"))
        level.load()
        frame = 0
        animationComplete = false
        levelLoaded = true
    end 
    if reachedGoal then 
        if love.keyboard.isDown('return') then 
            animationComplete  = true 
        end
        if saveData.levelsBeaten < currentLevel then 
            saveData.levelsBeaten = currentLevel
        end
        --print("saveData.levelsBeaten is " .. saveData.levelsBeaten)
        if animationComplete then 
            reachedGoal = false
        love.filesystem.write("save", serialize(saveData))
        levelgeneral.goBack()
        end 
    end
    camera:update(dt)
    if lvlbase ~= nil then 
        lvlbase:update(dt)
        end 
    --print(camera.x .. " " .. camera.y)
    for i, explosion in ipairs(explosions) do 
        explosion:update(dt)
        
        if explosion.killed then 
            table.remove(explosions, i)
            if shipIsHit and explosion.type == 0 then 
            gameStatus = "setup"
            levelgeneral.reset()
            end
        end
    end
    if gameStatus == "play" then
        camera.x, camera.y = firstShip.x - firstShip.height*4, firstShip.y- firstShip.width
        --print(camera.x .. firstShip.x)
        if shipIsHit and not firstShip.exploded then 
                table.insert(explosions, explosion(firstShip.x, firstShip.y, 100, {1,1,1,1}, 0))
                firstShip.exploded = true 
            
        end 
    firstShip:update(dt)
    
    for i in ipairs(planets) do 
        planets[i]:update(dt)
    end
    if currentLevel > 5 then 
        level.bonusUpdate(dt)
    end
else 
    camera:follow(VCAM.x, VCAM.y)
end
    levelgeneral.GUIControl()
else 
    settingsMenuUpdate(dt)
end
end 

function levelgeneral.draw()
    love.graphics.setColor(1,1,1,1)
    camera:attach()

    
    if lvlbase ~= nil then 
        lvlbase:draw()
        end 
    for i in ipairs(planets) do 
        planets[i]:draw(dt)
    end
    --love.graphics.rectangle("fill",VCAM.x,VCAM.y,30,30)
    for i in ipairs(cannons) do 
        cannons[i]:draw(dt)
    end
    for i in ipairs(projectiles) do 
        projectiles[i]:draw(dt)
    end



    if reachedGoal then 
        if frame <= WINDOW_WIDTH*1.1 then 
            stopMusic()
            sounds["finish"]:play()
        love.graphics.setColor(1,1,1,1)
        love.graphics.circle("fill", firstShip.x, firstShip.y, frame)
        end
        if frame > WINDOW_WIDTH*1.1 then 
        love.graphics.clear(0,0,0,1)
        love.graphics.setColor(1, 1, 1, 1)
        if frame-WINDOW_WIDTH*1.1 < WINDOW_WIDTH then 
        love.graphics.circle("fill", firstShip.x, firstShip.y, WINDOW_WIDTH - (frame - WINDOW_WIDTH*1.1))
        end 
        end 
        frame = frame + 40
    end 
        firstShip:draw()
        for i, explosion in ipairs(explosions) do 
                explosion:render()
            --print("exploding")
        end
    camera:detach()
    
    camera:draw()
    if reachedGoal then 
        love.graphics.setColor(1,1,1,1-1/frame)
        love.graphics.setFont(smallfont)
        love.graphics.printf("Press Enter to continue",0, 600, WINDOW_WIDTH, "center")
    end
    if gameStatus == "setup" and not reachedGoal then 
    level.hint()
    elseif gameStatus == "play" and not pauseStatus then 
        if not reachedGoal then 
        love.graphics.printf("[W] Thrusters: ", 0, WINDOW_HEIGHT-100, 300, "center")
        local m = smallfont:getWidth("[W] Thrusters: ")
        local n = smallfont:getHeight("[W] Thrusters: ")
        love.graphics.setColor(1,0,0,1)
        love.graphics.rectangle("fill",0, WINDOW_HEIGHT-50, thrusterMax/2, n)
        love.graphics.setColor(0,1,0,1)
        love.graphics.rectangle("fill",0, WINDOW_HEIGHT-50, firstShip.fuel/2, n)
        love.graphics.setColor(1,1,1,1)
        guimenu:butt(playbutts, WINDOW_WIDTH, WINDOW_HEIGHT, 1100, WINDOW_HEIGHT-50, 40, WINDOW_WIDTH/3)
        end 
    end
    if pauseStatus then 
        drawPauseMenu()
        love.keyboard.mouseisReleased = false
    end
    
    
    
end 
function levelgeneral.goBack()
    levelgeneral.reset()
    lvlbase = nil
    gameStatus = "setup"
    cameraControl = false
    firstShip.path = {}
    cannons = {}
    levelLoaded = false
    for k in pairs(planets) do
        planets[k] = nil
    end
    gameState = "selectlv"
end 
function levelgeneral.reset()
    level.reset()
end 
function levelgeneral.GUIControl()
level.GUIControl()
end
return levelgeneral

