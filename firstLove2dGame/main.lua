-- Tools
renderer = require("tools/renderer")
gameLoop = require("tools/gameLoop")
-- Screens
GameScreen = require("screens/game")
MenuScreen = require("screens/menu")

debug = true

gameTime = 0
deltaTime = 0

start = false
done = false

function love.load(arg)
    renderer:load()
    gameLoop:load()

    musicTrack = love.audio.newSource("assets/sounds/track1.mp3", "static")
    musicTrack:setLooping(true)
    musicTrack:play()
    
    
    menuScreen = MenuScreen:new()
    menuScreen:load()
end

function love.update(dt)
    deltaTime = dt
    gameTime = gameTime + dt
    gameLoop:update(dt)
end

function love.keypressed(key, unicode)
    start = true
    if start and not done then
        menuScreen:close()
        gameScreen = GameScreen:new()
        gameScreen:load()-- body
        done = true
    end
end

function love.draw()
    renderer:draw(gameTime)
end
