enemy = Class{}

G = 6.67e-5

function enemy:init(x, y, del, tm, atm)
self.x = x 
self.y = y 
self.image = love.graphics.newImage("entities/enemy/enemy.png")
self.cannon = love.graphics.newImage("entities/enemy/cannon.png")
self.w = self.image:getWidth()
self.h = self.image:getHeight()
self.cannonw = self.cannon:getWidth()
self.cannonh = self.cannon:getHeight()
self.angle = 0
self.deletable = del 
self.maxtimer = tm
self.destX = x
self.timer = tm
self.color = {1,1,1,1}
self.appeared = false
self.appeartimer = atm
end 

function enemy:update(dt)
    
    self.timer = self.timer - dt 
    if self.timer <= 0 then 
        self.timer = self.maxtimer 
        self:shoot()
    end 
    local distanceToShip = math.sqrt((firstShip.x - self.x)^2 + (firstShip.y - self.y)^2)
    self.angle = math.atan( (firstShip.y - self.y)/ (firstShip.x - self.x))
    if self.x < firstShip.x then 
        self.angle = self.angle - 3.14159
    end
end 
function enemy:time(dt)
    self.appeartimer = self.appeartimer - dt
end 
function enemy:draw()
    love.graphics.setColor(unpack(self.color))
    love.graphics.draw(self.image, self.x, self.y, 0, 1, 1, self.w/2, self.w/2)
    love.graphics.draw(self.cannon, self.x, self.y, self.angle-1.57, 1, 1, self.cannonw/2, self.cannonh/2)
end

function enemy:shoot()
    table.insert(projectiles, projectile(self.x, self.y, 0.5, self.angle+3.14, 5))
    sounds["launch"]:stop()
    sounds["launch"]:play()
end