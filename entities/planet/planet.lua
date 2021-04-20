planet = Class{}

G = 6.67e-1

function planet:init(x, y, mass, radius, img, arg)
self.x = x 
self.y = y 
self.mass = mass 
self.r = radius 
self.w = img:getWidth()
self.image = img
self.angle = 0
self.color = {1,1,1,1}
if arg == "nodelete" then 
    self.deletable = false 
else 
    self.deletable = true 
end
end 

function planet:update(dt)
    local distanceToShip = math.sqrt((firstShip.x - self.x)^2 + (firstShip.y - self.y)^2)
    
    local gravitationalAttraction = G*self.mass/(distanceToShip^2)
    --print((firstShip.x - self.x) .. " " .. (firstShip.y - self.y))
    self.angle = math.atan( (firstShip.y - self.y)/ (firstShip.x - self.x))
    if self.x < firstShip.x then 
        self.angle = self.angle - 3.14159
    end
    --print("Angle is:" .. self.angle*57.29)
    self.attractionY = math.sin(self.angle) * gravitationalAttraction
    self.attractionX = math.cos(self.angle) * gravitationalAttraction
    love.window.setTitle(self.attractionX)
    firstShip.dx = firstShip.dx + self.attractionX
    firstShip.dy = firstShip.dy + self.attractionY
    if distanceToShip < self.w/4 then 
        shipIsHit = true
    end
end 

function planet:draw()
    --love.graphics.rectangle("fill", firstShip.x, firstShip.y, 30, 30)
    love.graphics.push()
    love.graphics.translate(firstShip.x, firstShip.y) -- move relative (0,0) to (x,y)
    love.graphics.rotate(self.angle) -- rotate coordinate system around relative (0,0) (absolute (x,y))
    --love.graphics.rectangle("fill", -(firstShip.x - self.x)/2, -20/2, (firstShip.x - self.x), 20) VECTOR
    love.graphics.pop()
    love.graphics.setColor(unpack(self.color))
    love.graphics.draw(self.image, self.x, self.y, 1.5708, self.r, self.r, self.w/2, self.w/2)
end