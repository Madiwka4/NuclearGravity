practice = Class{}
local levelLoaded = false
local M = {}
function practice.update(dt)
    if not levelLoaded then 
        shipsleft = 1
        planetsleft = 10
        gameStatus = "setup"
        playbutts = {}
        guibutts = {}
        XCAM = 0
        YCAM = 0
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
        if explosion.killed then 
            table.remove(explosions, i)
            gameStatus = "setup"
            practice.reset()
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
    practice.GUIControl()
    
    
end 

function practice.draw()
    camera:attach()
    firstShip:draw()
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
    GUIDraw("anywhere")
    elseif gameStatus == "play" then 
        guimenu:butt(playbutts, WINDOW_WIDTH, WINDOW_HEIGHT, 1100, WINDOW_HEIGHT-50, 40, WINDOW_WIDTH/3)
        love.keyboard.mouseisReleased = false
    end
    
    
    
    
end 
function practice.goBack()
    practice.reset()
    gameStatus = "setup"
    levelLoaded = false
    gameState = "menu"
end 
function practice.reset()
    firstShip:reset()
    for k in pairs(planets) do
        planets[k] = nil
    end
    shipsleft = 1
    shipIsHit = false
    planetsleft = 10
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
return practice