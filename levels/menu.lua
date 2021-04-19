menu = Class{}
local M = {}
function menu.update(dt)
    if animationSecsLeft > 0 then 
        animationSecsLeft = animationSecsLeft - dt 
    end
end 

function menu.draw(dt)
    if animationSecsLeft > 0 then 
        love.graphics.setColor(1,1,1,1-1/(animationSecsLeft+0.000001))
        love.graphics.draw(logo, 0,0)
    else 
        love.graphics.setFont(titlefont)
    love.graphics.printf("NuclearGravity", 0, 20, WINDOW_WIDTH, "center")
    menu:butt(buttons, WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_WIDTH/2, WINDOW_HEIGHT/2, 40, WINDOW_WIDTH/3)
    end 
end 

return menu