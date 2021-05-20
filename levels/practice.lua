practice = Class{}
local levelLoaded = false
local M = {}
local currenctScore = 0

function practice.update(dt)
    if not pauseStatus then 
    if not levelLoaded then 
        shipsleft = 1
        planetsleft = 10
        cannonsleft = 10
        gameStatus = "setup"
        playbutts = {}
        guibutts = {}
        XCAM = 0
        currentScore = 0
        cameraControl = true 
        thrusterMax = 0
        YCAM = 0
        firstShip.fuel = 0
        explosions = {}
        shipIsHit = false
        guimenu = mainMenu()
        table.insert(playbutts, menu:addButton("Return to setup", function()
            gameStatus = "setup"
            practice.reset()
        end ))
        table.insert(guibutts, menu:addButton("Release brake!", function ()
            if shipsleft == 0 then 
                selectedItem = "none"
                gameStatus = "play"
                end 
        end 
        ))
        table.insert(guibutts, menu:addButton("To menu", function ()
            practice.goBack()
        end 
        ))
        levelLoaded = true 
    end
    camera:update(dt)
 
    --print(camera.x .. " " .. camera.y)
    for i, explosion in ipairs(explosions) do 
        explosion:update(dt)
       -- print("1 update done")
        if explosion.killed then 
            table.remove(explosions, i)
            if shipIsHit then 
            gameStatus = "setup"
            practice.reset()
            end 
        end
    end
    if gameStatus == "play" then
        camera.x, camera.y = firstShip.x - firstShip.height*4, firstShip.y- firstShip.width
        --print(camera.x .. firstShip.x)
        if shipIsHit and not firstShip.exploded then  
            table.insert(explosions, explosion(firstShip.x, firstShip.y, 100, {1,1,1,1}))
            explosions[#explosions].type = 0
            firstShip.exploded = true            
        end 
    firstShip:update(dt)
    for i in ipairs(planets) do 
        planets[i]:update(dt)
        if math.sqrt((firstShip.x - planets[i].x)^2 + (firstShip.y - planets[i].y)^2) > planets[i].w/3 then 
            currentScore = currentScore + math.sqrt(planets[i].attractionX^2 + planets[i].attractionY^2)*100
            --print(math.sqrt(planets[i].attractionX^2 + planets[i].attractionY^2))
        end 
    end
    for i in ipairs(cannons) do 
        cannons[i]:update(dt)
    end
    for i in ipairs(projectiles) do 
        projectiles[i]:update(dt)
    end
    for i in ipairs(projectiles) do 
        if projectiles[i].killed then 
            table.remove(projectiles, i) 
            --print("killing")
        end
    end 
    
else 
    camera:follow(VCAM.x, VCAM.y)
end
    practice.GUIControl()
else   
    settingsMenuUpdate(dt)
end
end 

function practice.draw()
    camera:attach()
    firstShip:draw()
    for i in ipairs(planets) do 
        planets[i]:draw(dt)
    end
    for i in ipairs(cannons) do 
        cannons[i]:draw(dt)
    end
    for i in ipairs(projectiles) do 
        projectiles[i]:draw(dt)
    end
    --love.graphics.rectangle("fill",VCAM.x,VCAM.y,30,30)
    for i, explosion in ipairs(explosions) do 
        if shipIsHit then 
            explosion:render()
        else 
            explosion:render("special")
        end
        --print("exploding")
    end
    camera:detach()
    
    camera:draw()
   
    if gameStatus == "setup" then 
    GUIDraw("anywhere")
    love.graphics.setFont(tinyfont)
    local textW = tinyfont:getWidth("Top score: " .. math.floor(saveData.score/100))
    love.graphics.print("Top score: " .. math.floor(saveData.score/100), WINDOW_WIDTH/2-textW/2, 10)
    practice.hint()
    elseif gameStatus == "play" and not pauseStatus then 
        local textW = tinyfont:getWidth("Score: " .. math.floor(currentScore/100))
        love.graphics.setFont(tinyfont)
        love.graphics.print("Score: " .. math.floor(currentScore/100), WINDOW_WIDTH/2-textW/2, 10)
        guimenu:butt(playbutts, WINDOW_WIDTH, WINDOW_HEIGHT, 1100, WINDOW_HEIGHT-50, 40, WINDOW_WIDTH/3)
    end
    
    if pauseStatus then 
        drawPauseMenu()
        love.keyboard.mouseisReleased = false
    end
    
    
end 
function practice.goBack()
    practice.reset()
    cameraControl = false
    gameStatus = "setup"
    levelLoaded = false
    gameState = "menu"
    cannons = {}
end 
function practice.reset()
    firstShip:reset()
    camera.scale = 1
    projectiles = {}
    for i in ipairs(cannons) do 
        cannons[i].timer = cannons[i].otimer
    end 
    shipsleft = 1
    if currentScore > saveData.score then 
        
        saveData.score = currentScore
        love.filesystem.write("save", serialize(saveData))
    end
    currentScore = 0
    shipIsHit = false
    firstShip.fuel = 99999
end 
function practice.GUIControl()
    if (love.keyboard.isDown('w')) then 
        VCAM.y = VCAM.y - 10
    end
    if (love.keyboard.isDown('a')) then 
        VCAM.x = VCAM.x - 10
    end
    if (love.keyboard.isDown('s')) then 
        VCAM.y = VCAM.y + 10
    end
    if (love.keyboard.isDown('d'))  then
        VCAM.x = VCAM.x + 10
    end
end 
function practice.hint()
    love.graphics.setFont(tinyfont)
    if love.keyboard.isDown('w') then
        love.graphics.setColor(1,0,0,1) 
    end
    love.graphics.print("↑[W]",80,10)
    love.graphics.setColor(1,1,1,1) 
    if love.keyboard.isDown('s') then
        love.graphics.setColor(1,0,0,1) 
    end
    love.graphics.print("↓[S]",80,100)
    love.graphics.setColor(1,1,1,1) 
    if love.keyboard.isDown('a') then
        love.graphics.setColor(1,0,0,1) 
    end
    love.graphics.print("←[A]",10,50)
    love.graphics.setColor(1,1,1,1) 
    if love.keyboard.isDown('d') then
        love.graphics.setColor(1,0,0,1) 
    end
    love.graphics.print("→[D]",150,50)
    love.graphics.setColor(1,1,1,1) 
    
    

end 
return practice