level6 = Class{}
local levelLoaded = false
local M = {}
function level6.load()
    shipsleft = 1
    local planetImage = love.graphics.newImage("entities/planet/planet" .. math.random(1, 18) .. ".png")
    planetsleft = 3
    gameStatus = "setup"
    playbutts = {}
    thrusterMax = 0
    firstShip.fuel = 0
    guibutts = {}
    VCAM.x, VCAM.y = WINDOW_WIDTH/2, WINDOW_HEIGHT/2
    explosions = {}
    shipIsHit = false
    guimenu = mainMenu()
    reachedGoal = false
    lvlbase = base(1600, 400)
    levelLoaded = true
    attackTimer = 5
    table.insert(playbutts, menu:addButton("Return to setup", function()
        gameStatus = "setup"
        levelgeneral.reset()
    end ))
    table.insert(guibutts, menu:addButton("Release brake!", function ()
        if shipsleft == 0 then 
            selectedItem = "none"
            gameStatus = "play"
            end 
    end 
    ))
    table.insert(guibutts, menu:addButton("To menu", function ()
        levelgeneral.goBack()
    end)) 
    table.insert(cannons, enemy(10000, 400, false, 3))
    table.insert(planets, planet(1600, 250, 50, 0.3, asteroidImage, "nodelete"))
    table.insert(planets, planet(1600, 550, 50, 0.3, asteroidImage, "nodelete"))
end 
function level6.hint()
    GUIDraw("left")
    love.graphics.setFont(tinyfont)
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
end 
function level6.reset()
    firstShip:reset()
    local planetImage = love.graphics.newImage("entities/planet/planet" .. math.random(1, 18) .. ".png")
    shipsleft = 1
    projectiles = {}
    cannons[1].x = 100000
    cannons[1].destX = 100000
    firstShip.fuel = 0
    shipIsHit = false
    attackTimer = 5
    cannons[1].appeared = false

    
end 
function level6.bonusUpdate(dt)
    if not reachedGoal then 
    if attackTimer >= 0 then 
        attackTimer = attackTimer - dt 
    else 
        cannons[1].destX = 1200
        cannons[1]:update(dt)
        if not cannons[1].appeared then 
            sounds["appear"]:stop()
        sounds["appear"]:play()
        if #explosions == 0 then 
            table.insert(explosions, explosion(1400, 400, 100, {1,40/255,40/255,1}))
            explosions[1].type = 1
        end
        cannons[1].appeared = true  
    end 
    end 
    for i in ipairs(projectiles) do 
        projectiles[i]:update(dt)
    end
    cannons[1].x = cannons[1].x - (math.abs(cannons[1].destX-cannons[1].x)/5)
end
end 
function level6.GUIControl()
    
    if (love.keyboard.isDown('a') and VCAM.x > WINDOW_WIDTH/2) then 
        VCAM.x = VCAM.x - 10
    end
    if (love.keyboard.isDown('d'))  then
        VCAM.x = VCAM.x + 10
    end
end 
function level6.goBack()
    levelgeneral.goBack()
end
return level6

