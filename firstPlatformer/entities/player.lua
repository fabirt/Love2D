local Class = require "libs.hump.class"
local Entity = require "entities.Entity"

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
    player_atlas = love.graphics.newImage("assets/player/fumiko_atlas.png")
    playerSprite = love.graphics.newQuad(24*0, 32*1, 24, 32, player_atlas:getDimensions())
    self.img = love.graphics.newImage("/assets/player/player.png")
    self.sprite = playerSprite
    imgRight = love.graphics.newImage("/assets/player/player.png")
    imgRight1 = love.graphics.newImage("/assets/player/right1.png")
    imgLeft = love.graphics.newImage("/assets/player/left.png")
    imgLeft1 = love.graphics.newImage("/assets/player/left1.png")

    Entity.init(self, world, x, y, self.img:getWidth(), self.img:getHeight())

    -- Add our unique player values
    self.xVelocity = 0 -- current velocity on x, y axes
    self.yVelocity = 0
    self.acc = 70 -- the acceleration of our player
    self.maxSpeed = 100 -- the top speed
    self.friction = 20 -- slow our player down - we could toggle this situationally to create icy or slick platforms
    self.gravity = 130 -- we will accelerate towards the bottom
    self.dir = "r"

    -- These are values applying specifically to jumping
    self.isJumping = false -- are we in the process of jumping?
    self.isGrounded = false -- are we on the ground?
    self.hasReachedMax = false -- is this as high as we can go?
    self.jumpAcc = 300 -- how fast do we accelerate towards the top
    self.jumpMaxSpeed = 4.6 -- our speed limit while jumping

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
    
    -- Apply Friction
    self.xVelocity = self.xVelocity * (1 - math.min(dt * self.friction, 1))
    self.yVelocity = self.yVelocity * (1 - math.min(dt * self.friction, 1))
    
    -- Apply gravity
    self.yVelocity = self.yVelocity + self.gravity * dt

    

    

    if love.keyboard.isDown("left", "a") and self.xVelocity > -self.maxSpeed then
        self.xVelocity = self.xVelocity - self.acc * dt
        self.dir = "l"
        self:anim(3, dt)
    elseif love.keyboard.isDown("right", "d") and self.xVelocity < self.maxSpeed then
        self.xVelocity = self.xVelocity + self.acc * dt
        self.dir = "r"
        self:anim(2, dt)
    elseif self.dir == "r" then
        self:anim(0, dt)   
    elseif self.dir == "l" then
        self:anim(1, dt)   
 
    end

    if love.keyboard.isDown("down") then
        self:anim(6, dt)
    end

    -- The Jump code gets a lttle bit crazy.  Bare with me.
    if love.keyboard.isDown("up", "w") then
        if -self.yVelocity < self.jumpMaxSpeed and not self.hasReachedMax  then
            self.yVelocity = self.yVelocity - self.jumpAcc * dt
        elseif math.abs(self.yVelocity) > self.jumpMaxSpeed then
            self.hasReachedMax = true
        end
        self.isGrounded = false -- we are no longer in contact with the ground
    end

    -- these store the location the player will arrive at should
    local goalX = self.x + self.xVelocity
    local goalY = self.y + self.yVelocity

    -- Move the player while testing for collisions
    self.x, self.y, collisions, len = self.world:move(self, goalX, goalY, self.collisionFilter)

    -- Loop through those collisions to see if anything important is happening
    for i, coll in ipairs(collisions) do
        if coll.touch.y > goalY then -- We touched below (remember that higher locations have lower y values) our intended target.
            self.hasReachedMax = true -- this scenario does not occur in this demo
            self.isGrounded = false
        elseif coll.normal.y < 0 then
            self.hasReachedMax = false
            self.isGrounded = true
        end
    end

end

function player:anim(type, dt)
    if type == 0 then
        playerSprite:setViewport(0, 32, 24, 32)
    elseif type == 1 then
        playerSprite:setViewport(0, 32*3, 24, 32)
    elseif type == 2 then
        anim_timer = anim_timer - dt
        if anim_timer <= 0 then
            anim_timer = 1 / fps
            frame = frame + 1
            if frame > num_frames then frame = 1 end
            xoffset = 24 * (frame + 2)
            playerSprite:setViewport(xoffset, 32, 24, 32)
        end
    elseif type == 3 then
        anim_timer = anim_timer - dt
        if anim_timer <= 0 then
            anim_timer = 1 / fps
            frame = frame + 1
            if frame > num_frames then frame = 1 end
            xoffset = 24 * (frame + 2)
            playerSprite:setViewport(xoffset, 32*3, 24, 32)
        end
    elseif type == 4 then
        playerSprite:setViewport(24*10, 32, 24, 32)
    elseif type == 5 then
        playerSprite:setViewport(24*10, 32*3, 24, 32)
    elseif type == 6 then
        playerSprite:setViewport(24*15, 32*2, 24, 32)
    
    end


end

function player:reset(x, y)
    
    
end

function player:draw()
    love.graphics.draw(player_atlas, self.sprite, self.x, self.y)
end

return player
