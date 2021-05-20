function buttonClutter()
    table.insert(buttons, menu:addButton("Practice", 
    function() 
        menuLoaded = false
        objReset()
        gameState = "practice"
    end))
    table.insert(buttons, menu:addButton("Levels", 
    function() 
        gameState = "selectlv"
    end))
    table.insert(buttons, menu:addButton("Toggle Fullscreen", 
    function() 
        myscreen:toggle(WINDOW_HEIGHT, WINDOW_WIDTH)
                DIFFERENCE_X = myscreen.c
                DIFFERENCE_Y = myscreen.d
                OFFSET_X = myscreen.e 
                OFFSET_Y = myscreen.f 
    end))
    table.insert(buttons, menu:addButton("Toggle Music", 
function() 
    toggleMusic()
end
))

table.insert(buttons, menu:addButton("Quit", 
function() 
    love.event.quit()
end
))
end 
local t=0
function explode(x, y)
    t = t+10
    love.graphics.circle("fill", x, y, t)
end 