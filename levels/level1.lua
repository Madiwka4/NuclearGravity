level1 = Class{}
local levelLoaded = false
local M = {}
function level1.load()
    shipsleft = 1
    thrusterMax = 25
    firstShip.fuel = 25
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
            if shipsleft == 0 then 
            selectedItem = "none"
            gameStatus = "play"
            end 
        end 
        ))
        table.insert(guibutts, menu:addButton("To menu", function ()
            level.goBack()
        end)) 
        table.insert(planets, planet(700, 200, 50, 0.3, asteroidImage, "nodelete"))
end 
function level1.hint()
    GUIDraw("left")
    love.graphics.setFont(tinyfont)
    love.graphics.setColor(1,1,1,1)
    if (VCAM.x > WINDOW_WIDTH/2) then 
        if love.keyboard.isDown('a') then
            love.graphics.setColor(1,0,0,1) 
        end
        love.graphics.print("←[A]",10,50)
        love.graphics.setColor(1,1,1,1) 
    end 
    if (VCAM.x < WINDOW_WIDTH*2) then 
        if love.keyboard.isDown('d') then
            love.graphics.setColor(1,0,0,1) 
        end
        love.graphics.print("[D]→",100,50)
        love.graphics.setColor(1,1,1,1) 
    end 
    love.graphics.setColor(1,1,1,1)
end 
function level1.reset()
    firstShip:reset()
    for k in pairs(planets) do
        planets[k] = nil
    end
    local planetImage = love.graphics.newImage("entities/planet/planet" .. math.random(1, 18) .. ".png")
    table.insert(planets, planet(700, 200, 50, 0.3, asteroidImage))
    shipsleft = 1
    shipIsHit = false
    firstShip.fuel = 25
    planetsleft = 3
end 
function level1.GUIControl()
    if (love.keyboard.isDown('a') and VCAM.x > WINDOW_WIDTH/2) then 
        VCAM.x = VCAM.x - 10
    end
    if (love.keyboard.isDown('d') and VCAM.x < WINDOW_WIDTH*2)  then
        VCAM.x = VCAM.x + 10
    end
end 
function level1.goBack()
    levelgeneral.goBack()
end
return level1

