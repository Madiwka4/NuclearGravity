selectedItem = "none"
local planetImage = love.graphics.newImage("entities/planet/planet" .. math.random(1, 18) .. ".png")


function GUIDraw(mode)
    --MAIN
    love.graphics.setColor(1,1,1,1)
    love.graphics.rectangle("fill", WINDOW_WIDTH*0.7-3, 0, WINDOW_WIDTH*0.3-3, WINDOW_HEIGHT)
    love.graphics.setColor(0,0,0,1)
    local menuX = WINDOW_WIDTH*0.7
    local menuW = WINDOW_WIDTH*0.3
    local menuY = 3 
    love.graphics.rectangle("fill", WINDOW_WIDTH*0.7, 3, WINDOW_WIDTH*0.3, WINDOW_HEIGHT-6)
    love.graphics.setFont(smallfont)
    love.graphics.setColor(1,1,1,1)
    local textW = smallfont:getWidth("Control Panel")
    love.graphics.print("Control Panel",menuX + menuW/2-textW/2,menuY+10)
    --MAIN

    --SHIP
    local shipImage = love.graphics.newImage("entities/ship/smol_white_01.png")
    GUIButton(shipsleft, shipImage, menuX + 60, menuY+WINDOW_HEIGHT*0.2, function() selectedItem = "ship" end, 1, 1, {1,1,1,1}, 1.57)
    --SHIP
    --PLANET
    GUIButton(planetsleft, planetImage, menuX + 60, menuY+WINDOW_HEIGHT*0.4, function() selectedItem = "planet" end, 0.5, 0.5, {1,1,1,1}, 1.57)
    
    --PLANET


    --PLACING
    local mx, my = love.mouse.getPosition()
    local vmx, vmy = camera:getMousePosition()
    local vmx = vmx * DIFFERENCE_X
    local vmy = vmy * DIFFERENCE_Y
    local mx = mx * DIFFERENCE_X
    local my = my * DIFFERENCE_Y
    if mode == "anywhere" then 
        love.graphics.setColor(1,1,1,0.5)
        if selectedItem == "ship" and mx < menuX then 
            local shipW = shipImage:getWidth()
            local shipH = shipImage:getHeight()
            love.graphics.draw(shipImage,mx,my, 1.5708, 1, 1, shipW/2, shipH/2)
            if love.keyboard.mouseisReleased  then 
                love.keyboard.mouseisReleased = false 
                firstShip.x = vmx 
                firstShip.y = vmy
                shipsleft = shipsleft - 1
            end
            if shipsleft == 0 then 
                selectedItem = "none"
            end
        end
    elseif mode == "left" then 
        love.graphics.setColor(1,1,1,0.5)
        if selectedItem == "ship" and mx < menuX then 
            local shipW = shipImage:getWidth()
            local shipH = shipImage:getHeight()
            if VCAM.x > WINDOW_WIDTH/2-1 then 
            love.graphics.draw(shipImage,10,my, 1.5708, 1, 1, shipW/2, shipH/2)
            elseif VCAM.x > -WINDOW_WIDTH/2+(WINDOW_WIDTH-(menuX-firstShip.height/2)) then
                local timex, timey = camera:toCameraCoords(250, 0) 
            love.graphics.draw(shipImage,timex,my, 1.5708, 1, 1, shipW/2, shipH/2)
            else 
            love.graphics.draw(shipImage,menuX-firstShip.height/2,my, 1.5708, 1, 1, shipW/2, shipH/2)
            end
            if love.keyboard.mouseisReleased  then 
                love.keyboard.mouseisReleased = false 
                firstShip.x = 250
                firstShip.y = vmy
                shipsleft = shipsleft - 1
            end
            if shipsleft == 0 then 
                selectedItem = "none"
            end
        end
    end
    local dx, dy = camera:toCameraCoords(firstShip.x, firstShip.y)
    if VCAM.x - WINDOW_WIDTH/2+250 > firstShip.x and shipsleft == 0 then 
        love.graphics.setColor(1,0,0,1)
        love.graphics.rectangle("fill", 0, dy-firstShip.width/2, 10, firstShip.width)
    end
    if VCAM.y - WINDOW_HEIGHT/2+50 > firstShip.y and shipsleft == 0 then 
        love.graphics.setColor(1,0,0,1)
        love.graphics.rectangle("fill", dx-firstShip.height/2, 0, firstShip.height, 10)
    end
    if VCAM.y + WINDOW_HEIGHT/2+50 < firstShip.y and shipsleft == 0 then 
        love.graphics.setColor(1,0,0,1)
        love.graphics.rectangle("fill", dx-firstShip.height/2, WINDOW_HEIGHT-10, firstShip.height, 10)
    end
    if VCAM.x + WINDOW_WIDTH/2-150< firstShip.x and shipsleft == 0 then 
        love.graphics.setColor(1,0,0,1)
        love.graphics.rectangle("fill", menuX-10, dy-firstShip.width/2, 10, firstShip.width)
    end
    
    for k in ipairs(planets) do 
        local dx, dy = camera:toCameraCoords(planets[k].x, planets[k].y)
        if VCAM.x - WINDOW_WIDTH/2+250 > planets[k].x then 
            love.graphics.setColor(0,0,1,1)
            love.graphics.rectangle("fill", 0, dy-planets[k].w*0.3/2, 10, planets[k].w*0.3)
        end
        if VCAM.y - WINDOW_HEIGHT/2+50 > planets[k].y then 
            love.graphics.setColor(0,0,1,1)
            love.graphics.rectangle("fill", dx-planets[k].w*0.3/2, 0, planets[k].w*0.3, 10)
        end
        if VCAM.y + WINDOW_HEIGHT/2+50 < planets[k].y then 
            love.graphics.setColor(0,0,1,1)
            love.graphics.rectangle("fill", dx-planets[k].w*0.3/2, WINDOW_HEIGHT-10, planets[k].w*0.3, 10)
        end
        if VCAM.x + WINDOW_WIDTH/2-150< planets[k].x then 
            love.graphics.setColor(0,0,1,1)
            love.graphics.rectangle("fill", menuX-10, dy-planets[k].w*0.3/2, 10, planets[k].w*0.3)
        end
    end 
    if lvlbase ~= nil then 
        local dx, dy = camera:toCameraCoords(lvlbase.x, lvlbase.y)
        --print("YESYEYSYSYADSYADYASD")
        if VCAM.x - WINDOW_WIDTH/2+250 > lvlbase.x then 
            love.graphics.setColor(0,1,0,1)
            love.graphics.rectangle("fill", 0, dy-lvlbase.w/2, 10, lvlbase.w)
        end
        if VCAM.y - WINDOW_HEIGHT/2+50 > lvlbase.y then 
            love.graphics.setColor(0,1,0,1)
            love.graphics.rectangle("fill", dx-lvlbase.w/2, 0, lvlbase.w, 10)
        end
        if VCAM.y + WINDOW_HEIGHT/2+50 < lvlbase.y then 
            love.graphics.setColor(0,1,0,1)
            love.graphics.rectangle("fill", dx-lvlbase.w/2, WINDOW_HEIGHT-10, lvlbase.w, 10)
        end
        if VCAM.x + WINDOW_WIDTH/2-150< lvlbase.x then 
            love.graphics.setColor(0,1,0,1)
            love.graphics.rectangle("fill", menuX-10, dy-lvlbase.w/2, 10, lvlbase.w)
        end
    end 
    love.graphics.setColor(1,1,1,1)
        if selectedItem == "planet" and mx < menuX then 
            local shipW = planetImage:getWidth()
            local shipH = planetImage:getHeight()
            love.graphics.draw(planetImage,mx,my,0, 0.3, 0.3, shipW/2, shipH/2)
            if love.keyboard.mouseisReleased  then 
                love.keyboard.mouseisReleased = false 
                table.insert(planets, planet(vmx, vmy, 100000000, 0.3, planetImage))
                planetImage = love.graphics.newImage("entities/planet/planet" .. math.random(1, 18) .. ".png")
                planetsleft = planetsleft-1
            end
            if planetsleft == 0 then 
                selectedItem = "none"
            end
        end
        if selectedItem == "eraser" then 
            local hot = (vmx > firstShip.x-firstShip.height/2 and vmx < firstShip.x+firstShip.height and vmy > firstShip.y-firstShip.width/2 and vmy < firstShip.y - firstShip.width/2 + firstShip.width)
            if hot then 
                firstShip.color = {1,0,0,1}
                --print("hot")
            else 
                firstShip.color = {1,1,1,1}
                --print(mx .. " " .. my .. " " .. firstShip.x .. " " .. firstShip.y .. " " .. firstShip.width .. firstShip.height)
            end
            local pressed = love.keyboard.mouseisReleased
            if location == "android" then 
                pressed = love.mouse.isDown(1)
            end
            if pressed and hot then
                love.keyboard.mouseisReleased = false 
                firstShip.x = -9000
                shipsleft = shipsleft + 1 
            end


            for j in ipairs(planets) do 
                if planets[j].deletable then 
                    local hot = (vmx > planets[j].x-planets[j].w*0.3/2 and vmx < planets[j].x+planets[j].w*0.3 and vmy > planets[j].y-planets[j].w*0.3/2 and vmy < planets[j].y + planets[j].w*0.3)
                    if hot then 
                        planets[j].color = {1,0,0,1}
                        --print("hot")
                    else 
                        planets[j].color = {1,1,1,1}
                        --print(mx .. " " .. my .. " " .. firstShip.x .. " " .. firstShip.y .. " " .. firstShip.width .. firstShip.height)
                    end
                    local pressed = love.keyboard.mouseisReleased
                    if location == "android" then 
                        pressed = love.mouse.isDown(1)
                    end
                    if pressed and hot then
                        love.keyboard.mouseisReleased = false 
                        table.remove(planets, j)
                        planetsleft = planetsleft + 1
                        break
                    end
                end
            end
        end
    --PLACING


    --REMOVE TOOL
    trashbin = love.graphics.newImage("entities/trashbin.png")
    GUIButton("inf", trashbin, menuX + 60, menuY+WINDOW_HEIGHT*0.6, function() selectedItem = "eraser" end, 1, 1, {1,1,1,1}, 0)
    --REMOVE TOOL

    --START BUTTON
        guimenu:butt(guibutts, WINDOW_WIDTH, WINDOW_HEIGHT, menuX + 200, WINDOW_HEIGHT-100, 40, WINDOW_WIDTH/3.7)
        love.keyboard.mouseisReleased = false 
    --START BUTTON
