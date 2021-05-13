level4 = Class{}
local levelLoaded = false
local M = {}
function level4.load()
    shipsleft = 1
    local planetImage = love.graphics.newImage("entities/planet/planet" .. math.random(1, 18) .. ".png")
    planetsleft = 3
    gameStatus = "setup"
    playbutts = {}
    guibutts = {}
    thrusterMax = 100
    firstShip.fuel = 100
    VCAM.x, VCAM.y = WINDOW_WIDTH/2, WINDOW_HEIGHT/2
    explosions = {}
    shipIsHit = false
    guimenu = mainMenu()
    reachedGoal = false
    lvlbase = base(-300, 300)
    levelLoaded = true
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
    table.insert(planets, planet(-200, 400, 50, 0.3, asteroidImage, "nodelete"))
    table.insert(planets, planet(-200, 200, 50, 0.3, asteroidImage, "nodelete"))
end 

function level4.reset()
    firstShip:reset()
    for k in pairs(planets) do
        if planets[k].deletable then 
        planets[k] = nil
        end 
    end
    local planetImage = love.graphics.newImage("entities/planet/planet" .. math.random(1, 18) .. ".png")
    shipsleft = 1
    firstShip.fuel = 100
    shipIsHit = false
    planetsleft = 3
end 
function level4.GUIControl()
    if (love.keyboard.isDown('a') and VCAM.x > -WINDOW_WIDTH/2) then 
        VCAM.x = VCAM.x - 10
    end
    if (love.keyboard.isDown('d') and VCAM.x < WINDOW_WIDTH)  then
        VCAM.x = VCAM.x + 10
    end
end 
function level4.hint()
    GUIDraw("left")
    love.graphics.setFont(tinyfont)
    if (VCAM.x > -WINDOW_WIDTH/2) then 
        love.graphics.print("←[A]",10,50)
    end 
    if (VCAM.x < WINDOW_WIDTH) then 
        love.graphics.print("[D]→",100,50)
    end 
end 
function level4.goBack()
    levelgeneral.goBack()
end
return level4

