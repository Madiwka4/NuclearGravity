explosion = Class{}

function explosion:init(x, y, v, color, type)
	self.color = color 
    self.type = 0
	self.x = x 
	self.y = y 
    self.v = v
    self.range = 0  
    self.maxRange = WINDOW_WIDTH*2
    self.killed = false 
    if type ~= nil then 
        self.type = type 
    end
    --print(self.i)
end

function explosion:update(dt)
    self.range = self.range + dt * 24 
    if (self.type == 0) then 
        --print("my range is " .. self.range)
    end
    self.maxRange = WINDOW_WIDTH*2
    if self.type == 1 then 
        self.maxRange = WINDOW_WIDTH*6
    elseif self.type == 2 then 
        self.maxRange = 200
    end
    if self.range * self.v > self.maxRange then 
        --print("killing myself with range" .. self.range .. " " .. self.v .. " " .. self.maxRange .. " and type " .. self.type)
        self.killed = true
    end
end



function explosion:render(toggle)
    --print("rendering myself" .. self.x .. " " .. self.y .. " " .. self.range .. " " .. self.v)
    love.graphics.setColor(unpack(self.color))
    if self.type == 2 then 
        love.graphics.setColor(1,1,1,0.7/(self.range))
      -- print(self.range)
    elseif self.type == 1 then 
        love.graphics.setColor(1,1,1,0.01*(76.32-(self.range*2)))
       --print(self.range)
    end
        love.graphics.circle("fill", self.x, self.y, self.range * self.v, 100)
        love.graphics.setColor(1,1,1,1)
end