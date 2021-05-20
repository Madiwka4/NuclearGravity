pauseStatus = false 
pauseState = "main"
pauseMenu = {}
settings = {}
function pauseMake()
    volumeSlider = newSlider(WINDOW_WIDTH/2, WINDOW_HEIGHT/2-100, 300, 0.5, 0, 1, function (v) love.audio.setVolume(v) end)
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
table.insert(settings, menu:addButton("Toggle Fullscreen", 
function() 
    myscreen:toggle(WINDOW_HEIGHT, WINDOW_WIDTH)
            DIFFERENCE_X = myscreen.c
            DIFFERENCE_Y = myscreen.d
            OFFSET_X = myscreen.e 
            OFFSET_Y = myscreen.f 
end
))
table.insert(settings, menu:addButton("back", 
function() 
    pauseState = "main"
end
))
table.insert(pauseMenu, menu:addButton("Settings", 
function() 
    pauseState = "settings"
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
   if pauseState == "main" then 
    menu:butt(pauseMenu, WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_WIDTH/2, WINDOW_HEIGHT/2, 40, WINDOW_WIDTH/3)
   end
   if pauseState == "settings" then 
    menu:butt(settings, WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_WIDTH/2, WINDOW_HEIGHT/2, 40, WINDOW_WIDTH/3)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(254, 67, 101)
    love.graphics.setFont(tinyfont)
    love.graphics.printf("Sound volume:", 0, WINDOW_HEIGHT/2-140, WINDOW_WIDTH, "center")
    -- draw slider, set color and line style before calling
    volumeSlider:draw()
   end
end 

function settingsMenuUpdate(dt)
    if pauseState == "settings" then 
        local mx, my = love.mouse.getPosition()
        local vmx, vmy = camera:getMousePosition()
        local vmx = vmx * DIFFERENCE_X
        local vmy = vmy * DIFFERENCE_Y
        local mx = mx * DIFFERENCE_X
        local my = my * DIFFERENCE_Y
        volumeSlider:update(mx, my)
       -- print("updating")
    end 
   -- print("called?")
end
