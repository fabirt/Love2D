require "tools/tiledmap"


function love.load()
    _G.map = loadTiledMap("assets/maps/map1/tilemap", "assets/maps/map1/")    
end

function love.draw()
    _G.map:draw()
end