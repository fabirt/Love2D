
G_WIDTH = nil
G_HEIGHT = nil

function love.load()
    success = love.window.setMode( 0, 0, { fullscreen=true } )
    G_WIDTH = love.graphics.getWidth()
    G_HEIGHT = love.graphics.getHeight()

end

function love.update(dt)
   
end

function love.draw()
    
end

function love.keypressed(key)
    if key == "escape" then
        love.event.push("quit")
    end
end


