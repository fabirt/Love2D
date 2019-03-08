require "tools/tiledmap"


function love.load()
    _G.map = loadTiledMap("assets/maps/map1/tilemap", "assets/maps/map1/")   
    bgMusic = love.audio.newSource("assets/music/track1.mp3", "stream") 
    bgMusic:setLooping(true)
    bgMusic:setVolume(0.33)
    bgMusic:play()
end

function love.draw()
    _G.map:draw()
end