selectlv = Class{}
levels = {}
table.insert(levels, menu:addButton("Level 1", function ()
menuLoaded = false
objReset()
gameState = "level1"
end ))
table.insert(levels, menu:addButton("Level 2", function ()
    if saveData.levelsBeaten > 0 then 
        menuLoaded = false
        objReset()
    gameState = "level2"
    end
    end ))
    table.insert(levels, menu:addButton("Level 3", function ()
        if saveData.levelsBeaten > 1 then 
            menuLoaded = false
            objReset()
        gameState = "level3"
        end
        end ))



table.insert(levels, menu:addButton("Go Back", function ()
    gameState = "menu"
    end ))
local M = {}
function selectlv.update(dt)
    if not menuLoaded then 
        firstShip.x = -100
        firstShip.speed = 10
        firstShip.y =  love.math.random(0, WINDOW_HEIGHT)
        menuLoaded = true
        table.insert(planets, planet(love.math.random(100, WINDOW_WIDTH-100), love.math.random(100, WINDOW_HEIGHT-100), 90000000, 0.3, love.graphics.newImage("entities/planet/planet.png")))
    end
    for i in ipairs(planets) do 
        planets[i]:update(dt)
    end
    firstShip:update(dt)
    if shipIsHit then 
        shipIsHit = false
        firstShip:reset()
        firstShip.x = -100
        firstShip.speed = 10
        firstShip.y =  love.math.random(0, WINDOW_HEIGHT)
        --print("ship is hit")
    end
end 

function selectlv.draw(dt)
    firstShip:draw()
    for i in ipairs(planets) do 
        planets[i]:draw(dt)
    end
    menu:butt(levels, WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_WIDTH/2, WINDOW_HEIGHT/2, 40, WINDOW_WIDTH/3, "beatenGreen")
end 

return selectlv