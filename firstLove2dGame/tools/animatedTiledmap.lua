


function loadTiledMap2(pathToTilemap, pathToTileset)
    local map = require(pathToTilemap)

    map.quads = {} 

    local tileset = map.tilesets[1]

    map.image = love.graphics.newImage(pathToTileset..tileset.image)

    for y = 0, (tileset.imageheight / tileset.tileheight ) - 1 do
        for x = 0, (tileset.imagewidth / tileset.tilewidth) - 1 do
            local quad = love.graphics.newQuad(
                x * tileset.tilewidth,
                y * tileset.tileheight,
                tileset.tilewidth,
                tileset.tileheight,
                tileset.imagewidth,
                tileset.imageheight
            )
            table.insert( map.quads, quad)
        end
    end

    function map:draw(dt)
        for i, layer in ipairs(self.layers) do
            for y = 0, layer.height - 1 do
                for x = 0, layer.width - 1 do
                    local index = (x + y * layer.width) + 1
                    local tid = layer.data[index]
                    if tid ~= 0 then
                        local quad = self.quads[tid]
                        if quad ~= nil then
                            local xx = x * tileset.tilewidth
                            local yy = (y * tileset.tileheight) + (dt * 16)
                            if yy > 700 + tileset.tileheight then
                                yy = yy - (700 + tileset.tileheight)
                            end
                            
                            love.graphics.draw(
                                self.image,
                                quad,
                                xx,
                                yy
                            )
                        end
                    end
                end
            end
        end
    end

    return map
end