end 


function GUIButton(num, shipImage, x, y, fn, sx, sy, color, r)
    love.graphics.setColor(unpack(color))
    local shipW = shipImage:getWidth()
    local shipH = shipImage:getHeight()

    local mx, my = love.mouse.getPosition()
    local vmx, vmy = camera:getMousePosition()
    local vmx = vmx * DIFFERENCE_X
    local vmy = vmy * DIFFERENCE_Y
    local mx = mx * DIFFERENCE_X
    local my = my * DIFFERENCE_Y
    local hot = (mx > x-shipW/2*sx and mx < x-shipW/2*sx + shipW*sx and my > y-shipH/2*sy and my < y -shipH/2*sy + shipH*sy)
    if (hot) then 
        love.graphics.setColor(1,0,0,0.5)
        --love.graphics.rectangle("fill", x, y, shipW, shipH)
    end
    local pressed = love.keyboard.mouseisReleased
    if location == "android" then 
        pressed = love.mouse.isDown(1)
    end
    if pressed and hot then
        love.keyboard.mouseisReleased = false 
        fn()
        hot = false
    end
    love.graphics.draw(shipImage,x,y, r, sx, sy, shipW/2, shipH/2)
    love.graphics.print("x" .. num,x+10,y)
    love.graphics.setColor(1,1,1,1)
end