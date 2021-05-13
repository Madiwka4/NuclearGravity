level5 = Class{}
local levelLoaded = false
local M = {}
function level5.load()
    shipsleft = 1
    local planetImage = love.graphics.newImage("entities/planet/planet" .. math.random(1, 18) .. ".png")
    planetsleft = 5
    gameStatus = "setup"
    playbutts = {}
    guibutts = {}
    thrusterMax = 100
    firstShip.fuel = 100
    VCAM.x, VCAM.y = 0, WINDOW_HEIGHT/2
    explosions = {}
    shipIsHit = false
    guimenu = mainMenu()
    reachedGoal = false
    lvlbase = base(50, 2000)
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
    table.insert(planets, planet(0, 2000, 50, 0.3, planetImage, "nodelete"))
    table.insert(planets, planet(100, 2000, 50, 0.3, planetImage, "nodelete"))
    table.insert(planets, planet(50, 1700, 50, 0.3, planetImage, "nodelete"))
end 

function level5.reset()
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
    planetsleft = 5
end 
function level5.GUIControl()
    if (love.keyboard.isDown('w') and VCAM.y > -WINDOW_WIDTH) then 
        VCAM.y = VCAM.y - 10
    end
    if (love.keyboard.isDown('s') and VCAM.y < WINDOW_WIDTH*2)  then
        VCAM.y = VCAM.y + 10
    end
end
function level5.hint()
    GUIDraw("up")
    love.graphics.setFont(tinyfont)
    if (VCAM.y > -WINDOW_WIDTH) then 
    love.graphics.print("↑[W]",50,10)
    end 
    if (VCAM.y < WINDOW_WIDTH*2) then 
    love.graphics.print("↓[D]",50,100)
    end 
end 
function level5.goBack()
    levelgeneral.goBack()
end
return level5

