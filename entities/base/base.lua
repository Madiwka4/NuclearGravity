base = Class{}

G = 6.67e-5

function base:init(x, y)
self.x = x 
self.y = y 
self.image = love.graphics.newImage("entities/base/base.png")
self.w = self.image:getWidth()
self.h = self.image:getHeight()
end 

function base:update(dt)
    local distanceToShip = math.sqrt((firstShip.x - self.x)^2 + (firstShip.y - self.y)^2)
    if distanceToShip < self.w/2 then 
        reachedGoal = true 
    end 
end 

function base:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, 1, 1, self.w/2, self.w/2)
end