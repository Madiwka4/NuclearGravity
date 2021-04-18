menu = Class{}
local M = {}
function menu.update(dt)

end 

function menu.draw(dt)
    menu:butt(buttons, WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_WIDTH/2, WINDOW_HEIGHT/2, 40, WINDOW_WIDTH/3)
end 

return menu