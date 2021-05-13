menu = Class{}
local M = {}
menuLoaded = false 
function menu.update(dt)
    if not menuLoaded then 
        firstShip.x = -100
        menuLoaded = true
        planets = {}
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
    if animationSecsLeft > 0 then 
        animationSecsLeft = animationSecsLeft - dt 
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

function menu.draw(dt)
    firstShip:draw()
    for i in ipairs(planets) do 
        planets[i]:draw(dt)
    end
    if animationSecsLeft > 0 then 
        love.graphics.setColor(1,1,1,1-1/(animationSecsLeft+0.000001))
        love.graphics.draw(logo, 0,0)
    else 
        love.graphics.setFont(titlefont)
    love.graphics.printf("NuclearGravity", 0, 20, WINDOW_WIDTH, "center")
    menu:butt(buttons, WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_WIDTH/2, WINDOW_HEIGHT/2, 40, WINDOW_WIDTH/3)
    love.keyboard.mouseisReleased = false
    end 
end 

return menu