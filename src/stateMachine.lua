state = require("levels/"..gameState)
loadedState = gameState
print("levels/"..gameState)
function stateUpdate(dt)
    if gameState ~= loadedState then 
        state = require("levels/"..gameState)
        loadedState = gameState
        print("levels/"..gameState)
    end
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