state = require("levels/"..gameState)
print("levels/"..gameState)
function stateUpdate(dt)
    state = require("levels/"..gameState)
    state.update(dt)
    if love.keyboard.isDown('escape') then 
        love.event.quit()
    end 
end 


function stateDraw()
    state.draw()
end 