local Class = require "libs.hump.class"
local Entity = require "entities.Entity"
require "libs.paddy.paddy"

local player =
    Class {
    __includes = Entity -- Player class inherits our Entity class
}

local fps = 8
local anim_timer = 1 / fps
local frame = 1
local num_frames = 3
local xoffset

function player:init(world, x, y)
    Entity.init(self, world, x, y, 32, 32)

    player_atlas = love.graphics.newImage("assets/player/lilith/lilith_pink.png")
    playerSprite = love.graphics.newQuad(0, 0, self.w, self.h, player_atlas:getDimensions())
    -- self.img = love.graphics.newImage("/assets/player/player.png")
    self.sprite = playerSprite

    -- Add our unique player values
    self.xVelocity = 0 -- current velocity on x, y axes
    self.yVelocity = 0
    self.acc = 70 -- the acceleration of our player
    self.maxSpeed = 100 -- the top speed
    self.friction = 40 -- slow our player down - we could toggle this situationally to create icy or slick platforms
    self.gravity = 130 -- we will accelerate towards the bottom
    self.dir = "r"

    self.world:add(self, self:getRect())
end

function player:collisionFilter(other)
    local x, y, w, h = self.world:getRect(other)
    local playerTop = self.y
    local playerBottom = self.y + self.h
    local playerRight = self.x + self.w
    local playerLeft = self.x
    local otherBottom = y + h

    if playerBottom <= y then -- bottom of player collides with top of platform.
        return "slide"
    end
    if playerTop >= y then -- top of player collides with bottom of platform.
        return "slide"
    end
    if playerRight >= x then -- top of player collides with bottom of platform.
        return "slide"
    end
end

function player:update(dt)
    local prevX, prevY = self.x, self.y
    paddy.update(dt)
    -- Apply Friction
    self.xVelocity = self.xVelocity * (1 - math.min(dt * self.friction, 1))

    -- Apply gravity
    -- self.yVelocity = self.yVelocity + self.gravity * dt
    self.yVelocity = self.yVelocity * (1 - math.min(dt * self.friction, 1))

    -- Horizontal movements
    if (love.keyboard.isDown("left", "a") or paddy.isDown("left")) and self.xVelocity > -self.maxSpeed then
        self.xVelocity = self.xVelocity - self.acc * dt
        self.dir = "l"
        self:anim(3, dt)
    elseif (love.keyboard.isDown("right", "d") or paddy.isDown("right")) and self.xVelocity < self.maxSpeed then
        -- Vertical movements
        self.xVelocity = self.xVelocity + self.acc * dt
        self.dir = "r"
        self:anim(2, dt)
    elseif (love.keyboard.isDown("up", "a") or paddy.isDown("up")) and self.yVelocity > -self.maxSpeed then
        self.yVelocity = self.yVelocity - self.acc * dt
        self.dir = "u"
        self:anim(4, dt)
    elseif (love.keyboard.isDown("down", "a") or paddy.isDown("down")) and self.yVelocity < self.maxSpeed then
        self.yVelocity = self.yVelocity + self.acc * dt
        self.dir = "d"
        self:anim(5, dt)
    elseif self.dir == "r" then
        self:anim(0, dt)
    elseif self.dir == "l" then
        self:anim(1, dt)
    end

    -- these store the location the player will arrive at should
    local goalX = self.x + self.xVelocity
    local goalY = self.y + self.yVelocity

    -- Move the player while testing for collisions
    self.x, self.y, collisions, len = self.world:move(self, goalX, goalY, self.collisionFilter)

end

function player:anim(type, dt)
    if type == 0 then
        playerSprite:setViewport(self.w * 1, self.h * 2, self.w, self.h)
    elseif type == 1 then
        playerSprite:setViewport(self.w * 1, self.h * 1, self.w, self.h)
    elseif type == 2 then
        anim_timer = anim_timer - dt
        if anim_timer <= 0 then
            anim_timer = 1 / fps
            frame = frame + 1
            if frame > num_frames then
                frame = 1
            end
            xoffset = self.w * (frame - 1)
            playerSprite:setViewport(xoffset, self.h * 2, self.w, self.h)
        end
    elseif type == 3 then
        anim_timer = anim_timer - dt
        if anim_timer <= 0 then
            anim_timer = 1 / fps
            frame = frame + 1
            if frame > num_frames then
                frame = 1
            end
            xoffset = self.w * (frame - 1)
            playerSprite:setViewport(xoffset, self.h * 1, self.w, self.h)
        end
    elseif type == 4 then
        anim_timer = anim_timer - dt
        if anim_timer <= 0 then
            anim_timer = 1 / fps
            frame = frame + 1
            if frame > num_frames then
                frame = 1
            end
            xoffset = self.w * (frame - 1)
            playerSprite:setViewport(xoffset, self.h * 3, self.w, self.h)
        end
    elseif type == 5 then
        anim_timer = anim_timer - dt
        if anim_timer <= 0 then
            anim_timer = 1 / fps
            frame = frame + 1
            if frame > num_frames then
                frame = 1
            end
            xoffset = self.w * (frame - 1)
            playerSprite:setViewport(xoffset, self.h * 0, self.w, self.h)
        end
    end
end

function player:reset(x, y)
end

function player:draw()
    love.graphics.draw(player_atlas, self.sprite, self.x, self.y)
end

return player
