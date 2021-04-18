level1 = Class{}
local levelLoaded = false
local M = {}
function level1.update(dt)
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
        lvlbase = base(900, 200)
        levelLoaded = true
        table.insert(playbutts, menu:addButton("Return to setup", function()
            gameStatus = "setup"
            level1.reset()
        end ))
        table.insert(guibutts, menu:addButton("Release brake!", function ()
            selectedItem = "none"
            gameStatus = "play"
        end 
        ))
        table.insert(guibutts, menu:addButton("To menu", function ()
            level1.goBack()
        end)) 
        table.insert(planets, planet(700, 200, 50, 0.3, planetImage))
        
    end 
    if reachedGoal then 
        if levelsBeaten < 1 then 
            levelsBeaten = 1
        end
        print("levelsBeaten is " .. levelsBeaten)
        love.filesystem.write("save", levelsBeaten)
        level1.goBack()
    end
    camera:update(dt)
    lvlbase:update(dt)
    --print(camera.x .. " " .. camera.y)
    for i, explosion in ipairs(explosions) do 
        explosion:update(dt)
        if explosion.killed then 
            table.remove(explosions, i)
            gameStatus = "setup"
            level1.reset()
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
    level1.GUIControl()
    
    
end 

function level1.draw()
    love.graphics.setColor(1,1,1,1)
    camera:attach()
    firstShip:draw()
    lvlbase:draw()
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
function level1.goBack()
    level1.reset()
    gameStatus = "setup"
    firstShip.path = {}
    levelLoaded = false
    for k in pairs(planets) do
        planets[k] = nil
    end
    gameState = "selectlv"
end 
function level1.reset()
    firstShip:reset()
    for k in pairs(planets) do
        planets[k] = nil
    end
    local planetImage = love.graphics.newImage("entities/planet/planet" .. math.random(1, 18) .. ".png")
    table.insert(planets, planet(700, 200, 50, 0.3, planetImage))
    shipsleft = 1
    shipIsHit = false
    planetsleft = 3
end 
function level1.GUIControl()
    if (love.keyboard.isDown('a') and VCAM.x > WINDOW_WIDTH/2) then 
        VCAM.x = VCAM.x - 10
    end
    if (love.keyboard.isDown('d'))  then
        VCAM.x = VCAM.x + 10
    end
end 
return level1

