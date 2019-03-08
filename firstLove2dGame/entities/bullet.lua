local Bullet = {}

function Bullet:new(x, y)
    img = love.graphics.newImage("assets/bullet.png")

    --x, y, w, h, speed, img, quad, id
    local bullet = require("components/entity"):new(x, y, 16, 16, 200, img, nil, "bullet")

    function bullet:load()
        -- renderer:addRenderer(self)
        -- gameLoop:addLoop(self)
    end

    function bullet:tick(dt)
        bullet.pos.y = bullet.pos.y - (250 * dt)
        if bullet.pos.y < 0 then -- remove bullets when they pass off the screen
            --renderer:removeRenderer(self)
            --gameLoop:removeLoop(self)
        end
    end

    function bullet:draw()
        love.graphics.draw(bullet.img, bullet.pos.x, bullet.pos.y)
    end

    return bullet
end

return Bullet
