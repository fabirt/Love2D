
instructions = Gamestate.new()

local fadeTime = 0.8 -- Duración en segundos de la transición
local timer = 1 * fadeTime
local fadeVel = (1 - 0) / (fadeTime - 0)

function instructions:enter(from)
    self.mainOpacity = 1
    self.animateIn = true
    self.animateOut = false
end

function instructions:update(dt)
    self:handleTouches(dt)
    if self.animateIn then
        self:fadeBgIn(dt)
    end
    if self.animateOut then
        self:fadeBgOut(dt)
    end
end

function instructions:draw()
    love.graphics.setFont(font_diabolica_40)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Instrucciones", 0, (G_HEIGHT / 8), G_WIDTH, "center")
    love.graphics.setFont(font_proximanova_28)
    love.graphics.printf("Utiliza los controles laterales para moverte.\nCuando aparezca una ventana de texto, toca la pantalla para continuar.", 
    G_WIDTH / 4, (G_HEIGHT / 8)*2, (G_WIDTH / 4) * 2, "center")
    
    love.graphics.setColor(0, 0, 0, self.mainOpacity)
    love.graphics.rectangle('fill', 0, 0, G_WIDTH, G_HEIGHT)
end

function instructions:keypressed(key)
    if key == "p" then
        -- return Gamestate.pop() -- return to previous state
    end
end

function instructions:mousepressed( tx, ty, mbutton, istouch, presses )
    if not self.animateIn then
        self.animateOut = true
    end
end

function instructions:mousereleased( x, y, mbutton, istouch, presses )
    
end

function instructions:handleTouches(dt)
    local touches = love.touch.getTouches()
    for i, id in ipairs(touches) do	
        
    end
end

function instructions:fadeBgIn(dt)
    timer = timer - dt
    self.mainOpacity = self.mainOpacity - (fadeVel*dt)
    if timer <= 0 then
        timer = 1 * fadeTime
        self.animateIn = false
    end
end

function instructions:fadeBgOut(dt)
    timer = timer - dt
    self.mainOpacity = self.mainOpacity + (fadeVel*dt)
    if timer <= 0 then
        timer = 1 * fadeTime
    end
end



return instructions