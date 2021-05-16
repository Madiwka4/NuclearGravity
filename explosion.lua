explosion = Class{}

function explosion:init(x, y, v, color, type)
	self.color = color 
    self.type = 0
	self.x = x 
	self.y = y 
    self.v = v
    self.range = 0  
    self.killed = false 
    if type ~= nil then 
        self.type = type 
    end
    --print(self.i)
end

function explosion:update(dt)
    self.range = self.range + dt * 24 
    local maxRange = WINDOW_WIDTH*2
    if self.type == 1 then 
        maxRange = WINDOW_WIDTH*6
    elseif self.type == 2 then 
        maxRange = 200
    end
    if self.range * self.v > maxRange then 
        --print("killing myself with range" .. self.range)
        self.killed = true
    end
end



function explosion:render(toggle)
    --print("rendering myself" .. self.x .. " " .. self.y .. " " .. self.range .. " " .. self.v)
    love.graphics.setColor(unpack(self.color))
    if self.type == 2 then 
        love.graphics.setColor(1,1,1,0.7/(self.range))
       -- print(self.range)
    elseif toggle == "special" then 
        love.graphics.setColor(1,1,1,0.7/(self.range/6))
       -- print(self.range)
    end
        love.graphics.circle("fill", self.x, self.y, self.range * self.v, 100)
        love.graphics.setColor(1,1,1,1)
end