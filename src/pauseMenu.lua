pauseStatus = false 
pauseMenu = {}
function pauseMake()
    table.insert(pauseMenu, menu:addButton("Resume", 
function() 
    pauseStatus = false 
end
))
table.insert(pauseMenu, menu:addButton("Main Menu", 
function() 
    pauseStatus = false 
    goBack()
end
))
table.insert(pauseMenu, menu:addButton("Toggle Fullscreen", 
function() 
    myscreen:toggle(WINDOW_HEIGHT, WINDOW_WIDTH)
            DIFFERENCE_X = myscreen.c
            DIFFERENCE_Y = myscreen.d
            OFFSET_X = myscreen.e 
            OFFSET_Y = myscreen.f 
end
))
table.insert(pauseMenu, menu:addButton("Toggle Music", 
function() 
    toggleMusic()
end
))
table.insert(pauseMenu, menu:addButton("Quit", 
function() 
    love.event.quit()
end
)) 
end
function drawPauseMenu()
   -- print("draw")
    menu:butt(pauseMenu, WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_WIDTH/2, WINDOW_HEIGHT/2, 40, WINDOW_WIDTH/3)
end 