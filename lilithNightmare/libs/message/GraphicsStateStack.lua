local stack = {}

function love.graphics.pushState()
    --get state
    local state = {}
    state.blendMode = love.graphics.getBlendMode()
    state.color = {love.graphics.getColor()}
    --  state.colorMode   = love.graphics.getColorMode()
    state.font = love.graphics.getFont() or 12
    state.lineStyle = love.graphics.getLineStyle()
    state.lineWidth = love.graphics.getLineWidth()
    state.scissor =  {love.graphics.getScissor()}

    -- push state
    stack[#stack + 1] = state
end

function love.graphics.popState()
    -- restore state
    local state = stack[#stack]

    love.graphics.setBlendMode(state.blendMode)
    love.graphics.setColor(unpack(state.color))
    --  love.graphics.setColorMode( state.colorMode )
    love.graphics.setFont(state.font)
    love.graphics.setLineWidth(state.lineWidth)
    love.graphics.setLineStyle(state.lineStyle)
    love.graphics.setScissor(unpack(state.scissor))

    -- pop state
    stack[#stack] = nil
end
