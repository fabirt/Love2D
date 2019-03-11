-- Pull in Gamestate from the HUMP library
Gamestate = require "libs.hump.gamestate"

-- Pull in each of our game states
mainMenu = require "gamestates.mainMenu"
instructions = require "gamestates.instructions"
gameLevel1 = require "gamestates.gameLevel1"

G_WIDTH = nil
G_HEIGHT = nil

function love.load()
    success = love.window.setMode( 0, 0, { fullscreen=true } )
    G_WIDTH, G_HEIGHT = love.graphics.getWidth(), love.graphics.getHeight()

    font_diabolica_50 = love.graphics.newFont("assets/fonts/joannavu_diabolica/Diabolica.ttf", 50)
    font_diabolica_40 = love.graphics.newFont("assets/fonts/joannavu_diabolica/Diabolica.ttf", 40)
    font_diabolica_32 = love.graphics.newFont("assets/fonts/joannavu_diabolica/Diabolica.ttf", 32)

    font_proximanova_28 = love.graphics.newFont("assets/fonts/proximanova/proximanova-semibold.ttf", 28)

    Gamestate.registerEvents()
    Gamestate.switch(mainMenu)
end

--[[ function love.update(dt)
   
end

function love.draw()
    
end ]]

function love.keypressed(key)
    if key == "escape" then
        love.event.push("quit")
    end
end


