state = require("levels/"..gameState)
print("levels/"..gameState)
function stateUpdate(dt)
    state = require("levels/"..gameState)
    state.update(dt)
    musicController("norm")
    rpcManager()
end 

function goBack()
    state.goBack()
end 
function stateDraw()
    state.draw()
end 