local Enemy = {}

function Enemy:new(x, y)
    img = love.graphics.newImage("assets/enemy.png")

    --x, y, w, h, speed, img, quad, id
    local enemy = require("components/entity"):new(x, y, 16, 16, 200, img, nil, "enemy")

    function enemy:load()
        -- renderer:addRenderer(self)
        -- gameLoop:addLoop(self)
    end

    function enemy:tick(dt)
        enemy.pos.y = enemy.pos.y + (200 * dt)
        if enemy.pos.y > 680 then -- remove enemys when they pass off the screen
            renderer:removeRenderer(self)
            --gameLoop:removeLoop(self)
        end
    end

    function enemy:draw()
        love.graphics.draw(enemy.img, enemy.pos.x, enemy.pos.y)
    end

    return enemy
end

return Enemy
