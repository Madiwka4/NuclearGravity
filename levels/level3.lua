level3 = Class{}
local levelLoaded = false
local M = {}
function level3.update(dt)
    if not levelLoaded then 
        shipsleft = 1
        local planetImage = love.graphics.newImage("entities/planet/planet" .. math.random(1, 18) .. ".png")
        planetsleft = 3
        gameStatus = "setup"
        playbutts = {}
        guibutts = {}
        VCAM.x, VCAM.y = WINDOW_WIDTH/2, WINDOW_HEIGHT/2
        explosions = {}
        shipIsHit = false
        guimenu = mainMenu()
        reachedGoal = false
        lvlbase = base(900, 300)
        levelLoaded = true
        table.insert(playbutts, menu:addButton("Return to setup", function()
            gameStatus = "setup"
            level3.reset()
        end ))
        table.insert(guibutts, menu:addButton("Release brake!", function ()
            if shipsleft == 0 then 
                selectedItem = "none"
                gameStatus = "play"
                end 
        end 
        ))
        table.insert(guibutts, menu:addButton("To menu", function ()
            level3.goBack()
        end)) 
        table.insert(planets, planet(900, 400, 50, 0.3, planetImage, "nodelete"))
        table.insert(planets, planet(700, 300, 50, 0.3, planetImage, "nodelete"))
        table.insert(planets, planet(900, 200, 50, 0.3, planetImage, "nodelete"))
        
    end 
    if reachedGoal then 
        if saveData.levelsBeaten < 3 then 
            saveData.levelsBeaten = 3
        end
        --print("saveData.levelsBeaten is " .. saveData.levelsBeaten)
        love.filesystem.write("save", serialize(saveData))
        level3.goBack()
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
            level3.reset()
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
    level3.GUIControl()
    
    
end 

function level3.draw()
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
function level3.goBack()
    level3.reset()
    lvlbase = nil
    gameStatus = "setup"
    firstShip.path = {}
    levelLoaded = false
    for k in pairs(planets) do
        planets[k] = nil
    end
    gameState = "selectlv"
end 
function level3.reset()
    firstShip:reset()
    for k in pairs(planets) do
        if planets[k].deletable then 
        planets[k] = nil
        end 
    end
    local planetImage = love.graphics.newImage("entities/planet/planet" .. math.random(1, 18) .. ".png")
    shipsleft = 1
    shipIsHit = false
    planetsleft = 3
end 
function level3.GUIControl()
    if (love.keyboard.isDown('a') and VCAM.x > WINDOW_WIDTH/2) then 
        VCAM.x = VCAM.x - 10
    end
    if (love.keyboard.isDown('d'))  then
        VCAM.x = VCAM.x + 10
    end
end 
return level3

