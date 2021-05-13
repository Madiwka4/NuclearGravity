ship = Class{}


function ship:init(x, y, image)
self.x = x 
self.y = y 
self.ox = x 
self.oy = y
self.dy = 0
self.dx = 5
self.speed = 1
self.image = love.graphics.newImage(image)
self.width = self.image:getWidth()
self.height = self.image:getHeight()
self.rotation = 1.5708
self.vector = 1.5708
self.color = {1,1,1,1}
self.path = {}
self.dottimer = 0.5
self.fuel = 0
end 
function ship:newPathDot(dotx, doty, color)
    return {
        x = dotx, 
        y = doty,
        color = color
    }
end
function ship:update(dt)
    if not shipIsHit then 
        self.dottimer = self.dottimer - dt
        if self.dottimer < 0 then 
            if (love.keyboard.isDown('w') and self.fuel > 0 and gameState == "levelgeneral") then 
                table.insert(self.path, self:newPathDot(self.x, self.y, 1))
            else 
                table.insert(self.path, self:newPathDot(self.x, self.y, 2))
            end
        self.dottimer = 0.2 
        end
        if love.timer.getFPS() < 20 then 
            self.path = {}
        end
    self.x = self.x + self.dx*self.speed/2
    self.y = self.y + self.dy*self.speed/2
    if self.dx ~= 0 then 
    self.vector = math.atan( self.dy/ self.dx)
    end 
    --[[if love.keyboard.isDown('s') then
        self.speed = math.sqrt(self.dx^2 + self.dy^2) 
        if self.speed > 0 then 
        self.speed = self.speed - 0.5
        end
        self.dx = math.cos(self.vector) * self.speed
        self.dy = math.sin(self.vector) * self.speed
    end ]]--
    if love.keyboard.isDown('w') and self.fuel > 0 and gameState == "levelgeneral" then 
        self.fuel = self.fuel - 0.5
        self.speed = self.speed + 0.05

    end
    --[[
    if love.keyboard.isDown('left') then 
        self.dx = self.dx - 0.5
    end
    if love.keyboard.isDown('right') then 
        self.dx = self.dx + 0.5
    end
    if love.keyboard.isDown('up') then 
        self.dy = self.dy - 0.5
    end
    if love.keyboard.isDown('down') then 
        self.dy = self.dy + 0.5
    end
    ]]--
    --print(self.speed)
    
    --[[
    if love.keyboard.isDown('right') then 
        self.rotation = self.rotation + 10
    elseif love.keyboard.isDown('left') then 
        self.rotation = self.rotation - 10
    end]]--

    --print("rotation:" .. self.rotation)
    --print("speed:" .. self.dx .. " " .. self.dy)
   
    if self.dx < 0 then 
        self.vector = self.vector - 3.14159
    end
    self.vector = self.vector + 1.5708
end
end 

function ship:draw()

    -- Draw the `self.canvas` to screen
    love.graphics.setColor(unpack(self.color))
    --print("DAW" .. camera.x)
    love.graphics.draw(self.image, self.x, self.y, self.vector, 1, 1, self.width/2, self.height/2)
    for i in ipairs(self.path) do 
        if i > 1 then 
            
            love.graphics.setColor(0.9,0.9,0.9,1)
            if (self.path[i].color < 2) then 
                love.graphics.setColor(0.9,0.4,0.4,1)
            end 
            --print("DOING".. i)
            love.graphics.line(self.path[i].x, self.path[i].y, self.path[i-1].x, self.path[i-1].y)
        end
    end
    love.graphics.setColor(1,1,1,1)
    
end

function ship:reset()
    self.x = self.ox
    self.y = self.oy
    self.dy = 0
    self.dx = 5
    self.rotation = 1.57
    self.canvas = love.graphics.newCanvas(WINDOW_WIDTH, WINDOW_HEIGHT)
    self.vector = 1.56
    self.speed = 1
    self.path = {}
    self.dottimer = 0.5
end 
