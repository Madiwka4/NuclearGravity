function buttonClutter()
    table.insert(buttons, menu:addButton("Practice", 
    function() 
        gameState = "practice"
    end))
    table.insert(buttons, menu:addButton("Levels", 
    function() 
        gameState = "selectlv"
    end
))
end 
local t=0
function explode(x, y)
    t = t+10
    love.graphics.circle("fill", x, y, t)
end 