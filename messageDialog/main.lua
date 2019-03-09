require "libs.message.MessageInABottle"

function love.load()
    love.graphics.setBackgroundColor(1, 1, 1)

    --Initialize the ocean to manage the bottles.
    --It is going to act as a bottle queue.
    ocean = Ocean:new()

    --Create a timed bottle and add it to the ocean
    --   ocean:addBottle(TimeBottle:new(nil,"...",1))
    --Create a stay bottle and add it to the ocean
    local bottle = StayBottle:new("jajaj", "What is this?")
    --Change some bottle settings to non-default ones
    bottle:setBgColor(63, 63, 63)
    bottle:setFgColor(186, 186, 186)
    bottle:setX(310)
    bottle:setVolume(0)
    ocean:addBottle(bottle)
end

function love.update(dt)
    --Required to update the bottles
    ocean:update(dt)
end

function love.draw()
    love.graphics.setColor(0, 0, 0)
    --This is showing some useful variables ocean stores.
    love.graphics.print(
        "last bottle return was: " ..
            ocean.response .. " at " .. (math.floor(ocean.responseTime * 10) / 10) .. "s from " .. ocean.responseID,
        12,
        12
    )
    --This is all that is needed to draw the current bottle
    ocean:draw()
end

function love.keypressed(k, u)
    --You can add a bottle on the fly.
    if k == "d" then
        local x = math.floor(math.random(400))
        local y = math.floor(math.random(150))
        local newBottle = TimeBottle:new("PRESSED_D", "Timed Box!", 2)
        newBottle:setX(x)
        newBottle:setY(y)
        newBottle:setBgColor(math.floor(math.random(255)), math.floor(math.random(255)), math.floor(math.random(255)))
        ocean:addBottle(newBottle)
    elseif k == "escape" then
        love.event.push("q")
    end
end
