levelgeneral = Class{}
local levelLoaded = false
local M = {}
local thrusterMax = 0
local animationComplete = false
local frame = 0
function levelgeneral.update(dt)
    if not levelLoaded then 
        level = require("levels/level" .. currentLevel)
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
            gameStatus = "setup"
            levelgeneral.reset()
        end
    end
    if gameStatus == "play" then
        camera.x, camera.y = firstShip.x - firstShip.height*4, firstShip.y- firstShip.width
        --print(camera.x .. firstShip.x)
        if shipIsHit then 
            if #explosions == 0 then 
                table.insert(explosions, explosion(firstShip.x, firstShip.y, 100, {1,1,1,1}))
            end 
            
        end 
    firstShip:update(dt)
    
    for i in ipairs(planets) do 
        planets[i]:update(dt)
    end
else 
    camera:follow(VCAM.x, VCAM.y)
end
    levelgeneral.GUIControl()
    
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
    if shipIsHit then 
        for i, explosion in ipairs(explosions) do 
            explosion:render()
            --print("exploding")
        end
    end
    if reachedGoal then 
        love.graphics.clear(0,0,0,1)
        love.graphics.setColor(30/255, 30/255, 30/255, 1)
        if frame < WINDOW_WIDTH then 
        love.graphics.circle("fill", firstShip.x, firstShip.y, WINDOW_WIDTH - frame)
        end 
        frame = frame + 20
    end 
        firstShip:draw()
    camera:detach()
    
    camera:draw()
    if reachedGoal then 
        love.graphics.setColor(1,1,1,1-1/frame)
        love.graphics.setFont(smallfont)
        love.graphics.printf("Press Enter to continue",0, 600, WINDOW_WIDTH, "center")
    end
    if gameStatus == "setup" and not reachedGoal then 
    GUIDraw("left")
    elseif gameStatus == "play" then 
        if not reachedGoal then 
        love.graphics.printf("Thrusters: ", 0, WINDOW_HEIGHT-100, 300, "center")
        local m = smallfont:getWidth("Thrusters: ")
        local n = smallfont:getHeight("Thrusters: ")
        love.graphics.setColor(1,0,0,1)
        love.graphics.rectangle("fill",0, WINDOW_HEIGHT-50, thrusterMax/2, n)
        love.graphics.setColor(0,1,0,1)
        love.graphics.rectangle("fill",0, WINDOW_HEIGHT-50, firstShip.fuel/2, n)
        love.graphics.setColor(1,1,1,1)
        guimenu:butt(playbutts, WINDOW_WIDTH, WINDOW_HEIGHT, 1100, WINDOW_HEIGHT-50, 40, WINDOW_WIDTH/3)
        end 
    end
    
    
    
    
end 
function levelgeneral.goBack()
    levelgeneral.reset()
    lvlbase = nil
    gameStatus = "setup"
    firstShip.path = {}
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

