levelgeneral = Class{}
local levelLoaded = false
local M = {}
function levelgeneral.update(dt)
    if not levelLoaded then 
        level = require("levels/level" .. currentLevel)
        level.load()
        levelLoaded = true
    end 
    if reachedGoal then 
        if saveData.levelsBeaten < currentLevel then 
            saveData.levelsBeaten = currentLevel
        end
        --print("saveData.levelsBeaten is " .. saveData.levelsBeaten)
        love.filesystem.write("save", serialize(saveData))
        levelgeneral.goBack()
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
    firstShip:draw()
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
    camera:detach()
    
    camera:draw()
   
    if gameStatus == "setup" then 
    GUIDraw("left")
    elseif gameStatus == "play" then 
        guimenu:butt(playbutts, WINDOW_WIDTH, WINDOW_HEIGHT, 1100, WINDOW_HEIGHT-50, 40, WINDOW_WIDTH/3)
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

