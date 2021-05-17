level7 = Class{}
local levelLoaded = false
local M = {}

function level7.load()
    shipsleft = 1
    local planetImage = love.graphics.newImage("entities/planet/planet" .. math.random(1, 18) .. ".png")
    planetsleft = 3
    gameStatus = "setup"
    playbutts = {}
    thrusterMax = 75
    firstShip.fuel = 75
    guibutts = {}
    VCAM.x, VCAM.y = WINDOW_WIDTH/2, WINDOW_HEIGHT/2
    explosions = {}
    shipIsHit = false
    guimenu = mainMenu()
    cameraControl = true 
    reachedGoal = false
    lvlbase = base(1400, WINDOW_HEIGHT/2)
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
    table.insert(cannons, enemy(10000, 100, false, 3, 5))
    table.insert(cannons, enemy(10000, 700, false, 3, 4))
    table.insert(planets, planet(1000, -100, 50, 0.3, asteroidImage, "nodelete"))
    table.insert(planets, planet(1000, 0, 50, 0.3, asteroidImage, "nodelete"))
    table.insert(planets, planet(1000, 100, 50, 0.3, asteroidImage, "nodelete"))
    table.insert(planets, planet(1000, 200, 50, 0.3, asteroidImage, "nodelete"))
    table.insert(planets, planet(1000, 300, 50, 0.3, asteroidImage, "nodelete"))
    table.insert(planets, planet(1000, 400, 50, 0.3, asteroidImage, "nodelete"))
    table.insert(planets, planet(1000, 500, 50, 0.3, asteroidImage, "nodelete"))
    table.insert(planets, planet(1000, 600, 50, 0.3, asteroidImage, "nodelete"))
    table.insert(planets, planet(1000, 700, 50, 0.3, asteroidImage, "nodelete"))
    table.insert(planets, planet(1000, 800, 50, 0.3, asteroidImage, "nodelete"))
end 
function level7.hint()
    GUIDraw("left")
    love.graphics.setFont(tinyfont)
    if (VCAM.x > WINDOW_WIDTH/2) then 
        if love.keyboard.isDown('a') then
            love.graphics.setColor(1,0,0,1) 
        end
        love.graphics.print("←[A]",10,50) 
    end 
    love.graphics.setColor(1,1,1,1) 
    if (VCAM.x < WINDOW_WIDTH*2) then 
        if love.keyboard.isDown('d') then
            love.graphics.setColor(1,0,0,1) 
        end
        love.graphics.print("[D]→",100,50)
        
    end 
    love.graphics.setColor(1,1,1,1) 
end 
function level7.reset()
    firstShip:reset()
    camera.scale = 1
    for i in ipairs(planets) do 
        if not planets[i].deletable then 
            table.remove(planets, i)
        end
    end
    for i in ipairs(cannons) do 
        cannons[i].timer = cannons[i].otimer
    end 
    table.insert(planets, planet(1000, -100, 50, 0.3, asteroidImage, "nodelete"))
    table.insert(planets, planet(1000, 0, 50, 0.3, asteroidImage, "nodelete"))
    table.insert(planets, planet(1000, 100, 50, 0.3, asteroidImage, "nodelete"))
    table.insert(planets, planet(1000, 200, 50, 0.3, asteroidImage, "nodelete"))
    table.insert(planets, planet(1000, 300, 50, 0.3, asteroidImage, "nodelete"))
    table.insert(planets, planet(1000, 400, 50, 0.3, asteroidImage, "nodelete"))
    table.insert(planets, planet(1000, 500, 50, 0.3, asteroidImage, "nodelete"))
    table.insert(planets, planet(1000, 600, 50, 0.3, asteroidImage, "nodelete"))
    table.insert(planets, planet(1000, 700, 50, 0.3, asteroidImage, "nodelete"))
    table.insert(planets, planet(1000, 800, 50, 0.3, asteroidImage, "nodelete"))
    local planetImage = love.graphics.newImage("entities/planet/planet" .. math.random(1, 18) .. ".png")
    shipsleft = 1
    projectiles = {}
    for i in ipairs(cannons) do 
        cannons[i].x = 100000
        cannons[i].destX = 100000
        cannons[i].appeared = false
    end 
    cannons[1].appeartimer = 5
    cannons[2].appeartimer = 4
    firstShip.fuel = 75
    shipIsHit = false
    attackTimer = 5
    

    
end 
function level7.bonusUpdate(dt)
    if not reachedGoal then 
        for i in ipairs(cannons) do 
            cannons[i]:time(dt)
            cannons[i].x = cannons[i].x - (math.abs(cannons[i].destX-cannons[i].x)/5)
            if cannons[i].appeartimer <= 0 then 
                cannons[i].destX = 1200 
                cannons[i]:update(dt)
                if not cannons[i].appeared then 
                    sounds["appear"]:stop()
                    sounds["appear"]:play() 
                    local coolx, cooly = camera:toWorldCoords(1280, 720)
                    table.insert(explosions, explosion(coolx, cannons[i].y, 100, {1,1,1,1}, 1))
                    cannons[i].appeared = true  
                end
            end
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
    
end
end 
function level7.GUIControl()
    
    if (love.keyboard.isDown('a') and VCAM.x > WINDOW_WIDTH/2) then 
        VCAM.x = VCAM.x - 10
    end
    if (love.keyboard.isDown('d'))  then
        VCAM.x = VCAM.x + 10
    end
end 
function level7.goBack()
    levelgeneral.goBack()
end
return level7

