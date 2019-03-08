-- Tools
require ("tools/tiledmap")

width = love.graphics.getWidth()
height = love.graphics.getHeight()

local MenuScreen = {}

function MenuScreen:new()
    local menuScreen = require("components/entity"):new(10, 10, 10, 10, 10, nil, nil, "game")
    
    function menuScreen:load(arg)
        renderer:addRenderer(self)
        gameLoop:addLoop(self)

        _G.map = loadTiledMap("assets/maps/menuMap", "assets/maps/")  

    
    end
    
    function menuScreen:tick(dt)
        
        
    end

    
    function menuScreen:draw(dt)
       _G.map:draw()
       love.graphics.print( "Space Monkeys", 150, 540, 0, 2, 2)
       love.graphics.print( "Press something to start!", 170, 600, 0, 1, 1 )
    end

    function menuScreen:close()
        renderer:removeRenderer(self)
    end

    return menuScreen
end

return MenuScreen