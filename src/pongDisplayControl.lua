function resolutionChanger()
    if (RESOLUTION_SET > 1) then
        RESOLUTION_SET = 0
    end
    if (RESOLUTION_SET == 0) then
        if (isFullscreen == 1) then
            DIFFERENCE_X = 1
            DIFFERENCE_Y = 1
            OFFSET_X = 0
            OFFSET_Y = 0
            simpleScale.updateWindow(WINDOW_WIDTH, WINDOW_HEIGHT, {fullscreen = false})
            isFullscreen = 0
        end
    end
    if (RESOLUTION_SET == 1) then
        if (isFullscreen == 0) then
            simpleScale.updateWindow(WINDOW_WIDTH, WINDOW_HEIGHT, {fullscreen = true})
            local newWidth = love.graphics.getWidth()
            local newHeight = love.graphics.getHeight()
            DIFFERENCE_X = VIRTUAL_WIDTH / newWidth
            DIFFERENCE_Y = VIRTUAL_HEIGHT / newHeight
            OFFSET_X = math.fmod(newWidth, VIRTUAL_WIDTH) / 2 
            OFFSET_Y = math.fmod(newHeight, VIRTUAL_HEIGHT) / 2
            isFullscreen = 1
        end
    end
end