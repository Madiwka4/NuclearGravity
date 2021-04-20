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
    VCAM.x, VCAM.y = WINDOW_WIDTH/2, WINDOW_HEIGHT/2
    explosions = {}
    shipIsHit = false
    guimenu = mainMenu()
    reachedGoal = false
    lvlbase = base(400, 300)
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

function level4.reset()
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
function level4.GUIControl()
    if (love.keyboard.isDown('a') and VCAM.x > WINDOW_WIDTH/2) then 
        VCAM.x = VCAM.x - 10
    end
    if (love.keyboard.isDown('d'))  then
        VCAM.x = VCAM.x + 10
    end
end 
return level4

