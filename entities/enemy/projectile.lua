projectile = Class{}

G = 6.67e-5

function projectile:init(x, y, v, angle, timer)
self.x = x 
self.y = y 
self.dx = 0
self.dy = 0
self.image = love.graphics.newImage("entities/enemy/missile-01.png")
self.w = self.image:getWidth()
self.h = self.image:getHeight()
self.angle = angle
self.v = v
self.timer = timer
self.killed = false
self.dx = math.cos(self.angle) * self.v
self.dy = math.sin(self.angle) * self.v
self.vx = 0
self.vy = 0
end 

function projectile:update(dt)
    local distanceToShip = math.sqrt((firstShip.x - self.x)^2 + (firstShip.y - self.y)^2)
    self.timer = self.timer - dt 
    if self.timer <= 0 then 
        self.killed = true
    end 
    self.vx = self.vx + self.dx 
    self.vy = self.vy + self.dy 
    self.x = self.x + self.vx 
    self.y = self.y + self.vy
    if distanceToShip < firstShip.width/3 then 
        shipIsHit = true
        sounds["close"]:stop()
        sounds["boom"]:play()
    end
end 

function projectile:draw()
    love.graphics.draw(self.image, self.x, self.y, self.angle, 1, 1, self.w/2, self.w/2)
end