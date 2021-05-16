gameState = "menu"
animationSecsLeft = 3
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
cameraControl = false
currentLevel = 0

saveData = {
    levelsBeaten = 0,
    score = 0
}

planets = {}
buttons = {}
cannons = {}
projectiles = {}
menu = mainMenu()
function love.wheelmoved(x, y)
    if gameStatus == "play" and cameraControl then 
    if y > 0 and camera.scale < 1 then
        camera.scale = camera.scale + 0.1
    elseif y < 0 and camera.scale > 0.5 then
        camera.scale = camera.scale - 0.1
    end
end 
end
function love.load()
    print(love.filesystem.getAppdataDirectory())
    print(love.filesystem.getSaveDirectory())
    print(love.filesystem.areSymlinksEnabled())
    print(love.filesystem.createDirectory('.'))
    love.filesystem.newFile("File")
    testwalls = love.filesystem.load("save")
    if testwalls ~= nil then
        saveData = love.filesystem.load("save")()
        --print("Save file found")
    else
        --print("No save file found!")
    end 
    if saveData.score == nil then 
        saveData.score = 0 
    end
    tick.framerate = 60
    camera = Camera()
    BG = love.graphics.newImage("entities/background.jpg")
    logo = love.graphics.newImage("logo.png")
    simpleScale.setWindow(WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT)
    firstShip = ship(-500, -500, "entities/ship/smol_white_01.png")
    VCAM = VCAM(WINDOW_WIDTH/2, WINDOW_HEIGHT/2)
    tinyfont = love.graphics.newFont("font.ttf", 15)
    smallfont = love.graphics.newFont("font.ttf", 25)
    titlefont = love.graphics.newFont("font.ttf", 50)
    myscreen = fullScreener(RESOLUTION_SET, isFullscreen, DIFFERENCE_X, DIFFERENCE_Y, OFFSET_X, OFFSET_Y)
    --table.insert(planets, planet(100, WINDOW_HEIGHT/2-100, 1010000000, 1))
    buttonClutter()
    --planet2 = planet(1000, 300, 1000000000, 20)
end 

function love.update(dt)
    stateUpdate(dt)
love.window.setTitle("Nuclear Gravity")
end 

function love.draw()
    simpleScale.set() 
    love.graphics.clear(30 / 255,30 / 255,30 / 255,1)
    stateDraw()
    simpleScale.unSet()
end 



function love.mousereleased(x, y, button)
    love.keyboard.mouseisReleased = true
end


function objReset()
    firstShip:reset()
    planets = {}
end
