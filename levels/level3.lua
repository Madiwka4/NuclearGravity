level3 = Class{}
local levelLoaded = false
local M = {}
function level3.load()
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
    reachedGoal = false
    lvlbase = base(900, 300)
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
    table.insert(planets, planet(900, 400, 50, 0.3, planetImage, "nodelete"))
    table.insert(planets, planet(700, 300, 50, 0.3, planetImage, "nodelete"))
    table.insert(planets, planet(900, 200, 50, 0.3, planetImage, "nodelete"))
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
    firstShip.fuel = 75
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
function level3.goBack()
    levelgeneral.goBack()
end
return level3

