function rpcManager()
    if gameState == "levelgeneral" then 
        presence = {
            state = "Thinking...",
            details = "Level: " .. currentLevel,
            startTimestamp = startTime,
            largeImageKey = "gravitynew",
            largeImageText = "Gravity",
        }
    end 
    if gameState == "menu" or gameState == "selectlv" then 
        presence = {
            state = "Choosing the best level",
            startTimestamp = startTime,
            largeImageKey = "gravitynew",
            largeImageText = "Gravity",
        }
    end
    if gameState == "practice" then 
        presence = {
            state = "Practicing",
            details = "Current best score: " .. math.floor(saveData.score/100),
            startTimestamp = startTime,
            largeImageKey = "gravitynew",
            largeImageText = "Gravity",
        }
    end
end 