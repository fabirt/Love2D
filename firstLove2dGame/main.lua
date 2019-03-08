-- Tools
renderer = require("tools/renderer")
gameLoop = require("tools/gameLoop")
-- Screens
GameScreen = require("screens/game")

debug = true

function love.load(arg)
    renderer:load()
    gameLoop:load()
    
    gameScreen = GameScreen:new()
    gameScreen:load()
end

function love.update(dt)
    gameLoop:update(dt)
end

function love.draw(dt)
    renderer:draw(dt)
end
