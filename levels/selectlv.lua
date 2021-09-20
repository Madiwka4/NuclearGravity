selectlv = Class{}
levels = {}
table.insert(levels, menu:addButton("Level 1", function ()
menuLoaded = false
objReset()
gameState = "levelgeneral"
currentLevel = 1
end ))
table.insert(levels, menu:addButton("Level 2", function ()
    if saveData.levelsBeaten > 0 then 
        menuLoaded = false
        objReset()
        gameState = "levelgeneral"
        currentLevel = 2
    end
    end ))
    table.insert(levels, menu:addButton("Level 3", function ()
        if saveData.levelsBeaten > 1 then 
            menuLoaded = false
            objReset()
            gameState = "levelgeneral"
            currentLevel = 3
        end
        end ))
        table.insert(levels, menu:addButton("Level 4", function ()
            if saveData.levelsBeaten > 2 then 
                menuLoaded = false
                objReset()
                gameState = "levelgeneral"
                currentLevel = 4
            end
            end ))
            table.insert(levels, menu:addButton("Level 5", function ()
                if saveData.levelsBeaten > 3 then 
                    menuLoaded = false
                    objReset()
                    gameState = "levelgeneral"
                    currentLevel = 5
                end
                end ))
                table.insert(levels, menu:addButton("Level 6", function ()
                    if saveData.levelsBeaten > 4 then 
                        menuLoaded = false
                        objReset()
                        gameState = "levelgeneral"
                        currentLevel = 6
                    end
                    end ))
                    table.insert(levels, menu:addButton("Level 7", function ()
                        if saveData.levelsBeaten > 5 then 
                            menuLoaded = false
                            objReset()
                            gameState = "levelgeneral"
                            currentLevel = 7
                        end
                        end ))
                        table.insert(levels, menu:addButton("Level 8", function ()
                            if saveData.levelsBeaten > 6 then 
                                menuLoaded = false
                                objReset()
                                gameState = "levelgeneral"
                                currentLevel = 8
                            end
                            end ))


table.insert(levels, menu:addButton("Go Back", function ()
    gameState = "menu"
    end ))
local M = {}
function selectlv.update(dt)
    if not menuLoaded then 
        startTime = os.time(os.date("*t"))
        firstShip.x = -100
        menuLoaded = true
        table.insert(planets, planet(love.math.random(100, WINDOW_WIDTH-100), love.math.random(100, WINDOW_HEIGHT-100), 90000000, 0.3, love.graphics.newImage("entities/planet/planet.png")))
        if (planets[1].y < WINDOW_HEIGHT/2) then 
            firstShip.y =  love.math.random(WINDOW_HEIGHT/2, WINDOW_HEIGHT)
        else 
            firstShip.y =  love.math.random(0, WINDOW_HEIGHT/2)
        end
    end
    for i in ipairs(planets) do 
        planets[i]:update(dt)
    end
    firstShip:update(dt)
    if shipIsHit then 
        shipIsHit = false
        firstShip:reset()
        firstShip.x = -100
        if (planets[1].y < WINDOW_HEIGHT/2) then 
            firstShip.y =  love.math.random(WINDOW_HEIGHT/2, WINDOW_HEIGHT)
        else 
            firstShip.y =  love.math.random(0, WINDOW_HEIGHT/2)
        end
        --print("ship is hit")
    end
end 

function selectlv.draw(dt)
    firstShip:draw()
    for i in ipairs(planets) do 
        planets[i]:draw(dt)
    end
    menu:butt(levels, WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_WIDTH/2, WINDOW_HEIGHT/2, 40, WINDOW_WIDTH/3, "beatenGreen")
    love.keyboard.mouseisReleased = false
end 

return selectlv