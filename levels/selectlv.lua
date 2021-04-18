selectlv = Class{}
levels = {}
table.insert(levels, menu:addButton("Level 1", function ()
gameState = "level1"
end ))
table.insert(levels, menu:addButton("Level 2", function ()
    if levelsBeaten > 0 then 
    gameState = "level2"
    end
    end ))




table.insert(levels, menu:addButton("Go Back", function ()
    gameState = "menu"
    end ))
local M = {}
function selectlv.update(dt)

end 

function selectlv.draw(dt)
    menu:butt(levels, WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_WIDTH/2, WINDOW_HEIGHT/2, 40, WINDOW_WIDTH/3, "beatenGreen")
end 

return selectlv