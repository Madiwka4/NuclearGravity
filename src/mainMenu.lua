mainMenu = Class{}
function mainMenu:butt(buttons, VIRTUAL_WIDTH, VIRTUAL_HEIGHT, locationx, locationy, ev_BUTTON_HEIGHT, ev_button_width, arg)
    local margin = 16
    local hot = false
    local cursor_y = 0
    local total_height = (ev_BUTTON_HEIGHT + margin) * #buttons
    local ev_bx, ev_by
    for i, button in ipairs(buttons) do 
        button.last = button.now
        ev_bx = locationx - (ev_button_width * 0.5)
        ev_by = locationy - (total_height * 0.5) + cursor_y
        local color = {255, 255, 255, 255}
        local mx, my = love.mouse.getPosition()
        local mx = mx * DIFFERENCE_X
        local my = my * DIFFERENCE_Y
        local hot = (mx > ev_bx and mx < ev_bx + ev_button_width and my > ev_by and my < ev_by + ev_BUTTON_HEIGHT) and i
        if (hot == i) then 
            color = {10, 10, 0, 255}
        end
        button.now = love.keyboard.mouseisReleased
        if location == "android" then 
            button.now = love.mouse.isDown(1)
        end
        if button.now and hot == i then
            love.keyboard.mouseisReleased = false 
            button.fn()
            hot = false
            break
        end
        if arg == "beatenGreen" then 
            if i <= saveData.levelsBeaten then 
                color = {0,1,0,1}
            end
        end
        love.graphics.setColor(unpack(color))
        love.graphics.rectangle("fill", ev_bx,ev_by, ev_button_width, ev_BUTTON_HEIGHT)
        love.graphics.setColor(0, 0, 0, 255)
        local textW = smallfont:getWidth(button.text)
        local textH = smallfont:getHeight(button.text)   
        love.graphics.print(button.text, smallfont, ev_bx + ev_button_width*0.5 - textW*0.5, ev_by+textH*0.5)
        love.graphics.setColor(255, 255, 255, 255)
        cursor_y = cursor_y + (ev_BUTTON_HEIGHT + margin)
                
    end            
            
end
function mainMenu:addButton(text, fn)
    return {
        text = text, 
        fn = fn,
        now = false,
        last = false
    }
end
