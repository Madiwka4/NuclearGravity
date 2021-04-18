state = require("levels/"..gameState)
print("levels/"..gameState)
function stateUpdate(dt)
    state = require("levels/"..gameState)
    state.update(dt)
end 


function stateDraw()
    state.draw()
end 