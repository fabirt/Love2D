
mainMenu = Gamestate.new()

local fadeTime = 0.5 -- Duración en segundos de la transición
local timer = 1 * fadeTime
local fadeVel = (1 - 0) / (fadeTime - 0)

function mainMenu:enter(from)
    -- self.from = from -- record previous state
    self.canvas = love.graphics.newCanvas(G_WIDTH, G_HEIGHT)
    self.background = love.graphics.newImage("assets/images/bg1.jpg")
    self.imageWidth = self.background:getWidth()
    self.imageHeight = self.background:getHeight()
    self.scale_x = G_WIDTH / self.imageWidth
    self.scale_y = G_HEIGHT / self.imageHeight

    self.start = false
    self.mainOpacity = 0

    -- Button table
    self.button = {
        x = G_WIDTH / 3,
        y = ((G_HEIGHT / 3) * 2) - 6,
        w = G_WIDTH / 3,
        h = 60,
        inactiveColor = { 1, 1, 1, 0.4 },
        activeColor = { 1, 1, 1, 0.8 },
        isActive = false
    }

    self.musicTrack = love.audio.newSource("assets/music/freeway.mp3", "stream")
    self.musicTrack:setVolume(0.5)
    self.musicTrack:setLooping(true)
    self.musicTrack:play()
 
    -- Rectangle is drawn to the canvas with the regular alpha blend mode.
    love.graphics.setCanvas(self.canvas)
        love.graphics.clear()
        love.graphics.setBlendMode("alpha")
        love.graphics.setColor(0, 0, 0, 0.7)
        love.graphics.rectangle('fill', 0, 0, G_WIDTH, G_HEIGHT)
    love.graphics.setCanvas()

end

function mainMenu:update(dt)
    self:handleTouches(dt)
    if start then
        self:fadeBg(dt)
    end
end

function mainMenu:draw()
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    -- draw previous screen
    -- self.from:draw()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setBlendMode("alpha", "premultiplied")
    love.graphics.draw(self.background, 0, 0, 0, self.scale_x, self.scale_y)
    love.graphics.draw(self.canvas)
    love.graphics.setBlendMode("alpha")

    -- overlay with mainMenu message
    love.graphics.setFont(font_diabolica_50)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Lilith's Nightmare", 0, h / 3, w, "center")
    
    love.graphics.setColor(0, 0, 0, 0)
    love.graphics.rectangle('fill', self.button.x, self.button.y, self.button.w, self.button.h)
    
    if self.button.isActive then
        love.graphics.setColor(self.button.activeColor)
    else
        love.graphics.setColor(self.button.inactiveColor)
    end
    love.graphics.setFont(font_diabolica_40)
    love.graphics.printf("COMENZAR", 0, (h / 3) * 2, w, "center")

    love.graphics.setColor(0, 0, 0, self.mainOpacity)
    love.graphics.rectangle('fill', 0, 0, w, h)
end

function mainMenu:keypressed(key)
    if key == "p" then
        -- return Gamestate.pop() -- return to previous state
    end
end

function mainMenu:mousepressed( tx, ty, mbutton, istouch, presses )
    if  tx >= self.button.x 
        and tx <= self.button.x + self.button.w 
        and ty >= self.button.y 
        and ty <= self.button.y + self.button.h then
            self.button.isActive = true
            start = true
        end
end

function mainMenu:mousereleased( x, y, mbutton, istouch, presses )
    self.button.isActive = false
end

function mainMenu:handleTouches(dt)
    local touches = love.touch.getTouches()
    for i, id in ipairs(touches) do	
        local tx,ty = love.touch.getPosition(id)
        if  tx >= self.button.x 
            and tx <= self.button.x + self.button.w 
            and ty >= self.button.y 
            and ty <= self.button.y + self.button.h then
            self.button.isActive = true
            start = true
        else
            self.button.isActive = false
        end
    end
end

function mainMenu:fadeBg(dt)
    timer = timer - dt
    self.mainOpacity = self.mainOpacity + (fadeVel*dt)
    if timer <= 0 then
        timer = 1 * fadeTime
        Gamestate.switch(instructions)
    end
end


return mainMenu