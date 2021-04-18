gameState = "menu"
require 'src/dependencies'
math.randomseed(os.time())
--VARIABLES
RESOLUTION_SET = 0
isFullscreen = 0
DIFFERENCE_X = 1
DIFFERENCE_Y = 1
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
OFFSET_X = 0
OFFSET_Y = 0

levelsBeaten = 0
planets = {}
buttons = {}
menu = mainMenu()

function love.load()
    testwalls = love.filesystem.load("save")
    if testwalls ~= nil then
        levelsBeaten = love.filesystem.load("save")
        print("Save file found")
    else
        print("No save file found!")
    end 
    tick.framerate = 60
    camera = Camera()
    BG = love.graphics.newImage("entities/background.jpg")
    simpleScale.setWindow(WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT)
    firstShip = ship(-500, -500, "entities/ship/smol_red_01.png")
    VCAM = VCAM(WINDOW_WIDTH/2, WINDOW_HEIGHT/2)
    smallfont = love.graphics.newFont("font.ttf", 25)
    --table.insert(planets, planet(100, WINDOW_HEIGHT/2-100, 1010000000, 1))
    buttonClutter()
    --planet2 = planet(1000, 300, 1000000000, 20)
end 

function love.update(dt)
    stateUpdate(dt)

end 

function love.draw()
    simpleScale.set() 
    --love.graphics.draw(BG, 0, 0)
    stateDraw()
    simpleScale.unSet()
end 



function love.mousereleased(x, y, button)
    love.keyboard.mouseisReleased = true
end


