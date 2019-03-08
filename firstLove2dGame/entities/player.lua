local Player = {}

function Player:new(x, y)
    img = love.graphics.newImage("assets/airplane.png")

    --x, y, w, h, speed, img, quad, id
    local player = require("components/entity"):new(x, y, 16, 16, 200, img, nil, "player")

    function player:load()
        -- renderer:addRenderer(self)
        -- gameLoop:addLoop(self)
    end

    function player:tick(dt)
        if love.keyboard.isDown("left", "a") then
            if player.pos.x > 0 then -- binds us to the map
                player.pos.x = player.pos.x - (player.speed * dt)
            end
        elseif love.keyboard.isDown("right", "d") then
            if player.pos.x < (width - player.img:getWidth()) then
                player.pos.x = player.pos.x + (player.speed * dt)
            end
        end

        -- Vertical movement
        if love.keyboard.isDown("up", "w") then
            if player.pos.y > (love.graphics.getHeight() / 2) then
                player.pos.y = player.pos.y - (player.speed * dt)
            end
        elseif love.keyboard.isDown("down", "s") then
            if player.pos.y < (love.graphics.getHeight() - 55) then
                player.pos.y = player.pos.y + (player.speed * dt)
            end
        end
    end

    function player:getX()
        local x = player.img:getWidth() / 2
        return x
    end
    
    function player:getY()
        local y = player.pos.y
        return y
    end

    function player:draw()
        love.graphics.draw(player.img, player.pos.x, player.pos.y)
    end

    return player
end

return Player
